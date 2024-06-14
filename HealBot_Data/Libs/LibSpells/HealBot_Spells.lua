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
        return hbSpell.name, hbSpell.iconID, hbSpell.castTime, hbSpell.minRange, hbSpell.maxRange, hbSpell.spellID
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

local function HealBot_Spells_GetNumTabsV1()
    return GetNumSpellTabs()
end

local function HealBot_Spells_GetNumTabsV11()
    return C_SpellBook.GetNumSpellBookSkillLines()
end

local function HealBot_Spells_GetSpellTabInfoV1(index)
    return GetSpellTabInfo(index)
end

local function HealBot_Spells_GetSpellTabInfoV11(index)
    return C_SpellBook.GetSpellBookSkillLineInfo(index)
end

local function HealBot_Spells_GetSpellBookItemInfoV1(index, bookType)
    return GetSpellBookItemInfo(index, bookType)
end

local function HealBot_Spells_GetSpellBookItemInfoV11(index, spellBank)
    hbSpell=C_SpellBook.GetSpellBookItemType(index, spellBank)
    if hbSpell then
        return hbSpell.spellType, hbSpell.id
    end
    return nil
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

local function HealBot_Spells_IsAttackSpellV1(spellId)
    return IsAttackSpell(spellId)
end

local function HealBot_Spells_IsAttackSpellV11(spellId)
    return C_Spell.IsAutoAttackSpell(spellId)
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

local HealBot_Spells_GetSpellName=HealBot_Spells_GetNameV1
local HealBot_Spells_GetSpellInfo=HealBot_Spells_GetInfoV1
local HealBot_Spells_GetSpellDesc=HealBot_Spells_GetSpellDescV1
local HealBot_Spells_GetSpellCooldown=HealBot_Spells_GetCooldownV1
local HealBot_Spells_GetNumTabs=HealBot_Spells_GetNumTabsV1
local HealBot_Spells_GetSpellTabInfo=HealBot_Spells_GetSpellTabInfoV1
local HealBot_Spells_GetSpellBookItemInfo=HealBot_Spells_GetSpellBookItemInfoV1
local HealBot_Spells_GetSpellLink=HealBot_Spells_GetSpellLinkV1
local HealBot_Spells_IsPassiveSpell=HealBot_Spells_IsPassiveSpellV1
local HealBot_Spells_PickupSpell=HealBot_Spells_PickupSpellV1
local HealBot_Spells_IsAttackSpell=HealBot_Spells_IsAttackSpellV1
local HealBot_Spells_GetSpellTexture=HealBot_Spells_GetSpellTextureV1
if C_Spell then
    if C_Spell.GetSpellName then
        HealBot_Spells_GetSpellName=HealBot_Spells_GetNameV9
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
    if C_Spell.IsAutoAttackSpell then
        HealBot_Spells_IsAttackSpell=HealBot_Spells_IsAttackSpellV11
    end
    if C_Spell.GetSpellTexture then
        HealBot_Spells_GetSpellTexture=HealBot_Spells_GetSpellTextureV11
    end
end
if C_SpellBook then
    if C_SpellBook.GetNumSpellBookSkillLines then
        HealBot_Spells_GetNumTabs=HealBot_Spells_GetNumTabsV11
    end
    if C_SpellBook.GetSpellBookSkillLineInfo then
        HealBot_Spells_GetSpellTabInfo=HealBot_Spells_GetSpellTabInfoV11
    end
    if C_SpellBook.GetSpellBookItemType then
        HealBot_Spells_GetSpellBookItemInfo=HealBot_Spells_GetSpellBookItemInfoV11
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

function HealBot_Spells_NumTabs()
    return HealBot_Spells_GetNumTabs()
end

function HealBot_Spells_TabInfo(index)
    return HealBot_Spells_GetSpellTabInfo(index)
end

function HealBot_Spells_ItemInfo(index, bookType)
    return HealBot_Spells_GetSpellBookItemInfo(index, bookType)
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

function HealBot_Spells_AttackSpell(spellId)
    return HealBot_Spells_IsAttackSpell(spellId)
end

function HealBot_Spells_Texture(spellId)
    return HealBot_Spells_GetSpellTexture(spellId)
end
