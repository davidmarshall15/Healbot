local hbInfo, _
HealBot_Spell_IDs={};
HealBot_Spell_Names={};

local function HealBot_WoWAPI_True()
    return true
end

function HealBot_WoWAPI_SetAll()
    HealBot_WoWAPI_SetC_Spell()
    HealBot_WoWAPI_SetC_SpellBook()
    HealBot_WoWAPI_SetC_Item()
    HealBot_WoWAPI_SetC_AddOns()
end

-- GetSpellIDForSpellIdentifier
-- C_Spell
local GetSpellInfo=GetSpellInfo
local GetSpellName=GetSpellInfo
local GetSpellId=GetSpellInfo
local GetSpellCooldown=GetSpellCooldown
local GetSpellCount=GetSpellCount
local GetSpellCharges=GetSpellCharges

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

local function HealBot_WoWAPI_GetSpellIdV1(spellName)
    _, _, _, _, _, _, hbInfo=GetSpellId(spellName)
    return hbInfo
end

local function HealBot_WoWAPI_GetSpellIdV11(spellName)
    return GetSpellId(spellName)
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
    if HEALBOT_GAME_VERSION == 4 and (spellId == HEALBOT_SPELL_HOLYWORDSERENITY or spellId == HEALBOT_SPELL_HOLYWORDSANCTUARY) then
        spellId=HEALBOT_SPELL_HOLYWORDCHASTISE
    end
    return GetSpellCooldown(spellId)
end

local function HealBot_WoWAPI_GetCooldownV11(spellId)
    hbInfo=GetSpellCooldown(spellId)
    if hbInfo then
        return hbInfo.startTime, hbInfo.duration --, hbInfo.isEnabled, hbInfo.modRate
    end
    return nil
end

local function HealBot_WoWAPI_GetSpellChargesV1(spellId)
    return GetSpellCharges(spellId)
end

local function HealBot_WoWAPI_GetSpellCountV1(spellId)
    return GetSpellCount(spellId)
end

local function HealBot_WoWAPI_GetSpellChargesV11(spellId)
    hbInfo=GetSpellCharges(spellId)
    if hbInfo then
        return hbInfo.currentCharges --, hbInfo.maxCharges
    end
    return nil
end

local HealBot_WoWAPI_GetSpellName=HealBot_WoWAPI_GetSpellNameV1
local HealBot_WoWAPI_GetSpellId=HealBot_WoWAPI_GetSpellIdV1
local HealBot_WoWAPI_GetSpellInfo=HealBot_WoWAPI_GetInfoV1
local HealBot_WoWAPI_GetSpellCooldown=HealBot_WoWAPI_GetCooldownV1
local HealBot_WoWAPI_GetSpellCount=HealBot_WoWAPI_GetSpellCountV1
local HealBot_WoWAPI_GetSpellCharges=HealBot_WoWAPI_GetSpellChargesV1
local HealBot_WoWAPI_GetSpellLink=GetSpellLink
local HealBot_WoWAPI_IsPassiveSpell=IsPassiveSpell
local HealBot_WoWAPI_PickupSpell=PickupSpell
local HealBot_WoWAPI_GetSpellTexture=GetSpellTexture
local HealBot_WoWAPI_GetSpellPowerCost=GetSpellPowerCost
local HealBot_WoWAPI_IsHelpfulSpell=IsHelpfulSpell
local HealBot_WoWAPI_IsSpellInRange=IsSpellInRange

function HealBot_WoWAPI_SetC_Spell()
    if C_Spell then
        if C_Spell.GetSpellName then
            HealBot_WoWAPI_GetSpellName=HealBot_WoWAPI_GetSpellNameV11
           -- GetSpellName=C_Spell.GetSpellName
            GetSpellName=C_Spell.GetSpellInfo
        end
        if C_Spell.GetSpellIDForSpellIdentifier then
            HealBot_WoWAPI_GetSpellId=HealBot_WoWAPI_GetSpellIdV11
            GetSpellId=C_Spell.GetSpellIDForSpellIdentifier
        end
        if C_Spell.GetSpellInfo then
            HealBot_WoWAPI_GetSpellInfo=HealBot_WoWAPI_GetInfoV11
            GetSpellInfo=C_Spell.GetSpellInfo
        end
        if C_Spell.GetSpellCooldown then
            HealBot_WoWAPI_GetSpellCooldown=HealBot_WoWAPI_GetCooldownV11
            GetSpellCooldown=C_Spell.GetSpellCooldown
        end
        if C_Spell.GetSpellCharges then
            HealBot_WoWAPI_GetSpellCount=HealBot_WoWAPI_GetSpellChargesV11
            HealBot_WoWAPI_GetSpellCharges=HealBot_WoWAPI_GetSpellChargesV11
            GetSpellCharges=C_Spell.GetSpellCharges
        end
        if C_Spell.GetSpellCount then
            HealBot_WoWAPI_GetSpellCount=HealBot_WoWAPI_GetSpellChargesV11
            HealBot_WoWAPI_GetSpellCharges=HealBot_WoWAPI_GetSpellChargesV11
            GetSpellCharges=C_Spell.GetSpellCharges
        end
        HealBot_WoWAPI_GetSpellLink=C_Spell.GetSpellLink or GetSpellLink
        HealBot_WoWAPI_IsPassiveSpell=C_Spell.IsSpellPassive or IsPassiveSpell
        HealBot_WoWAPI_PickupSpell=C_Spell.PickupSpell or PickupSpell
        HealBot_WoWAPI_GetSpellTexture=C_Spell.GetSpellTexture or GetSpellTexture
        HealBot_WoWAPI_GetSpellPowerCost=C_Spell.GetSpellPowerCost or GetSpellPowerCost
        HealBot_WoWAPI_IsHelpfulSpell=C_Spell.IsHelpfulSpell or IsHelpfulSpell
        HealBot_WoWAPI_IsSpellInRange=C_Spell.IsSpellInRange or IsSpellInRange


        local vMajor=string.split(".", select(1, GetBuildInfo()))
        local vGameVersion=tonumber(vMajor)
        if vGameVersion>10 then
            HealBot_WoWAPI_IsHelpfulSpell=HealBot_WoWAPI_True
        end
    end
end

function HealBot_WoWAPI_SpellName(spellId)
    return HealBot_WoWAPI_GetSpellName(spellId or "X")
end

function HealBot_WoWAPI_SpellId(spellName)
    return HealBot_WoWAPI_GetSpellId(spellName or "X")
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
        return nil, nil, hbInfo.itemIndexOffset, hbInfo.numSpellBookItems, nil, 0 --hbInfo.isOffSpec
    end
    return nil
end

local function HealBot_WoWAPI_GetSpellBookItemInfoV1(index)
    return GetSpellBookItemInfo(index, BOOKTYPE_SPELL)
end

local SpellBookItemtypes={[1]="SPELL", [3]="SPELL", [4]="FLYOUT"}
local function HealBot_WoWAPI_GetSpellBookItemInfoV11(index)
    hbInfo=GetSpellBookItemInfo(index, Enum.SpellBookSpellBank.Player)
    if hbInfo and hbInfo.itemType then
        return SpellBookItemtypes[hbInfo.itemType], hbInfo.actionID
    else
        hbInfo=GetSpellBookItemInfo(index, Enum.SpellBookSpellBank.Pet)
        if hbInfo and hbInfo.itemType then
            return SpellBookItemtypes[hbInfo.itemType], hbInfo.actionID
        end
    end
    return nil
end

local function HealBot_WoWAPI_GetSpellBookItemNameV1(index)
    return GetSpellBookItemName(index, BOOKTYPE_SPELL)
end

local function HealBot_WoWAPI_GetSpellBookItemNameV11(index)
    hbInfo=GetSpellBookItemName(index, Enum.SpellBookSpellBank.Player)
    if hbInfo then
        return hbInfo.spellName, hbInfo.spellSubName
    end
    return nil
end

local HealBot_WoWAPI_GetNumSpellTabs=GetNumSpellTabs
local HealBot_WoWAPI_GetSpellTabInfo=HealBot_WoWAPI_GetSpellTabInfoV1
local HealBot_WoWAPI_GetSpellBookItemInfo=HealBot_WoWAPI_GetSpellBookItemInfoV1
local HealBot_WoWAPI_GetSpellBookItemName=HealBot_WoWAPI_GetSpellBookItemNameV1

function HealBot_WoWAPI_SetC_SpellBook()
    if C_SpellBook then
        HealBot_WoWAPI_GetNumSpellTabs=C_SpellBook.GetNumSpellBookSkillLines or GetNumSpellTabs
        if C_SpellBook.GetSpellBookSkillLineInfo then
            HealBot_WoWAPI_GetSpellTabInfo=HealBot_WoWAPI_GetSpellTabInfoV11
            GetSpellTabInfo=C_SpellBook.GetSpellBookSkillLineInfo
        end
        if C_SpellBook.GetSpellBookItemInfo then
            HealBot_WoWAPI_GetSpellBookItemInfo=HealBot_WoWAPI_GetSpellBookItemInfoV11
            GetSpellBookItemInfo=C_SpellBook.GetSpellBookItemInfo
        end
        if C_SpellBook.GetSpellBookItemName then
            HealBot_WoWAPI_GetSpellBookItemName=HealBot_WoWAPI_GetSpellBookItemNameV11
            GetSpellBookItemName=C_SpellBook.GetSpellBookItemName
        end
    end
end

function HealBot_WoWAPI_NumSpellTabs()
    return HealBot_WoWAPI_GetNumSpellTabs()
end

function HealBot_WoWAPI_SpellTabInfo(index)
    return HealBot_WoWAPI_GetSpellTabInfo(index)
end

function HealBot_WoWAPI_SpellBookItemInfo(index)
    return HealBot_WoWAPI_GetSpellBookItemInfo(index)
end

function HealBot_WoWAPI_SpellBookItemName(index)
    return HealBot_WoWAPI_GetSpellBookItemName(index)
end


-- C_Item
local HealBot_WoWAPI_GetItemInfo=GetItemInfo
local HealBot_WoWAPI_GetItemInfoInstant=GetItemInfoInstant
local HealBot_WoWAPI_IsUsableItem=IsUsableItem
local HealBot_WoWAPI_GetItemClassInfo=GetItemClassInfo

function HealBot_WoWAPI_SetC_Item()
    if C_Item then
        HealBot_WoWAPI_GetItemInfo=C_Item.GetItemInfo or GetItemInfo
        HealBot_WoWAPI_GetItemInfoInstant=C_Item.GetItemInfoInstant or GetItemInfoInstant
        HealBot_WoWAPI_IsUsableItem=C_Item.IsUsableItem or IsUsableItem
        HealBot_WoWAPI_GetItemClassInfo=C_Item.GetItemClassInfo or GetItemClassInfo
    end
end

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
local HealBot_WoWAPI_AddOnLoad=LoadAddOn
function HealBot_WoWAPI_SetC_AddOns()
    if C_AddOns then
        HealBot_WoWAPI_AddOnLoad=C_AddOns.LoadAddOn or LoadAddOn
    end
end

function HealBot_WoWAPI_LoadAddOn(name)
    return HealBot_WoWAPI_AddOnLoad(name)
end
