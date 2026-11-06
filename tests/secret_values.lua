-- Test mixed readable/protected inputs against the real update functions.
-- These mocks do not model WoW taint or protected-frame restrictions.
local passed,failures=0,{}
local function eq(actual,expected,label)
    assert(actual==expected,label or "unexpected value")
    passed=passed+1
end
local function forbidden() error("secret arithmetic/comparison") end
local secret=setmetatable({}, {__lt=forbidden,__le=forbidden,__add=forbidden,
    __sub=forbidden,__mul=forbidden,__div=forbidden})
local function noop() end
local function loadFunction(file,name,env)
    local handle=assert(io.open(file,"rb"))
    local source=handle:read("*a"):gsub("\r\n","\n")
    handle:close()
    local code=assert(source:match("(function "..name.."%b().-)\nend"),name).."\nend"
    setfenv(assert(loadstring(code,"@"..file..":"..name)),env)()
end
local action="HealBot/HealBot_Action.lua"
local core="HealBot/HealBot.lua"
local function fixture()
    local function bar()
        return {value=0,SetValue=function(self,v) self.value=v end,
            GetValue=function(self) return self.value end,
            SetStatusBarColor=function(self,r,g,b,a) self.alpha=a end,
            SetBackdropBorderColor=function(self,r,g,b,a) self.alpha=a end}
    end
    local b={id=1,frame=1,framecol=1,unit="player",roletxt="HEALER",
        health={current=50,max=100,pct=0.5,hpct=500,incoming=10,absorbs=20,
            overheal=5,auxabsorbs=0,absorbr=1,absorbg=1,absorbb=1},
        status={current=1,enabled=true,alpha=1},range={current=1},
        gref={Shield=bar(),Absorb=bar(),InHeal=bar(),Bar=bar(),Back=bar(),BackBorder=bar()},
        adaptive={current=1},aura={debuff={colbar=0},buff={colbar=0}}}
    local env=setmetatable({
        HealBot_issecretvalue=function(v) return rawequal(v,secret) end,
        HealBot_Data={UILOCK=true},HealBot_Action_luVars={FluidInUse=false},
        HealBot_Unit_Status={DEAD=20,DC=30,ENABLEDIR=1,PLUGINBARCOL=15},
        HEALBOT_FOREVER=false,
        hbv_Skins_GetFrameBoolean=function() return true end,
        hbv_Skins_GetFrameVar=function(_,key)
            return ({AC=2,IC=2,AA=1,IA=1,CRITICAL=0.25,INJURED=0.75})[key] or 0
        end,
        HealBot_Action_BarColourAlpha=function(_,a) return a end,
        hbAbsorbsColourFuncs={[2]=noop},hbHealsInColourFuncs={[2]=noop},
        HealBot_Action_UpdateAbsorbStatusBarColor=noop,
        HealBot_Action_UpdateInHealStatusBarColor=noop,
        HealBot_Action_UpdateHotBar=noop,HealBot_Text_setInHealAbsorbsText=noop,
        HealBot_Action_AdaptiveAbsorbsUpdate=noop,HealBot_Aux_UpdateAbsorbBar=noop,
        HealBot_Action_UpdateAbsorbsButton=noop,HealBot_Action_OverShield=noop,
        HealBot_Action_UpdateBackground=noop,
        HealBot_Action_AdaptiveNextActive=function(button,index) button.adaptive[index]=false end,
        hbAdaptive={Absorbs=true,Overheals=true},
        hbAdaptiveOrder={[1]="Absorbs"},hbAdaptiveOrderName={Absorbs=1,Overheals=1},
        hbAdaptiveCol={Absorbs={R=1,G=1,B=1}},
        HealBot_Emerg_Button={[1]={state=4}},emergHealthCol={},
        HealBot_Action_EmergBarUpdate=noop,HealBot_Action_DisableEmergButtonGlowKey=noop,
        HealBot_Range_Spell=function() return "heal" end,
        floor=math.floor,
    }, {__index=_G})
    return b,env
end
local function test(name,run)
    local ok,err=pcall(run)
    if not ok then failures[#failures+1]=name..": "..tostring(err) end
end

for _,field in ipairs({"current","max","absorbs"}) do
    test("overshield with protected "..field,function()
        local b,e=fixture(); b.health[field]=secret
        loadFunction(action,"HealBot_Action_OverShield",e)
        e.HealBot_Action_OverShield(b)
        eq(b.gref.Shield.alpha,0,"unknown overshield stays hidden")
    end)
end
test("readable overshield",function()
    local b,e=fixture(); b.health.current=90
    loadFunction(action,"HealBot_Action_OverShield",e)
    e.HealBot_Action_OverShield(b); eq(b.gref.Shield.alpha,1)
    b.health.absorbs=0; e.HealBot_Action_OverShield(b); eq(b.gref.Shield.alpha,0)
end)

for _,spec in ipairs({{"HealBot_Action_UpdateHealsInButton","InHeal","inheala",700},
                      {"HealBot_Action_UpdateAbsorbsButton","Absorb","absorba",900}}) do
    local fields={"current","max","incoming"}
    if spec[2]=="Absorb" then fields[#fields+1]="absorbs" end
    for _,field in ipairs(fields) do
        test(spec[1].." with protected "..field,function()
            local b,e=fixture(); b.health[field]=secret; b.gref[spec[2]].value=800
            loadFunction(action,spec[1],e); e[spec[1]](b)
            eq(b.gref[spec[2]].value,0,"unsafe legacy prediction clears")
            eq(b.health[spec[3]],0,"unsafe prediction opacity clears")
            eq(b.health[spec[2]=="Absorb" and "abptc" or "inhptc"],0,"hidden smoothing target stays readable")
        end)
    end
    test(spec[1].." readable",function()
        local b,e=fixture(); b.health.incoming=20
        loadFunction(action,spec[1],e); e[spec[1]](b)
        eq(b.gref[spec[2]].value,spec[4],"readable prediction preserved")
    end)
end

for _,kind in ipairs({"Absorbs","Overheals"}) do
    local field=kind=="Absorbs" and "absorbs" or "overheal"
    for _,prefix in ipairs({"BackgroundColourAdaptive","BackgroundBorderColourAdaptive"}) do
        local name="HealBot_Action_"..prefix..kind
        test(name,function()
            local b,e=fixture(); loadFunction(action,name,e)
            local target=prefix=="BackgroundColourAdaptive" and b.gref.Back or b.gref.BackBorder
            b.health[field]=secret; e[name](b); eq(target.alpha,0,"secret numerator hidden")
            b.health[field]=5; b.health.max=secret; e[name](b); eq(target.alpha,0,"secret maximum hidden")
            b.health.max=0; e[name](b); eq(target.alpha,0,"zero maximum hidden")
            b.health.max=100; e[name](b); eq(target.alpha,0.5,"readable alpha preserved")
            b.health[field]=20; e[name](b); eq(target.alpha,1,"readable alpha clamped")
        end)
    end
    test("adaptive selection "..kind,function()
        local b,e=fixture(); local name="HealBot_Action_Adaptive"..kind.."Update"
        loadFunction(action,name,e)
        b.health[field]=secret; e[name](b); eq(b.adaptive[1],false)
        b.health[field]=5; e[name](b); eq(b.adaptive[1],true)
        b.health.max=secret; e[name](b); eq(b.adaptive[1],false)
    end)
end

test("emergency thresholds with protected percentage",function()
    local b,e=fixture(); b.health.pct=secret
    loadFunction(action,"HealBot_Action_EmergBarCheck",e)
    e.HealBot_Action_EmergBarCheck(b,true); eq(e.HealBot_Emerg_Button[1].state,0)
    b.health.pct=0.1; e.HealBot_Action_EmergBarCheck(b,true); eq(e.HealBot_Emerg_Button[1].state,4)
    b.health.pct=0.5; e.HealBot_Action_EmergBarCheck(b,true); eq(e.HealBot_Emerg_Button[1].state,3)
end)

test("absorb refresh with protected maximum",function()
    local b,e=fixture(); b.health.absorbs=0; b.health.max=secret
    e.HealBot_AbsorbsAmount=function() e.abuAbsorbAmount=20 end
    loadFunction(core,"HealBot_AbsorbsUpdate",e)
    e.HealBot_AbsorbsUpdate(b)
    eq(b.health.absorbs,20,"readable amount retained")
    eq(b.health.absorbspctc,0,"no ratio from secret maximum")
    b.health.max=100; e.HealBot_AbsorbsAmount=function() e.abuAbsorbAmount=30 end
    e.HealBot_AbsorbsUpdate(b); eq(b.health.absorbspctc,300,"readable absorb ratio retained")
end)

for _,name in ipairs({"HealBot_Action_setEnabled","HealBot_Action_UpdateHealthButton"}) do
    test(name.." protected cached amounts",function()
        local b,e=fixture(); local heals,absorbs=0,0
        b.health.incoming,b.health.absorbs=secret,secret
        b.status.hlthupd=false
        e.HealBot_Action_UpdateHealsInButton=function() heals=heals+1 end
        e.HealBot_Action_UpdateAbsorbsButton=function() absorbs=absorbs+1 end
        e.HealBot_Action_EmergBarCheck=noop
        e.HealBot_Aux_UpdBar=noop; e.HealBot_Aura_Update_AllIcons=noop
        e.HealBot_Util_isMidnight=function() return true end
        loadFunction(action,name,e)
        if name=="HealBot_Action_setEnabled" then e[name](b,true,0.5) else e[name](b,false) end
        eq(heals,1,"heal refresh reaches its secret guard")
        eq(absorbs,1,"absorb refresh reaches its secret guard")
    end)
end

for _,spec in ipairs({{"HealBot_Action_UpdateHealsInButton","InHeal","inhptc","HealBot_Fluid_InHealButtons"},
                      {"HealBot_Action_UpdateAbsorbsButton","Absorb","abptc","HealBot_Fluid_AbsorbButtons"}}) do
    test(spec[1].." smoothing with secret health",function()
        local b,e=fixture(); b.health.current=secret; b.health.hpct=secret
        e.HealBot_Action_luVars.FluidInUse=true
        e.HealBot_Util_isMidnight=function() return true end
        e.HealBot_Fluid_BarButtons={}; e.HealBot_Fluid_InHealButtons={}; e.HealBot_Fluid_AbsorbButtons={}
        e[spec[4]][1]=b
        loadFunction(action,spec[1],e)
        loadFunction(action,"HealBot_Action_UpdateFluidBars",e)
        e[spec[1]](b); e.HealBot_Action_UpdateFluidBars()
        eq(b.gref[spec[2]].value,0,"native smoothing receives zero for a hidden legacy bar")
        eq(e[spec[4]][1],nil,"processed smoothing entry removed")
    end)
end
test("native Forever prediction remains first choice",function()
    local b,e=fixture(); b.health.current=secret; b.health.incoming=secret
    e.HealBot_Forever_UpdateIncomingHeals=function(button)
        button.gref.InHeal:SetValue(secret)
        return true
    end
    loadFunction(action,"HealBot_Action_UpdateHealsInButton",e)
    e.HealBot_Action_UpdateHealsInButton(b)
    eq(b.gref.InHeal.value,secret,"native renderer still consumes protected prediction")
end)

if #failures>0 then
    for _,failure in ipairs(failures) do print("FAIL: "..failure) end
    error(#failures.." mixed secret-value cases failed")
end
print("PASS: "..passed.." mixed secret-value assertions (mock APIs)")
