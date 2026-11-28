-- Repaint the distinct panel owners affected by hover. Run with a source directory and
-- "baseline" to report the work performed by an older revision.
local base=arg[1] or "HealBot"
local baseline=arg[2]=="baseline"
local env=setmetatable({
    grpFrameBar={},grpFrame={},hbUpdateFramesOpacity={},HealBot_Header_Frames={},
    HealBot_Action_luVars={ResetFrame=0,LastResetFrame=0,ActiveFrameID=0},
    hbv_Skins_GetVar=function() return 2 end,
    HealBot_Timers_Set=function() end,
},{__index=_G})
local function section(file,first,after)
    local f=assert(io.open(base.."/"..file,"rb"))
    local s=f:read("*a"):gsub("\r\n","\n"); f:close()
    local a=assert(s:find(first,1,true))
    local z=assert(s:find(after,a+#first,true))
    setfenv(assert(loadstring(s:sub(a,z-1))),env)()
end
section("HealBot_Action.lua","function HealBot_Action_IsFrameActive(","function HealBot_Action_DebugFrameActive(")
section("HealBot_Action.lua","function HealBot_Action_UpdateFramesOpacity(","function HealBot_Action_ResetrCallsUnit(")
section("HealBot_Update.lua","function HealBot_Update_DisableButtonIconsGlow(","function HealBot_Update_RegisterForClicks(")
section("HealBot_Panel.lua","function HealBot_Panel_UpdateHeadersOpacity(","local vSpecialAnchor")
local members={"Unit","Private","Extra","Pet","Vehicle","Enemy","UnitTarget","PrivateTarget"}
local buttons={}
for _,kind in ipairs(members) do
    env["HealBot_"..kind.."_Button"]={}
    for frame=1,10 do
        local b={frame=frame,framecol=10}
        env["HealBot_"..kind.."_Button"][frame]=b
        buttons[#buttons+1]=b
    end
end
for i=1,10 do
    env.grpFrameBar[i]={}
    env.grpFrame[i]={visible=i~=10}
    env.HealBot_Header_Frames[i]={frame=i}
end
local buttonDraw,frameDraw,headerDraw=0,0,0
env.HealBot_Action_ResetUnitButtonOpacity=function(b)
    buttonDraw=buttonDraw+1
    b.active=env.HealBot_Action_IsFrameActive(b.frame)
end
env.HealBot_Action_UpdateFrameOpacity=function(i)
    frameDraw=frameDraw+1
    env.grpFrame[i].active=env.HealBot_Action_IsFrameActive(i)
end
env.HealBot_Action_UpdateHeaderOpacity=function(h)
    headerDraw=headerDraw+1
    h.active=env.HealBot_Action_IsFrameActive(h.frame)
end
local function paint(label,frame,force,buttonsExpected,framesExpected,headersExpected)
    buttonDraw,frameDraw,headerDraw=0,0,0
    env.HealBot_Action_UpdateGlobalDimming(frame)
    env.HealBot_Action_ResetOpacity(force)
    for _,b in ipairs(buttons) do
        assert(b.active==env.HealBot_Action_IsFrameActive(b.frame),label.." button tint")
    end
    for i,h in ipairs(env.HealBot_Header_Frames) do
        assert(h.active==env.HealBot_Action_IsFrameActive(i),label.." header tint")
        if env.grpFrame[i].visible then assert(env.grpFrame[i].active==h.active,label.." frame tint") end
    end
    if baseline then
        print(label,buttonDraw,frameDraw,headerDraw)
    else
        assert(buttonDraw==buttonsExpected and frameDraw==framesExpected and headerDraw==headersExpected,
               label..": draws "..buttonDraw.."/"..frameDraw.."/"..headerDraw)
    end
end
paint("initial skin",0,true,80,9,10)
env.grpFrameBar[1].active=true
paint("enter",1,false,8,1,1)
paint("move to a sibling",1,false,0,0,0)
env.grpFrameBar[1].active=false
env.grpFrameBar[3].active=true
paint("cross two panels",3,false,16,2,2)
env.HealBot_Action_luVars.ActiveFrameID=3
env.grpFrameBar[3].active=false
paint("child leaves into the same parent",0,false,0,0,0)
env.HealBot_Action_luVars.ActiveFrameID=0
env.grpFrameBar[10].active=true
env.hbUpdateFramesOpacity[10]=nil
paint("defer a hidden panel",10,false,16,1,2)
assert(env.hbUpdateFramesOpacity[10],"hidden panel must repaint on show")
paint("force full skin refresh",10,true,80,9,10)
if not baseline then print("raid hover dimming preserves button, frame and header colors across all eight button sets") end
