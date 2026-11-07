-- The native API mock propagates opaque values. Addon arithmetic on them fails.
local passed=0
local hidden=setmetatable({}, {__mode="k"})
local function secret(n)
    local function forbidden() error("addon inspected a secret") end
    local v=setmetatable({}, {__add=forbidden,__sub=forbidden,__mul=forbidden,
        __div=forbidden,__lt=forbidden,__le=forbidden,__tostring=forbidden})
    hidden[v]=n
    return v
end
local function raw(v) if type(v)=="table" and hidden[v]~=nil then return hidden[v] end return v end
local function protected(v) return type(v)=="table" and hidden[v]~=nil end
local function result(n,...)
    for i=1,select("#",...) do if protected(select(i,...)) then return secret(n) end end
    return n
end
local function eq(a,b,label)
    assert(raw(a)==b,(label or "value")..": expected "..tostring(b)..", got "..tostring(raw(a)))
    passed=passed+1
end
local function noop() end
local env=setmetatable({}, {__index=_G})
env._G=env
env.HEALBOT_FOREVER=true
env.HEALBOT_GAME_VERSION=1
env.HealBot_issecretvalue=protected
env.Enum={UnitIncomingHealClampMode={MissingHealth=0},UnitDamageAbsorbClampMode={MissingHealth=0,MissingHealthWithoutIncomingHeals=1},
    LuaCurveType={Linear=0,Step=1},CustomAuraButtonDispelTypeTextureStyle={PreserveAsset=3}}
env.AuraContainerSortMethod={UnitFrameDebuff=2}
env.HealBot_Unit_Status={DEAD=20,PLUGINBARCOL=15}
env.HealBot_Data={UILOCK=true}
env.HealBot_Config_Cures={CDCBarColour={},CDCshownHB=false}
env.HealBot_Globals={CustomDebuffsShowBarCol={DEFAULT=4}}
env.InCombatLockdown=function() return false end
local hooks={}
env.hooksecurefunc=function(name,fn) hooks[name]=fn end
local function color(r,g,b) return {GetRGB=function() return r,g,b end} end
env.CreateColor=color
env.C_CurveUtil={}
local curveCount=0
function env.C_CurveUtil.CreateColorCurve()
    curveCount=curveCount+1
    local c={points={}}
    function c:SetType(t) self.kind=t end
    function c:AddPoint(x,y)
        for i,p in ipairs(self.points) do if p.x==x then self.points[i]={x=x,y=y} return end end
        self.points[#self.points+1]={x=x,y=y}
        table.sort(self.points,function(a,b) return a.x<b.x end)
    end
    function c:Evaluate(n)
        local x=raw(n)
        local left=self.points[1]
        for _,right in ipairs(self.points) do
            if x<right.x then
                local r,g,b=left.y:GetRGB()
                if self.kind==0 and right.x>left.x then
                    local rr,gg,bb=right.y:GetRGB()
                    local t=(x-left.x)/(right.x-left.x)
                    r,g,b=r+(rr-r)*t,g+(gg-g)*t,b+(bb-b)*t
                end
                return color(result(r,n),result(g,n),result(b,n))
            end
            left=right
        end
        local r,g,b=left.y:GetRGB()
        return color(result(r,n),result(g,n),result(b,n))
    end
    return c
end
function env.C_CurveUtil.EvaluateColorValueFromBoolean(v,yes,no)
    return result(raw(v) and yes or no,v)
end
local function calc()
    local c={values={}}
    function c:SetIncomingHealClampMode() end
    function c:SetIncomingHealOverflowPercent() end
    function c:SetDamageAbsorbClampMode(m) self.clamp=m end
    function c:SetPredictedValues(v) self.values=v end
    function c:GetMaximumHealth() return self.values.healthMax end
    function c:GetMissingHealth()
        local v=self.values
        return result(math.max(0,raw(v.healthMax)-raw(v.health)),v.health,v.healthMax)
    end
    function c:GetTotalIncomingHeals() return self.values.totalIncomingHeals end
    function c:GetTotalDamageAbsorbs() return self.values.totalDamageAbsorbs end
    function c:GetIncomingHeals()
        local v=self.values
        return result(math.min(raw(self:GetMissingHealth()),math.max(0,raw(v.totalIncomingHeals)-raw(v.totalHealAbsorbs or 0))),
            v.health,v.healthMax,v.totalIncomingHeals),false,false,false
    end
    function c:GetMaximumDamageAbsorbs()
        local missing=self:GetMissingHealth()
        if self.clamp==1 then return missing end
        local heals=self:GetIncomingHeals()
        return result(math.max(0,raw(missing)-raw(heals)),missing,heals)
    end
    function c:GetDamageAbsorbs()
        local maximum=self:GetMaximumDamageAbsorbs()
        local amount=self.values.totalDamageAbsorbs
        return result(math.min(raw(maximum),raw(amount)),maximum,amount),
               result(raw(amount)>raw(maximum),maximum,amount)
    end
    function c:EvaluateCurrentHealthPercent(curve)
        local v=self.values
        local pct=raw(v.healthMax)>0 and raw(v.health)/raw(v.healthMax) or 0
        return curve:Evaluate(result(pct,v.health,v.healthMax))
    end
    return c
end
env.CreateUnitHealPredictionCalculator=calc
local values={health=secret(40),healthMax=secret(100),totalIncomingHeals=secret(20),totalDamageAbsorbs=secret(15)}
env.UnitGetDetailedHealPrediction=function(_,_,c) c:SetPredictedValues(values) end
env.UnitGetIncomingHeals=function() return values.totalIncomingHeals end
env.UnitGetTotalAbsorbs=function() return values.totalDamageAbsorbs end
local function frame()
    local f={value=0,orientation="HORIZONTAL",reverse=false}
    function f:CreateTexture() return frame() end
    function f:SetStatusBarTexture(v) self.texture=v end
    function f:SetAllPoints(v) self.anchor=v end
    function f:SetBlendMode(v) self.blend=v end
    function f:SetVertexColor(...) self.tint={...} end
    function f:SetAtlas(asset,autoSize,filter,reset,u,v) self.atlas=asset;self.addressU=u;self.addressV=v end
    function f:SetTexture(asset,u,v) self.asset=asset;self.addressU=u;self.addressV=v end
    function f:SetHorizTile(v) self.hTile=v end
    function f:SetVertTile(v) self.vTile=v end
    function f:SetValue(v) self.value=v end
    function f:GetValue() return self.value end
    function f:SetMinMaxValues(a,b) self.minimum,self.maximum=a,b end
    function f:SetStatusBarColor(...) self.color={...} end
    function f:GetStatusBarTexture() return self end
    function f:SetShown(v) self.shown=v end
    function f:Hide() self.shown=false end
    function f:Show() self.shown=true end
    function f:GetWidth() return 100 end
    function f:GetHeight() return 20 end
    function f:GetOrientation() return self.orientation end
    function f:GetReverseFill() return self.reverse end
    function f:SetOrientation(v) self.orientation=v end
    function f:SetReverseFill(v) self.reverse=v end
    function f:GetFrameLevel() return 20 end
    function f:SetPoint(...) self.point={...} end
    function f:SetText(v) self.text=v end
    function f:SetTextColor(...) self.textColor={...} end
    for _,name in ipairs({"EnableMouse","ClearAllPoints","SetSize","SetFrameLevel","SetParent",
        "SetDrawLayer","SetMouseClickEnabled","SetMouseMotionEnabled","SetUnit","AddAuraGroup","SetEnabled",
        "RegisterEvent","SetScript","SetAlpha","UpdateAllAuras"}) do f[name]=noop end
    return f
end
local createdFrames=0
env.CreateFrame=function(...) createdFrames=createdFrames+1; return frame(...) end
env.C_Texture={GetAtlasInfo=function() return {} end}
env.HealBot_Media_UpdateTexture=noop
env.HealBot_Aura_DebuffsEnabled=function() return false end
env.HealBot_Action_BarColourAlpha=function(_,a) return a end
local skin={IC=6,AC=6,IA=0.8,AA=0.5,IIT=0.75,ICT=0.25,AIT=0.75,ACT=0.25,
    IR=0,IG=1,IB=0,IIR=1,IIG=1,IIB=0,ICR=1,ICG=0,ICB=0,
    AR=0,AG=1,AB=0,AIR=1,AIG=1,AIB=0,ACR=1,ACG=0,ACB=0}
env.hbv_Skins_GetFrameVar=function(_,key) return skin[key] end
env.hbv_Skins_GetFrameBoolean=function() return true end
env.hbv_Aux_GetBarVar=function(key) return ({COLOUR=1,OTYPE=1,ANCHOR=1})[key] end
env.hbv_Aux_GetBarBoolean=function() return true end
env.hbv_Aux_GetBarTextVar=function(key) return ({COLTYPE=1,COLA=1})[key] end
env.HealBot_Util_isMidnight=function() return true end
env.hbv_GetStatic=function() return {} end
env.HealBot_Text_shortHealTxt=function(v) assert(not protected(v)) return tostring(v) end
local function loadFile(path)
    local f=assert(io.open(path,"rb")); local s=f:read("*a"):gsub("^\239\187\191",""); f:close()
    setfenv(assert(loadstring(s,"@"..path)),env)()
end
local function extract(path,name)
    local f=assert(io.open(path,"rb"));local s=f:read("*a"):gsub("\r\n","\n");f:close()
    setfenv(assert(loadstring(assert(s:match("(function "..name.."%b().-\nend)")))),env)()
end
for _,prefix in ipairs({"HealsIn","Absorbs"}) do
    for _,name in ipairs({"Health","Class","Role","ClassHlthMix","RoleHlthMix"}) do
        extract("HealBot/HealBot_Action.lua","HealBot_Action_"..prefix.."Colour"..name)
    end
end
env.hbCustomRoleCols={HEALER={r=0.2,g=0.3,b=0.4}}
loadFile("tests/fixtures/forever_texture_util.lua")
loadFile("HealBot/HealBot_Aux.lua")
loadFile("HealBot/HealBot_ForeverFrames.lua")
loadFile("HealBot/HealBot_ForeverPrediction.lua")
local b={id=1,unit="party1",frame=1,roletxt="HEALER",text={r=0.8,g=0.2,b=0.6},
    health={rcol=0.3,gcol=0.7},status={events=true,enabled=true,current=1,alpha=1},
    range={current=1},mana={},aux={},auxtxt={},gref={Bar=frame(),InHeal=frame(),Absorb=frame(),Shield=frame(),Top=frame(),txt={},
    aux={},auxtxt={}}}
for _,name in ipairs({"text","text2","text3","text4","text5"}) do b.gref.txt[name]=frame() end
for i=1,9 do
    b.aux[i]={FLUID=-1,TIMED=-1};b.auxtxt[i]={}
    b.gref.aux[i]=frame();b.gref.auxtxt[i]=frame()
end
env.HealBot_Aux_setInHealsAssigned("HEAL",1,1)
env.HealBot_Aux_setInHealsAssigned("ABSORB",1,2)
hooks.HealBot_Action_RegisterUnitEvents(b)
local p=b.foreverIncoming
eq(p.absorb.texture.atlas,"raidframe-shield-fill","shield fill atlas")
eq(p.absorb.texture.addressU,"REPEAT","helper converts wrap enum horizontally")
eq(p.absorb.texture.addressV,"REPEAT","helper converts wrap enum vertically")
eq(p.absorb.texture.hTile,true,"shield fill tiles horizontally")
eq(p.absorb.texture.vTile,true,"shield fill tiles vertically")
eq(p.absorbOverlay.atlas,"RaidFrame-Shield-Overlay","shield overlay atlas")
eq(p.absorbOverlay.hTile,true,"overlay tiles")
eq(p.absorbOverlay.tint[1],128/255,"light-blue overlay red")
eq(p.absorbOverlay.tint[3],1,"light-blue overlay blue")
eq(p.bar.value,20,"secret incoming")
eq(p.absorb.value,15,"secret absorbs")
eq(p.absorb.point[2],p.bar:GetStatusBarTexture(),"absorbs follow incoming")
eq(p.bar.color[1],1,"60% future health injured red")
eq(p.bar.color[2],1,"60% future health injured green")
eq(p.absorb.color[1],0,"shield fill stays cerulean despite injured health")
eq(b.health.incoming,0,"readable legacy incoming")
eq(b.health.absorbs,0,"readable legacy absorbs")
eq(b.gref.aux[1].value,20,"raw incoming auxiliary")
eq(b.gref.aux[2].value,15,"raw absorb auxiliary")
eq(b.gref.aux[1].maximum,3000,"configured auxiliary scale")
eq(b.aux[1].FLUID,-1,"no protected smoothing target")
eq(b.gref.auxtxt[1].text,"","protected text is not formatted")
local count=curveCount
env.HealBot_Forever_UpdatePrediction(b)
eq(curveCount,count,"curves reused")
values.health=secret(5);values.totalIncomingHeals=secret(10)
env.HealBot_Forever_UpdatePrediction(b)
eq(p.bar.color[2],0,"critical colour")
values.health=secret(80);values.totalIncomingHeals=secret(30)
env.HealBot_Forever_UpdatePrediction(b)
eq(p.bar.value,20,"heals clamp to missing health")
eq(p.absorb.value,0,"absorbs clamp after heals")
eq(b.gref.aux[1].value,30,"auxiliary shows unclamped total")
eq(p.bar.color[1],0,"normal colour after healing")
eq(b.gref.Shield.color[4],1,"overflow indicator accepts secret bool")
skin.IR=0.4
env.HealBot_Forever_UpdatePrediction(b)
eq(p.bar.color[1],0.4,"edited custom colour is applied")
skin.IC=3;env.HealBot_Forever_UpdatePrediction(b)
eq(p.bar.color[1],0.8,"class colour")
skin.IC=4;env.HealBot_Forever_UpdatePrediction(b)
eq(p.bar.color[1],0.2,"role colour")
skin.IC=5;env.HealBot_Forever_UpdatePrediction(b)
eq(p.bar.color[1],0,"future-health green despite current 80%")
skin.IC=1;env.HealBot_Forever_UpdatePrediction(b)
eq(p.bar.shown,false,"incoming disabled")
eq(p.absorb.value,15,"absorbs ignore invisible incoming")
eq(p.absorb.point[2],b.gref.Bar,"absorbs anchor to health when incoming hidden")
eq(b.gref.aux[1].value,30,"aux independent of disabled main bar")
skin.IC=6
values.health=secret(100);env.HealBot_Forever_UpdatePrediction(b)
eq(b.gref.Shield.color[4],1,"full-health shield indicator")
b.gref.Bar.orientation="VERTICAL";b.gref.Bar.reverse=true
env.HealBot_Forever_UpdatePrediction(b)
eq(p.absorb.point[1],"TOPLEFT","reverse vertical absorb anchor")
eq(p.absorb.point[3],"BOTTOMLEFT","reverse vertical absorb destination")
b.range.current=0;env.HealBot_Forever_UpdatePrediction(b)
eq(p.absorb.color[4],0.5/3,"range opacity")
b.status.enabled=false;env.HealBot_Forever_UpdatePrediction(b)
eq(p.absorb.shown,false,"disabled hides absorbs")
eq(b.gref.aux[1].value,0,"disabled clears auxiliary")
eq(b.gref.aux[1].maximum,1000,"clear restores standard auxiliary range")
eq(b.gref.Shield.color[4],0,"disabled clears overflow")
b.status.enabled=true;b.range.current=1
values.health=40;values.healthMax=100;values.totalIncomingHeals=20;values.totalDamageAbsorbs=10
env.HealBot_Forever_UpdatePrediction(b)
eq(b.health.incoming,20,"readable incoming cache")
eq(b.health.absorbs,10,"readable absorb cache")
eq(b.gref.auxtxt[1].text,"20","readable text preserved")
values.totalIncomingHeals=0;values.totalDamageAbsorbs=0
env.HealBot_Forever_UpdatePrediction(b)
eq(p.absorb.value,0,"expired shield clears")
eq(b.gref.aux[2].value,0,"expired auxiliary clears")
hooks.HealBot_Action_UnregisterUnitEvents(b)
eq(p.absorb.shown,false,"unregister hides absorbs")
eq(b.gref.Shield.color[4],0,"unregister clears overflow")
env.HealBot_Action_luVars={FluidInUse=false}
env.HealBot_Text_setInHealAbsorbsText=noop
extract("HealBot/HealBot.lua","HealBot_AbsorbsUpdate")
values.totalDamageAbsorbs=secret(20);b.status.events=true
env.HealBot_AbsorbsUpdate(b)
eq(p.absorb.value,20,"real absorb event uses native renderer")
eq(b.health.absorbs,0,"event keeps cache readable")
-- Stale smoothing/timer targets must never read back a protected bar value.
b.aux[1].FLUID=400;b.aux[1].TIMED=1000
values.totalIncomingHeals=secret(30)
env.HealBot_Aux_UpdateHealInBar(b)
eq(b.aux[1].FLUID,-1,"old smoothing target cancelled")
eq(b.aux[1].TIMED,-1,"old timer cancelled")
env.HealBot_Unit_Status.RESERVED=40
env.HealBot_Aux_UpdateTargetBarById(b,1)
eq(b.gref.aux[1].maximum,1000,"reassignment restores normal scale")
eq(b.gref.aux[1].value,1000,"reassigned Target auxiliary fills normally")
eq(b.aux[1].NATIVEPREDICTION,nil,"reassignment drops native flag")
-- Settings hooks update real active bars immediately, without another cast.
hooks.HealBot_Action_RegisterUnitEvents(b)
skin.IC=3;hooks.hbv_Skins_SetFrameVar(3,"BarIACol","IC",1)
eq(p.bar.color[1],0.8,"live mode hook")
skin.IC=6;skin.AC=1;env.HealBot_Forever_UpdatePrediction(b)
eq(p.absorb.shown,false,"absorb mode disabled")
eq(b.gref.Shield.color[4],0,"disabled absorbs hide overflow")
eq(b.gref.aux[2].value,20,"absorb auxiliary independent of main mode")
skin.AC=6
for _,key in ipairs({"R","G","B","IR","IG","IB","CR","CG","CB"}) do
    skin["I"..key.."E"]=0.6
    skin["A"..key.."E"]=0.7
end
b.status.hostile=true;env.HealBot_Forever_UpdatePrediction(b)
eq(p.bar.color[1],0.6,"enemy incoming palette")
eq(p.absorb.color[1],0,"shield fill stays cerulean on enemy frames")
b.status.hostile=false
skin.IIT=0.25;skin.ICT=0.25;values.health=secret(15);values.totalIncomingHeals=secret(10)
env.HealBot_Forever_UpdatePrediction(b)
eq(p.bar.color[2],0,"equal thresholds at boundary use critical")
values.health=secret(20);env.HealBot_Forever_UpdatePrediction(b)
eq(p.bar.color[1],0.4,"equal thresholds above boundary use normal")
b.status.current=20;env.HealBot_Forever_UpdatePrediction(b)
eq(p.bar.shown,false,"death hides prediction")
eq(p.absorb.shown,false,"death hides absorbs")
eq(b.gref.aux[2].value,0,"death clears auxiliary")

-- Reproduce the state left by the old failed texture initialization. Neither
-- the class nor custom colour path may consume an incomplete renderer.
b.status.current=1
values={health=secret(40),healthMax=secret(100),totalIncomingHeals=secret(20),totalDamageAbsorbs=secret(15)}
for _,missing in ipairs({"absorbOverlay","colourCalculator","remainingCalculator"}) do
    for _,mode in ipairs({3,6}) do
        local partial={}
        for k,v in pairs(p) do partial[k]=v end
        partial[missing]=nil
        b.foreverIncoming=partial; skin.IC=mode; skin.AC=mode
        partial.absorb:Show()
        eq(env.HealBot_Forever_UpdatePrediction(b),false,missing.." declines partial renderer")
        eq(partial.absorb.shown,false,"partial absorb bar hidden")
        eq(env.HealBot_Forever_UpdateOverShield(b),false,"partial overflow declines native path")
        eq(env.HealBot_Forever_UpdateIncomingHeals(b),true,"incoming-heal fallback survives")
        eq(partial.bar.value,20,"fallback still draws protected incoming heals")
    end
end

-- Inject failures at each texture and after both textures, then exercise the
-- real attach hook to recover. No incomplete resources should be published.
local textureHelper=env.SetTextureWithAddressModeOptions
for _,asset in ipairs({"raidframe-shield-fill","RaidFrame-Shield-Overlay","calculator"}) do
    local pending={calculator=calc(),bar=frame()}
    b.foreverIncoming=pending
    env.SetTextureWithAddressModeOptions=function(region,name,...)
        if name==asset then error("simulated texture initialization failure") end
        return textureHelper(region,name,...)
    end
    local calls=0
    env.CreateUnitHealPredictionCalculator=function()
        calls=calls+1
        if asset=="calculator" and calls==2 then error("simulated calculator failure") end
        return calc()
    end
    eq(pcall(env.HealBot_Forever_CreatePrediction,b),false,"injected setup failure is visible")
    eq(pending.absorb,nil,"failed setup does not publish absorb bar")
    eq(pending.absorbOverlay,nil,"failed setup does not publish overlay")
    eq(pending.colourCalculator,nil,"failed setup does not publish colour calculator")
    eq(env.HealBot_Forever_UpdateIncomingHeals(b),true,"refresh after setup failure falls back")
    eq(pending.bar.value,20,"failure preserves incoming-heal rendering")
    env.SetTextureWithAddressModeOptions=textureHelper
    env.CreateUnitHealPredictionCalculator=calc
    hooks.HealBot_Action_RegisterUnitEvents(b)
    eq(pending.absorb.value,15,"out-of-combat attach repairs initialization")
    eq(pending.absorbOverlay.atlas,"RaidFrame-Shield-Overlay","repair restores overlay")
    local before=createdFrames
    hooks.HealBot_Action_RegisterUnitEvents(b)
    eq(createdFrames,before,"complete renderer is reused on repeated attach")
end
local partial={calculator=calc(),bar=frame(),absorb=frame()}
b.foreverIncoming=partial
partial.absorb:Show()
env.InCombatLockdown=function() return true end
local before=createdFrames
hooks.HealBot_Action_RegisterUnitEvents(b)
eq(createdFrames,before,"partial renderer never rebuilt in combat")
eq(partial.absorb.shown,false,"old partial bar hidden in combat")
eq(partial.bar.value,20,"combat fallback still draws incoming heals")
env.InCombatLockdown=function() return false end
local oldAbsorb=partial.absorb
hooks.HealBot_Action_RegisterUnitEvents(b)
eq(partial.absorb~=oldAbsorb,true,"partial bar replaced outside combat")
eq(oldAbsorb.shown,false,"replaced partial bar stays hidden")
eq(partial.absorb.value,15,"repaired bar draws absorbs")
eq(partial.colourCalculator~=nil,true,"repair restores colour calculator")
eq(partial.remainingCalculator~=nil,true,"repair restores remaining-health calculator")
print("PASS: "..passed.." native prediction/auxiliary assertions (mock APIs)")
