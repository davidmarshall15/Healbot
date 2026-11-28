-- Execute the same Arathi Basin roster workload against pinned release code
-- and today's installation. Counters are workload measurements, not frame times.
-- Optional arguments are directories containing HealBot_CombatAuras.lua from
-- 26.11.20 (ea5fd485), 26.11.27 (0003eaf7), and the merge of #92 (febde0e5).
local run=assert(loadfile("tests/fixtures/raid_aura_workload.lua"))
local refs={{"candidate","HealBot",0}}
if arg[1] then
    assert(arg[2] and arg[3], "supply all three historical source directories")
    refs[#refs+1]={"26.11.20",arg[1],0}
    refs[#refs+1]={"26.11.27",arg[2],75}
    refs[#refs+1]={"PR92",arg[3],75}
end
local classes={"DRUID","HUNTER","MAGE","PALADIN","PRIEST","ROGUE","SHAMAN","WARLOCK","WARRIOR"}
local all=0
for _,class in ipairs(classes) do
    for _,ref in ipairs(refs) do
        local report={}
        local env=setmetatable({arg={ref[2],ref[1],class}, print=function(line)
            local label,player,phase,filters,builds,skins=line:match("^(.-)\t(.-)\t(.-)\t(%d+)\t(%d+)\t(%d+)")
            assert(label==ref[1] and player==class, "missing or mislabeled baseline result")
            report[phase]={filters=tonumber(filters),builds=tonumber(builds),skins=tonumber(skins)}
        end},{__index=_G})
        setfenv(run,env)()
        assert(report.cold.builds>0,"missing positive construction control")
        assert(report.flags_after_subpixel_move.builds==ref[3],
            class.." "..ref[1].." rebuild count after donor moved: "..report.flags_after_subpixel_move.builds)
        assert(report.required_geometry_change.builds>0,"real geometry change was skipped")
        if ref[1]=="candidate" then
            assert(report["25_warm_flags"].skins==0 and report["25_warm_flags"].builds==0)
        end
        all=all+1
    end
end
print("PASS: "..all.." raid replays reproduced the expected rebuild counts across all nine classes")
