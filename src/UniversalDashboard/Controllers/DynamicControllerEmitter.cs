using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Caching.Memory;
using System;
using System.Linq;
using System.Reflection;
using System.Reflection.Emit;
using UniversalDashboard.Interfaces;
using UniversalDashboard.Models;

namespace UniversalDashboard.Controllers
{
    public class DynamicControllerEmitter 
    {
        public TypeInfo EmitController(IDashboardService dashboardService)
        {
            var controllerType = "c" + Guid.NewGuid().ToString("N") + "Controller";
            var assemblyName = "a" + Guid.NewGuid().ToString("N");
            var typeBuilder = GetTypeBuilder(controllerType, assemblyName);

            DefineConstructor(typeBuilder);
            DefinePageMethods(typeBuilder, dashboardService.Dashboard);

            return typeBuilder.CreateTypeInfo();
        }

        private static void DefineConstructor(TypeBuilder typeBuilder)
        {
            var baseConstructor = typeof(DynamicControllerBase).GetConstructor(new[] { typeof(IDashboardService) });

            var ctor = typeBuilder.DefineConstructor(MethodAttributes.Public, CallingConventions.Standard, new[] { typeof(IDashboardService) });
            var ilGenerator = ctor.GetILGenerator();
            ilGenerator.Emit(OpCodes.Ldarg_0);
            ilGenerator.Emit(OpCodes.Ldarg_1);
            ilGenerator.Emit(OpCodes.Call, baseConstructor);
            ilGenerator.Emit(OpCodes.Nop);
            ilGenerator.Emit(OpCodes.Nop);
            ilGenerator.Emit(OpCodes.Ret);
        }

        private static void DefinePageMethods(TypeBuilder typeBuilder, Dashboard dashboard) {
            Type[] ctorParams = new Type[] { typeof(string) };
	        ConstructorInfo classCtorInfo = typeof(HttpGetAttribute).GetConstructor(ctorParams);

            foreach(var page in dashboard.Pages.Where(m => m.Name != null)) {

                var method = typeBuilder.DefineMethod("m" + Guid.NewGuid().ToString("N"), 
                                MethodAttributes.Public, 
                                typeof(Page), null);

                CustomAttributeBuilder myCABuilder = new CustomAttributeBuilder(
                    classCtorInfo,
                    new object[] { $"dashboard/{page.Name}"});

                method.SetCustomAttribute(myCABuilder);

                var ilGenerator = method.GetILGenerator();
                ilGenerator.Emit(OpCodes.Ldarg_0); // this
                ilGenerator.Emit(OpCodes.Ldstr, page.Name); // string
                ilGenerator.EmitCall(OpCodes.Call, typeof(DynamicControllerBase).GetMethod("GetPage"), new Type[0]);
                ilGenerator.Emit(OpCodes.Nop);
                ilGenerator.Emit(OpCodes.Nop);
                ilGenerator.Emit(OpCodes.Ret);
            }
        }

        private static TypeBuilder GetTypeBuilder(string typeName, string assemblyName)
        {
            var typeSignature = typeName;
            var an = new AssemblyName(typeSignature);
            AssemblyBuilder assemblyBuilder = AssemblyBuilder.DefineDynamicAssembly(an, AssemblyBuilderAccess.Run);
            ModuleBuilder moduleBuilder = assemblyBuilder.DefineDynamicModule(assemblyName);
            TypeBuilder tb = moduleBuilder.DefineType(typeSignature,
                    TypeAttributes.Public |
                    TypeAttributes.Class |
                    TypeAttributes.AutoClass |
                    TypeAttributes.AnsiClass |
                    TypeAttributes.BeforeFieldInit |
                    TypeAttributes.AutoLayout,
                    typeof(DynamicControllerBase));
            return tb;
        }
    }
}
