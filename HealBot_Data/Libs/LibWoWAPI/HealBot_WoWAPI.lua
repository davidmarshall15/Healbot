local hbInfo
HealBot_Spell_IDs={};
HealBot_Spell_Names={};

-- C_Spell
local GetSpellInfo=GetSpellInfo
local GetSpellName=GetSpellInfo
local GetSpellCooldown=GetSpellCooldown
local function HealBot_WoWAPI_GetSpellCountV101(spellId)
    return 1
end

local function HealBot_WoWAPI_IsHelpfulSpellV101()
    return true
end

local function HealBot_WoWAPI_GetSpellNameV1(spellId)
    return GetSpellName(spellId)
end

local function HealBot_WoWAPI_GetSpellNameV11(spellId)
    hbInfo=GetSpellName(spellId)
    if hbInfo then
        return hbInfo.name
    end
    return nil
end

local function HealBot_WoWAPI_GetInfoV1(spellId)
    return GetSpellInfo(spellId)
end

local function HealBot_WoWAPI_GetInfoV11(spellId)
    hbInfo=GetSpellInfo(spellId)
    if hbInfo then
        return hbInfo.name, nil, hbInfo.iconID, hbInfo.castTime, hbInfo.minRange, hbInfo.maxRange, hbInfo.spellID
    end
    return nil
end

local function HealBot_WoWAPI_GetCooldownV1(spellId)
    if HEALBOT_GAME_VERSION==4 and spellId==HEALBOT_SPELL_HOLYWORDSERENITY and HealBot_Aura_CurrentBuff(HealBot_Data["PGUID"], HEALBOT_CHAKRA_SERENITYNAME) then
        spellId=HEALBOT_SPELL_HOLYWORDCHASTISE
    end
    return GetSpellCooldown(spellId)
end

local function HealBot_WoWAPI_GetCooldownV11(spellId)
    hbInfo=GetSpellCooldown(spellId)
    if hbInfo then
        return hbInfo.start, hbInfo.duration
    end
    return nil
end

local HealBot_WoWAPI_GetSpellName=HealBot_WoWAPI_GetSpellNameV1
local HealBot_WoWAPI_GetSpellInfo=HealBot_WoWAPI_GetInfoV1
local HealBot_WoWAPI_GetSpellCooldown=HealBot_WoWAPI_GetCooldownV1
local HealBot_WoWAPI_GetSpellLink=GetSpellLink
local HealBot_WoWAPI_IsPassiveSpell=IsPassiveSpell
local HealBot_WoWAPI_PickupSpell=PickupSpell
local HealBot_WoWAPI_GetSpellTexture=GetSpellTexture
local HealBot_WoWAPI_GetSpellCharges=GetSpellCharges
local HealBot_WoWAPI_GetSpellCount=GetSpellCount
local HealBot_WoWAPI_GetSpellPowerCost=GetSpellPowerCost
local HealBot_WoWAPI_IsHelpfulSpell=IsHelpfulSpell
local HealBot_WoWAPI_IsSpellInRange=IsSpellInRange
if C_Spell then
    if C_Spell.GetSpellName then
        HealBot_WoWAPI_GetSpellName=HealBot_WoWAPI_GetSpellNameV11
        GetSpellName=C_Spell.GetSpellName
    end
    if C_Spell.GetSpellInfo then
        HealBot_WoWAPI_GetSpellInfo=HealBot_WoWAPI_GetInfoV11
        GetSpellInfo=C_Spell.GetSpellInfo
    end
    if C_Spell.GetSpellCooldown then
    --    HealBot_WoWAPI_GetSpellCooldown=HealBot_WoWAPI_GetCooldownV11
    --    GetSpellCooldown=C_Spell.GetSpellCooldown
    end
    HealBot_WoWAPI_GetSpellLink=C_Spell.GetSpellLink or GetSpellLink
    HealBot_WoWAPI_IsPassiveSpell=C_Spell.IsSpellPassive or IsPassiveSpell
    HealBot_WoWAPI_PickupSpell=C_Spell.PickupSpell or PickupSpell
    HealBot_WoWAPI_GetSpellTexture=C_Spell.GetSpellTexture or GetSpellTexture
    HealBot_WoWAPI_GetSpellCharges=C_Spell.GetSpellCharges or GetSpellCharges
    HealBot_WoWAPI_GetSpellCount=C_Spell.GetSpellCount or GetSpellCount
    HealBot_WoWAPI_GetSpellPowerCost=C_Spell.GetSpellPowerCost or GetSpellPowerCost
    HealBot_WoWAPI_IsHelpfulSpell=C_Spell.IsHelpfulSpell or IsHelpfulSpell
    HealBot_WoWAPI_IsSpellInRange=C_Spell.IsSpellInRange or IsSpellInRange
    
    
    local vMajor = string.split(".", select(1, GetBuildInfo()))
    local vGameVersion = tonumber(vMajor)
    if vGameVersion>10 then
        HealBot_WoWAPI_GetSpellCount=HealBot_WoWAPI_GetSpellCountV101
        HealBot_WoWAPI_IsHelpfulSpell=HealBot_WoWAPI_IsHelpfulSpellV101
        GetSpellName=C_Spell.GetSpellInfo
    end
end

function HealBot_WoWAPI_SpellName(spellId)
    return HealBot_WoWAPI_GetSpellName(spellId or "X")
end

function HealBot_WoWAPI_SpellInfo(spellId)
    return HealBot_WoWAPI_GetSpellInfo(spellId or "X")
end

function HealBot_WoWAPI_SpellCooldown(spellId)
    return HealBot_WoWAPI_GetSpellCooldown(spellId or "X")
end

function HealBot_WoWAPI_SpellLink(spellId)
    return HealBot_WoWAPI_GetSpellLink(spellId or "X")
end

function HealBot_WoWAPI_IsSpellPassive(spellId)
    return HealBot_WoWAPI_IsPassiveSpell(spellId or "X")
end

function HealBot_WoWAPI_SpellPickup(spellId)
    return HealBot_WoWAPI_PickupSpell(spellId or "X")
end

function HealBot_WoWAPI_SpellTexture(spellId)
    return HealBot_WoWAPI_GetSpellTexture(spellId or "X")
end

function HealBot_WoWAPI_SpellCharges(spellId)
    return HealBot_WoWAPI_GetSpellCharges(spellId or "X")
end

function HealBot_WoWAPI_SpellCount(spellId)
    return HealBot_WoWAPI_GetSpellCount(spellId or "X")
end

function HealBot_WoWAPI_SpellPowerCost(spellId)
    return HealBot_WoWAPI_GetSpellPowerCost(spellId or "X")
end

function HealBot_WoWAPI_HelpfulSpell(spellId)
    return HealBot_WoWAPI_IsHelpfulSpell(spellId or "X")
end

function HealBot_WoWAPI_SpellInRange(spellId, unit)
    return HealBot_WoWAPI_IsSpellInRange(spellId or "X", unit)
end


-- C_SpellBook
local GetSpellTabInfo=GetSpellTabInfo
local GetSpellBookItemInfo=GetSpellBookItemInfo
local GetSpellBookItemName=GetSpellBookItemName
local function HealBot_WoWAPI_GetSpellTabInfoV1(index)
    return GetSpellTabInfo(index)
end

local function HealBot_WoWAPI_GetSpellTabInfoV11(index)
    hbInfo=GetSpellTabInfo(index)
    if hbInfo then
        return nil, nil, hbInfo.itemIndexOffset, hbInfo.numSpellBookItems, nil, hbInfo.offSpecID
    end
    return nil
end

local function HealBot_WoWAPI_GetSpellBookItemInfoV1(index, bookType)
    return GetSpellBookItemInfo(index, bookType)
end

local function HealBot_WoWAPI_GetSpellBookItemInfoV11(index, bookType)
    hbInfo=GetSpellBookItemInfo(index, bookType)
    if hbInfo then
        return hbInfo.spellType, hbInfo.id
    end
    return nil
end

local function HealBot_WoWAPI_GetSpellBookItemNameV1(index, bookType)
    return GetSpellBookItemName(index, bookType)
end

local function HealBot_WoWAPI_GetSpellBookItemNameV11(index, bookType)
    hbInfo=GetSpellBookItemName(index, bookType)
    if hbInfo then
        return hbInfo.spellName, hbInfo.spellSubName
    end
    return nil
end

local HealBot_WoWAPI_GetNumSpellTabs=GetNumSpellTabs
local HealBot_WoWAPI_GetSpellTabInfo=HealBot_WoWAPI_GetSpellTabInfoV1
local HealBot_WoWAPI_GetSpellBookItemInfo=HealBot_WoWAPI_GetSpellBookItemInfoV1
local HealBot_WoWAPI_GetSpellBookItemName=HealBot_WoWAPI_GetSpellBookItemNameV1
if C_SpellBook then
    HealBot_WoWAPI_GetNumSpellTabs=C_SpellBook.GetNumSpellBookSkillLines or GetNumSpellTabs
    if C_SpellBook.GetSpellBookSkillLineInfo then
        HealBot_WoWAPI_GetSpellTabInfo=HealBot_WoWAPI_GetSpellTabInfoV11
        GetSpellTabInfo=C_SpellBook.GetSpellBookSkillLineInfo
    end
    if C_SpellBook.GetSpellBookItemType then
        HealBot_WoWAPI_GetSpellBookItemInfo=HealBot_WoWAPI_GetSpellBookItemInfoV11
        GetSpellBookItemInfo=C_SpellBook.GetSpellBookItemType
    end
    if C_SpellBook.GetSpellBookItemName then
        HealBot_WoWAPI_GetSpellBookItemName=HealBot_WoWAPI_GetSpellBookItemNameV11
        GetSpellBookItemName=C_SpellBook.GetSpellBookItemName
    end
end

function HealBot_WoWAPI_NumSpellTabs()
    return HealBot_WoWAPI_GetNumSpellTabs()
end

function HealBot_WoWAPI_SpellTabInfo(index)
    return HealBot_WoWAPI_GetSpellTabInfo(index)
end

function HealBot_WoWAPI_SpellBookItemInfo(index, bookType)
    return HealBot_WoWAPI_GetSpellBookItemInfo(index, bookType)
end

function HealBot_WoWAPI_SpellBookItemName(index, bookType)
    return HealBot_WoWAPI_GetSpellBookItemName(index, bookType)
end


-- C_Item
local HealBot_WoWAPI_GetItemInfo=(C_Item and C_Item.GetItemInfo) or GetItemInfo
local HealBot_WoWAPI_GetItemInfoInstant=(C_Item and C_Item.GetItemInfoInstant) or GetItemInfoInstant
local HealBot_WoWAPI_IsUsableItem=(C_Item and C_Item.IsUsableItem) or IsUsableItem
local HealBot_WoWAPI_GetItemClassInfo=(C_Item and C_Item.GetItemClassInfo) or GetItemClassInfo

function HealBot_WoWAPI_ItemInfo(itemId)
    return HealBot_WoWAPI_GetItemInfo(itemId)
end

function HealBot_WoWAPI_ItemInfoInstant(itemId)
    return HealBot_WoWAPI_GetItemInfoInstant(itemId)
end

function HealBot_WoWAPI_UsableItem(itemId)
    return HealBot_WoWAPI_IsUsableItem(itemId)
end

function HealBot_WoWAPI_ItemClassInfo(itemId)
    return HealBot_WoWAPI_GetItemClassInfo(itemId)
end


-- C_AddOns
local HealBot_WoWAPI_AddOnLoad=(C_AddOns and C_AddOns.LoadAddOn) or LoadAddOn

function HealBot_WoWAPI_LoadAddOn(name)
    return HealBot_WoWAPI_AddOnLoad(name)
end
