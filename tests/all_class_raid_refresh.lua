local f=assert(io.open("tests/native_buff_casters.lua","rb"))
local source=f:read("*a"):gsub("\r\n","\n")
f:close()
local fixture=assert(loadstring(assert(source:match("^(.-)\nlocal function admits%(")).."\nreturn fixture"))()
local classes={"DRUID","HUNTER","MAGE","PALADIN","PRIEST","ROGUE","SHAMAN","WARLOCK","WARRIOR"}
for _,class in ipairs(classes) do
    local d=fixture(class,4)
    local env=d.env
    local inBG=false
    env.IsInInstance=function() return inBG,inBG and "pvp" or "none" end
    d.skin.limits={4,4,4}
    local generic=900101
    d.names[generic]="Synthetic test effect"
    d.globals.WatchHoT.ALL[generic]=1
    d.globals.CustomBuffIDMethod[generic]=1
    local builds=0
    env.HealBot_Forever_VisitAuraPerfScopes(function(name,fn)
        if name~="Aura.BuildOne" then return fn end
        return function(...) builds=builds+1; return fn(...) end
    end)
    local donor,reserves
    for i=1,15 do donor=d.button("raid"..i) end
    reserves={}
    local pass=env.HealBot_Forever_PrepareArrivalAuraContext()
    for i=16,40 do
        local row={unit="raid"..i,frame=1,healthBar={},GetFrameLevel=function() return 5 end}
        reserves[#reserves+1]=row
        env.HealBot_Forever_SkinArrivalAuras(row,donor,pass)
    end
    assert(builds>0,"cold pass did not construct aura rows for "..class)
    local frameCount=#d.frames
    builds=0
    d.globals.WatchHoT.ALL[generic]=3
    inBG=true
    d.fire("PLAYER_ENTERING_WORLD")
    for i=1,25 do d.hook("HealBot_Aura_SetAuraCheckFlags") end
    d.combat(true)
    for i=1,25 do d.hook("HealBot_Aura_SetAuraCheckFlags") end
    d.combat(false)
    inBG=false
    d.fire("PLAYER_ENTERING_WORLD")
    for _,row in ipairs(reserves) do
        local group=row.arrivalAuras[1].container.groups.hbcahotEveryone
        assert(group.options.candidateFilters.includeSpellIDs[generic],class.." lost newly selected caster scope")
    end
    assert(builds==0 and #d.frames==frameCount,class.." rebuilt warm rows during monitoring or combat transitions")
end
print("PASS: all 9 Forever classes, 40 regular/reserve bars each, 50 policy refreshes and BG/combat transitions per class; zero warm group builds")
