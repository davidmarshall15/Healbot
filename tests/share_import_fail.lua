-- Malformed import text shows the import failed popup instead of raising a Lua error.
local passed=0
local function eq(actual,expected,label)
    assert(actual==expected,label..": expected "..tostring(expected)..", got "..tostring(actual))
    passed=passed+1
end
local file=assert(io.open(arg[1] or "HealBot/HealBot_Share.lua","rb"))
local source=file:read("*a"):gsub("\r\n","\n")
file:close()
local function grab(pattern,name)
    return assert(source:match(pattern),name)
end
local chunk=grab("(local function HealBot_Share_ImportFail%b().-\nend)\n","ImportFail")
for _,name in ipairs({"PresetCols","Spells","Buffs","Debuffs"}) do
    chunk=chunk.."\n"..grab("(function HealBot_Share_Load"..name.."%b().-\nend)\n","Load"..name)
end

function string.split(sep,str)
    local out,i={},1
    while true do
        local j=str:find(sep,i,true)
        if not j then out[#out+1]=str:sub(i);break end
        out[#out+1]=str:sub(i,j-1);i=j+#sep
    end
    return unpack(out)
end

local shown
local env=setmetatable({
    HEALBOT_OPTIONS_IMPORT_FAIL1="Import failed:",HEALBOT_OPTIONS_IMPORT_FAIL2="Reason:",CLOSE="Close",
    StaticPopupDialogs={},StaticPopup_Show=function(name) shown=name end,
    HealBot_Util_Decompress=function(s) return s end,
    HealBot_Globals={},HealBot_Config_Spells={},
    HealBot_Share_luVars={InMethodSpell=0,InMethodBuff=0,InMethodDebuff=0},
    HealBot_Action_retComboKeysList=function() return {} end,
    HealBot_Action_ClearSpellCache=function() end,
}, {__index=function(_,k)
    if type(k)=="string" and k:find("^HealBot_") then return function() end end
    return _G[k]
end})
setfenv(assert(loadstring(chunk)),env)()

local cases={
    {"LoadPresetCols","Preset Colours","header\nTest~0.2,0.2,0.902"},
    {"LoadSpells","Spells","header\nFlash Heal~1,1~1,2061"},
    {"LoadBuffs","Buffs","header\nBuff~x~1"},
    {"LoadDebuffs","Debuffs","header\nDebuff~x~1"},
}
for _,case in ipairs(cases) do
    local fn,label,text=case[1],case[2],case[3]
    shown=nil
    env.StaticPopupDialogs.HEALBOT_SHARE_IMPORTFAIL=nil
    local ok,err=pcall(env["HealBot_Share_"..fn],text)
    eq(ok,true,fn.." runs without error: "..tostring(err))
    eq(shown,"HEALBOT_SHARE_IMPORTFAIL",fn.." shows the import failed popup")
    local popup=env.StaticPopupDialogs.HEALBOT_SHARE_IMPORTFAIL
    eq(popup.text:find(label,1,true)~=nil,true,fn.." popup names "..label)
end

print("Share import failure tests passed: "..passed)
