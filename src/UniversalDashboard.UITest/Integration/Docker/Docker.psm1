$Docker = "docker"

function Get-DockerContainer {
    param(
        [Parameter()]
        [Switch]$All,
        [Parameter()]
        [String]$Name
    )

    $Arguments = @("ps", '--format', '{{json .}}')

    if ($All) {
        $Arguments += '-a'
    }

    $Containers = & $Docker $Arguments | ConvertFrom-Json

    if ($Name) {
        $Containers | Where-Object Names -like $Name
    } else {
        $Containers
    }
}

function Start-DockerContainer {
    param(
        [Parameter(ValueFromPipelineByPropertyName  = $true)]
        [Alias("Name")]
        $Names,
        [Switch]$Interactive
        )

        Process {
            $Arguments = @("start", $Names)

            if ($Interactive) {
                $Arguments += "--interactive"
                $Arguments += "--attach"
            }
        
            & $Docker $Arguments | Out-Null
        }
}

function Get-DockerImage {
    param(
        $Repository
    )

    $Arguments = @("images", $Repository, "--format", '{{json .}}')
    & $Docker $Arguments | ConvertFrom-Json
}

function Debug-DockerContainer {
    param(
        [Parameter(Mandatory = $true)]
        $Name
    )

    $Arguments = @("attach", $Name)
    & $Docker $Arguments 
}

function New-DockerContainer {
    [CmdletBinding()]
    param(
        $Repository,
        $Name,
        $Tag,
        [int[]]$Port
    )

    $Arguments = @("create", "--name", $Name, "-t")
    
    foreach($p in $port) {
        $Arguments += '-p'
        $Arguments += "$($p):$($p)"
    }

    $Arguments += ($Repository + ':' + $Tag)

    Write-Verbose ($Arguments -join ' ')

    & $Docker $Arguments 
}

function Invoke-DockerCommand {
    param(
        [Parameter(Mandatory = $true, ParameterSetName = "Raw")]
        $Command,
        [Parameter(ParameterSetName = "Raw")]
        $CommandArguments,
        [Parameter(Mandatory = $true, ParameterSetName = "ScriptBlock")]
        [ScriptBlock]$ScriptBlock,
        [Parameter(ParameterSetName = "ScriptBlock")]
        [Switch]$NoExit,
        $ContainerName,
        [Parameter()]
        $WorkingDirectory
    )

    if ($PSCmdlet.ParameterSetName -eq "Raw") {
        $Arguments = @("exec", $ContainerName, $Command)

        $CommandArguments | ForEach-Object {
            $Arguments += $_
        }
    } 
    else 
    {
        $ScriptBlockString = $ScriptBlock.ToString().Replace('"', '`"')

        if ($NoExit) {
            $NoExitParameter = "-NoExit"
        }

        $Arguments = @("exec", $ContainerName, "pwsh", $NoExitParameter, "-Command", "`"& { $ScriptBlockString }`"")
    }

    if ($WorkingDirectory) {
        $Arguments += "-w"
        $Arguments += $WorkingDirectory
    }

    & $Docker $Arguments
}

function Enter-DockerContainer {
    param(
        $Name
    )

    $Arguments = @("attach", $Name)
    & $Docker $Arguments
}

function Stop-DockerContainer {
    param(
        [Parameter(ValueFromPipelineByPropertyName  = $true)]
        [Alias("Name")]
        $Names,
        [Switch]$Force
    )

    Process {
        if ($Force) {
            $cmd = "kill"
        } else {
            $cmd = "stop"
        }
    
        $Arguments = @($cmd, $Names)
        & $Docker $Arguments | Out-Null
    }


}

function Remove-DockerContainer {
    param(
        [Parameter(ValueFromPipelineByPropertyName  = $true)]
        [Alias("Name")]
        $Names,
        [Switch]$Force
    )

    Process {
        $Arguments = @("container", "rm")
    
        if ($Force) {
            $Arguments += "--force"
        }
    
        $Arguments += $Names
    
        & $Docker $Arguments | Out-Null
    }
}

function Copy-DockerItem {
    param(
        [Parameter(Mandatory = $true, ParameterSetName = "FromContainer")]
        [string]$FromContainer,
        [Parameter(Mandatory = $true, ParameterSetName = "ToContainer")]
        [string]$ToContainer,
        $Source,
        $Destination
    )

    if ($PSCmdlet.ParameterSetName -eq "FromContainer") {
        $Arguments = @("cp", "$($FromContainer):$($Source)", $Destination)
        & $Docker $Arguments
    } else {
        $Arguments = @("cp", $Source, "$($ToContainer):$($Destination)")
        & $Docker $Arguments
    }
}