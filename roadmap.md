# Roadmap

This roadmap document serves as a general direction for Universal Dashboard. If you have changes you would like to see in the general direction of Universal Dashboard, please submit a PR. 

# v3 - Late 2020 

## Framework Support 

Universal Dashboard currently uses Materialize CSS as it's primary set of controls. It isn't React based and really locks people into a single look and feel. We've made some progress at switching this out but it's not complete. 

We should be able to completely plug in a framework that changes the control set. Certain controls should be backwards compatible and only change how they look. The following cmdlets should work no matter the framework. 

- New-UDCard
- New-UDCounter
- New-UDGrid 
- New-UDTable 
- New-UDInput
- New-UDChart
- New-UDRow
- New-UDColumn
- More? 


Frameworks should be able to define their own controls but should some how allow for backwards compabiltiy of the above controls. 

### Core Module

As part of the framework support, we will isolate the core UD module. This will consist of things that are core to the UD experience. These cmdlets include the following. 

- New-UDElement 
- Set-UDElement
- Remove-UDElement
- Add-UDElement
- Clear-UDElement 
- Sync-UDElement
- New-UDPage
- New-UDDashboard 
- Show-UDModal
- Hide-UDModal
- Show-UDToast
- Hide-UDToast
- Invoke-UDRedirect
- More? 

## Theme Support

Themes are a never ending battle in the current implementation of UD. Themes are never up to date and are rebroken every release. We will be changing how themes work. 

### Color Definitions 

Themes will work via color definitions and not CSS. Controls and frameworks will need to opt in to themes to make sure they work appropriately. 

An example theme will be something like. We will better define the colors need through this document. 

```
@{
    PrimaryColor = "#234234"
    SecondaryColor = "#2343242"
    SomeOtherColor = "#234234"
}
```

Themes should still support CSS but should not be used by the in-box themes.

## Material UI Framework 

As part of the move to a framework model, we should remove Materialize as the default framework and instead use Material UI. It offers more controls, supports the proposed theme model, is more actively maintained, is written in React and looks better. 

For the first v3 version, we should look to replicate the existing required components. 

## Ant Design Framework 

As another option for UD, we should ensure that the upcoming Ant Design framework is fully supported by UD v3. 

## Remove Role Support

Roles don't work with any authentication type besides endpoint based auth. We should remove roles and focus on authorization policies since they work everywhere. 

## Rename Endpoint to DynamicContent 

Endpoint is a very confusing name. We should consider renaming (or aliasing) all component-based Endpoint parameters to DynamicContent instead. 

## Enhanced JavaScript API 

As part of the framework work, we should improve the JavaScript API so it's much easier to implement custom components. This primarily focuses on improving the implmentation of the following cmdlets in your custom components. 

- Add-UDElement
- Get-UDElement
- Remove-UDElement
- Set-UDElement 
- Clear-UDElement 
- Sync-UDElement 

## v2.+ - 2020 

v2 will continue to be supported with development going in tandem with v3. We should focus on bug fixing and features that will enhance the core module but try to avoid adding features that rely on Materialize or introduce new Materialize controls. 

### Additonal Endpoint Support

There has been some desire in the community for more cmdlets for managing endpoints. We should look at implementing these cmdlets. 

- Invoke-UDElement - Run endpoints synchronously and asynchronously from other endpoints
- Get-UDElement - Return elements registered with the system

### Improved Grid

The existing grid has a lot of problems and has been notoriously had to support. There are better options and we should consider implementing a solid React control that supports more features and doesn't require so much code on the UD side. 
