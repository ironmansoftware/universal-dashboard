using System.IO;
using System.Management.Automation;

namespace UniversalDashboard.Cmdlets 
{
    public class RegisterAssetCommand : PSCmdlet
    {
	
		[Parameter(Mandatory = true, ValueFromPipeline = true, ParameterSetName = "Uri")]
		public string Uri { get; set; }
		[Parameter(Mandatory = true, ValueFromPipeline = true, ParameterSetName = "Asset")]
        [Parameter(Mandatory = true, ParameterSetName = "Framework")]
		public FileInfo Path { get;set; }
		[Parameter(ParameterSetName = "Asset")]
		[Parameter(ParameterSetName = "Uri")]
		public SwitchParameter Plugin { get; set; }
		[Parameter(ParameterSetName = "Framework")]
		public string FrameworkName { get; set; }
		
        protected override void ProcessRecord()
        {
            if (FrameworkName != null)
            {
                var assetId = UniversalDashboard.Services.AssetService.Instance.RegisterAsset(Path.FullName);
                UniversalDashboard.Services.AssetService.Instance.RegisterFramework(FrameworkName, assetId);
            }
            else if (Plugin)
            {
                UniversalDashboard.Services.AssetService.Instance.RegisterPlugin(Path.FullName);
            }
            else 
            {
                var assetId = UniversalDashboard.Services.AssetService.Instance.RegisterAsset(Path.FullName);
                WriteObject(assetId);
            }
        }
    }
}