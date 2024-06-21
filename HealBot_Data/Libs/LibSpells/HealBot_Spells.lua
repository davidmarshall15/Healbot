local hbSpell
HealBot_Spell_IDs={};
HealBot_Spell_Names={};

local function HealBot_Spells_GetNameV1(spellId)
    if HealBot_Spell_IDs[spellId] then
        return HealBot_Spell_IDs[spellId].name
    else
        return GetSpellInfo(spellId)
    end
end

local function HealBot_Spells_GetNameV9(spellId)
    if HealBot_Spell_IDs[spellId] then
        return HealBot_Spell_IDs[spellId].name
    else
        hbSpell=C_Spell.GetSpellName(spellId)
        if hbSpell then
            return hbSpell.name
        end
    end
    return nil
end

local function HealBot_Spells_GetInfoV1(spellId)
    return GetSpellInfo(spellId)
end

local function HealBot_Spells_GetInfoV11(spellId)
    hbSpell=C_Spell.GetSpellInfo(spellId)
    if hbSpell then
        return hbSpell.name, nil, hbSpell.iconID, hbSpell.castTime, hbSpell.minRange, hbSpell.maxRange, hbSpell.spellID
    end
    return nil
end

local function HealBot_Spells_GetCooldownV1(spellId)
    if HEALBOT_GAME_VERSION==4 and spellId==HEALBOT_SPELL_HOLYWORDSERENITY and HealBot_Aura_CurrentBuff(HealBot_Data["PGUID"], HEALBOT_CHAKRA_SERENITYNAME) then
        spellId=HEALBOT_SPELL_HOLYWORDCHASTISE
    end
    return GetSpellCooldown(spellId)
end

local function HealBot_Spells_GetCooldownV11(spellId)
    hbSpell=C_Spell.GetSpellCooldown(spellId)
    if hbSpell then
        return hbSpell.start, hbSpell.duration
    end
    return nil
end

local function HealBot_Spells_GetSpellDescV1(spellId)
    return GetSpellDescription(spellId)
end

local function HealBot_Spells_GetSpellDescV11(spellId)
    return C_Spell.GetSpellDescription(spellId)
end

local function HealBot_Spells_GetSpellLinkV1(spellId)
    return GetSpellLink(spellId)
end

local function HealBot_Spells_GetSpellLinkV11(spellId)
    return C_Spell.GetSpellLink(spellId)
end

local function HealBot_Spells_IsPassiveSpellV1(spellId)
    return IsPassiveSpell(spellId)
end

local function HealBot_Spells_IsPassiveSpellV11(spellId)
    return C_Spell.IsSpellPassive(spellId)
end

local function HealBot_Spells_PickupSpellV1(spellId)
    PickupSpell(spellId)
end

local function HealBot_Spells_PickupSpellV11(spellId)
    C_Spell.PickupSpell(spellId)
end

local function HealBot_Spells_GetSpellTextureV1(spellId)
    if HealBot_Spell_IDs[spellId] then 
        return HealBot_Spell_IDs[spellId].texture
    else
        return GetSpellTexture(spellId)
    end
end

local function HealBot_Spells_GetSpellTextureV11(spellId)
    if HealBot_Spell_IDs[spellId] then 
        return HealBot_Spell_IDs[spellId].texture
    else
        return C_Spell.GetSpellTexture(spellId)
    end
end

local function HealBot_Spells_GetSpellChargesV1(spellId)
    return GetSpellCharges(spellId)
end

local function HealBot_Spells_GetSpellChargesV11(spellId)
    return C_Spell.GetSpellCharges(spellId)
end

local function HealBot_Spells_GetSpellCountV1(spellId)
    return GetSpellCount(spellId)
end

local function HealBot_Spells_GetSpellCountV11(spellId)
    return C_Spell.GetSpellCount(spellId)
end

local function HealBot_Spells_GetSpellPowerCostV1(spellId)
    return GetSpellPowerCost(spellId)
end

local function HealBot_Spells_GetSpellPowerCostV11(spellId)
    return C_Spell.GetSpellPowerCost(spellId)
end

local function HealBot_Spells_IsHelpfulSpellV1(spellId)
    return IsHelpfulSpell(spellId)
end

local function HealBot_Spells_IsHelpfulSpellV11(spellId)
    return C_Spell.IsHelpfulSpell(spellId)
end

local function HealBot_Spells_GetSpellCountV101(spellId)
    return 1
end

local function HealBot_Spells_IsHelpfulSpellV101()
    return true
end

local HealBot_Spells_GetSpellName=HealBot_Spells_GetNameV1
local HealBot_Spells_GetSpellInfo=HealBot_Spells_GetInfoV1
local HealBot_Spells_GetSpellDesc=HealBot_Spells_GetSpellDescV1
local HealBot_Spells_GetSpellCooldown=HealBot_Spells_GetCooldownV1
local HealBot_Spells_GetSpellLink=HealBot_Spells_GetSpellLinkV1
local HealBot_Spells_IsPassiveSpell=HealBot_Spells_IsPassiveSpellV1
local HealBot_Spells_PickupSpell=HealBot_Spells_PickupSpellV1
local HealBot_Spells_GetSpellTexture=HealBot_Spells_GetSpellTextureV1
local HealBot_Spells_GetSpellCharges=HealBot_Spells_GetSpellChargesV1
local HealBot_Spells_GetSpellCount=HealBot_Spells_GetSpellCountV1
local HealBot_Spells_GetSpellPowerCost=HealBot_Spells_GetSpellPowerCostV1
local HealBot_Spells_IsHelpfulSpell=HealBot_Spells_IsHelpfulSpellV1
if C_Spell then
    local vMajor = string.split(".", select(1, GetBuildInfo()))
    local vGameVersion = tonumber(vMajor)
    if C_Spell.GetSpellInfo then
        HealBot_Spells_GetSpellName=HealBot_Spells_GetInfoV11
    end
    if C_Spell.GetSpellInfo then
        HealBot_Spells_GetSpellInfo=HealBot_Spells_GetInfoV11
    end
    if C_Spell.GetSpellDescription then
        HealBot_Spells_GetSpellDesc=HealBot_Spells_GetSpellDescV11
    end
    if C_Spell.GetSpellCooldown then
        HealBot_Spells_GetSpellCooldown=HealBot_Spells_GetCooldownV11
    end
    if C_Spell.GetSpellLink then
        HealBot_Spells_GetSpellLink=HealBot_Spells_GetSpellLinkV11
    end
    if C_Spell.IsSpellPassive then
        HealBot_Spells_IsPassiveSpell=HealBot_Spells_IsPassiveSpellV11
    end
    if C_Spell.PickupSpell then
        HealBot_Spells_PickupSpell=HealBot_Spells_PickupSpellV11
    end
    if C_Spell.GetSpellTexture then
        HealBot_Spells_GetSpellTexture=HealBot_Spells_GetSpellTextureV11
    end
    if C_Spell.GetSpellCharges then
        HealBot_Spells_GetSpellCharges=HealBot_Spells_GetSpellChargesV11
    end
    if C_Spell.GetSpellCount then
        HealBot_Spells_GetSpellCount=HealBot_Spells_GetSpellCountV11
    end
    if C_Spell.GetSpellPowerCost then
        HealBot_Spells_GetSpellPowerCost=HealBot_Spells_GetSpellPowerCostV11
    end
    if C_Spell.IsHelpfulSpell then
        HealBot_Spells_IsHelpfulSpell=HealBot_Spells_IsHelpfulSpellV11
    end
    if vGameVersion>10 then
        HealBot_Spells_GetSpellCount=HealBot_Spells_GetSpellCountV101
        HealBot_Spells_IsHelpfulSpell=HealBot_Spells_IsHelpfulSpellV101
    end
end
function HealBot_Spells_GetName(spellId)
    return HealBot_Spells_GetSpellName(spellId)
end

function HealBot_Spells_GetInfo(spellId)
    return HealBot_Spells_GetSpellInfo(spellId)
end

function HealBot_Spells_GetDesc(spellId)
    return HealBot_Spells_GetSpellDesc(spellId)
end

function HealBot_Spells_GetCooldown(spellId)
    return HealBot_Spells_GetSpellCooldown(spellId)
end

function HealBot_Spells_Link(spellId)
    return HealBot_Spells_GetSpellLink(spellId)
end

function HealBot_Spells_IsPassive(spellId)
    return HealBot_Spells_IsPassiveSpell(spellId)
end

function HealBot_Spells_Pickup(spellId)
    return HealBot_Spells_PickupSpell(spellId)
end

function HealBot_Spells_Texture(spellId)
    return HealBot_Spells_GetSpellTexture(spellId)
end

function HealBot_Spells_Charges(spellId)
    return HealBot_Spells_GetSpellCharges(spellId)
end

function HealBot_Spells_Count(spellId)
    return HealBot_Spells_GetSpellCount(spellId)
end

function HealBot_Spells_PowerCost(spellId)
    return HealBot_Spells_GetSpellPowerCost(spellId)
end

function HealBot_Spells_IsHelpful(spellId)
    return HealBot_Spells_IsHelpfulSpell(spellId)
end

-- C_SpellBook
local function HealBot_Spells_GetNumSpellTabsV1()
    return GetNumSpellTabs()
end

local function HealBot_Spells_GetNumSpellTabsV11()
    return C_SpellBook.GetNumSpellBookSkillLines()
end

local function HealBot_Spells_GetSpellTabInfoV1(index)
    return GetSpellTabInfo(index)
end

local function HealBot_Spells_GetSpellTabInfoV11(index)
    hbSpell=C_SpellBook.GetSpellBookSkillLineInfo(index)
    if hbSpell then
        return nil, nil, hbSpell.itemIndexOffset, hbSpell.numSpellBookItems, nil, hbSpell.offSpecID
    end
    return nil
end

local function HealBot_Spells_GetSpellBookItemInfoV1(index, bookType)
    return GetSpellBookItemInfo(index, bookType)
end

local function HealBot_Spells_GetSpellBookItemInfoV11(index, bookType)
    hbSpell=C_SpellBook.GetSpellBookItemInfo(index, bookType)
    if hbSpell then
        return hbSpell.spellType, hbSpell.id
    end
    return nil
end

local function HealBot_Spells_GetSpellBookItemNameV1(index, bookType)
    return GetSpellBookItemName(index, bookType)
end

local function HealBot_Spells_GetSpellBookItemNameV11(index, bookType)
    hbSpell=C_SpellBook.GetSpellBookItemName(index, bookType)
    if hbSpell then
        return hbSpell.spellName, hbSpell.spellSubName
    end
    return nil
end

local function HealBot_Spells_Broken()
    return nil
end

local HealBot_Spells_GetNumSpellTabs=HealBot_Spells_GetNumSpellTabsV1
local HealBot_Spells_GetSpellTabInfo=HealBot_Spells_GetSpellTabInfoV1
local HealBot_Spells_GetSpellBookItemInfo=HealBot_Spells_GetSpellBookItemInfoV1
local HealBot_Spells_GetSpellBookItemName=HealBot_Spells_GetSpellBookItemNameV1
if C_SpellBook then
    if C_SpellBook.GetNumSpellBookSkillLines then
        HealBot_Spells_GetNumSpellTabs=HealBot_Spells_GetNumSpellTabsV11
    end
    if C_SpellBook.GetSpellBookSkillLineInfo then
        HealBot_Spells_GetSpellTabInfo=HealBot_Spells_GetSpellTabInfoV11
    end
    if C_SpellBook.GetSpellBookItemType then
        HealBot_Spells_GetSpellBookItemInfo=HealBot_Spells_GetSpellBookItemInfoV11
    end
    if C_SpellBook.GetSpellBookItemName then
        HealBot_Spells_GetSpellBookItemName=HealBot_Spells_GetSpellBookItemNameV11
    end
end

function HealBot_Spells_NumSpellTabs()
    return HealBot_Spells_GetNumSpellTabs()
end

function HealBot_Spells_SpellTabInfo(index)
    return HealBot_Spells_GetSpellTabInfo(index)
end

function HealBot_Spells_SpellBookItemInfo(index, bookType)
    return HealBot_Spells_GetSpellBookItemInfo(index, bookType)
end

function HealBot_Spells_SpellBookItemName(index, bookType)
    return HealBot_Spells_GetSpellBookItemName(index, bookType)
end


-- C_Item

local function HealBot_Spells_GetItemInfoV1(itemId)
    return GetItemInfo(itemId)
end

local function HealBot_Spells_GetItemInfoV11(itemId)
    return C_Item.GetItemInfo(itemId)
end

local function HealBot_Spells_GetItemInfoInstantV1(itemId)
    return GetItemInfoInstant(itemId)
end

local function HealBot_Spells_GetItemInfoInstantV11(itemId)
    return C_Item.GetItemInfoInstant(itemId)
end

local HealBot_Spells_GetItemInfo=HealBot_Spells_GetItemInfoV1
local HealBot_Spells_GetItemInfoInstant=HealBot_Spells_GetItemInfoInstantV1
if C_Item then
    if C_Item.GetItemInfo then
        HealBot_Spells_GetItemInfo=HealBot_Spells_GetItemInfoV11
    end
    if C_Item.GetItemInfoInstant then
        HealBot_Spells_GetItemInfoInstant=HealBot_Spells_GetItemInfoInstantV11
    end
end

function HealBot_Spells_ItemInfo(itemId)
    return HealBot_Spells_GetItemInfo(itemId)
end

function HealBot_Spells_ItemInfoInstant(itemId)
    return HealBot_Spells_GetItemInfoInstant(itemId)
end

-- Util

local ksName=false
function HealBot_Spells_KnownByID(spellID)
      --HealBot_setCall("HealBot_KnownSpell")
    --if not spellID then return nil end
    if HealBot_Spell_IDs[spellID] then   
        return HealBot_Spell_IDs[spellID].name; 
    else
        ksName=HealBot_Spells_GetName(spellID) or false
        if ksName and HealBot_Spells_KnownByName(ksName) then
            return ksName
        end
    end
    return nil;
end

function HealBot_Spells_KnownByName(spellName)
    if spellName then
        return HealBot_Spell_Names[spellName] or HealBot_Init_knownClassicHealSpell(spellName) or HealBot_Spells_GetInfo(spellName)
    else
        return nil
    end
end

