using System.Management.Automation;
using UniversalDashboard.Interfaces;
using UniversalDashboard.Interfaces.Models;
using UniversalDashboard.Utilities;

namespace UniversalDashboard.Cmdlets
{
    public abstract class PluggablePSCmdlet : PSCmdlet, IDynamicParameters, ICmdlet
    {
        private IUdDynamicParameters _dynamicParameters;

        protected abstract string CommandKey { get; }

        public object GetDynamicParameters()
        {
            foreach (var plugin in PluginRegistry.Instance.Plugins)
            {
                if (plugin.CmdletExtender != null)
                {
                    _dynamicParameters = plugin.CmdletExtender.GetDynamicParameters(DynamicParameterKeys.NewDashboardCommand, this);
                    return _dynamicParameters;
                }
            }

            return null;
        }

        public void WriteError(string error)
        {
            WriteError(new ErrorRecord(new System.Exception(error), string.Empty, ErrorCategory.NotSpecified, this));
        }

        protected void AddDynamicParameters(IDynamicModel model)
        {
            if (_dynamicParameters != null)
            {
                foreach (var kvp in _dynamicParameters.AsDictionary())
                {
                    model.Properties.Add(kvp.Key, kvp.Value);
                }
            }
        }

        protected void ValidateModel(IDynamicModel model)
        {
            foreach (var plugin in PluginRegistry.Instance.Plugins)
            {
                if (plugin.CmdletExtender != null)
                {
                    plugin.CmdletExtender.ValidateParameters(CommandKey, model, this);
                }
            }
        }
    }
}
