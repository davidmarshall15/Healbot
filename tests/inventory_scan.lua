-- Replay the normal bag scanner and delayed callbacks with the live Lua code.
local function read(path)
    local file=assert(io.open(path,"rb"))
    local result=file:read("*a"):gsub("\r\n","\n")
    file:close()
    return result
end

local source=read(arg[1] or "HealBot/HealBot.lua")
local scanner=assert(source:match("(local HealBot_WellFedItems=%{%}.-)\nfunction HealBot_InvReady%("))
local state={InvReady=true,InvFirstRunDone=true}
local data,ready,queue,queued={},{},{},{}
local tips,peak,passes=0,0,0
local language="enUS"
local current
local secret={}
local function region(line)
    return {GetObjectType=function() return "FontString" end,GetText=function() return line end}
end
local e=setmetatable({
    NUM_BAG_SLOTS=1,HealBot_luVars=state,Enum={ItemClass={Consumable=0}},
    HealBot_issecretvalue=function(v) return rawequal(v,secret) end,
    HEALBOT_STRING_MATCH_WELLFED="well fed",HEALBOT_STRING_MATCH_RESTOREMANA="restore mana",
    HEALBOT_STRING_MATCH_EXTRABUFFS={"grants strength"},
    HealBot_SetToolTip=function() end,HealBot_Options_SetBuffExtraItemText=function() end,
},{__index=_G})
e.HealBot_Timers_Set=function(cat,name)
    if cat=="PLAYER" and not queued[name] then
        queued[name]=true
        queue[#queue+1]=name
    end
end
local bags={[0]={},[1]={}}
e.HealBot_GetContainerNumSlots=function(bag) if bag==0 then passes=passes+1 end; return #bags[bag] end
e.HealBot_GetContainerItemID=function(bag,slot) return bags[bag][slot] end
e.HealBot_WoWAPI_ItemClassInfo=function(id)
    return id==0 and (language=="enUS" and "Consumable" or "Consommable") or "Other"
end
e.HealBot_WoWAPI_ItemInfo=function(id)
    local item=data[id]
    if not item or not ready[id] then return end
    return item.name,nil,nil,nil,nil,e.HealBot_WoWAPI_ItemClassInfo(item.class),nil,nil,nil,11,nil,item.class
end
e.HealBot_ScanTooltip={
    SetBagItem=function(_,bag,slot)
        tips=tips+1
        current=data[bags[bag][slot]]
    end,
    GetRegions=function() return region(current.name),region(current.text) end,
}
local slots=setfenv(assert(loadstring("local HealBot_ItemsInBags={}\n"..scanner.."\nreturn HealBot_ItemsInBags")),e)()
local function make(id,class,text)
    data[id]={name="Item "..id,class=class,text=text}
    ready[id]=true
end
for i=1,40 do
    bags[0][i]=i
    make(i,i>28 and 0 or 4,i>28 and "well fed, restore mana" or "well fed")
end
ready[39],ready[40]=nil,nil
local function step(f)
    local before=tips
    f()
    peak=math.max(peak,tips-before)
end
local function drain()
    local count=0
    while queue[1] do
        count=count+1; assert(count<80,"inventory timer loop")
        local name=table.remove(queue,1)
        queued[name]=nil
        if name=="ScanNextBag" then step(e.HealBot_ItemIdsInNextBag)
        elseif name=="InvChange" then step(e.HealBot_ItemIdsInBags)
        else error("unexpected timer "..name) end
    end
end
step(e.HealBot_ItemIdsInBags)
drain()
print("40-slot cold inventory: tooltip calls="..tips..", max per callback="..peak)
assert(tips==10 and peak<=2 and passes==1)
assert(slots[1].slot==1 and slots[40].slot==40 and e.HealBot_retManaDrinkItems()["Item 38"])
assert(not e.HealBot_retBuffExtraItems()["Item 1"])
-- Ignore unrelated or unsuccessful loads, and recover asynchronously on success.
e.HealBot_BagItemDataLoaded(999,true);e.HealBot_BagItemDataLoaded(39,false)
assert(#queue==0)
language="frFR";ready[39],ready[40]=true,true
data[40].text="grants strength"
e.HealBot_BagItemDataLoaded(39,true);e.HealBot_BagItemDataLoaded(40,true);drain()
assert(passes==2 and tips==12 and e.HealBot_retConsumableItems()[39]=="Item 39")
assert(e.HealBot_retWellFedItems()["Item 39"] and e.HealBot_retBuffExtraItems()["Item 40"])
-- Keep the last complete view available while inventory changes mid-scan.
local oldFood=e.HealBot_retWellFedItems()
bags[0][39]=0;bags[1][1]=40
local before=tips
step(e.HealBot_ItemIdsInBags)
assert(slots[39] and oldFood["Item 39"])
for _=1,40 do e.HealBot_ItemIdsInBags() end
drain()
assert(passes==4 and tips==before and not slots[39] and not oldFood["Item 39"])
assert(slots[40].bag==1 and slots[40].slot==1 and oldFood==e.HealBot_retWellFedItems())
-- Private/unready tooltips never poison the classification cache.
make(41,0,secret);bags[1][2]=41
step(e.HealBot_ItemIdsInBags);drain()
assert(not e.HealBot_retWellFedItems()["Item 41"])
data[41].text="well fed";step(e.HealBot_ItemIdsInBags);drain()
assert(e.HealBot_retWellFedItems()["Item 41"])
local action=read("HealBot/HealBot_Action.lua")
assert(not action:find('RegisterUnitEvent%("UNIT_INVENTORY_CHANGED"'),"raid frames still subscribe to other players' inventory")
assert(source:find('HealBot:RegisterUnitEvent%("UNIT_INVENTORY_CHANGED","player"%)'))
assert(source:find('%["UNIT_INVENTORY_CHANGED"%]=HealBot_Events_InvChange'))
assert(source:find('HealBot:UnregisterEvent%("UNIT_INVENTORY_CHANGED"%)'))
print("PASS: player-only inventory, pending items, localized consumables, stable snapshots and bounded scans")
