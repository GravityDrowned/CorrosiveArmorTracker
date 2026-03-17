-- Corrosive Armor Tracker
-- Settings.lua - Settings panel integration

CAT.Settings = CAT.Settings or {}

-- Panel metadata
local ADDON_NAME = "Corrosive Armor Tracker"
local ADDON_VERSION = "1.0.0"
local PANEL_NAME = "CAT_SettingsPanel"

-- Initialize settings module
function CAT.Settings.Initialize()
    -- Check if LibAddonMenu is available
    if not LibAddonMenu2 then
        d("[CAT] LibAddonMenu-2.0 not found - settings panel disabled")
        return
    end
    
    -- Create the addon panel
    local panelData = {
        type = "panel",
        name = ADDON_NAME,
        displayName = "|cFFD700" .. ADDON_NAME .. "|r",
        author = "ESO Addon Developer",
        version = ADDON_VERSION,
        registerForRefresh = true,
        registerForDefaults = true,
    }
    
    LibAddonMenu2:RegisterAddonPanel(PANEL_NAME, panelData)
    
    -- Create the settings controls
    local optionsData = {
        -- Header: General Settings
        {
            type = "header",
            name = "General Settings",
        },
        
        -- Enable/Disable addon
        {
            type = "checkbox",
            name = "Enable Addon",
            tooltip = "Master toggle to enable or disable the addon entirely.",
            getFunc = function() return CAT.savedVars.enabled end,
            setFunc = function(value) 
                CAT.savedVars.enabled = value
                CAT.UI.UpdateVisibility()
            end,
            default = true,
            width = "full",
        },
        
        -- Header: Alert Settings
        {
            type = "header",
            name = "Alert Settings",
        },
        
        -- Visual alerts toggle
        {
            type = "checkbox",
            name = "Visual Alerts",
            tooltip = "Show on-screen warning banner when hovering enemies with Corrosive Armor active.",
            getFunc = function() return CAT.savedVars.visualEnabled end,
            setFunc = function(value) 
                CAT.savedVars.visualEnabled = value
                CAT.UI.UpdateVisibility()
            end,
            default = true,
            width = "full",
        },
        
        -- Sound alerts toggle
        {
            type = "checkbox",
            name = "Sound Alerts",
            tooltip = "Play sound effect when hovering enemies with Corrosive Armor active.",
            getFunc = function() return CAT.savedVars.soundEnabled end,
            setFunc = function(value) 
                CAT.savedVars.soundEnabled = value
            end,
            default = true,
            width = "full",
        },
        
        -- Header: About
        {
            type = "header",
            name = "About",
        },
        
        -- Description
        {
            type = "description",
            text = "Corrosive Armor Tracker monitors when opponents activate the Corrosive Armor ultimate ability (DK ultimate).\n\nWhen you hover your cursor over an enemy with Corrosive Armor active, a prominent warning banner will appear on your screen.\n\nAbility ID tracked: 17878",
            width = "full",
        },
        
        -- Slash commands reference
        {
            type = "description",
            title = "Slash Commands",
            text = "/cat - Show addon status\n/cat toggle - Enable/disable addon\n/cat sound - Toggle sound alerts\n/cat visual - Toggle visual alerts",
            width = "full",
        },
    }
    
    LibAddonMenu2:RegisterOptionControls(PANEL_NAME, optionsData)
    
    d("[CAT] Settings panel initialized")
end
