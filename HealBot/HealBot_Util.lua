local HealBot_Util_luVars={}

function HealBot_Util_setLuVars(vName, vValue)
      --HealBot_setCall("HealBot_Util_setLuVars - "..vName)
    HealBot_Aggro_luVars[vName]=vValue
end

function HealBot_Util_retLuVars(vName)
      --HealBot_setCall("HealBot_Util_retLuVars - "..vName)
    return HealBot_Aggro_luVars[vName]
end

local mult=0
function HealBot_Util_Round(num, idp)
      --HealBot_setCall("HealBot_Util_Round")
    mult=10^(idp or 0)
    return floor(num * mult + 0.5) / mult
end

local function HealBot_Util_PerfMod(mod, mType, mMax)
    if mType == 1 then
        if mod>mMax then
            return 1
        elseif mod<1 then
            return 1/mMax
        else
            return mod/mMax
        end
    elseif mod>(mMax-1) then
        return mMax
    elseif mod<1 then
        return 99.9*mMax
    else
        return (100-(mod/10))*mMax
    end
end

function HealBot_Util_PerfVal1(mod)  -- max mod is 1000, returns higher value at higher FPS, returns int
      --HealBot_setCall("HealBot_Util_PerfVal1")
    mod=HealBot_Util_PerfMod(mod, 1, 1000)
    return ceil(HealBot_Globals.CPUUsage*mod)
    -- when HealBot_Globals.CPUUsage equals 20 (FPS == 80)
    -- - mod 1000 will return 20
    -- - mod  750 will return 15
    -- - mod  500 will return 10
    -- - mod  250 will return  5
    -- - mod  100 will return  2
    -- - mod   50 will return  1
    -- - mod   10 will return  1
end

function HealBot_Util_PerfVal2(mod)  -- max mod is 1000, returns lower value at higher FPS, returns fraction of CPUUsage in ms
      --HealBot_setCall("HealBot_Util_PerfVal")
    mod=HealBot_Util_PerfMod(mod, 2, 1000)
    return HealBot_Util_Round(((mod/HealBot_Globals.CPUUsage)/1000),2)
    -- when HealBot_Globals.CPUUsage equals 20 (FPS == 80)
    -- - mod 1000 will return 0.05
    -- - mod  750 will return 1.25
    -- - mod  500 will return 2.5
    -- - mod  250 will return 3.75
    -- - mod  100 will return 4.5
    -- - mod   50 will return 4.75
    -- - mod   10 will return 4.95
end

function HealBot_Util_PerfVal3(mod)  -- max mod is 1000, returns lower value at higher FPS, returns fraction of fps in ms
      --HealBot_setCall("HealBot_Util_PerfVal")
    mod=HealBot_Util_PerfMod(mod, 2, 1000)
    return HealBot_Util_Round(((mod/HealBot_Globals.FPS)/1000),2)
    -- when FPS == 80
    -- - mod 1000 will return 0.01
    -- - mod  750 will return 0.31
    -- - mod  500 will return 0.62
    -- - mod  250 will return 0.94
    -- - mod  100 will return 1.12
    -- - mod   50 will return 1.19
    -- - mod   10 will return 1.24
end

function HealBot_Util_PerfVal4(mod)  -- max mod is 100, returns fraction of fps in ms
      --HealBot_setCall("HealBot_Util_PerfVal")
    mod=HealBot_Util_PerfMod(mod, 1, 100)
    HealBot_Util_luVars["msFPS"]=1000/(HealBot_Globals.FPS*1000)
    return HealBot_Util_Round((1-HealBot_Util_luVars["msFPS"])*mod,2)
    -- when FPS == 40
    -- - mod 100 will return 0.98
    -- - mod  75 will return 0.73
    -- - mod  50 will return 0.49
    -- - mod  25 will return 0.24
    -- - mod  10 will return 0.1
    -- - mod   5 will return 0.05
    -- - mod   1 will return 0.01
end

function HealBot_Util_EmptyTable(t, key)
    HealBot_Util_luVars["emptyTable"]=true
    for _,v in pairs(t[key]) do
        if v then
            HealBot_Util_luVars["emptyTable"]=false
            break
        end
    end
    if HealBot_Util_luVars["emptyTable"] then
        t[key]=nil
    end
end