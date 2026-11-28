local function read(path)
    local f=assert(io.open(path,'rb')); local s=f:read('*a'); f:close()
    return s:gsub('\r\n','\n'):gsub('^\239\187\191','')
end
local prefix=assert(read('tests/native_buff_casters.lua'):match('^(.-)\nlocal function admits%('))
local fixture=assert(loadstring(prefix..'\nreturn fixture'))()
local cases=0
for _,family in ipairs({{401859,401863,401877},{1240826,1240848,1240849},{1240827,1240849,1240848},{99010,99011,99012}}) do
    for set=1,3 do
        for _,caster in ipairs({1,3}) do
            local d=fixture('PRIEST',4); local e=d.env
            d.skin.limits={4,4,4}; local zone='none'
            e.IsInInstance=function() return zone~='none',zone end
            if family[1]==99010 then assert(e.HealBot_Forever_RegisterAuraFamily(family[1],{family[2],family[3]})) end
            d.globals.WatchHoT.ALL[family[1]]=caster
            d.globals.CustomBuffsIconSet[family[1]]=set
            d.globals.CustomBuffIDMethod[family[1]]=2
            local b=d.button(); local allocated=#d.frames
            local function check(label)
                local found
                for _,f in ipairs(d.frames) do
                    local group=f.groups[caster==1 and 'hbcahot' or 'hbcahotEveryone']
                    if f.parent==b and group and group.options.candidateFilters.includeSpellIDs
                        and group.options.candidateFilters.includeSpellIDs[family[2]] then found=f end
                end
                assert(found,label..': applied aura ID missing after handoff ('..family[1]..' set '..set..' caster '..caster..')')
                local group=found.groups[caster==1 and 'hbcahot' or 'hbcahotEveryone']
                assert(group.options.candidateFilters.includeSpellIDs[family[2]] and
                    group.options.candidateFilters.includeSpellIDs[family[3]],label..': triggered/jumping variants missing')
                assert(group.options.maxFrameCount>0,label..': requested caster group has no slots')
                assert(found.point[1]==b.gref.icon[({1,9,11})[set]].point[1],label..': wrong icon set')
                assert(#d.frames==allocated,label..': handoff allocated frames')
            end
            check('prepared')
            zone='pvp'; d.fire('PLAYER_ENTERING_WORLD'); check('BG preparation')
            d.combat(true); check('BG combat')
            d.combat(false); check('BG combat exit')
            zone='none'; d.fire('PLAYER_ENTERING_WORLD'); check('BG exit')
            cases=cases+1
        end
    end
end
-- Strict ID remains strict: registering a family must not widen that setting.
local d=fixture('PRIEST',4)
d.env.HealBot_Forever_RegisterAuraFamily(99010,{99011,99012})
d.globals.WatchHoT.ALL[99010]=1; d.globals.CustomBuffIDMethod[99010]=1
local b=d.button()
for _,f in ipairs(d.frames) do
    if f.parent==b and f.groups.hbcahot then
        local ids=f.groups.hbcahot.options.candidateFilters.includeSpellIDs
        assert(not ids or not ids[99011],'strict ID widened to trigger family')
    end
end
local exact=fixture('PRIEST',4)
exact.globals.WatchHoT.ALL[1240827]=1; exact.globals.CustomBuffIDMethod[1240827]=1
local strictRow=exact.row(exact.button())
assert(strictRow.groups.hbcahot.options.candidateFilters.includeSpellIDs[1240827])
assert(not strictRow.groups.hbcahot.options.candidateFilters.includeSpellIDs[1240849],'strict cast ID admitted applied rank 3')
print('PASS: '..cases..' real and unfamiliar aura-family/caster/icon-set cases across 5 contexts; strict-ID behavior preserved')
