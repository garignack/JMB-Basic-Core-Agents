#include "BasicWindowLayout.Common.iss"

objectdef bwlUplink
{
    variable bwlSettings Settings

    method Initialize()
    {
        LGUI2:LoadPackageFile[BasicWindowLayout.Uplink.lgui2Package.json]
        Settings:Store
    }

    method Shutdown()
    {
        LGUI2:UnloadPackageFile[BasicWindowLayout.Uplink.lgui2Package.json]
    }

    method ToggleFocusFollowsMouse()
    {
        This:SetFocusFollowsMouse[${Settings.FocusFollowsMouse.Not}]
    }

    method SetFocusFollowsMouse(bool newValue)
    {
        if ${newValue}==${Settings.FocusFollowsMouse}
            return
        Settings.FocusFollowsMouse:Set[${newValue}]
        Settings:Store

        ; push updated setting
        relay all "BWLSession.Settings.FocusFollowsMouse:Set[${newValue}]"
    }

    method ToggleAvoidTaskbar()
    {
        This:SetAvoidTaskbar[${Settings.AvoidTaskbar.Not}]
    }

    method SetAvoidTaskbar(bool newValue)
    {
        if ${newValue}==${Settings.AvoidTaskbar}
            return
        Settings.AvoidTaskbar:Set[${newValue}]
        Settings:Store

        ; push updated setting
        relay all "BWLSession.Settings.AvoidTaskbar:Set[${newValue}]"
    }

    method ToggleSwapOnActivate()
    {
        This:SetSwapOnActivate[${Settings.SwapOnActivate.Not}]
    }

    method SetSwapOnActivate(bool newValue)
    {
        if ${newValue}==${Settings.SwapOnActivate}
            return
        Settings.SwapOnActivate:Set[${newValue}]
        Settings:Store

        ; push updated setting
        relay all "BWLSession.Settings.SwapOnActivate:Set[${newValue}]"
    }

    method ToggleSwapOnHotkeyFocused()
    {
        This:SetSwapOnHotkeyFocused[${Settings.SwapOnHotkeyFocused.Not}]
    }

    method SetSwapOnHotkeyFocused(bool newValue)
    {
        if ${newValue}==${Settings.SwapOnHotkeyFocused}
            return
        Settings.SwapOnHotkeyFocused:Set[${newValue}]
        Settings:Store

        ; push updated setting
        relay all "BWLSession.Settings.SwapOnHotkeyFocused:Set[${newValue}]"
    }

    method ToggleLeaveHole()
    {
        This:SetLeaveHole[${Settings.LeaveHole.Not}]
    }

    method SetLeaveHole(bool newValue)
    {
        if ${newValue}==${Settings.LeaveHole}
            return
        Settings.LeaveHole:Set[${newValue}]
        Settings:Store

        ; push updated setting
        relay all "BWLSession.Settings.LeaveHole:Set[${newValue}]"
    }    

    method SelectLayout(string newValue)
    {
        if ${newValue.Equal["${Settings.UseLayout~}"]}
            return

        Settings.UseLayout:Set["${newValue~}"]
        Settings:Store

        relay all "BWLSession:SelectLayout[${newValue.AsJSON~}]"
    }

    method ApplyWindowLayout()
    {
        relay jmb1 "BWLSession:ApplyWindowLayout"
    }

    ;Active funtions (Not DRY) - TODO: Roll the Activate functions into a single function with parameters. 

    method ActivateHorizontal()
    {
        This:SelectLayout["Horizontal"]
        This:ApplyWindowLayout
    }
   
    method ActivateVertical()
    {
        This:SelectLayout["Vertical"]
        This:ApplyWindowLayout
    }
   
    method ActivateTwoMonitor()
    {
        This:SelectLayout["TwoMonitor"]
        This:ApplyWindowLayout
    }
   
    method ActivateCustom()
    {
        This:SelectLayout["Custom"]
        This:ApplyWindowLayout
    } 

}

variable(global) bwlUplink BWLUplink

function main()
{
    while 1
        waitframe
}