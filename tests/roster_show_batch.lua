local source=assert(io.open("HealBot/HealBot_Panel.lua","rb"))
local code=source:read("*a"):gsub("\r\n","\n")
source:close()
local function section(first,after)
    local start=assert(code:find(first,1,true))
    return code:sub(start,assert(code:find(after,start+#first,true))-1)
end
local queue, now={},1
local scheduled=0
C_Timer={After=function(delay,callback)
    assert(delay==0.125)
    scheduled=scheduled+1
    queue[#queue+1]={at=now+delay,run=callback}
end}
function GetTime() return now end
local function advance(time)
    now=time
    while queue[1] and queue[1].at<=now do table.remove(queue,1).run() end
end
local function record(id)
    return {id=id,shows=0,status={},Show=function(self) self.shows=self.shows+1 end,Hide=function(self) self.hidden=true end}
end
HealBot_Emerg_Button={}
HealBot_Buttons={}
function hbv_Skins_GetFrameBoolean() return true end
assert(loadstring(section("local hbShowButtons={}","function HealBot_Panel_PetVehicleShow")))()
for i=1,40 do
    HealBot_Buttons[i]=record(i)
    HealBot_Emerg_Button[i]=record(i)
    HealBot_Panel_UnitShow(HealBot_Buttons[i],false,false)
end
local firstCount=scheduled
advance(1.050)
for i=1,40 do HealBot_Panel_UnitShow(HealBot_Buttons[i],true,false) end
HealBot_Panel_ButtonHide(HealBot_Buttons[39])
HealBot_Panel_UnitShow(HealBot_Buttons[39],false,false)
HealBot_Panel_UnitShow(HealBot_Buttons[40],false,true)
advance(1.125)
for i=1,38 do
    assert(HealBot_Buttons[i].shows==1 and HealBot_Emerg_Button[i].shows==1,"first deadline or emergency mode lost")
end
assert(HealBot_Buttons[39].shows==0 and HealBot_Buttons[40].shows==1,"outdated visibility request")
advance(1.200)
assert(HealBot_Buttons[39].shows==1 and HealBot_Emerg_Button[39].shows==0,"hide/requeue deadline or emergency")
local old=HealBot_Buttons[1]
HealBot_Panel_UnitShow(old,false,false)
local current=record(1)
HealBot_Buttons[1]=current
HealBot_Panel_UnitShow(current,true,false)
advance(1.400)
assert(current.shows==1 and old.shows==1,"recycled ID received old show")
HealBot_Panel_UnitShow(current,false,false)
HealBot_Panel_ButtonShowNow()
advance(1.600)
assert(current.shows==2,"immediate combat flush ran twice")
assert(firstCount==1,"40-unit pass scheduled "..firstCount.." callbacks")
local errors=0
function geterrorhandler()
    return function(err) assert(tostring(err):find("row rejected",1,true)); errors=errors+1 end
end
local broken=record(71)
broken.Show=function() error("row rejected") end
HealBot_Panel_UnitShow(broken,false,false)
HealBot_Panel_UnitShow(current,false,false)
advance(1.8)
assert(current.shows==3 and errors==1,"one row failure stranded the rest of the batch")
broken.Show=record(72).Show
HealBot_Panel_UnitShow(broken,false,false)
advance(2)
assert(broken.shows==1,"row could not be retried")

assert(loadstring(section("function HealBot_Panel_PrePartyChanged(","function HealBot_Panel_PartyChanged(")))()
local groups={}
for i=1,15 do groups[i]={FRAME=1,STATE=false} end
groups[9].FRAME,groups[10].FRAME=6,7
Healbot_Config_Skins={Current_Skin="Example",HealGroups={Example=groups}}
local calls
function HealBot_Panel_buildDataStore() end
function HealBot_nextRecalcParty(k) calls[k]=(calls[k] or 0)+1 end
function HealBot_Panel_DoPartyChanged(_,k) HealBot_nextRecalcParty(k) end
for mask=0,15 do
    for index=0,3 do
        local group=groups[11+index]
        group.FRAME=math.floor(mask/2^index)%2==1 and (index<2 and 8 or 9) or 1
    end
    for _,preCombat in ipairs({true,false}) do
        calls={}
        HealBot_Panel_PrePartyChanged(preCombat,0)
        assert((calls[3] or 0)==(mask%4>0 and 1 or 0),"target frame refresh count")
        assert((calls[4] or 0)==(mask>=4 and 1 or 0),"focus frame refresh count")
        for _,k in ipairs({1,2,5,6}) do assert(calls[k]==1,"other roster refresh changed") end
    end
end
print("PASS: 40 simultaneous button shows use one timer; 125ms deadlines, hide/reuse/flush, latest emergency policy and all 32 target/focus refresh configurations")
