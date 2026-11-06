-- Exercise the actual tooltip refresh, including native text handoff. The
-- sentinel rejects Lua comparisons/arithmetic; concatenation propagates it.
local passed=0
local function eq(actual,expected,label)
    assert(actual==expected,label)
    passed=passed+1
end
local function forbidden() error("attempt to inspect a secret tooltip value") end
local secret
secret=setmetatable({}, {__lt=forbidden,__le=forbidden,__add=forbidden,
    __sub=forbidden,__mul=forbidden,__div=forbidden,__concat=function() return secret end})
local file=assert(io.open(arg[1] or "HealBot_Tips/HealBot_Tooltip.lua","rb"))
local source=file:read("*a"):gsub("\r\n","\n")
file:close()
local refresh=assert(source:match("(function HealBot_Action_DoRefreshTooltip%(%).-)\nfunction HealBot_Action_RefreshTooltip"))
local function noop() end
local function run(game,client,health,maxHealth,mana,maxMana,showHealth)
    local lines,reads={},{}
    local shown=false
    local button={unit="player",guid="test",frame=1,level=20,role=0,rank=0,
        health={current=health,max=maxHealth,cpct=50,rcol=1,gcol=1},
        mana={current=mana,max=maxMana,pct=50,r=1,g=1,b=1},
        text={nameonly="Test",tag="",r=1,g=1,b=1},
        aura={debuff={},buff={}},aggro={threatpct=0},status={}}
    local env=setmetatable({
        HEALBOT_GAME_VERSION=game,HEALBOT_CLIENT_VERSION=client,
        HealBot_Globals={ShowTooltip=true,Tooltip_ShowTarget=true,
            Tooltip_ShowHealth=showHealth,Tooltip_ShowMana=true},
        HealBot_Data={TIPBUTTON=button,TIPTYPE="Enabled",UILOCK=false},
        HealBot_Tooltip_luVars={},powerCols={},tipsAuraWatch={},
        hbTip={ClearLines=noop},
        UnitGUID=function() return "test" end,
        UnitExists=function() return true end,
        UnitCreatureFamily=function() return "Paladin" end,
        IsInRaid=function() return false end,
        HealBot_UnitZone=function() return "Zone" end,
        HealBot_retIsInVehicle=function() return nil end,
        HealBot_Action_GetTimeOffline=function() return nil end,
        HealBot_ToolTip_SetTooltipPos=noop,
        HealBot_ToolTip_ShowHoT=noop,
        HealBot_Tooltip_Show=function() shown=true end,
        HealBot_Tooltip_SetLine=function(left,lr,lg,lb,la,right)
            lines[#lines+1]={left=left,right=right}
        end,
        HealBot_issecretvalue=function(value) return rawequal(value,secret) end,
        HealBot_Util_isMidnight=function() return client>=12 end,
        HealBot_Util_ReadNumber=function(value)
            assert(not rawequal(value,secret),"secret value reached numeric formatter")
            reads[#reads+1]=value
            return tostring(value)
        end,
        format=string.format,strfind=string.find,
    }, {__index=_G})
    for i=1,8 do env.tipsAuraWatch[i]={} end
    setfenv(assert(loadstring(refresh)),env)()
    env.HealBot_Action_DoRefreshTooltip()
    eq(shown,true,"tooltip refresh must complete")
    local healthLine,manaLine
    for _,line in ipairs(lines) do
        if line.left=="Zone" then healthLine=line.right end
        if line.left==" " and line.right then manaLine=line.right end
    end
    return healthLine,manaLine,reads
end

for _,case in ipairs({
    {secret,100,secret,200}, -- reported health + mana combination
    {50,secret,100,200},
    {secret,secret,secret,secret},
    {50,100,secret,200}, -- health readable, mana still protected
}) do
    local h,m,reads=run(1,12,case[1],case[2],case[3],case[4],true)
    eq(#reads,0,"Forever must not call the legacy numeric formatter")
    if rawequal(case[1],secret) or rawequal(case[2],secret) then
        eq(h,secret,"protected health reaches native tooltip text")
    else
        eq(h,"50/100 (50%)","readable health text retained")
    end
    if rawequal(case[4],secret) then
        eq(m,nil,"restricted maximum mana retains existing omission")
    elseif rawequal(case[3],secret) then
        eq(m,secret,"protected mana reaches native tooltip text")
    else
        eq(m,"100/200 (50%)","readable mana text retained")
    end
end
local h,m,reads=run(1,12,secret,100,secret,200,false)
eq(h,nil,"health display can be disabled with secret health")
eq(m,secret,"mana can still display when health is disabled")
eq(#reads,0,"hidden health does not enable legacy formatting")

for _,client in ipairs({1,5}) do
    h,m,reads=run(client,client,150,100,100,200,true)
    eq(h,"100/100 (50%)","readable overheal still clamps on legacy clients")
    eq(m,"100/200 (50%)","legacy mana text retained")
    eq(#reads,4,"legacy health and mana formatting retained")
end
h,m,reads=run(12,12,secret,100,secret,200,true)
eq(h,secret,"retail secret health reaches native text")
eq(m,secret,"retail secret mana reaches native text")
eq(#reads,0,"retail skips legacy numeric formatting")
print("PASS: "..passed.." tooltip regression assertions (mock APIs)")
