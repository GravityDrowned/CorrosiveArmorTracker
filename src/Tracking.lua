-- Corrosive Armor Tracker
-- Tracking.lua - Event handling and tracking logic

CAT.Tracking = CAT.Tracking or {}

-- Corrosive Armor ability ID
local CORROSIVE_ARMOR_ID = 17878

-- Currently tracked units with Corrosive Armor active
CAT.trackedUnits = {}

-- Currently hovered unit
CAT.hoveredUnit = nil

-- Initialize tracking module
function CAT.Tracking.Initialize()
    -- Register for effect changes (track buff gain/fade)
    EVENT_MANAGER:RegisterForEvent(
        "CAT_EffectChanged",
        EVENT_EFFECT_CHANGED,
        CAT.Tracking.OnEffectChanged
    )
    
    -- Add filter to only track effects on ALL units
    EVENT_MANAGER:AddFilterForEvent(
        "CAT_EffectChanged",
        EVENT_EFFECT_CHANGED,
        REGISTER_FILTER_ABILITY_ID,
        CORROSIVE_ARMOR_ID
    )
    
    -- Register for reticle target changes (hover detection)
    EVENT_MANAGER:RegisterForEvent(
        "CAT_ReticleChanged",
        EVENT_RETICLE_TARGET_CHANGED,
        CAT.Tracking.OnReticleTargetChanged
    )
    
    d("[CAT] Tracking module initialized (watching ability ID: " .. CORROSIVE_ARMOR_ID .. ")")
end

-- Handle effect changes (Corrosive Armor gained/faded)
function CAT.Tracking.OnEffectChanged(eventCode, changeType, effectSlot, effectName, unitTag, 
                                      beginTime, endTime, stackCount, iconName, buffType, 
                                      effectType, abilityType, statusEffectType, unitName, 
                                      unitId, abilityId, sourceType)
    
    if not CAT.savedVars.enabled then
        return
    end
    
    -- Only track if ability ID matches (filter should handle this, but double check)
    if abilityId ~= CORROSIVE_ARMOR_ID then
        return
    end
    
    -- Get unit name
    local targetName = GetUnitName(unitTag)
    if not targetName or targetName == "" then
        return
    end
    
    if changeType == EFFECT_RESULT_GAINED then
        -- Corrosive Armor activated
        CAT.trackedUnits[targetName] = {
            unitTag = unitTag,
            endTime = endTime,
            unitName = targetName,
        }
        d("[CAT] Corrosive Armor ACTIVE on: " .. targetName)
        
        -- Update UI if we're hovering this unit
        if CAT.hoveredUnit == targetName then
            CAT.UI.ShowWarning(targetName)
        end
        
    elseif changeType == EFFECT_RESULT_FADED then
        -- Corrosive Armor ended
        CAT.trackedUnits[targetName] = nil
        d("[CAT] Corrosive Armor FADED from: " .. targetName)
        
        -- Hide UI if we're hovering this unit
        if CAT.hoveredUnit == targetName then
            CAT.UI.HideWarning()
        end
    end
end

-- Handle reticle target changes (hover)
function CAT.Tracking.OnReticleTargetChanged(eventCode)
    if not CAT.savedVars.enabled then
        return
    end
    
    -- Get the unit under the reticle
    local unitTag = "reticleover"
    local targetName = GetUnitName(unitTag)
    
    -- Update hovered unit
    CAT.hoveredUnit = targetName
    
    -- Check if this unit has Corrosive Armor active
    if targetName and CAT.trackedUnits[targetName] then
        CAT.UI.ShowWarning(targetName)
    else
        CAT.UI.HideWarning()
    end
end
