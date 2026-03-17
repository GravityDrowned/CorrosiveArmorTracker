-- Corrosive Armor Tracker
-- UI.lua - Visual warning display

CAT.UI = CAT.UI or {}

-- UI element references
local warningContainer = nil
local warningLabel = nil
local warningBackground = nil

-- Initialize UI module
function CAT.UI.Initialize()
    -- Create top-level window
    warningContainer = WINDOW_MANAGER:CreateTopLevelWindow("CATWarningContainer")
     warningContainer:SetDimensions(500, 80)
     warningContainer:SetAnchor(TOP, GuiRoot, TOP, 0, 100)
    warningContainer:SetHidden(true)
    warningContainer:SetDrawLayer(DL_OVERLAY)
    warningContainer:SetDrawLevel(1000)
    
    -- Create background
    warningBackground = WINDOW_MANAGER:CreateControl("CATWarningBackground", warningContainer, CT_BACKDROP)
    warningBackground:SetAnchorFill(warningContainer)
    warningBackground:SetCenterColor(0.8, 0.1, 0.1, 0.9)
    warningBackground:SetEdgeColor(1.0, 0.2, 0.2, 1.0)
    warningBackground:SetEdgeTexture("EsoUI/Art/Miscellaneous/borderOverlay_simple.dds", 256, 256, 16)
    
    -- Create label
    warningLabel = WINDOW_MANAGER:CreateControl("CATWarningLabel", warningContainer, CT_LABEL)
    warningLabel:SetAnchor(CENTER, warningContainer, CENTER, 0, 0)
    warningLabel:SetFont("ZoFontWinH1")
    warningLabel:SetColor(1.0, 0.8, 0.0, 1.0)
    warningLabel:SetText("⚠ CORROSIVE ARMOR ACTIVE ⚠")
    warningLabel:SetHorizontalAlignment(TEXT_ALIGN_CENTER)
    warningLabel:SetVerticalAlignment(TEXT_ALIGN_CENTER)
    
    d("[CAT] UI module initialized")
end

-- Show warning
function CAT.UI.ShowWarning(unitName)
    if not CAT.savedVars.visualEnabled then
        return
    end
    
    if warningContainer and warningLabel then
        warningLabel:SetText("⚠ CORROSIVE ARMOR ACTIVE ⚠\n" .. unitName)
        warningContainer:SetHidden(false)
        
        -- Play sound if enabled
        if CAT.savedVars.soundEnabled then
            PlaySound(SOUNDS.DUEL_START)
        end
    end
end

-- Hide warning
function CAT.UI.HideWarning()
    if warningContainer then
        warningContainer:SetHidden(true)
    end
end

-- Update visibility based on settings
function CAT.UI.UpdateVisibility()
    if not CAT.savedVars.enabled or not CAT.savedVars.visualEnabled then
        CAT.UI.HideWarning()
    end
end
