-- Exercise normal roster classification at the point where a button can change occupants.
local f=assert(io.open("HealBot/HealBot.lua","rb"))
local src=f:read("*a"):gsub("\r\n","\n")
f:close()
src=assert(src:match('(local guName=false.-)\nfunction HealBot_UpdateUnitExists'))
local hidden={}
local roster={}
local cache={}
local env=setmetatable({
    strsub=string.sub, HealBot_Data={PGUID="Player-self"}, HEALBOT_WORDS_UNKNOWN="Unknown",
    HealBot_customTempUserName={}, HealBot_issecretvalue=function(v) return v==hidden end,
    UnitClass=function(unit) return "",roster[unit].class end,
    UnitIsUnit=function(unit) return roster[unit].self end,
    UnitIsPlayer=function(unit) return roster[unit].human end,
    UnitGUID=function(unit) return roster[unit].guid end,
    UnitName=function(unit) return roster[unit].name end,
    HealBot_Panel_RaidPetUnitButtonCheck=function() return true end,
    HealBot_Action_ClassColour=function() return 1,1,1 end,
    HealBot_Action_getGuidData=function(guid,key) return (cache[guid] or {})[key] end,
    HealBot_Action_SetGuidData=function(b,key,value)
        assert(b.guid~=hidden and b.guid~=b.unit,"unverified GUID used for identity cache")
        cache[b.guid]=cache[b.guid] or {}
        cache[b.guid][key]=value
    end,
},{__index=_G})
setfenv(assert(loadstring(src)),env)()
local b={isplayer=true,player=true,range={},text={},status={}}
local function classify(unit,id,isSelf,isHuman,name,class)
    roster[unit]={guid=id,self=isSelf,human=isHuman,name=name,class=class}
    b.unit,b.guid,b.range.current=unit,id,-1
    env.HealBot_UnitClass(b)
end
classify("raid4","Player-other",hidden,true,"Other","DRUID")
assert(b.player==false and b.isplayer==true and b.range.current==-1,"other human classified as self")
classify("player","Player-self",hidden,hidden,"Me","MAGE")
assert(b.player==true and b.isplayer==true and b.range.current==2)
classify("raid3","Player-self",hidden,true,"Me","MAGE")
assert(b.player==true and b.isplayer==true and b.range.current==2)
cache={}
classify("raid3","Player-self",hidden,true,"Me","MAGE")
assert(b.player==true and b.range.current==2,"verified GUID alias lost self")
classify("target",hidden,hidden,hidden,hidden,"MAGE")
assert(b.player==false and b.isplayer==false and b.name==false and b.range.current==-1)
classify("target","target",false,true,"First","MAGE")
classify("target","target",false,false,"Second","WARRIOR")
assert(b.player==false and b.isplayer==false and b.name=="Second" and b.text.classtrim=="WARR")
classify("focus","Player-later",hidden,hidden,"Later",hidden)
assert(not b.status.classknown)
classify("focus","Player-later",false,true,"Later","PRIEST")
assert(b.player==false and b.isplayer==true and b.status.classknown)
cache={}
env.HealBot_SetGuidData(b)
assert(cache[b.guid].CLASSKNOWN and cache[b.guid].ISPLAYER)
print("ordinary class and self identity passed across protected values, cached aliases and recycled units")
