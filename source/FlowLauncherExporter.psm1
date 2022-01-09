function ExportLibrary()
{
    param(
        $scriptMainMenuItemActionArgs
    )

    $path = $PlayniteApi.Paths.ExtensionsDataPath
    $full_path = Join-Path -Path $path -ChildPath "FlowLauncher_Exporter" | Join-Path -ChildPath "library.json"
    $PlayniteApi.Database.Games | Select Id, Name, Source, ReleaseDate, Playtime, IsInstalled, InstallDirectory, Icon | ConvertTo-Json | Out-File $full_path -Encoding utf8

}

function OnLibraryUpdated()
{
    ExportLibrary
}

function OnApplicationStarted()
{
    ExportLibrary
}

function OnGameInstalled()
{
    ExportLibrary
}

function OnGameUninstalled() 
{
    ExportLibrary
}

function GetMainMenuItems()
{
    param(
        $menuArgs
    )

    $menuItem = New-Object Playnite.SDK.Plugins.ScriptMainMenuItem
    $menuItem.Description = "Update index"
    $menuItem.FunctionName = "ExportLibrary"
    $menuItem.MenuSection = "@Flow Launcher Exporter"
    return $menuItem
}
