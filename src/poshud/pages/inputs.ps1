
$Textboxes = {
    New-UDInput -Title "Echo" -SubmitText "Echo text" -Endpoint {
        param([string]$Message)

        New-UDInputAction -Toast $Message
    } -FontColor "black"
}

$Checkboxes = {
    New-UDInput -Title "Check me" -Endpoint {
        param([bool]$CheckMe)

        if ($CheckMe) {
            New-UDInputAction -Toast "Checked"
        } else {
            New-UDInputAction -Toast "Not checked"
        }
    } -FontColor "black"
}

$Select = {
    New-UDInput -Title "Select me" -Endpoint {
        param([ValidateSet("Yes", "No", "Don't care")]$Opinion)

        New-UDInputAction -Toast "You selected: $Opinion"
    } -FontColor "black"
}

$DeclarativeInputs = {
    New-UDInput -Title "Try Me" -Endpoint {
        param($Textbox, $Checkbox)

        New-UDInputAction -Toast "$Textbox : $Checkbox"
    } -Content {
        New-UDInputField -Name "Textbox" -Placeholder "My textbox" -Type "textbox"
        New-UDInputField -Name "Checkbox" -Placeholder "My checkbox" -Type "checkbox"
    } -FontColor "black"
}

$ReplacingContent = {
    New-UDInput -Title "Make GUID" -Endpoint {
        New-UDInputAction -Content {
            New-UDElement -Tag "h2" -Content {
                (New-Guid).ToString()
            }
        }
    } -FontColor "black"
}


New-UDPage -Name "Inputs" -Icon wpforms -Content {
    New-UDPageHeader -Title "Inputs" -Icon "wpforms" -Description "Take input and perform actions." -DocLink "https://docs.universaldashboard.io/components/inputs"
    New-UDExample -Title "Textboxes" -Description "Accept data from a textbox." -Script $Textboxes
    New-UDExample -Title "Checkboxes" -Description "Accept data from a checkbox." -Script $Checkboxes
    New-UDExample -Title "Select" -Description "Accept data from a select." -Script $Select
    New-UDExample -Title "Declarative Input Fields" -Description "Define exactly which input fields you'd like by defining them in the content block." -Script $DeclarativeInputs
    #New-UDExample -Title "Replace Content" -Description "Replace input field with other content." -Script $ReplacingContent
}