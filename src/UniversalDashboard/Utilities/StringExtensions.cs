using System;
using System.Security.Cryptography;
using System.Text;

namespace UniversalDashboard.Utilities
{
    public static class StringExtensions
    {
        public static Guid ToGuid(this string str)
        {
            MD5 md5Hasher = MD5.Create();
            byte[] data = md5Hasher.ComputeHash(Encoding.Default.GetBytes(str));
            return new Guid(data);
        }
    }
}
