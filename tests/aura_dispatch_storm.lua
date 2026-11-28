-- Replay the installed event, queue and timed scanner dispatch. The scanner
-- boundary counts full-family visits and clears its dirty bit as in the addon.
local prefix=arg[1] or "HealBot"
local baseline=arg[2]=="baseline"
local function read(path)
    local file=assert(io.open(path,"rb"))
    local source=file:read("*a"):gsub("\r\n","\n")
    file:close()
    return source
end
local event=read(prefix.."/HealBot_Events.lua")
local start=event:find("local function ReadableAuraTable",1,true) or assert(event:find("function HealBot_Events_UnitAura(",1,true))
local stop=assert(event:find("function HealBot_Events_UnitManaUpdate(",start,true))
local core=read(prefix.."/HealBot.lua")
local work=assert(core:match("elseif (button%.event%.aura then.-)\n            if hbActionFallWatch"))
local unknown=setmetatable({},{__index=function() error("opaque field read") end})
local blocked=setmetatable({},{__index=function() error("inaccessible table read") end})
local counts={buff=0,debuff=0}
local env=setmetatable({
    HEALBOT_FOREVER=true,
    HealBot_issecretvalue=function(v) return rawequal(v,unknown) end,
    canaccesstable=function(v) return not rawequal(v,blocked) end,
    HealBot_Aura_CheckUnitAuras=function(button,harmful)
        local side=harmful and "debuff" or "buff"
        assert(button.aura[side].update,"scanner invoked without a dirty family")
        counts[side]=counts[side]+1
        button.aura[side].update=false
    end,
},{__index=_G})
setfenv(assert(loadstring(event:sub(start,stop-1))),env)()
local drain=setfenv(assert(loadstring("return function(button) if "..work.."\nend")),env)()
local function unit(i)
    return {unit="raid"..i,status={unittype=1},event={},aura={buff={},debuff={}}}
end
local hot={isHelpful=true,isHarmful=false}
local bad={isHelpful=false,isHarmful=true}
local function delta(a) return {isFullUpdate=false,addedAuras={a}} end
local raid={}
for i=1,40 do raid[i]=unit(i) end
local function burst(coalesce)
    counts.buff,counts.debuff=0,0
    for wave=1,40 do
        local payload=delta(wave%2==0 and bad or hot)
        for _,button in ipairs(raid) do
            env.HealBot_Events_UnitAura(button,button.unit,payload)
            if not coalesce then drain(button) end
        end
    end
    if coalesce then for _,button in ipairs(raid) do drain(button) end end
    return counts.buff+counts.debuff
end
local spaced=burst(false)
local coalesced=burst(true)
assert(spaced==(baseline and 3200 or 1600) and coalesced==80)
-- Any unavailable data, mixed family, removal or update keeps both full
-- scans. Classic and callers without event data keep the original dispatch.
local b=raid[1]
local function expect(payload,hw,dw)
    counts.buff,counts.debuff=0,0
    env.HealBot_Events_UnitAura(b,b.unit,payload)
    drain(b)
    assert(counts.buff==hw and counts.debuff==dw,"incorrect family dispatch")
end
expect(nil,1,1)
for _,info in ipairs({
    unknown,blocked,{}, {isFullUpdate=true,addedAuras={hot}}, {isFullUpdate=unknown,addedAuras={hot}},
    {addedAuras=unknown},{addedAuras=blocked},{addedAuras={unknown}},{addedAuras={blocked}},{addedAuras={}},
    {addedAuras={{isHelpful=unknown,isHarmful=false}}},{addedAuras={{isHelpful=false,isHarmful=false}}},
    {addedAuras={{isHelpful=true,isHarmful=true}}},{addedAuras={hot,bad}},
    {addedAuras={hot},updatedAuraInstanceIDs={1}}, {addedAuras={bad},removedAuraInstanceIDs={2}},
    {addedAuras={hot},updatedAuraInstanceIDs=unknown},{addedAuras={bad},removedAuraInstanceIDs=blocked},
}) do expect(info,1,1) end
env.HEALBOT_FOREVER=false
expect(delta(hot),1,1)
env.HEALBOT_FOREVER=true
b.aura.debuff.update=true
expect(delta(hot),1,1)
expect({addedAuras={hot,hot},removedAuraInstanceIDs={},updatedAuraInstanceIDs={}},1,baseline and 1 or 0)
print(string.format("%s: 40 units x 40 waves -> %d family scans when drained per wave; %d when all events coalesce",baseline and "BASELINE" or "PASS",spaced,coalesced))
