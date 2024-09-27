

local hbUnitTypes={[HEALBOT_TANK]=1,
                   [HEALBOT_HEALER]=2,
                   [HEALBOT_SELF]=3,
                   [HEALBOT_PRIVATELIST]=4,
                   [HEALBOT_PRIVATEFOCUS]=5,
                   [HEALBOT_RAID]=11,
                   [HEALBOT_GROUP]=12,
                   [HEALBOT_VEHICLE]=21,
                   [HEALBOT_PET]=22,
                   [HEALBOT_TARGET]=31,
                   [HEALBOT_TOT]=32,
                   [HEALBOT_TOF]=33,
                   [HEALBOT_PRIVFOCUSTOT]=8,
                   [HEALBOT_FOCUS]=38,
                   [HEALBOT_ENEMY]=41,
                   [HEALBOT_PLAYERTARGET]=42,
                   [HEALBOT_PRIVATETARGET]=43,}
                   
function hbVars_GetUnitType(uType)
    return hbUnitTypes[uType]
end       
            
function hbVars_IsUnitType(uType, tType)
    if uType == hbUnitTypes[tType] then
        return true
    end
    return false
end
            
function hbVars_IsNotUnitType(uType, tType)
    if uType ~= hbUnitTypes[tType] then
        return true
    end
    return false
end