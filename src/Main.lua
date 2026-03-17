-- Corrosive Armor Tracker
-- Main.lua - Entry point and initialization

local ADDON_NAME = "CorrosiveArmorTracker"
local ADDON_VERSION = "1.0.0"

-- Global namespace
CAT = {}

-- Default configuration
local defaults = {
    enabled = true,
    soundEnabled = true,
    visualEnabled = true,
}

-- Initialize saved variables
CAT.savedVars = ZO_SavedVars:NewAccountWide(
    "CorrosiveArmorTrackerSavedVars",
    1,
    nil,
    defaults
)

-- Addon initialization
local function OnAddOnLoaded(eventCode, addOnName)
    if addOnName ~= ADDON_NAME then 
        return 
    end
    
    -- Initialize modules
    CAT.Tracking.Initialize()
    CAT.UI.Initialize()
    CAT.Settings.Initialize()
    
    -- Register slash command
    SLASH_COMMANDS["/cat"] = CAT.SlashCommand
    
    -- Unregister this event
    EVENT_MANAGER:UnregisterForEvent("CAT_AddOnLoaded", EVENT_ADD_ON_LOADED)
    
    d("[CAT] Corrosive Armor Tracker v" .. ADDON_VERSION .. " loaded. Use /cat for commands.")
end

-- Slash command handler
function CAT.SlashCommand(input)
    local args = {}
    for arg in string.gmatch(input, "%S+") do
        table.insert(args, arg)
    end
    
    if #args == 0 then
        d("=== Corrosive Armor Tracker ===")
        d("Enabled: " .. tostring(CAT.savedVars.enabled))
        d("Sound Alerts: " .. tostring(CAT.savedVars.soundEnabled))
        d("Visual Alerts: " .. tostring(CAT.savedVars.visualEnabled))
        d("Commands: /cat toggle, /cat sound, /cat visual")
        return
    end
    
    local cmd = string.lower(args[1])
    
    if cmd == "toggle" then
        CAT.savedVars.enabled = not CAT.savedVars.enabled
        d("[CAT] Enabled: " .. tostring(CAT.savedVars.enabled))
        CAT.UI.UpdateVisibility()
    elseif cmd == "sound" then
        CAT.savedVars.soundEnabled = not CAT.savedVars.soundEnabled
        d("[CAT] Sound Alerts: " .. tostring(CAT.savedVars.soundEnabled))
    elseif cmd == "visual" then
        CAT.savedVars.visualEnabled = not CAT.savedVars.visualEnabled
        d("[CAT] Visual Alerts: " .. tostring(CAT.savedVars.visualEnabled))
        CAT.UI.UpdateVisibility()
    else
        d("[CAT] Unknown command. Use: /cat, /cat toggle, /cat sound, /cat visual")
    end
end

-- Register for addon loaded event
EVENT_MANAGER:RegisterForEvent("CAT_AddOnLoaded", EVENT_ADD_ON_LOADED, OnAddOnLoaded)
