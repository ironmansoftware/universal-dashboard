<#
.SYNOPSIS
Automates PowerShell Core script testing on local Docker containers
.DESCRIPTION
Automates testing of PowerShell Core scripts on different operating systems by using
local Docker containers running PowerShell Core images from the official Microsoft 
Docker hub. Performs these steps:
 - validates user-specified image names with local images and Docker hub versions;
 - for each valid Docker image name:
   - ensures container exists for this image, creating if necessary;
   - ensures container is running;
   - get temp folder path from container;
   - copies user's folders/files, including test script, from computer to container's
     temp folder;
   - runs test script in container;
   - stops container.
If an error occurs running the test script in one container, all processing ceases
after that container is stopped; no additional containers are tested as it's likely
the test script would just fail on those as well.

PowerShell Core Docker container test script written by Dan Ward.
See https://github.com/DTW-DanWard/PowerShell-Beautifier or http://dtwconsulting.com 
for more information.  I hope you enjoy using this utility!
-Dan Ward
.PARAMETER SourcePaths
Folders and/or files on local machine to copy to container
.PARAMETER TestFileAndParams
Path to the test script with any params to run test; path is relative to SourcePaths;
see example for more details 
.PARAMETER TestImageNames
Docker image names to test against. Default values: 'ubuntu16.04', 'centos7', 'opensuse42.1'
.PARAMETER DockerHubRepository
Docker hub repository team/project name. Default value: "microsoft/powershell"
.PARAMETER Quiet
Run test with as little or no output possible.  If all tests are successful on all 
containers, returns only $true.  However if a container is specified in TestImageNames
that does not exist locally, that info will be output.  In addition, if an error 
occurs running a Docker command or running the test script, that info will also
be output and $true will not be returned.
.EXAMPLE
.\Invoke-RunTestScriptInDockerCoreContainers.ps1 `
  -SourcePaths 'C:\Path\To\PowerShell-Beautifier' `
  -TestFileAndParams 'PowerShell-Beautifier/test/Invoke-DTWBeautifyScriptTests.ps1 -Quiet' `
  -TestImageNames ('ubuntu16.04','centos7')

Key details here: 
 - C:\Path\To\PowerShell-Beautifier is a folder that gets copied to each container.
 - The test script is located under that folder, so including that source folder name,
   the path is: PowerShell-Beautifier/test/Invoke-DTWBeautifyScriptTests.ps1
 - -Quiet is a parameter of Invoke-DTWBeautifyScriptTests.ps1; when specified if no
   errors occur (knock on wood) only $true is returned. This script looks for $true
   to know the test on the current container was successful.
 - Tests with two images: microsoft/powershell:ubuntu16.04 and microsoft/powershell:centos7

.EXAMPLE
.\Invoke-RunTestScriptInDockerCoreContainers.ps1 `
  -SourcePaths ('c:\Code\Folder1','c:\Code\Folder2','c:\Code\TestFile.ps1') `
  -TestFileAndParams 'TestFile.ps1'

Key details here:
 - Multiple sources are being copied.
 - TestFile.ps1 is the test file to run here.
 - We are explicitly copying over TestFile.ps1, not a parent folder, so the script will
   be located in the root of the temp folder in the container.  For that reason, there 
   is no relative path to that script in the TestFileAndParams value.
 - That script could be anywhere, doesn't have to be in the root of c:\Code, so the
   SourcePath value could be c:\Code\TestScripts\Blahblah\TestFile.ps1 but the 
   TestFileAndParams value would be the same.
#>

#region Script parameters
# note: the default values below are specific to my machine and the PowerShell-Beautifier
# project. I tried to parameterize and genericize this as much as possible so that it could
# be used by others with *preferably* no code changes. See readme.md in same folder as this
# script for more information about running this script.
param(
  [string[]]$SourcePaths = @((Split-Path -Path (Split-Path -Path (Split-Path -Path $MyInvocation.MyCommand.Path -Parent) -Parent) -Parent)),
  [string]$TestFileAndParams = 'PowerShell-Beautifier/test/Invoke-DTWBeautifyScriptTests.ps1 -Quiet',
  [string[]]$TestImageNames = @('ubuntu16.04','centos7','opensuse42.1'),
  [string]$DockerHubRepository = 'microsoft/powershell',
  [switch]$Quiet
)
#endregion

Set-StrictMode -Version 2

#region Output startup info
if ($Quiet -eq $false) {
  Write-Output ' '
  Write-Output 'Testing with these values:'
  Write-Output "  Test file:        $TestFileAndParams"
  Write-Output "  Docker hub repo:  $DockerHubRepository"
  Write-Output "  Images names:     $TestImageNames"
  if ($SourcePaths.Count -eq 1) {
    Write-Output "  Source paths:     $SourcePaths"
  } else {
    Write-Output '  Source paths:'
    $SourcePaths | ForEach-Object {
      Write-Output "    $_"
    }
  }
  Write-Output ' '
}
#endregion


#region Misc functions

#region Function: Out-ErrorInfo
<#
.SYNOPSIS
Write-Output error information when running a command
.DESCRIPTION
Write-Output error information when running a command
.PARAMETER Command
Command that was run
.PARAMETER Parameters
Parameters for the command
.PARAMETER ErrorInfo
Error information captured to display
.PARAMETER ErrorMessage
Optional message to display before all error info
.EXAMPLE
Out-ErrorInfo -Command "docker" -Parameters "--notaparam" -ErrorInfo $CapturedError
# Writes command, parameters and error info to output
#>
function Out-ErrorInfo {
  #region Function parameters
  [CmdletBinding()]
  param(
    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [string]$Command,
    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [object[]]$Parameters,
    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [object[]]$ErrorInfo,
    [string]$ErrorMessage
  )
  #endregion
  process {
    if ($ErrorMessage -ne $null -and $ErrorMessage.Trim() -ne '') {
      Write-Output $ErrorMessage
    }
    Write-Output 'Error occurred running this command:'
    Write-Output "  $Command $Parameters"
    Write-Output 'Error info:'
    $ErrorInfo | ForEach-Object { Write-Output $_.ToString() }
  }
}
#endregion


#region Function: Invoke-RunCommand
<#
.SYNOPSIS
Runs 'legacy' command-line commands with call operator &
.DESCRIPTION
Runs 'legacy' command-line commands with call operator & in try/catch
block and tests both $? and $LastExitCode for errors. If error occurs, 
writes out using Out-ErrorInfo.
.PARAMETER Command
Command to run
.PARAMETER Parameters
Parameters to use
.PARAMETER ErrorMessage
Optional message to display if error occurs
.PARAMETER ExitOnError
If error occurs, exit script
.PARAMETER ErrorOccurred
Return $true if error occurred, else false; only used by Copy-FilesToDockerContainer
#>
function Invoke-RunCommand {
  #region Function parameters
  [CmdletBinding()]
  param(
    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [string]$Command,
    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [object[]]$Parameters,
    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [ref]$Results,
    [string]$ErrorMessage,
    [switch]$ExitOnError,
    [ref]$ErrorOccurred
  )
  #endregion
  process {
    try {
      if ($ErrorOccurred -ne $null) { $ErrorOccurred.Value = $false }
      $Results.Value = & $Command $Parameters 2>&1
      if ($? -eq $false -or $LastExitCode -ne 0) {
        Out-ErrorInfo -Command $Command -Parameters $Parameters -ErrorInfo $Results.Value -ErrorMessage $ErrorMessage
        if ($ErrorOccurred -ne $null) { $ErrorOccurred.Value = $true }
        if ($ExitOnError -eq $true) { exit }
      }
    } catch {
      Out-ErrorInfo -Command $Command -Parameters $Parameters -ErrorInfo $_.Exception.Message -ErrorMessage $ErrorMessage
      if ($ErrorOccurred -ne $null) { $ErrorOccurred.Value = $true }
      if ($ExitOnError -eq $true) { exit }
    }
  }
}
#endregion


#region Function: Confirm-ValidateUserImages
<#
.SYNOPSIS
Validates script param TestImageNames entries: names, local availability, OS
.DESCRIPTION
Validates script parameter TestImageNames entries
 - checks name with locally installed images for repository DockerHubRepository
   - if found locally, also checks OS type for image matches current Docker server OS
 - if not found locally but is valid for repository DockerHubRepository (i.e. from
   the online hub data) outputs command for user to run to download image.
If image is not found locally nor found at repository DockerHubRepository, writes
error info but does not exit script (it will process any valid image names).
.PARAMETER DockerHubRepositoryImageData
Hashtable of valid image data from the Docker hub repository itself
.PARAMETER ValidImageNames
Reference parameter! Any/all valid image names found in list TestImageNames are
returned in this parameter
#>
function Confirm-ValidateUserImages {
  #region Function parameters
  [CmdletBinding()]
  param(
    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    $DockerHubRepositoryImageData,
    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [ref]$ValidImageNames
  )
  #endregion
  process {
    # get local images for Docker project $DockerHubRepository
    [object[]]$LocalDockerRepositoryImages = Get-DockerImageStatus
    # get list of local image names
    $LocalDockerRepositoryImageNames = $null
    if ($LocalDockerRepositoryImages -ne $null -and $LocalDockerRepositoryImages.Count -gt 0) {
      $LocalDockerRepositoryImageNames = $LocalDockerRepositoryImages.Tag
    }

    # get local Docker server OS
    [string]$DockerServerOS = Get-DockerServerOS

    $TestImageNames | ForEach-Object {
      $TestImageTagName = $_
      if ($LocalDockerRepositoryImageNames -contains $TestImageTagName) {
        # make sure image OS is valid for current Docker server OS
        [string]$ImageOS = $DockerHubRepositoryImageData.$TestImageTagName.images.os
        if ($ImageOS -ne $DockerServerOS) {
          Write-Output ' '
          Write-Output "Image $TestImageTagName cannot be tested at this time as the image OS type is $ImageOS"
          Write-Output "while your local Docker server OS is $DockerServerOS.  You need to change your Docker"
          Write-Output 'server OS type; on Windows this can be done by right-clicking the Docker system'
          Write-Output "tray icon and selecting 'Change to $ImageOS containers'"
          Write-Output 'Note: if you do this there could be additional setup work if this is the first'
          Write-Output "time you are attempting to run $ImageOS containers on this machine."
        } else {
          $ValidImageNames.Value += $TestImageTagName
        }
      } else {
        # no need to check if .Keys doesn't exist; this data should always get pulled from Docker hub
        if ($DockerHubRepositoryImageData.Keys -contains $TestImageTagName) {
          #region Programming note
          # if the image name is valid but not installed locally we *could* just run the 'docker pull' command
          # ourselves programmatically.  however, pulling down that much data (WindowsServerCore is 5GB!) is
          # really something the user should initiate.
          #endregion
          Write-Output "Image $TestImageTagName is not installed locally but exists in repository $DockerHubRepository"
          Write-Output 'To download and install type:'
          Write-Output ('  docker pull ' + $DockerHubRepository + ':' + $TestImageTagName)
          Write-Output ' '
        } else {
          Write-Output "Image $TestImageTagName is not installed locally and does not exist in repository $DockerHubRepository"
          Write-Output 'Do you have an incorrect image name?  Valid image names are:'
          $DockerHubRepositoryImageData.Keys | Sort-Object | ForEach-Object {
            Write-Output "  $_"
          }
          Write-Output ' '
        }
      }
    }
  }
}
#endregion


#region Function: Confirm-DockerHubRepositoryFormatCorrect
<#
.SYNOPSIS
Confirms script param DockerHubRepository is <team name>/<project name>
.DESCRIPTION
Confirms script param DockerHubRepository is <team name>/<project name>, 
i.e. it should have only 1 slash in it 'in the middle' of other characters.
If correct, does nothing, if incorrect writes info and exits script.
#>
function Confirm-DockerHubRepositoryFormatCorrect {
  process {
    # the value for $DockerHubRepository should be: <team name>/<project name>
    # i.e. it should have only 1 slash in it between other characters
    if ($DockerHubRepository -notmatch '^[^/]+/[^/]+$') {
      Write-Output "The format for DockerHubRepository is incorrect: $DockerHubRepository"
      Write-Output 'It should be in the format: TeamName/ProjectName'
      Write-Output 'That is: only 1 forward slash surrounded by other non-forward-slash text'
      exit
    }
  }
}
#endregion


#region Function: Confirm-SourcePathsValid
<#
.SYNOPSIS
Confirms script param SourcePaths paths all exist
.DESCRIPTION
Confirms script param SourcePaths paths all exist. If all paths exist, function
does nothing; if they don't, error info is displayed and script exists.
#>
function Confirm-SourcePathsValid {
  process {
    $SourcePaths | ForEach-Object {
      $SourcePath = $_
      if ($false -eq (Test-Path -Path $SourcePath)) {
        Write-Output "Source path not found: $SourcePath"
        exit
      }
    }
  }
}
#endregion


#region Function: Convert-ImageDataToHashTables
<#
.SYNOPSIS
Converts Docker hub project image/tags data to hashtable of hashtables
.DESCRIPTION
Converts Docker hub project image/tags data, in the form of an object array,
to hashtable of hashtables for easier lookup.  Also adds a sanitized / safe
value to use for container name, based on repository:image name.
.PARAMETER ImageDataPSObjects
Image data as array of PSObjects
#>
function Convert-ImageDataToHashTables {
  #region Function parameters
  [CmdletBinding()]
  param(
    [Parameter(Mandatory = $true,ValueFromPipeline = $false)]
    [ValidateNotNullOrEmpty()]
    [object[]]$ImageDataPSObjects
  )
  #endregion
  process {
    $ImageDataHashTable = [ordered]@{}
    # for each entry in $ImageDataPSObjects:
    #   create an entry in hash table $ImageDataHashTable
    #   the key will be the image/tag name
    #   the value will be a new hashtable containing the data from the PSObject plus
    #     a new property ContainerName, which is a sanitized name to be used as the
    #     Docker container name (which can only have certain characters)
    $ImageDataPSObjects.Name | Sort-Object | ForEach-Object {
      $Name = $_
      $OneImageData = [ordered]@{}
      # get PSObject for this tag
      $TagObject = $ImageDataPSObjects | Where-Object { $_.Name -eq $Name }

      # for each property on the PSObject, add to hashtable
      ($TagObject | Get-Member -MemberType NoteProperty).Name | Sort-Object | ForEach-Object {
        $OneImageData.$_ = $TagObject.$_
      }

      #region Container name information
      # when creating and using containers we want to use a specific container name; if you
      # don't specify a name, Docker will create the container with a random value. it's a lot
      # easier to find/start/use/stop a container with a distinct name you know in advance. 
      # so we'll base the name on the Docker standard RepositoryName:ImageName; unfortunately 
      # Docker's container name only allows certain characters (no slashes or colons) so we'll
      # add a sanitized ContainerName property to the image data in $ImageDataHashTable and use
      # that later in our code.
      # per Docker error message only these characters are valid for the --name parameter:
      #   [a-zA-Z0-9][a-zA-Z0-9_.-]
      #endregion
      # replace any invalid characters with underscores to get sanitized/safe name
      $OneImageData.ContainerName = ($DockerHubRepository + '_' + $Name) -replace '[^a-z0-9_.-]','_'

      # now add this image/tag's hashtable data to the main $ImageDataHashTable hashtable
      $ImageDataHashTable.$Name = $OneImageData
    }
    #return data
    $ImageDataHashTable
  }
}
#endregion


#region Function: Get-DockerHubProjectImageInfo
<#
.SYNOPSIS
Returns Docker hub project image/tag info for $DockerHubRepository
.DESCRIPTION
Returns Docker hub project image/tag info for $DockerHubRepository; format is PSObjects.
#>
function Get-DockerHubProjectImageInfo {
  process {
    # path to tags for Docker project
    $ImageTagsUri = 'https://hub.docker.com/v2/repositories/' + $DockerHubRepository + '/tags'
    try {
      $Response = Invoke-WebRequest -Uri $ImageTagsUri
      # Convert JSON response to PSObjects and return
      (ConvertFrom-Json -InputObject $Response.Content).results
    } catch {
      Write-Output 'Error occurred calling Docker hub project tags url'
      Write-Output "  Url:   $ImageTagsUri"
      Write-Output "  Error: $($_.Exception.Message)"
      exit
    }
  }
}
#endregion
#endregion


#region All Docker command functions

#region Function: Confirm-DockerInstalled
<#
.SYNOPSIS
Confirms Docker is installed
.DESCRIPTION
Confirms Docker is installed; if installed ('docker --version' works) then function
does nothing.  If not installed, reports error and exits script.
#>
function Confirm-DockerInstalled {
  process {
    $Cmd = 'docker'
    $Params = @('--version')
    $ErrorMessage = 'Docker does not appear to be installed or is not working correctly.'
    # capture Results output and discard; if error, Invoke-RunCommand exits script
    $Results = $null
    Invoke-RunCommand -Command $Cmd -Parameters $Params -Results ([ref]$Results) -ErrorMessage $ErrorMessage -ExitOnError
  }
}
#endregion


#region Function: Copy-FilesToDockerContainer
<#
.SYNOPSIS
Copies $SourcePaths files to local container ContainerName
.DESCRIPTION
Copies all $SourcePaths files to local container ContainerName putting
files under folder ContainerPath
.PARAMETER ContainerName
Name of container to copy files to.
.PARAMETER ContainerPath
Path in container to copy files to.
.PARAMETER ErrorOccurred
Return $true if error occurred, else false.
.EXAMPLE
Copy-FilesToDockerContainer -ContainerName MyContainer -ContainerPath /tmp
# copies files from $SourcePaths local container named MyContainer under path ContainerPath
#>
function Copy-FilesToDockerContainer {
  #region Function parameters
  [CmdletBinding()]
  param(
    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [string]$ContainerName,
    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [string]$ContainerPath,
    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [ref]$ErrorOccurred
  )
  #endregion
  process {
    if ($Quiet -eq $false) { Write-Output "  Copying source content to container temp folder $ContainerPath" }
    # for each source file path, copy to Docker container
    $SourcePaths | ForEach-Object {
      $SourcePath = $_
      if ($Quiet -eq $false) { Write-Output "    $SourcePath" }
      $Cmd = 'docker'
      $Params = @('cp',$SourcePath,($ContainerName + ':' + $ContainerPath))
      # capture output, discard Results but return ErrorOccurred; don't exit on error
      $Results = $null
      $Error = $false
      Invoke-RunCommand -Command $Cmd -Parameters $Params -Results ([ref]$Results) -ErrorOccurred ([ref]$Error)
      $ErrorOccurred.Value = $Error
    }
  }
}
#endregion


#region Function: Initialize-DockerContainerAndStart
<#
.SYNOPSIS
Creates local container and starts it
.DESCRIPTION
Creates local container and starts it using Docker run (as opposed to explicit
docker create and start commands). Uses image $ImageName from repository 
$DockerHubRepository and creates with name $ContainerName.
If error occurs, reports error and exits script.
.PARAMETER ImageName
Name of Docker image to use to create container.
.PARAMETER ContainerName
Name of container to create.
.EXAMPLE
Initialize-DockerContainerAndStart -ImageName MyImageName -ContainerName MyContainer
# Creates local container from repository $DockerHubRepository using image MyImageName
# naming it MyContainer and starts it.
#>
function Initialize-DockerContainerAndStart {
  #region Function parameters
  [CmdletBinding()]
  param(
    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [string]$ImageName,
    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [string]$ContainerName
  )
  #endregion
  process {
    if ($Quiet -eq $false) { Write-Output '  Preexisting container not found; creating and starting' }
    $Cmd = 'docker'

    $Params = @('run','--name',$ContainerName,'-t','-d',($DockerHubRepository + ':' + $ImageName))
    # capture output and discard; if error, Invoke-RunCommand exits script
    $Results = $null
    Invoke-RunCommand -Command $Cmd -Parameters $Params -Results ([ref]$Results) -ExitOnError
  }
}
#endregion


#region Function: Get-DockerContainerTempFolderPath
<#
.SYNOPSIS
Gets temp folder path in container ContainerName
.DESCRIPTION
Gets temp folder path inside running container ContainerName by running
[System.IO.Path]::GetTempPath()
If container is not running exists script with error.
.PARAMETER ContainerName
Name of container to create.
.EXAMPLE
Get-DockerContainerTempFolderPath -ContainerName microsoft_powershell_ubuntu16.04
/tmp
#>
function Get-DockerContainerTempFolderPath {
  #region Function parameters
  [CmdletBinding()]
  param(
    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [string]$ContainerName,
    [Parameter(Mandatory = $true)]
    [ref]$Path
  )
  #endregion
  process {
    if ($Quiet -eq $false) { Write-Output '  Getting temp folder path in container' }
    # get container info for $ContainerName
    $ContainerInfo = Get-DockerContainerStatus | Where-Object { $_.Names -eq $ContainerName }
    # this error handling shouldn't be needed; at this point in the script
    # the container name has been validated and started, but just in case
    # if no container exists or container not started, exit with error
    if ($ContainerInfo -eq $null) {
      Write-Output "Container $ContainerName not found; exiting script"
      exit
    } elseif (!$ContainerInfo.Status.StartsWith('Up')) {
      Write-Output "Container $ContainerName isn't running but it should be; exiting script"
      exit
    }
    # Note: see developer info in Invoke-TestScriptInDockerContainer about why command is run
    # this particular way
    $Cmd = 'docker'
    $Params = @('exec',$ContainerName,'pwsh','-Command',"& { [System.IO.Path]::GetTempPath() }")
    # capture output and return; if error, Invoke-RunCommand exits script
    $Results = $null
    Invoke-RunCommand -Command $Cmd -Parameters $Params -Results ([ref]$Results) -ExitOnError
    $Path.Value = $Results
  }
}
#endregion


#region Function: Get-DockerContainerStatus
<#
.SYNOPSIS
Returns all local Docker container info as PSObjects
.DESCRIPTION
Returns all local Docker container info as PSObjects. If error occurs,
reports error and exits script.
.EXAMPLE
Get-DockerContainerStatus | Format-Table
# Additional content to right not shown
Command      CreatedAt                     ID           Image                             .......
-------      ---------                     --           -----                             .......
"powershell" 2017-09-07 12:54:26 -0400 EDT cbd1e9ea22d9 microsoft/powershell:opensuse42.1 .......
"powershell" 2017-09-07 12:50:43 -0400 EDT 6b0f74711cda microsoft/powershell:centos7      .......
"powershell" 2017-09-07 12:46:03 -0400 EDT 7bec8cacd139 microsoft/powershell:ubuntu16.04  .......
#>
function Get-DockerContainerStatus {
  process {
    $Cmd = 'docker'
    $Params = @('ps','-a','--format','{{json .}}')
    $Results = $null
    Invoke-RunCommand -Command $Cmd -Parameters $Params -Results ([ref]$Results) -ExitOnError
    # parse results, converting from JSON to PSObjects
    if ($Results -ne $null -and $Results.ToString().Trim() -ne '') {
      $Results | ConvertFrom-Json
    } else {
      $null
    }
  }
}
#endregion


#region Function: Get-DockerImageStatus
<#
.SYNOPSIS
Returns local Docker image info as PSObjects for repository $DockerHubRepository
.DESCRIPTION
Returns local Docker image info (images -a) as PSObjects. If error occurs,
reports error and exits script.
.EXAMPLE
Get-DockerImageStatus | Format-Table
# Additional content to right not shown
Containers CreatedAt                     CreatedSince Digest ID           Repository           .......
---------- ---------                     ------------ ------ --           ----------           .......
N/A        2017-08-31 15:45:18 -0400 EDT 7 days ago   <none> c9a0ce9c00a0 microsoft/powershell .......
N/A        2017-08-31 15:45:11 -0400 EDT 7 days ago   <none> e83ef70fc111 microsoft/powershell .......
N/A        2017-08-04 01:18:49 -0400 EDT 5 weeks ago  <none> 61ae8d8940e6 microsoft/powershell .......
N/A        2017-06-14 15:29:01 -0400 EDT 2 months ago <none> 1815c82652c0 hello-world          .......
#>
function Get-DockerImageStatus {
  process {
    $Cmd = 'docker'
    $Params = @('images',$DockerHubRepository,'--format','{{json .}}')
    $Results = $null
    Invoke-RunCommand -Command $Cmd -Parameters $Params -Results ([ref]$Results) -ExitOnError
    # parse results, converting from JSON to PSObjects
    if ($Results -ne $null -and $Results.ToString().Trim() -ne '') {
      $Results | ConvertFrom-Json
    } else {
      $null
    }
  }
}
#endregion


#region Function: Get-DockerServerOS
<#
.SYNOPSIS
Returns local Docker server operating system: linux or windows
.DESCRIPTION
Returns local Docker server operating system: linux or windows. If error occurs,
reports error and exits script.
.EXAMPLE
Get-DockerServerOS
linux
#>
function Get-DockerServerOS {
  process {
    $Cmd = 'docker'
    $Params = @('info','--format','{{json .}}')
    $Results = $null
    Invoke-RunCommand -Command $Cmd -Parameters $Params -Results ([ref]$Results) -ExitOnError
    # parse results, converting from JSON to PSObject, then return OSType property
    ($Results | ConvertFrom-Json).OSType
  }
}
#endregion


#region Function: Invoke-TestScriptInDockerContainer
<#
.SYNOPSIS
Executes PowerShell script in local container
.DESCRIPTION
Executes script ScriptPath in container ContainerName; if error occurs, reports
error and sets parameter TestScriptSuccess = $false (else $true).
.PARAMETER ContainerName
Name of container to use.
.PARAMETER ScriptPath
Path in container to run script.
.PARAMETER TestScriptSuccess
Reference parameter! $true if an error occurred running test
.EXAMPLE
Invoke-TestScriptInDockerContainer MyContainer /tmp/MyScript.ps1 ([ref]$TestScriptSuccess)
# Executes script /tmp/MyScript.ps1 in container, sets $TestScriptSuccess = $false if error
#>
function Invoke-TestScriptInDockerContainer {
  #region Function parameters
  [CmdletBinding()]
  param(
    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [string]$ContainerName,
    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [string]$ScriptPath,
    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [ref]$TestScriptSuccess
  )
  #endregion
  process {
    if ($Quiet -eq $false) { Write-Output '  Running test script on container' }
    #region A handy tip
    # if you are reading this script, this next bit contains the biggest gotcha I encountered when
    # writing the Docker commands to run in PowerShell. if you were to type a Docker execute command in a
    # PowerShell window to execute a different PowerShell script in the container, it would look like this:
    #   docker exec containername powershell -Command { /SomeScript.ps1 }
    # There are multiple gotchas:
    #  - On Windows: when converting this to a command with array of parameters to pass to the call
    #    operator & (i.e.: & $Cmd $Params), you must explicitly create " /SomeScript.ps1 " as a
    #    scriptblock first; passing it in as just a string will not execute no matter how you format it.
    #  - But doing that fails on OSX native PowerShell Core!  The trick to getting it to work is to use
    #    *this* format of launching PowerShell with a command:
    #   docker exec containername powershell -Command "& { /SomeScript.ps1 }"
    #endregion
    $Cmd = 'docker'
    $Params = @('exec',$ContainerName,'pwsh','-Command',"& { $ScriptPath }")

    # capture output $Results; don't exit on error
    $Results = $null
    Invoke-RunCommand -Command $Cmd -Parameters $Params -Results ([ref]$Results)
    # my test script in $TestFileAndParams when used with the -Quiet param, is designed to
    # return ONLY $true if everything worked. so if anything other than $true is returned assume 
    # error and report results
    if ($Results -ne $null -and $Results -ne $true) {
      $TestScriptSuccess.Value = $false
      Out-ErrorInfo -Command $Cmd -Parameters $Params -ErrorInfo $Results
    } else {
      $TestScriptSuccess.Value = $true
      if ($Quiet -eq $false) { Write-Output '  Test script completed successfully' }
    }
  }
}
#endregion


#region Function: Start-DockerContainer
<#
.SYNOPSIS
Starts local container
.DESCRIPTION
Starts local container. If error occurs, reports error and exits script.
.PARAMETER ContainerName
Name of container to start.
.EXAMPLE
Start-DockerContainer MyContainer
# starts local container named MyContainer
#>
function Start-DockerContainer {
  #region Function parameters
  [CmdletBinding()]
  param(
    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [string]$ContainerName
  )
  #endregion
  process {
    if ($Quiet -eq $false) { Write-Output '  Starting container' }
    $Cmd = 'docker'
    $Params = @('start',$ContainerName)
    # capture output and discard; if error, Invoke-RunCommand exits script
    $Results = $null
    Invoke-RunCommand -Command $Cmd -Parameters $Params -Results ([ref]$Results) -ExitOnError
  }
}
#endregion


#region Function: Stop-DockerContainer
<#
.SYNOPSIS
Stops local container
.DESCRIPTION
Stops local container. If error occurs, reports error and exits script.
.PARAMETER ContainerName
Name of container to stop.
.EXAMPLE
Stop-DockerContainer MyContainer
# stops local container named MyContainer
#>
function Stop-DockerContainer {
  #region Function parameters
  [CmdletBinding()]
  param(
    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [string]$ContainerName
  )
  #endregion
  process {
    if ($Quiet -eq $false) { Write-Output '  Stopping container' }
    $Cmd = 'docker'
    $Params = @('stop',$ContainerName)
    # capture output and discard; if error, Invoke-RunCommand exits script
    $Results = $null
    Invoke-RunCommand -Command $Cmd -Parameters $Params -Results ([ref]$Results) -ExitOnError
  }
}
#endregion
#endregion



# ################ 'main' begins here


# Programming note: to improve simplicity and readability, if any of the below functions
# generates an error, info is written and the script is exited from within the function.
# There are some exceptions: 
#   if an error occurs in Copy-FilesToDockerContainer, ErrorOccurred is set to $true and
#     thus Invoke-TestScriptInDockerContainer will not be run (we can't execute the test
#     if code didn't copy correctly)
#   Invoke-TestScriptInDockerContainer does not exit the script, either, so processing
#   can continue and the container will be stopped (and *then* the script will exit).


# make sure Docker is installed, 'docker' is in the path and is working
# no point in continuing if Docker isn't working
Confirm-DockerInstalled

#region Get Docker hub image/tag data and validate script parameters

# confirm script parameter $DockerHubRepository is <team name>/<project name>
Confirm-DockerHubRepositoryFormatCorrect

# confirm all the user-supplied paths exist
Confirm-SourcePathsValid

# for project $DockerHubRepository, get Docker image names and other details from online Docker hub
# project tags data (format of data is PSObjects)
[object[]]$HubImageDataPSObject = Get-DockerHubProjectImageInfo

# now convert data in $HubImageDataPSObject to a hash table of hash tables for easier lookup/usage
# *plus* add an entry for ContainerName - a safe/sanitized name to re/use for the container
[hashtable]$HubImageDataHashTable = Convert-ImageDataToHashTables -ImageDataPSObjects $HubImageDataPSObject

#region If user didn't specify any values for TestImageNames, display valid values and exit
if ($TestImageNames.Count -eq 0) {
  Write-Output 'No image/tag name specified for TestImageTagName; please use a value below:'
  $HubImageDataHashTable.Keys | Sort-Object | ForEach-Object {
    Write-Output "  $_"
  }
  exit
}
#endregion

#region Validate script param TestImageNames
# listing of valid, locally installed image names
[string[]]$ValidTestImageTagNames = $null
# check user supplied images names, if valid will be stored in ValidTestImageTagNames 
Confirm-ValidateUserImages -DockerHubRepositoryImageData $HubImageDataHashTable -ValidImageNames ([ref]$ValidTestImageTagNames)
# check if no valid image names - exit
if ($ValidTestImageTagNames -eq $null) {
  Write-Output 'No locally installed images to test against; exiting.'
  exit
}
#endregion
#endregion


#region Loop through valid local images, create/start container, copy code to it, run test and stop container
if ($Quiet -eq $false) { Write-Output "Testing on these containers: $ValidTestImageTagNames" }

# did all test scripts run successfully? start with $true but Invoke-TestScriptInDockerContainer
# will set to $false if error
[bool]$TestScriptSuccess = $true

$ValidTestImageTagNames | ForEach-Object {
  $ValidTestImageTagName = $_
  if ($Quiet -eq $false) { Write-Output ' '; Write-Output $ValidTestImageTagName }

  # get sanitized container name (based on repository + image name) for this image
  $ContainerName = ($HubImageDataHashTable[$ValidTestImageTagName]).ContainerName
  # get container info for $ContainerName
  $ContainerInfo = $null
  $AllContainerStatusInfo = Get-DockerContainerStatus
  if ($AllContainerStatusInfo -ne $null) {
    $ContainerInfo = $AllContainerStatusInfo | Where-Object { $_.Names -eq $ContainerName }
  }
  # if no container exists, create one and start it
  if ($ContainerInfo -eq $null) {
    # create Docker container and start it
    Initialize-DockerContainerAndStart -ImageName $ValidTestImageTagName -ContainerName $ContainerName
  } else {
    if ($Quiet -eq $false) { Write-Output '  Preexisting container found' }
    # if container not started, start it
    if ($ContainerInfo.Status.StartsWith('Up')) {
      if ($Quiet -eq $false) { Write-Output '  Container already started' }
    } else {
      # start local container
      Start-DockerContainer -ContainerName $ContainerName
    }
  }

  # temp folder path inside container
  [string]$ContainerTestFolderPath = $null
  Get-DockerContainerTempFolderPath -ContainerName $ContainerName ([ref]$ContainerTestFolderPath)

  # copy items in script param $SourcePaths to container $ContainerName to location
  # under folder $ContainerTestFolderPath; if error occurred, return $true
  # value in $ErrorOccurred but do not exit in Copy-FilesToDockerContainer
  [bool]$ErrorOccurred = $false
  Copy-FilesToDockerContainer -ContainerName $ContainerName -ContainerPath $ContainerTestFolderPath -ErrorOccurred ([ref]$ErrorOccurred)

  # only run test if no error occurred during copying
  if ($ErrorOccurred -eq $false) {
    # run test script in container $ContainerName at path $ContainerTestFolderPath/$TestFileAndParams  
    # if error, do not exit so container can be stopped next step
    $ContainerScriptPath = Join-Path -Path $ContainerTestFolderPath -ChildPath $TestFileAndParams
    Invoke-TestScriptInDockerContainer -ContainerName $ContainerName -ScriptPath $ContainerScriptPath -TestScriptSuccess ([ref]$TestScriptSuccess)
  }

  # stop local container
  Stop-DockerContainer -ContainerName $ContainerName
}
#endregion


#region If -Quiet and no errors occurred, return $true
# if not -Quiet, don't return any value BUT if -Quiet and everything 
# successful, return $true (best for automation)
if ($Quiet -eq $true -and $TestScriptSuccess -eq $true) { $TestScriptSuccess }
#endregion
