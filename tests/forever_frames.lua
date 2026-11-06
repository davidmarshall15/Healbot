local passed=0
local function eq(actual, expected, label)
    assert(actual==expected, label..": expected "..tostring(expected)..", got "..tostring(actual))
    passed=passed+1
end

local function forbidden() error("Attempted to inspect a protected value") end
local secret=setmetatable({}, {__add=forbidden,__sub=forbidden,__mul=forbidden,
    __div=forbidden,__lt=forbidden,__le=forbidden,__index=forbidden})
local hooks={}
local combat=false
local monitoring=true
local mode=6
local amount=secret
local maximum=secret
local eventFrame
local lastUnit
local created=0
local messages={}
local env=setmetatable({}, {__index=_G})

local function frame()
    local f={shown=false, value=0, orientation="HORIZONTAL", reverse=false, level=5}
    function f:Hide() self.shown=false end
    function f:Show() self.shown=true end
    function f:SetShown(show) self.shown=not not show end
    function f:EnableMouse() end
    function f:SetMouseClickEnabled() end
    function f:SetMouseMotionEnabled() end
    function f:SetSize(w,h) self.width,self.height=w,h end
    function f:GetWidth() return self.width or 120 end
    function f:GetHeight() return self.height or 25 end
    function f:SetOrientation(value) self.orientation=value end
    function f:GetOrientation() return self.orientation end
    function f:SetReverseFill(value) self.reverse=value end
    function f:GetReverseFill() return self.reverse end
    function f:ClearAllPoints() self.point=nil end
    function f:SetPoint(...) self.point={...} end
    function f:SetAllPoints(target) self.target=target end
    function f:SetFrameLevel(value) self.level=value end
    function f:GetFrameLevel() return self.level end
    function f:SetParent(parent)
        assert(not combat,"reparented text in combat")
        self.parent=parent
    end
    function f:GetParent() return self.parent end
    function f:SetDrawLayer(layer) self.drawLayer=layer end
    function f:GetStatusBarTexture() self.texture=self.texture or frame() return self.texture end
    function f:SetHorizTile() end
    function f:SetColorTexture(...) self.color={...} end
    function f:SetStatusBarColor(...) self.color={...} end
    function f:SetMinMaxValues(low,high) self.min,self.max=low,high end
    function f:SetValue(value, ...)
        eq(select("#",...),0,"only the heal amount reaches SetValue")
        self.value=value
    end
    function f:GetValue() return self.value end
    function f:SetAlpha(alpha) self.alpha=alpha end
    function f:CreateTexture() self.overlay=frame() return self.overlay end
    function f:AddDispelTypeTexture(texture,options) self.dispel={texture=texture,options=options} end
    function f:SetUnit(unit) self.unit=unit end
    function f:SetEnabled(value) assert(not combat,"enabled container in combat") self.enabled=value end
    function f:AddAuraGroup(_,filter,options)
        assert(not combat,"created group in combat")
        self.filter,self.options=filter,options
        self.aura=frame()
        self.aura.level=self.level+1
        options.initializeFrame(self.aura)
    end
    function f:UpdateAllAuras() self.updates=(self.updates or 0)+1 end
    function f:RegisterEvent() end
    function f:SetScript(_,callback) self.callback=callback end
    return f
end

env.HEALBOT_FOREVER=true
env.HealBot_issecretvalue=function(value) return rawequal(value,secret) end
env.InCombatLockdown=function() return combat end
env.CreateFrame=function(kind)
    assert(not combat,"created a frame in combat")
    created=created+1
    local f=frame()
    if kind=="Frame" then eventFrame=f end
    return f
end
env.hooksecurefunc=function(name, callback) hooks[name]=callback end
env.CreateUnitHealPredictionCalculator=function()
    return {
        SetIncomingHealClampMode=function(_,value) eq(value,0,"clamp incoming to missing health") end,
        SetIncomingHealOverflowPercent=function(_,value) eq(value,1,"no overflowing prediction") end,
        GetMaximumHealth=function() return maximum end,
        GetIncomingHeals=function() return amount,secret,secret,secret end,
    }
end
env.UnitGetDetailedHealPrediction=function(unit,healer)
    lastUnit=unit
    eq(healer,"player","healing unit")
end
env.Enum={UnitIncomingHealClampMode={MissingHealth=0},CustomAuraButtonDispelTypeTextureStyle={PreserveAsset=3}}
env.AuraContainerSortMethod={UnitFrameDebuff=2}
env.HealBot_Unit_Status={DEAD=20,PLUGINBARCOL=15}
env.HealBot_Config_Cures={CDCshownHB=true,CDCBarColour={Magic={R=0.2,G=0.6,B=1}},WarnRange_Bar=1}
env.HealBot_Globals={CustomDebuffsShowBarCol={DEFAULT=4},CombatAurasOn=false}
env.CreateColor=function(r,g,b) return {r=r,g=g,b=b} end
env.HealBot_Aura_DebuffsEnabled=function() return monitoring end
env.HealBot_Range_WarnInRange=function() return true end
env.hbv_Skins_GetFrameVar=function(_,key)
    return ({IC=mode,IA=0.8,IR=0.1,IG=1,IB=0.3,TEXTURE="test"})[key]
end
env.HealBot_Media_UpdateTexture=function() end
env.HealBot_Action_BarColourAlpha=function(_,alpha) return alpha end
env.HealBot_Action_HealsInColourHealth=function(b)
    b.health.inhealr,b.health.inhealg,b.health.inhealb=secret,secret,0
end
env.print=function(message) messages[#messages+1]=message end

local function loadAddon(path)
    local chunk=assert(loadfile(path))
    setfenv(chunk,env)()
end
loadAddon("HealBot/HealBot_ForeverFrames.lua")

local function button(unit)
    local b={unit=unit,frame=1,framecol=1,gref={Bar=frame(),InHeal=frame(),Top=frame(),txt={}},
        status={events=true,enabled=true,current=5,alpha=0.9},range={current=1},
        health={current=secret,max=secret},special={unit=false}}
    b.gref.Bar.level=24
    b.gref.InHeal.level=23
    b.gref.Top.level=50
    for _, key in ipairs({"text", "text2", "text3", "text4", "text5"}) do
        local label=frame()
        label.parent=b.gref.Bar
        label.point={"LEFT",b.gref.Bar,"LEFT",3,5}
        label.content=key.." content"
        b.gref.txt[key]=label
    end
    return b
end

local b=button("party1")
hooks.HealBot_Action_RegisterUnitEvents(b)
local bar=b.foreverIncoming.bar
eq(bar.shown,true,"incoming shown with protected health")
eq(bar.value,secret,"protected amount passed directly to native bar")
eq(bar.max,secret,"protected maximum passed directly to native bar")
eq(bar.point[3],"TOPRIGHT","prediction starts at end of health")
eq(bar.color[4],0.8*0.9,"prediction honors skin opacity")
eq(b.gref.InHeal.value,0,"legacy prediction cleared")
eq(b.foreverDebuffs.all.shown,false,"out-of-combat debuffs use existing engine")
eq(b.foreverDebuffs.dispel.filter,"HARMFUL|RAID","native dispellable filter")
eq(b.foreverDebuffs.all.options.maxFrameCount,1,"one native debuff selected")
eq(b.foreverDebuffs.all.aura.dispel.options.customDispelColorMap.Magic.g,0.6,"configured debuff color")
eq(b.foreverDebuffs.all.aura.overlay.target,b.gref.Bar:GetStatusBarTexture(),"debuff tint follows health fill")

for _, overlay in pairs(b.foreverDebuffs) do
    for key, label in pairs(b.gref.txt) do
        eq(label:GetParent():GetFrameLevel()>overlay.aura:GetFrameLevel(),true,key.." remains above debuff tint")
        eq(label.point[2],b.gref.Bar,key.." keeps its health-bar anchor")
        eq(label.point[4],3,key.." keeps its horizontal offset")
        eq(label.content,key.." content",key.." keeps its content")
    end
end

combat=true
local before=created
eventFrame.callback(nil,"PLAYER_REGEN_DISABLED")
eq(created,before,"combat start reuses native frames")
eq(b.gref.txt.text:GetParent(),b.gref.Top,"name stays on top during combat")
eq(b.foreverDebuffs.all.shown,true,"debuff coloring works independently of combat icons")
eq(b.foreverDebuffs.dispel.shown,false,"only selected overlay is visible")
env.HealBot_Config_Cures.CDCshownHBDispelOnly=true
env.HealBot_Forever_UpdateDebuffOverlay(b)
eq(b.foreverDebuffs.all.shown,false,"all-debuff overlay hidden for dispel-only")
eq(b.foreverDebuffs.dispel.shown,true,"dispel-only setting honored")
env.HealBot_Config_Cures.CDCshownHB=false
env.HealBot_Forever_UpdateDebuffOverlay(b)
eq(b.foreverDebuffs.dispel.shown,false,"coloring disabled immediately")
env.HealBot_Config_Cures.CDCshownHB=true
monitoring=false
env.HealBot_Forever_UpdateDebuffOverlay(b)
eq(b.foreverDebuffs.dispel.shown,false,"debuff monitoring gate honored")
monitoring=true
b.status.current=20
env.HealBot_Forever_UpdateIncomingHeals(b)
env.HealBot_Forever_UpdateDebuffOverlay(b)
eq(bar.shown,false,"prediction hidden on death")
eq(b.foreverDebuffs.dispel.shown,false,"debuff tint hidden on death")
b.status.current=5
amount=0
maximum=1000
env.HealBot_Forever_UpdateIncomingHeals(b)
eq(bar.value,0,"interrupted or completed heal clears prediction")
mode=1
env.HealBot_Forever_UpdateIncomingHeals(b)
eq(bar.shown,false,"disabled prediction mode")
mode=2
amount=secret
env.HealBot_Forever_UpdateIncomingHeals(b)
eq(bar.color[1],secret,"health color may also be protected")
b.gref.Bar.orientation="VERTICAL"
env.HealBot_Forever_UpdateIncomingHeals(b)
eq(bar.point[1],"BOTTOMLEFT","vertical prediction anchor")
eq(bar.point[3],"TOPLEFT","vertical prediction starts above health")
b.gref.Bar.reverse=true
env.HealBot_Forever_UpdateIncomingHeals(b)
eq(bar.point[3],"BOTTOMLEFT","reverse vertical prediction anchor")
b.gref.Bar.orientation="HORIZONTAL"
env.HealBot_Forever_UpdateIncomingHeals(b)
eq(bar.point[3],"TOPLEFT","reverse horizontal prediction anchor")

local deferred=button("party2")
hooks.HealBot_Action_RegisterUnitEvents(deferred)
eq(deferred.foreverIncoming,nil,"creation deferred during combat")
eq(deferred.gref.txt.text:GetParent(),deferred.gref.Bar,"text reparenting deferred during combat")
eq(created,before,"no protected container created during combat")
combat=false
eventFrame.callback(nil,"PLAYER_REGEN_ENABLED")
eq(deferred.foreverIncoming~=nil,true,"deferred frame created after combat")
eq(deferred.gref.txt.text:GetParent(),deferred.gref.Top,"deferred name moved above debuff tint")
eq(b.foreverDebuffs.dispel.shown,false,"combat exit removes native tint")
hooks.HealBot_Action_UnregisterUnitEvents(b)
eq(bar.shown,false,"unregister hides prediction")
b.unit="party3"
hooks.HealBot_Action_RegisterUnitEvents(b)
eq(lastUnit,"party3","reused prediction follows new unit")
eq(b.foreverDebuffs.all.unit,"party3","reused debuff container follows new unit")

combat=true
b.unit="party5"
hooks.HealBot_Action_RegisterUnitEvents(b)
eq(lastUnit,"party5","prediction follows a unit change in combat")
eq(b.foreverDebuffs.dispel.shown,false,"old unit's debuffs stay hidden until rebound")
combat=false
eventFrame.callback(nil,"PLAYER_REGEN_ENABLED")
eq(b.foreverDebuffs.dispel.unit,"party5","deferred unit rebind after combat")

-- Exercise the real event handler, including the legacy secret-value clearing
-- that originally erased incoming heals before the frame could display them.
local handle=assert(io.open("HealBot/HealBot.lua","rb"))
local source=handle:read("*a"):gsub("\r\n","\n")
handle:close()
local handler=assert(source:match("(local hiuIsSecret=false.-)\nfunction HealBotClassic_HealsInDoUpdate"))
local chunk=assert(loadstring("local hiuHealAmount\nlocal function HealBot_HealsInAmount() hiuHealAmount=_incomingAmount end\n"..handler))
env.HealBot_Action_UpdateHealsInButton=env.HealBot_Forever_UpdateIncomingHeals
env.HealBot_Action_UpdateInHealStatusBarColor=function() end
env.HealBot_Text_setInHealAbsorbsText=function() end
env.HealBot_OverHeal=function() end
env.HealBot_Aux_UpdateHealInBar=function() end
setfenv(chunk,env)()
b.health.incoming,b.health.auxincoming=0,0
env._incomingAmount=secret
amount=secret
env.HealBot_HealsInUpdate(b)
eq(b.health.incoming,0,"protected values stay out of legacy arithmetic caches")
eq(bar.value,secret,"real heal event still renders protected prediction")
env._incomingAmount=250
amount=250
env.HealBot_HealsInUpdate(b)
eq(bar.value,250,"real heal event renders readable prediction")
eq(b.health.incoming,250,"readable prediction remains available to legacy consumers")
env._incomingAmount=0
amount=0
env.HealBot_HealsInUpdate(b)
eq(bar.value,0,"real heal event clears prediction on interruption")
eq(b.health.incoming,0,"legacy prediction clears on interruption")

env.CreateUnitHealPredictionCalculator=nil
local unsupported=button("party4")
hooks.HealBot_Action_RegisterUnitEvents(unsupported)
eq(env.HealBot_Forever_UpdateIncomingHeals(unsupported),false,"missing calculator keeps legacy path")
env.HEALBOT_FOREVER=false
env.HealBot_Forever_UpdateIncomingHeals=nil
loadAddon("HealBot/HealBot_ForeverFrames.lua")
eq(env.HealBot_Forever_UpdateIncomingHeals,nil,"other clients unchanged")
print("PASS: "..passed.." Forever frame assertions (mock APIs, not an in-game test)")
