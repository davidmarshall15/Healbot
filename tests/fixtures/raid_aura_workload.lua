local folder,label,class=arg[1],arg[2],arg[3] or "PRIEST"
local function read(path)
    local f=assert(io.open(path,"rb"))
    local s=f:read("*a"):gsub("\r\n","\n")
    f:close()
    return s
end
local utility=read("tests/native_buff_casters.lua")
local prefix=assert(utility:match("^(.-)\nlocal function admits%("))
local source=read(folder.."/HealBot_CombatAuras.lua")
local counts,errors={},{}
local function count(key) counts[key]=(counts[key] or 0)+1 end
local function probe(name,key)
    local pattern="(function "..name.."%b())"
    source=source:gsub(pattern,function(decl) return decl.."\nProbe('"..key.."')" end)
end
probe("HBCA_PriestFilters","filters")
probe("HBCA_ConfiguredBuffFilters","filters")
probe("HBCA_BuildOne","builds")
probe("HBCA_SetButtonShown","visual")
probe("HealBot_Forever_SkinArrivalAuras","skinReserve")
probe("HBCA_UpdateBuffRow","updateRow")
probe("HBCA_RefreshBuffRows","refresh")
prefix=prefix:gsub('local source=read%("HealBot/HealBot_CombatAuras.lua"%)','local source=...',1)
prefix=prefix:gsub("function r:SetShown%(v%) self.shown=v end","function r:SetShown(v) if self.kind then ProbeAPI() end; self.shown=v end",1)
local fenv=setmetatable({ProbeAPI=function() count("writes") end},{__index=_G})
local fixture=setfenv(assert(loadstring(prefix.."\nreturn fixture")),fenv)(source)
local function run()
    local d=fixture(class,4,function(env)
        env.Probe=count
        local function checked(ok,...)
            if not ok then errors[(...)]=true end
            return ok,...
        end
        env.pcall=function(fn,...) return checked(pcall(fn,...)) end
        local create=env.CreateFrame
        env.CreateFrame=function(kind,...)
            if kind=="AuraContainer" then count("containers") end
            return create(kind,...)
        end
    end)
    d.skin.limits={4,4,4}
    local donor
    for i=1,15 do donor=d.button("raid"..i) end
    local pass=d.env.HealBot_Forever_PrepareArrivalAuraContext and d.env.HealBot_Forever_PrepareArrivalAuraContext()
    local reserves={}
    for i=16,40 do
        local row={unit="raid"..i,frame=1,healthBar={},GetFrameLevel=function()return 5 end}
        d.env.HealBot_Forever_SkinArrivalAuras(row,donor,pass)
        reserves[#reserves+1]=row
    end
    assert(counts.builds and counts.builds>0,"no functional native construction")
    local function phase(name)
        local keys={"filters","builds","skinReserve","visual","updateRow","writes","refresh","containers"}
        local parts={}
        for _,key in ipairs(keys) do parts[#parts+1]=tostring(counts[key] or 0) end
        print(table.concat({label,class,name,unpack(parts)},"\t"))
        counts={}
    end
    phase("cold")
    for i=1,25 do d.hook("HealBot_Aura_SetAuraCheckFlags") end
    phase("25_warm_flags")
    d.combat(true)
    for i=1,25 do d.hook("HealBot_Aura_SetAuraCheckFlags") end
    d.combat(false)
    phase("combat_25_flags_exit")
    d.names[900101]="Synthetic raid buff"
    d.globals.WatchHoT.ALL[900101]=3
    d.globals.CustomBuffIDMethod[900101]=1
    d.hook("HealBot_Aura_SetAuraCheckFlags")
    phase("new_generic_watch")
    -- Public centers may move when frames are repositioned. A tiny change is
    -- sufficient to distinguish screen-space rebuild keys from local geometry.
    for _,index in ipairs({1,9,11}) do donor.gref.icon[index].GetCenter=function() return 100+1/1024,200 end end
    d.hook("HealBot_Aura_SetAuraCheckFlags")
    phase("flags_after_subpixel_move")
    d.skin.limits[1]=2
    pass=d.env.HealBot_Forever_PrepareArrivalAuraContext and d.env.HealBot_Forever_PrepareArrivalAuraContext()
    for _,row in ipairs(reserves) do d.env.HealBot_Forever_SkinArrivalAuras(row,donor,pass) end
    phase("required_geometry_change")
    for _,row in ipairs(reserves) do
        assert(row.arrivalAuras and #row.arrivalAuras>0,"missing all reserve rows")
    end
    for err in pairs(errors) do error(err) end
end
run()
