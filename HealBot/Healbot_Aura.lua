local HealBot_UnitBuffIcons={}
local HealBot_UnitDebuffIcons={}
local HealBot_UnitBuffCurrent={}
local HealBot_UnitDebuffCurrent={}
local HealBot_UnitExtraIcons={}
local HealBot_BuffNameTypes={}
local HealBot_BuffMinLevels={}
local HealBot_AuraBuffCache={}
local HealBot_AuraBuffIconCache={}
local HealBot_AuraDebuffCache={}
local HealBot_ExcludeBuffInCache={}
local HealBot_Aura_WarningFilter={}
local HealBot_Aura_CanDispel={}
local HealBot_Aura_prevIconCount={["DEBUFF"]={[1]=0,[2]=0,[3]=0,},["BUFF"]={[1]=0,[2]=0,[3]=0,} }
local HealBot_Watch_HoT={};
local HealBot_CheckBuffs={}
local HealBot_ShortBuffs={}
local HealBot_BuffWatch={}
local HealBot_BuffWatchList={}
local PlayerBuffs={}
local PlayerBuffTypes={}
local buffSort={[1]={},[2]={},[3]={}}
local debuffSort={[1]={},[2]={},[3]={}}
local HealBot_Aura_ID={}
local HealBot_Aura_IconSet={}
local HealBot_SpellID_LookupData={}
local HealBot_SpellID_LookupIdx={}
local HealBot_BuffIconSet={}
local HealBot_BuffIconGlow={}
local HealBot_DebuffIconSet={}
local HealBot_DebuffIconGlow={}
local HealBot_BuffTagNames={}
local HealBot_DebuffTagNames={}
local HealBot_AuraBuffXRef={}
local HealBot_AuraDebuffXRef={}
local _
local HealBot_Buff_Aura2Item={}
local HealBot_Buff_Aura2Spell={}
local HealBot_Buff_ItemIDs={};
local buffCheck, generalBuffs, buffWarnings, debuffCheck, debuffWarnings=false,false,false,true,true
local tmpBCheck, tmpCBuffs, tmpGBuffs, tmpDCheck, tmpBGroup, tmpDGroup, tmpNumGroup=false,false,false,false,false,false,0
local uaName, uaTexture, uaCount, uaDebuffType, uaDuration="","",0,"",0
local uaExpirationTime, uaUnitCaster, uaUnitIsPlayer, uaSpellId, uaIsBossDebuff=0,"",false,0,false
local uaExtra17, uaExtra18, uaExtra19=nil, nil, nil
local uaBuffData={}
local uaDebuffData={}
local uaBuffSlot, uaDebuffSlot=0,0
local HealBot_Classic_Absorbs={}
local HealBot_Classic_AbsorbsV1Track={}
local classicAbsorbBonusV1={}
local HealBot_TargetIconsTextures={[1]=[[Interface\Addons\HealBot\Images\Star.tga]],
                                     [2]=[[Interface\Addons\HealBot\Images\Circle.tga]],
                                     [3]=[[Interface\Addons\HealBot\Images\Diamond.tga]],
                                     [4]=[[Interface\Addons\HealBot\Images\Triangle.tga]],
                                     [5]=[[Interface\Addons\HealBot\Images\Moon.tga]],
                                     [6]=[[Interface\Addons\HealBot\Images\Square.tga]],
                                     [7]=[[Interface\Addons\HealBot\Images\Cross.tga]],
                                     [8]=[[Interface\Addons\HealBot\Images\Skull.tga]],}
local HealBot_Weapon_Enchant={[1]=false,[2]=false}
local HealBot_Aura_AuxAssigns={}
HealBot_Aura_AuxAssigns["NameOverlayBuff"]={[0]=false,[1]=false,[2]=false,[3]=false,[4]=false,[5]=false,[6]=false,[7]=false,[8]=false,[9]=false,[10]=false}
HealBot_Aura_AuxAssigns["NameOverlayDebuff"]={[0]=false,[1]=false,[2]=false,[3]=false,[4]=false,[5]=false,[6]=false,[7]=false,[8]=false,[9]=false,[10]=false}
HealBot_Aura_AuxAssigns["HealthOverlayBuff"]={[0]=false,[1]=false,[2]=false,[3]=false,[4]=false,[5]=false,[6]=false,[7]=false,[8]=false,[9]=false,[10]=false}
HealBot_Aura_AuxAssigns["HealthOverlayDebuff"]={[0]=false,[1]=false,[2]=false,[3]=false,[4]=false,[5]=false,[6]=false,[7]=false,[8]=false,[9]=false,[10]=false}
local HealBot_Aura_luVars={}
HealBot_Aura_luVars["TankGUID1"]="x"
HealBot_Aura_luVars["mapName"]=HEALBOT_WORD_OUTSIDE
HealBot_Aura_luVars["IgnoreFastDurDebuffsSecs"]=-1
HealBot_Aura_luVars["HotBarDebuff"]=0
HealBot_Aura_luVars["ManaDrink"]=""
HealBot_Aura_luVars["WellFed"]=""
HealBot_Aura_luVars["TestBarsOn"]=false
HealBot_Aura_luVars["AuraUpdate"]=0.98

local hbDebuffOnCD={}

local hbTextureUpdate={[HEALBOT_RENEWING_MIST_NAME]=8}
local hbTextureUpdateId={}
local hbTextureUpdateTime={}

local hbDebuffBleed={}
hbDebuffBleed[703]="Garrote"
hbDebuffBleed[1079]="Rip"
hbDebuffBleed[1943]="Rupture"
hbDebuffBleed[3147]="Rend Flesh"
hbDebuffBleed[5597]="Serious Wound"
hbDebuffBleed[5598]="Serious Wound"
hbDebuffBleed[8818]="Garrote"
hbDebuffBleed[10266]="Lung Puncture"
hbDebuffBleed[11977]="Rend"
hbDebuffBleed[12054]="Rend"
hbDebuffBleed[13318]="Rend"
hbDebuffBleed[13443]="Rend"
hbDebuffBleed[13445]="Rend"
hbDebuffBleed[13738]="Rend"
hbDebuffBleed[14087]="Rend"
hbDebuffBleed[14118]="Rend"
hbDebuffBleed[14331]="Vicious Rend"
hbDebuffBleed[14874]="Rupture"
hbDebuffBleed[14903]="Rupture"
hbDebuffBleed[15583]="Rupture"
hbDebuffBleed[15976]="Puncture"
hbDebuffBleed[16095]="Vicious Rend"
hbDebuffBleed[16393]="Rend"
hbDebuffBleed[16403]="Rend"
hbDebuffBleed[16406]="Rend"
hbDebuffBleed[16509]="Rend"
hbDebuffBleed[17153]="Rend"
hbDebuffBleed[17504]="Rend"
hbDebuffBleed[18075]="Rend"
hbDebuffBleed[18078]="Rend"
hbDebuffBleed[18106]="Rend"
hbDebuffBleed[18200]="Rend"
hbDebuffBleed[18202]="Rend"
hbDebuffBleed[19771]="Serrated Bite"
hbDebuffBleed[21949]="Rend"
hbDebuffBleed[24192]="Speed Slash"
hbDebuffBleed[24331]="Rake"
hbDebuffBleed[24332]="Rake"
hbDebuffBleed[27555]="Shred"
hbDebuffBleed[27556]="Rake"
hbDebuffBleed[27638]="Rake"
hbDebuffBleed[28913]="Flesh Rot"
hbDebuffBleed[29574]="Rend"
hbDebuffBleed[29578]="Rend"
hbDebuffBleed[29583]="Impale"
hbDebuffBleed[29906]="Ravage"
hbDebuffBleed[29935]="Gaping Maw"
hbDebuffBleed[30285]="Eagle Claw"
hbDebuffBleed[30639]="Carnivorous Bite"
hbDebuffBleed[31041]="Mangle"
hbDebuffBleed[31410]="Coral Cut"
hbDebuffBleed[31956]="Grievous Wound"
hbDebuffBleed[32019]="Gore"
hbDebuffBleed[32901]="Carnivorous Bite"
hbDebuffBleed[33865]="Singe"
hbDebuffBleed[33912]="Rip"
hbDebuffBleed[35144]="Vicious Rend"
hbDebuffBleed[35318]="Saw Blade"
hbDebuffBleed[35321]="Gushing Wound"
hbDebuffBleed[36023]="Deathblow"
hbDebuffBleed[36054]="Deathblow"
hbDebuffBleed[36332]="Rake"
hbDebuffBleed[36383]="Carnivorous Bite"
hbDebuffBleed[36590]="Rip"
hbDebuffBleed[36617]="Gaping Maw"
hbDebuffBleed[36789]="Diminish Soul"
hbDebuffBleed[36965]="Rend"
hbDebuffBleed[36991]="Rend"
hbDebuffBleed[37066]="Garrote"
hbDebuffBleed[37123]="Saw Blade"
hbDebuffBleed[37487]="Blood Heal"
hbDebuffBleed[37641]="Whirlwind"
hbDebuffBleed[37662]="Rend"
hbDebuffBleed[37937]="Flayed Flesh"
hbDebuffBleed[37973]="Coral Cut"
hbDebuffBleed[38056]="Flesh Rip"
hbDebuffBleed[38363]="Gushing Wound"
hbDebuffBleed[38772]="Grievous Wound"
hbDebuffBleed[38801]="Grievous Wound"
hbDebuffBleed[38810]="Gaping Maw"
hbDebuffBleed[38848]="Diminish Soul"
hbDebuffBleed[39198]="Carnivorous Bite"
hbDebuffBleed[39215]="Gushing Wound"
hbDebuffBleed[39382]="Carnivorous Bite"
hbDebuffBleed[40199]="Flesh Rip"
hbDebuffBleed[41092]="Carnivorous Bite"
hbDebuffBleed[41932]="Carnivorous Bite"
hbDebuffBleed[42395]="Lacerating Slash"
hbDebuffBleed[42397]="Rend Flesh"
hbDebuffBleed[42658]="Sic'em!"
hbDebuffBleed[43093]="Grievous Throw"
hbDebuffBleed[43104]="Deep Wound"
hbDebuffBleed[43153]="Lynx Rush"
hbDebuffBleed[43246]="Rend"
hbDebuffBleed[43931]="Rend"
hbDebuffBleed[43937]="Grievous Wound"
hbDebuffBleed[48130]="Gore"
hbDebuffBleed[48261]="Impale"
hbDebuffBleed[48286]="Grievous Slash"
hbDebuffBleed[48374]="Puncture Wound"
hbDebuffBleed[48880]="Rend"
hbDebuffBleed[48920]="Grievous Bite"
hbDebuffBleed[49678]="Flesh Rot"
hbDebuffBleed[50729]="Carnivorous Bite"
hbDebuffBleed[50871]="Savage Rend"
hbDebuffBleed[51275]="Gut Rip"
hbDebuffBleed[52401]="Gut Rip"
hbDebuffBleed[52504]="Lacerate"
hbDebuffBleed[52771]="Wounding Strike"
hbDebuffBleed[52873]="Open Wound"
hbDebuffBleed[53317]="Rend"
hbDebuffBleed[53499]="Rake"
hbDebuffBleed[53602]="Dart"
hbDebuffBleed[54668]="Rake"
hbDebuffBleed[54703]="Rend"
hbDebuffBleed[54708]="Rend"
hbDebuffBleed[55102]="Determined Gore"
hbDebuffBleed[55249]="Whirling Slash"
hbDebuffBleed[55250]="Whirling Slash"
hbDebuffBleed[55276]="Puncture"
hbDebuffBleed[55550]="Jagged Knife"
hbDebuffBleed[55604]="Death Plague"
hbDebuffBleed[55622]="Impale"
hbDebuffBleed[55645]="Death Plague"
hbDebuffBleed[57661]="Rip"
hbDebuffBleed[58459]="Impale"
hbDebuffBleed[58517]="Grievous Wound"
hbDebuffBleed[58830]="Wounding Strike"
hbDebuffBleed[58978]="Impale"
hbDebuffBleed[59007]="Flesh Rot"
hbDebuffBleed[59239]="Rend"
hbDebuffBleed[59256]="Impale"
hbDebuffBleed[59262]="Grievous Wound"
hbDebuffBleed[59264]="Gore"
hbDebuffBleed[59268]="Impale"
hbDebuffBleed[59269]="Carnivorous Bite"
hbDebuffBleed[59343]="Rend"
hbDebuffBleed[59349]="Dart"
hbDebuffBleed[59444]="Determined Gore"
hbDebuffBleed[59682]="Grievous Wound"
hbDebuffBleed[59691]="Rend"
hbDebuffBleed[59824]="Whirling Slash"
hbDebuffBleed[59825]="Whirling Slash"
hbDebuffBleed[59826]="Puncture"
hbDebuffBleed[59881]="Rake"
hbDebuffBleed[59989]="Rip"
hbDebuffBleed[61164]="Impale"
hbDebuffBleed[61896]="Lacerate"
hbDebuffBleed[62318]="Barbed Shot"
hbDebuffBleed[62331]="Impale"
hbDebuffBleed[62418]="Impale"
hbDebuffBleed[63468]="Careful Aim"
hbDebuffBleed[64374]="Savage Pounce"
hbDebuffBleed[64666]="Savage Pounce"
hbDebuffBleed[65033]="Constricting Rend"
hbDebuffBleed[65406]="Rake"
hbDebuffBleed[66620]="Old Wounds"
hbDebuffBleed[67280]="Dagger Throw"
hbDebuffBleed[69203]="Vicious Bite"
hbDebuffBleed[70278]="Puncture Wound"
hbDebuffBleed[71926]="Rip"
hbDebuffBleed[74846]="Bleeding Wound"
hbDebuffBleed[75160]="Bloody Rip"
hbDebuffBleed[75161]="Spinning Rake"
hbDebuffBleed[75388]="Rusty Cut"
hbDebuffBleed[75930]="Mangle"
hbDebuffBleed[76507]="Claw Puncture"
hbDebuffBleed[76524]="Grievous Whirl"
hbDebuffBleed[76594]="Rend"
hbDebuffBleed[76807]="Lacerate"
hbDebuffBleed[78842]="Carnivorous Bite"
hbDebuffBleed[78859]="Elementium Spike Shield"
hbDebuffBleed[79444]="Impale"
hbDebuffBleed[79828]="Mangle"
hbDebuffBleed[79829]="Rip"
hbDebuffBleed[80028]="Rock Bore"
hbDebuffBleed[80051]="Grievous Wound"
hbDebuffBleed[81043]="Razor Slice"
hbDebuffBleed[81087]="Puncture Wound"
hbDebuffBleed[81568]="Spinning Slash"
hbDebuffBleed[81569]="Spinning Slash"
hbDebuffBleed[81690]="Scent of Blood"
hbDebuffBleed[82753]="Ritual of Bloodletting"
hbDebuffBleed[82766]="Eye Gouge"
hbDebuffBleed[83783]="Impale"
hbDebuffBleed[84642]="Puncture"
hbDebuffBleed[85415]="Mangle"
hbDebuffBleed[87395]="Serrated Slash"
hbDebuffBleed[89212]="Eagle Claw"
hbDebuffBleed[90098]="Axe to the Head"
hbDebuffBleed[91348]="Tenderize"
hbDebuffBleed[93587]="Ritual of Bloodletting"
hbDebuffBleed[93675]="Mortal Wound"
hbDebuffBleed[95334]="Elementium Spike Shield"
hbDebuffBleed[96570]="Gaping Wound"
hbDebuffBleed[96592]="Ravage"
hbDebuffBleed[96700]="Ravage"
hbDebuffBleed[97357]="Gaping Wound"
hbDebuffBleed[98282]="Tiny Rend"
hbDebuffBleed[99100]="Mangle"
hbDebuffBleed[102066]="Flesh Rip"
hbDebuffBleed[102925]="Garrote"
hbDebuffBleed[112896]="Drain Blood"
hbDebuffBleed[113344]="Bloodbath"
hbDebuffBleed[113855]="Bleeding Wound"
hbDebuffBleed[114056]="Bloody Mess"
hbDebuffBleed[114860]="Rend"
hbDebuffBleed[114881]="Hawk Rend"
hbDebuffBleed[115767]="Deep Wounds"
hbDebuffBleed[115774]="Vicious Wound"
hbDebuffBleed[115871]="Rake"
hbDebuffBleed[118146]="Lacerate"
hbDebuffBleed[119840]="Serrated Blade"
hbDebuffBleed[120166]="Serrated Blade"
hbDebuffBleed[120560]="Rake"
hbDebuffBleed[120699]="Lynx Rush"
hbDebuffBleed[121247]="Impale"
hbDebuffBleed[121411]="Crimson Tempest"
hbDebuffBleed[122962]="Carnivorous Bite"
hbDebuffBleed[123422]="Arterial Bleeding"
hbDebuffBleed[123852]="Gored"
hbDebuffBleed[124015]="Gored"
hbDebuffBleed[124296]="Vicious Strikes"
hbDebuffBleed[124341]="Bloodletting"
hbDebuffBleed[124678]="Hacking Slash"
hbDebuffBleed[124800]="Pinch Limb"
hbDebuffBleed[125099]="Rake"
hbDebuffBleed[125206]="Rend Flesh"
hbDebuffBleed[125431]="Slice Bone"
hbDebuffBleed[125624]="Vicious Rend"
hbDebuffBleed[126901]="Mortal Rend"
hbDebuffBleed[126912]="Grievous Whirl"
hbDebuffBleed[127872]="Consume Flesh"
hbDebuffBleed[127987]="Bleeding Bite"
hbDebuffBleed[128051]="Serrated Slash"
hbDebuffBleed[128903]="Garrote"
hbDebuffBleed[129463]="Crane Kick"
hbDebuffBleed[129497]="Pounced"
hbDebuffBleed[129537]="Snap!"
hbDebuffBleed[130191]="Rake"
hbDebuffBleed[130306]="Ankle Bite"
hbDebuffBleed[130785]="My Eye!"
hbDebuffBleed[130897]="Vicious Bite"
hbDebuffBleed[131662]="Vicious Stabbing"
hbDebuffBleed[133074]="Puncture"
hbDebuffBleed[133081]="Rip"
hbDebuffBleed[134691]="Impale"
hbDebuffBleed[135528]="Bleeding Wound"
hbDebuffBleed[135892]="Razor Slice"
hbDebuffBleed[136654]="Rending Charge"
hbDebuffBleed[136753]="Slashing Talons"
hbDebuffBleed[137497]="Garrote"
hbDebuffBleed[138956]="Dark Bite"
hbDebuffBleed[139514]="Bloodstorm"
hbDebuffBleed[140274]="Vicious Wound"
hbDebuffBleed[140275]="Rend"
hbDebuffBleed[140276]="Rend"
hbDebuffBleed[140396]="Rend"
hbDebuffBleed[143198]="Garrote"
hbDebuffBleed[144113]="Chomp"
hbDebuffBleed[144263]="Rend"
hbDebuffBleed[144264]="Rend"
hbDebuffBleed[144304]="Rend"
hbDebuffBleed[144853]="Carnivorous Bite"
hbDebuffBleed[145263]="Chomp"
hbDebuffBleed[145417]="Rupture"
hbDebuffBleed[146556]="Pierce"
hbDebuffBleed[146927]="Rend"
hbDebuffBleed[147396]="Rake"
hbDebuffBleed[148033]="Grapple"
hbDebuffBleed[148375]="Brutal Hemorrhage"
hbDebuffBleed[150807]="Traumatic Strike"
hbDebuffBleed[151092]="Traumatic Strike"
hbDebuffBleed[151475]="Drain Life"
hbDebuffBleed[152357]="Rend"
hbDebuffBleed[152623]="Rend"
hbDebuffBleed[152724]="Lacerating Strike"
hbDebuffBleed[153897]="Rending Cleave"
hbDebuffBleed[154489]="Puncturing Horns"
hbDebuffBleed[154953]="Internal Bleeding"
hbDebuffBleed[154960]="Pinned Down"
hbDebuffBleed[155065]="Ripping Claw"
hbDebuffBleed[155701]="Serrated Slash"
hbDebuffBleed[155722]="Rake"
hbDebuffBleed[157344]="Vital Strike"
hbDebuffBleed[158150]="Goring Swipe"
hbDebuffBleed[158341]="Gushing Wounds"
hbDebuffBleed[158453]="Rending Swipe"
hbDebuffBleed[158667]="Warleader's Spear"
hbDebuffBleed[159238]="Shattered Bleed"
hbDebuffBleed[161117]="Puncturing Tusk"
hbDebuffBleed[161229]="Pounce"
hbDebuffBleed[161765]="Iron Axe"
hbDebuffBleed[162487]="Steel Trap"
hbDebuffBleed[162516]="Whirling Steel"
hbDebuffBleed[162921]="Peck"
hbDebuffBleed[162951]="Lacerating Spines"
hbDebuffBleed[163276]="Shredded Tendons"
hbDebuffBleed[164218]="Double Slash"
hbDebuffBleed[164323]="Precise Strike"
hbDebuffBleed[164427]="Ravage"
hbDebuffBleed[165308]="Gushing Wound"
hbDebuffBleed[166185]="Rending Slash"
hbDebuffBleed[166638]="Gushing Wound"
hbDebuffBleed[166639]="Item - Druid T17 Feral 4P Bonus Proc Driver"
hbDebuffBleed[166917]="Savage"
hbDebuffBleed[167334]="Windfang Bite"
hbDebuffBleed[167597]="Rending Nails"
hbDebuffBleed[167978]="Jagged Edge"
hbDebuffBleed[168097]="Shredder Bomb"
hbDebuffBleed[168392]="Fangs of the Predator"
hbDebuffBleed[169584]="Serrated Spines"
hbDebuffBleed[170367]="Vicious Throw"
hbDebuffBleed[170373]="Razor Teeth"
hbDebuffBleed[170936]="Talador Venom"
hbDebuffBleed[172019]="Stingtail Venom"
hbDebuffBleed[172035]="Thrash"
hbDebuffBleed[172139]="Lacerating Bite"
hbDebuffBleed[172361]="Puncturing Strike"
hbDebuffBleed[172366]="Jagged Slash"
hbDebuffBleed[172657]="Serrated Edge"
hbDebuffBleed[172889]="Charging Slash"
hbDebuffBleed[173113]="Hatchet Toss"
hbDebuffBleed[173278]="Spinal Shards"
hbDebuffBleed[173299]="Rip"
hbDebuffBleed[173307]="Serrated Spear"
hbDebuffBleed[173378]="Rending Bite"
hbDebuffBleed[173643]="Drill Fist"
hbDebuffBleed[173876]="Rending Claws"
hbDebuffBleed[174423]="Pinning Spines"
hbDebuffBleed[174734]="Axe to the Face!"
hbDebuffBleed[174820]="Rending Claws"
hbDebuffBleed[175014]="Rupture"
hbDebuffBleed[175151]="Thousand Fangs"
hbDebuffBleed[175156]="Painful Pinch"
hbDebuffBleed[175372]="Sharp Teeth"
hbDebuffBleed[175461]="Sadistic Slice"
hbDebuffBleed[175747]="Big Sharp Nasty Claws"
hbDebuffBleed[176147]="Ignite"
hbDebuffBleed[176256]="Talon Sweep"
hbDebuffBleed[176575]="Consume Flesh"
hbDebuffBleed[176695]="Bone Fragments"
hbDebuffBleed[177337]="Carnivorous Bite"
hbDebuffBleed[177422]="Thrash"
hbDebuffBleed[181346]="Lacerating Swipe"
hbDebuffBleed[181533]="Jagged Blade"
hbDebuffBleed[182325]="Phantasmal Wounds"
hbDebuffBleed[182330]="Coral Cut"
hbDebuffBleed[182347]="Impaling Coral"
hbDebuffBleed[182795]="Primal Mangle"
hbDebuffBleed[182846]="Thrash"
hbDebuffBleed[183025]="Rending Lash"
hbDebuffBleed[183952]="Shadow Claws"
hbDebuffBleed[184025]="Rending Claws"
hbDebuffBleed[184090]="Bloody Arc"
hbDebuffBleed[184175]="Primal Rake"
hbDebuffBleed[185539]="Rapid Rupture"
hbDebuffBleed[185698]="Bloody Hack"
hbDebuffBleed[185855]="Lacerate"
hbDebuffBleed[186191]="Bloodletting Slash"
hbDebuffBleed[186365]="Sweeping Blade"
hbDebuffBleed[186594]="Laceration"
hbDebuffBleed[186639]="Big Sharp Nasty Teeth"
hbDebuffBleed[186730]="Exposed Wounds"
hbDebuffBleed[187647]="Bloodletting Pounce"
hbDebuffBleed[188353]="Rip"
hbDebuffBleed[189035]="Barbed Cutlass"
hbDebuffBleed[191977]="Impaling Spear"
hbDebuffBleed[192090]="Thrash"
hbDebuffBleed[192131]="Throw Spear"
hbDebuffBleed[192925]="Blood of the Assassinated"
hbDebuffBleed[193092]="Bloodletting Sweep"
hbDebuffBleed[193340]="Fenri's Bite"
hbDebuffBleed[193585]="Bound"
hbDebuffBleed[193639]="Bone Chomp"
hbDebuffBleed[194279]="Caltrops"
hbDebuffBleed[194636]="Cursed Rend"
hbDebuffBleed[194639]="Rending Claws"
hbDebuffBleed[194674]="Barbed Spear"
hbDebuffBleed[195094]="Coral Slash"
hbDebuffBleed[195279]="Bind"
hbDebuffBleed[195506]="Razorsharp Axe"
hbDebuffBleed[196111]="Jagged Claws"
hbDebuffBleed[196189]="Bloody Talons"
hbDebuffBleed[196313]="Lacerating Talons"
hbDebuffBleed[196376]="Grievous Tear"
hbDebuffBleed[196497]="Ravenous Leap"
hbDebuffBleed[197359]="Shred"
hbDebuffBleed[197381]="Exposed Wounds"
hbDebuffBleed[199108]="Frantic Gore"
hbDebuffBleed[199146]="Bucking Charge"
hbDebuffBleed[199337]="Bear Trap"
hbDebuffBleed[199847]="Grievous Wound"
hbDebuffBleed[200182]="Festering Rip"
hbDebuffBleed[200620]="Frantic Rip"
hbDebuffBleed[204175]="Rend"
hbDebuffBleed[204179]="Rend Flesh"
hbDebuffBleed[204968]="Hemoraging Barbs"
hbDebuffBleed[205437]="Laceration"
hbDebuffBleed[207662]="Nightmare Wounds"
hbDebuffBleed[207690]="Bloodlet"
hbDebuffBleed[208470]="Necrotic Thrash"
hbDebuffBleed[208945]="Mangle"
hbDebuffBleed[208946]="Rip"
hbDebuffBleed[209336]="Mangle"
hbDebuffBleed[209378]="Whirling Blades"
hbDebuffBleed[209667]="Blade Surge"
hbDebuffBleed[209858]="Necrotic Wound"
hbDebuffBleed[210013]="Bloodletting Slash"
hbDebuffBleed[210177]="Spiked Shield"
hbDebuffBleed[210723]="Ashamane's Frenzy"
hbDebuffBleed[211672]="Mutilated Flesh"
hbDebuffBleed[211846]="Bloodletting Lunge"
hbDebuffBleed[213431]="Gnawing Eagle"
hbDebuffBleed[213537]="Bloody Pin"
hbDebuffBleed[213824]="Rending Pounce"
hbDebuffBleed[213933]="Harpoon Swipe"
hbDebuffBleed[213990]="Shard Bore"
hbDebuffBleed[214676]="Razorsharp Teeth"
hbDebuffBleed[215442]="Shred"
hbDebuffBleed[215506]="Jagged Quills"
hbDebuffBleed[215537]="Trauma"
hbDebuffBleed[215721]="Gut Slash"
hbDebuffBleed[217023]="Antler Gore"
hbDebuffBleed[217041]="Shred"
hbDebuffBleed[217091]="Puncturing Stab"
hbDebuffBleed[217142]="Mangle"
hbDebuffBleed[217163]="Rend"
hbDebuffBleed[217200]="Barbed Shot"
hbDebuffBleed[217235]="Rending Whirl"
hbDebuffBleed[217363]="Ashamane's Frenzy"
hbDebuffBleed[217369]="Rake"
hbDebuffBleed[217868]="Impale"
hbDebuffBleed[218506]="Jagged Slash"
hbDebuffBleed[219167]="Chomp"
hbDebuffBleed[219240]="Bloody Ricochet"
hbDebuffBleed[219339]="Thrash"
hbDebuffBleed[219680]="Impale"
hbDebuffBleed[220222]="Rending Snap"
hbDebuffBleed[220874]="Lacerate"
hbDebuffBleed[221352]="Cut the Flank"
hbDebuffBleed[221422]="Vicious Bite"
hbDebuffBleed[221759]="Feathery Stab"
hbDebuffBleed[221770]="Rend Flesh"
hbDebuffBleed[222491]="Gutripper"
hbDebuffBleed[223111]="Rake"
hbDebuffBleed[223572]="Rend"
hbDebuffBleed[223954]="Rake"
hbDebuffBleed[223967]="Tear Flesh"
hbDebuffBleed[224435]="Ashamane's Rip"
hbDebuffBleed[225484]="Grievous Rip"
hbDebuffBleed[225963]="Bloodthirsty Leap"
hbDebuffBleed[227742]="Garrote"
hbDebuffBleed[228275]="Rend"
hbDebuffBleed[228281]="Rend"
hbDebuffBleed[228305]="Unyielding Rend"
hbDebuffBleed[229127]="Powershot"
hbDebuffBleed[229265]="Garrote"
hbDebuffBleed[229923]="Talon Rend"
hbDebuffBleed[230011]="Cruel Garrote"
hbDebuffBleed[231003]="Barbed Talons"
hbDebuffBleed[231998]="Jagged Abrasion"
hbDebuffBleed[232135]="Bloody Jab"
hbDebuffBleed[235832]="Bloodletting Strike"
hbDebuffBleed[237346]="Rend"
hbDebuffBleed[238594]="Ripper Blade"
hbDebuffBleed[238618]="Fel Swipe"
hbDebuffBleed[240449]="Grievous Wound"
hbDebuffBleed[240539]="Wild Bite"
hbDebuffBleed[240559]="Grievous Wound"
hbDebuffBleed[241070]="Bloodletting Strike"
hbDebuffBleed[241092]="Rend"
hbDebuffBleed[241212]="Fel Slash"
hbDebuffBleed[241465]="Coral Cut"
hbDebuffBleed[241644]="Mangle"
hbDebuffBleed[242376]="Puncturing Strike"
hbDebuffBleed[242828]="Dire Thrash"
hbDebuffBleed[242931]="Rake"
hbDebuffBleed[244040]="Eskhandar's Rake"
hbDebuffBleed[246904]="Smoldering Rend"
hbDebuffBleed[247932]="Shrapnel Blast"
hbDebuffBleed[247949]="Shrapnel Blast"
hbDebuffBleed[250393]="Rake"
hbDebuffBleed[251332]="Rip"
hbDebuffBleed[253384]="Slaughter"
hbDebuffBleed[253516]="Hexabite"
hbDebuffBleed[253610]="Ripper Blade"
hbDebuffBleed[254280]="Jagged Maw"
hbDebuffBleed[254575]="Rend"
hbDebuffBleed[254901]="Blood Frenzy"
hbDebuffBleed[255299]="Bloodletting"
hbDebuffBleed[255595]="Chomp"
hbDebuffBleed[255814]="Rending Maul"
hbDebuffBleed[256077]="Gore"
hbDebuffBleed[256314]="Barbed Strike"
hbDebuffBleed[256363]="Ripper Punch"
hbDebuffBleed[256476]="Rending Whirl"
hbDebuffBleed[256715]="Jagged Maw"
hbDebuffBleed[256880]="Bone Splinter"
hbDebuffBleed[256914]="Barbed Blade"
hbDebuffBleed[256965]="Thorned Barrage"
hbDebuffBleed[257036]="Feral Charge"
hbDebuffBleed[257170]="Savage Tempest"
hbDebuffBleed[257250]="Bramblepelt"
hbDebuffBleed[257544]="Jagged Cut"
hbDebuffBleed[257790]="Gutripper"
hbDebuffBleed[257971]="Leaping Thrash"
hbDebuffBleed[258058]="Squeeze"
hbDebuffBleed[258075]="Itchy Bite"
hbDebuffBleed[258143]="Rending Claws"
hbDebuffBleed[258718]="Scratched!"
hbDebuffBleed[258798]="Razorsharp Teeth"
hbDebuffBleed[258825]="Vampiric Bite"
hbDebuffBleed[259220]="Barbed Net"
hbDebuffBleed[259277]="Kill Command"
hbDebuffBleed[259328]="Gory Whirl"
hbDebuffBleed[259382]="Shell Slash"
hbDebuffBleed[259739]="Stone Claws"
hbDebuffBleed[259873]="Rip"
hbDebuffBleed[259983]="Pierce"
hbDebuffBleed[260016]="Itchy Bite"
hbDebuffBleed[260025]="Rending Whirl"
hbDebuffBleed[260400]="Rend"
hbDebuffBleed[260455]="Serrated Fangs"
hbDebuffBleed[260563]="Gnaw"
hbDebuffBleed[260582]="Gushing Wound"
hbDebuffBleed[260741]="Jagged Nettles"
hbDebuffBleed[261882]="Steel Jaw Trap"
hbDebuffBleed[262115]="Deep Wounds"
hbDebuffBleed[262143]="Ravenous Claws"
hbDebuffBleed[262557]="Rake"
hbDebuffBleed[262677]="Keelhaul"
hbDebuffBleed[262875]="Papercut"
hbDebuffBleed[263144]="Talon Slash"
hbDebuffBleed[264145]="Shatter"
hbDebuffBleed[264150]="Shatter"
hbDebuffBleed[264210]="Jagged Mandible"
hbDebuffBleed[264556]="Tearing Strike"
hbDebuffBleed[265019]="Savage Cleave"
hbDebuffBleed[265074]="Rend"
hbDebuffBleed[265165]="Charging Gore"
hbDebuffBleed[265232]="Rend"
hbDebuffBleed[265377]="Hooked Snare"
hbDebuffBleed[265533]="Blood Maw"
hbDebuffBleed[265948]="Denticulated"
hbDebuffBleed[266035]="Bone Splinter"
hbDebuffBleed[266191]="Whirling Axe"
hbDebuffBleed[266231]="Severing Axe"
hbDebuffBleed[266505]="Rending Claw"
hbDebuffBleed[267064]="Bleeding"
hbDebuffBleed[267080]="Blight of G'huun"
hbDebuffBleed[267103]="Blight of G'huun"
hbDebuffBleed[267441]="Serrated Axe"
hbDebuffBleed[267523]="Cutting Surge"
hbDebuffBleed[269576]="Master Marksman"
hbDebuffBleed[270084]="Axe Barrage"
hbDebuffBleed[270139]="Gore"
hbDebuffBleed[270343]="Internal Bleeding"
hbDebuffBleed[270473]="Serrated Arrows"
hbDebuffBleed[270487]="Severing Blade"
hbDebuffBleed[270979]="Rend and Tear"
hbDebuffBleed[271178]="Ravaging Leap"
hbDebuffBleed[271798]="Click"
hbDebuffBleed[272273]="Rending Cleave"
hbDebuffBleed[273436]="Gore"
hbDebuffBleed[273632]="Gaping Maw"
hbDebuffBleed[273794]="Rezan's Fury"
hbDebuffBleed[273900]="Bramble Swipe"
hbDebuffBleed[273909]="Steelclaw Trap"
hbDebuffBleed[274089]="Rend"
hbDebuffBleed[274389]="Rat Traps"
hbDebuffBleed[274838]="Feral Frenzy"
hbDebuffBleed[275895]="Rend of Kimbul"
hbDebuffBleed[276868]="Impale"
hbDebuffBleed[277077]="Big Sharp Nasty Teeth"
hbDebuffBleed[277309]="Jagged Maw"
hbDebuffBleed[277431]="Hunter Toxin"
hbDebuffBleed[277517]="Serrated Slash"
hbDebuffBleed[277569]="Bloodthirsty Rend"
hbDebuffBleed[277592]="Blood Frenzy"
hbDebuffBleed[277794]="Paw Swipe"
hbDebuffBleed[278175]="Bramble Claw"
hbDebuffBleed[278570]="Boils and Sores"
hbDebuffBleed[278733]="Deep Wound"
hbDebuffBleed[278866]="Carve and Spit"
hbDebuffBleed[279133]="Rend"
hbDebuffBleed[280286]="Dagger in the Back"
hbDebuffBleed[280321]="Garrote"
hbDebuffBleed[280940]="Mangle"
hbDebuffBleed[281711]="Cut of Death"
hbDebuffBleed[282444]="Lacerating Claws"
hbDebuffBleed[282845]="Bear Trap"
hbDebuffBleed[283419]="Rend"
hbDebuffBleed[283667]="Rupture"
hbDebuffBleed[283668]="Crimson Tempest"
hbDebuffBleed[283700]="Rake"
hbDebuffBleed[283708]="Rip"
hbDebuffBleed[284158]="Circular Saw"
hbDebuffBleed[285875]="Rending Bite"
hbDebuffBleed[286269]="Mangle"
hbDebuffBleed[288091]="Gushing Wound"
hbDebuffBleed[288266]="Mangle"
hbDebuffBleed[288535]="Rip"
hbDebuffBleed[288539]="Mangle"
hbDebuffBleed[289355]="Smoldering Rend"
hbDebuffBleed[289373]="Lacerating Pounce"
hbDebuffBleed[289848]="Rending Claw"
hbDebuffBleed[292348]="Bloodletting"
hbDebuffBleed[292611]="Rake"
hbDebuffBleed[292626]="Rip"
hbDebuffBleed[293670]="Chainblade"
hbDebuffBleed[294617]="Rupture"
hbDebuffBleed[294741]="Saber Slash"
hbDebuffBleed[294901]="Serrated Blades"
hbDebuffBleed[295008]="Bloody Cleaver"
hbDebuffBleed[295929]="Rats!"
hbDebuffBleed[295945]="Rat Traps"
hbDebuffBleed[296777]="Bleeding Wound"
hbDebuffBleed[299474]="Ripping Slash"
hbDebuffBleed[299502]="Nanoslicer"
hbDebuffBleed[299923]="Tear Flesh"
hbDebuffBleed[300610]="Fanged Bite"
hbDebuffBleed[301061]="Thrash"
hbDebuffBleed[301712]="Pounce"
hbDebuffBleed[302295]="Slicing Claw"
hbDebuffBleed[302474]="Phantom Laceration"
hbDebuffBleed[303162]="Carve Flesh"
hbDebuffBleed[303215]="Shell Slash"
hbDebuffBleed[303501]="Rending Strike"
hbDebuffBleed[308342]="Bore"
hbDebuffBleed[308859]="Carnivorous Bite"
hbDebuffBleed[308891]="Jagged Chop"
hbDebuffBleed[308938]="Lacerating Swipe"
hbDebuffBleed[309760]="Raking Claws"
hbDebuffBleed[311122]="Jagged Wound"
hbDebuffBleed[311744]="Deep Wound"
hbDebuffBleed[311748]="Lacerating Swipe"
hbDebuffBleed[313674]="Jagged Wound"
hbDebuffBleed[313734]="Ravaging Leap"
hbDebuffBleed[313747]="Rend"
hbDebuffBleed[313957]="Rend"
hbDebuffBleed[314130]="Skewer"
hbDebuffBleed[314160]="Penetrating Lance"
hbDebuffBleed[314454]="Thrashing Lunge"
hbDebuffBleed[314531]="Tear Flesh"
hbDebuffBleed[314533]="Rend"
hbDebuffBleed[314568]="Deep Wound"
hbDebuffBleed[314847]="Decapitate"
hbDebuffBleed[315311]="Ravage"
hbDebuffBleed[315711]="Serrated Strike"
hbDebuffBleed[315805]="Crippler"
hbDebuffBleed[316511]="Scratch"
hbDebuffBleed[317561]="Swooping Lunge"
hbDebuffBleed[317908]="Razor Wing"
hbDebuffBleed[317916]="Razor Clip"
hbDebuffBleed[318187]="Gushing Wound"
hbDebuffBleed[319127]="Gore"
hbDebuffBleed[319275]="Razor Wing"
hbDebuffBleed[320007]="Gash"
hbDebuffBleed[320147]="Bleeding"
hbDebuffBleed[320200]="Stitchneedle"
hbDebuffBleed[321538]="Bloodshed"
hbDebuffBleed[321807]="Boneflay"
hbDebuffBleed[322429]="Severing Slice"
hbDebuffBleed[322796]="Wicked Gash"
hbDebuffBleed[322965]="Tearing Bite"
hbDebuffBleed[323043]="Bloodletting"
hbDebuffBleed[323406]="Jagged Gash"
hbDebuffBleed[324073]="Serrated Bone Spike"
hbDebuffBleed[324149]="Flayed Shot"
hbDebuffBleed[324154]="Dark Stride"
hbDebuffBleed[324447]="Slashing Rend"
hbDebuffBleed[325021]="Mistveil Tear"
hbDebuffBleed[325022]="Jagged Swipe"
hbDebuffBleed[325037]="Death Chakram"
hbDebuffBleed[326298]="Bleeding Wound"
hbDebuffBleed[326586]="Crimson Flurry"
hbDebuffBleed[327258]="Rend"
hbDebuffBleed[327814]="Wicked Gash"
hbDebuffBleed[328287]="Heart Strike"
hbDebuffBleed[328897]="Exsanguinated"
hbDebuffBleed[328910]="Tantrum"
hbDebuffBleed[328940]="Gore"
hbDebuffBleed[329293]="Vorpal Wound"
hbDebuffBleed[329516]="Swift Slash"
hbDebuffBleed[329563]="Goring Swipe"
hbDebuffBleed[329906]="Carnage"
hbDebuffBleed[329986]="Maul"
hbDebuffBleed[329990]="Craggy Swipe"
hbDebuffBleed[330400]="Bleeding Swipe"
hbDebuffBleed[330457]="Ripping Strike"
hbDebuffBleed[330532]="Jagged Quarrel"
hbDebuffBleed[330632]="Maul"
hbDebuffBleed[331045]="Talon Rake"
hbDebuffBleed[331066]="Bursting Plumage"
hbDebuffBleed[331072]="Talon Rake"
hbDebuffBleed[331340]="Plague Swipe"
hbDebuffBleed[331415]="Wicked Gash"
hbDebuffBleed[332168]="Maul"
hbDebuffBleed[332610]="Penetrating Insight"
hbDebuffBleed[332678]="Gushing Wound"
hbDebuffBleed[332792]="Gore"
hbDebuffBleed[332835]="Ruthless Strikes"
hbDebuffBleed[332836]="Chop"
hbDebuffBleed[333235]="Horn Rush"
hbDebuffBleed[333250]="Reaver"
hbDebuffBleed[333478]="Gut Slice"
hbDebuffBleed[333861]="Ricocheting Blade"
hbDebuffBleed[333985]="Culling Strike"
hbDebuffBleed[334669]="Tirnenn Wrath"
hbDebuffBleed[334960]="Vicious Wound"
hbDebuffBleed[334971]="Jagged Claws"
hbDebuffBleed[335105]="Dinner Time"
hbDebuffBleed[336628]="Eternal Polearm"
hbDebuffBleed[336810]="Ragged Claws"
hbDebuffBleed[337349]="Triple Thrash"
hbDebuffBleed[337729]="Kerim's Laceration"
hbDebuffBleed[337892]="Gore"
hbDebuffBleed[338935]="Razor Petals"
hbDebuffBleed[339163]="Wicked Gash"
hbDebuffBleed[339189]="Chain Bleed"
hbDebuffBleed[339453]="Darksworn Blast"
hbDebuffBleed[339789]="Darksworn Blast"
hbDebuffBleed[339975]="Grievous Strike"
hbDebuffBleed[340058]="Heart Piercer"
hbDebuffBleed[340374]="Bloody Tantrum"
hbDebuffBleed[340431]="Mutilated Flesh"
hbDebuffBleed[341435]="Lunge"
hbDebuffBleed[341475]="Crimson Flurry"
hbDebuffBleed[341833]="Rending Cleave"
hbDebuffBleed[341863]="Bleeding Out"
hbDebuffBleed[342250]="Jagged Swipe"
hbDebuffBleed[342464]="Javelin Flurry"
hbDebuffBleed[342675]="Bone Spear"
hbDebuffBleed[343159]="Stone Claws"
hbDebuffBleed[343722]="Crushing Bite"
hbDebuffBleed[344312]="Serrated Edge"
hbDebuffBleed[344464]="Shield Spike"
hbDebuffBleed[344993]="Jagged Swipe"
hbDebuffBleed[345548]="Spare Meat Hook"
hbDebuffBleed[346770]="Grinding Bite"
hbDebuffBleed[346807]="Rending Roar"
hbDebuffBleed[347716]="Letter Opener"
hbDebuffBleed[347807]="Barbed Arrow"
hbDebuffBleed[348074]="Assailing Lance"
hbDebuffBleed[348385]="Bloody Cleave"
hbDebuffBleed[348726]="Lethal Shot"
hbDebuffBleed[351119]="Shuriken Blitz"
hbDebuffBleed[351976]="Shredder"
hbDebuffBleed[353068]="Razor Trap"
hbDebuffBleed[353466]="Sadistic Glee"
hbDebuffBleed[353919]="Rury's Sleepy Tantrum"
hbDebuffBleed[354334]="Hook'd!"
hbDebuffBleed[355087]="Piercing Quill"
hbDebuffBleed[355256]="Rending Roar"
hbDebuffBleed[355416]="Sharpened Hide"
hbDebuffBleed[355832]="Quickblade"
hbDebuffBleed[356445]="Sharpened Hide"
hbDebuffBleed[356620]="Pouch of Razor Fragments"
hbDebuffBleed[356808]="Spiked"
hbDebuffBleed[356923]="Sever"
hbDebuffBleed[356925]="Carnage"
hbDebuffBleed[357091]="Cleave Flesh"
hbDebuffBleed[357192]="Dark Flurry"
hbDebuffBleed[357239]="Cleave Flesh"
hbDebuffBleed[357322]="Night Glaive"
hbDebuffBleed[357665]="Crystalline Flesh"
hbDebuffBleed[357827]="Frantic Rip"
hbDebuffBleed[357953]="Fanged Bite"
hbDebuffBleed[358197]="Searing Scythe"
hbDebuffBleed[358224]="Jagged Swipe"
hbDebuffBleed[359587]="Bloody Peck"
hbDebuffBleed[359981]="Rend"
hbDebuffBleed[360194]="Deathmark"
hbDebuffBleed[360775]="Puncture"
hbDebuffBleed[360826]="Rupture"
hbDebuffBleed[360830]="Garrote"
hbDebuffBleed[361024]="Thief's Blade"
hbDebuffBleed[361049]="Bleeding Gash"
hbDebuffBleed[361756]="Death Chakram"
hbDebuffBleed[362149]="Ascended Phalanx"
hbDebuffBleed[362194]="Suffering"
hbDebuffBleed[362819]="Rend"
hbDebuffBleed[363830]="Sickle of the Lion"
hbDebuffBleed[363831]="Bleeding Soul"
hbDebuffBleed[365336]="Rending Bite"
hbDebuffBleed[365877]="Jagged Blade"
hbDebuffBleed[366075]="Bloody Peck"
hbDebuffBleed[366275]="Rending Bite"
hbDebuffBleed[366884]="Ripped Secrets"
hbDebuffBleed[367481]="Bloody Bite"
hbDebuffBleed[367521]="Bone Bolt"
hbDebuffBleed[367726]="Lupine's Slash"
hbDebuffBleed[368401]="Puncture"
hbDebuffBleed[368637]="The Third Rune"
hbDebuffBleed[368651]="Vicious Wound"
hbDebuffBleed[368701]="Boon of Harvested Hope"
hbDebuffBleed[369408]="Rending Slash"
hbDebuffBleed[369828]="Chomp"
hbDebuffBleed[370742]="Jagged Strike"
hbDebuffBleed[371472]="Rake"
hbDebuffBleed[372224]="Dragonbone Axe"
hbDebuffBleed[372397]="Vicious Bite"
hbDebuffBleed[372570]="Bold Ambush"
hbDebuffBleed[372718]="Earthen Shards"
hbDebuffBleed[372796]="Blazing Rush"
hbDebuffBleed[372860]="Searing Wounds"
hbDebuffBleed[373735]="Dragon Strike"
hbDebuffBleed[373947]="Rending Swipe"
hbDebuffBleed[375201]="Talon Rip"
hbDebuffBleed[375416]="Bleeding"
hbDebuffBleed[375475]="Rending Bite"
hbDebuffBleed[375803]="Mammoth Trap"
hbDebuffBleed[375893]="Death Chakram"
hbDebuffBleed[375937]="Rending Strike"
hbDebuffBleed[376997]="Savage Peck"
hbDebuffBleed[376999]="Thrash"
hbDebuffBleed[377002]="Thrash"
hbDebuffBleed[377344]="Peck"
hbDebuffBleed[377609]="Dragon Rend"
hbDebuffBleed[377732]="Jagged Bite"
hbDebuffBleed[378020]="Gash Frenzy"
hbDebuffBleed[381575]="Lacerate"
hbDebuffBleed[381628]="Internal Bleeding"
hbDebuffBleed[381672]="Mutilated Flesh"
hbDebuffBleed[381692]="Swift Stab"
hbDebuffBleed[384134]="Pierce"
hbDebuffBleed[384148]="Ensnaring Trap"
hbDebuffBleed[384575]="Crippling Bite"
hbDebuffBleed[385042]="Gushing Wound"
hbDebuffBleed[385060]="Odyn's Fury"
hbDebuffBleed[385511]="Messy"
hbDebuffBleed[385638]="Razor Fragments"
hbDebuffBleed[385834]="Bloodthirsty Charge"
hbDebuffBleed[385905]="Tailstrike"
hbDebuffBleed[386116]="Messy"
hbDebuffBleed[386640]="Tear Flesh"
hbDebuffBleed[387205]="Beak Rend"
hbDebuffBleed[387473]="Big Sharp Teeth"
hbDebuffBleed[387809]="Splatter!"
hbDebuffBleed[388301]="Savage Tear"
hbDebuffBleed[388377]="Rending Slash"
hbDebuffBleed[388473]="Feeding Frenzy"
hbDebuffBleed[388539]="Rend"
hbDebuffBleed[388912]="Severing Slash"
hbDebuffBleed[389505]="Rending Slice"
hbDebuffBleed[389881]="Spearhead"
hbDebuffBleed[390194]="Rending Slash"
hbDebuffBleed[390583]="Logcutter"
hbDebuffBleed[390834]="Primal Rend"
hbDebuffBleed[391098]="Puncturing Impalement"
hbDebuffBleed[391114]="Cutting Winds"
hbDebuffBleed[391140]="Frenzied Assault"
hbDebuffBleed[391308]="Rending Swoop"
hbDebuffBleed[391356]="Tear"
hbDebuffBleed[391725]="Swooping Dive"
hbDebuffBleed[392006]="Vicious Chomp"
hbDebuffBleed[392235]="Furious Charge"
hbDebuffBleed[392236]="Furious Charge"
hbDebuffBleed[392332]="Horn Gore"
hbDebuffBleed[392341]="Mighty Swipe"
hbDebuffBleed[392411]="Beetle Thrust"
hbDebuffBleed[392416]="Beetle Charge"
hbDebuffBleed[392841]="Hungry Chomp"
hbDebuffBleed[393426]="Spear Swipe"
hbDebuffBleed[393444]="Gushing Wound"
hbDebuffBleed[393718]="Heartpiercer"
hbDebuffBleed[393817]="Hardened Shards"
hbDebuffBleed[393820]="Horn Swing"
hbDebuffBleed[394021]="Mutilated Flesh"
hbDebuffBleed[394036]="Serrated Bone Spike"
hbDebuffBleed[394063]="Rend"
hbDebuffBleed[394371]="Hit the Mark"
hbDebuffBleed[394628]="Peck"
hbDebuffBleed[394647]="Merciless Gore"
hbDebuffBleed[395827]="Severing Gore"
hbDebuffBleed[395832]="Jagged Cuts"
hbDebuffBleed[396007]="Vicious Peck"
hbDebuffBleed[396093]="Savage Leap"
hbDebuffBleed[396348]="Dismember"
hbDebuffBleed[396353]="Fatal Chomp"
hbDebuffBleed[396476]="Rending Claw"
hbDebuffBleed[396639]="Bloody Pounce"
hbDebuffBleed[396641]="Rending Slash"
hbDebuffBleed[396674]="Rupturing Slash"
hbDebuffBleed[396675]="Hemorrhaging Rend"
hbDebuffBleed[396716]="Splinterbark"
hbDebuffBleed[396807]="Savage Gore"
hbDebuffBleed[397037]="Slicing Winds"
hbDebuffBleed[397092]="Impaling Horn"
hbDebuffBleed[397112]="Primal Devastation"
hbDebuffBleed[397364]="Thunderous Roar"
hbDebuffBleed[398392]="Stomp"
hbDebuffBleed[398497]="Rock Needle"
hbDebuffBleed[400050]="Claw Rip"
hbDebuffBleed[400344]="Spike Traps"
hbDebuffBleed[400941]="Ragged Slash"
hbDebuffBleed[401370]="Deep Claws"
hbDebuffBleed[403589]="Gushing Wound"
hbDebuffBleed[403662]="Garrote"
hbDebuffBleed[403790]="Vicious Swipe"
hbDebuffBleed[404907]="Rupturing Slash"
hbDebuffBleed[404945]="Raking Slice"
hbDebuffBleed[404978]="Devastating Rend"
hbDebuffBleed[405233]="Thrash"
hbDebuffBleed[406183]="Time Slash"
hbDebuffBleed[406365]="Rending Charge"
hbDebuffBleed[406499]="Ravening Leaps"
hbDebuffBleed[407120]="Serrated Axe"
hbDebuffBleed[407313]="Shrapnel"
hbDebuffBleed[411101]="Artifact Shards"
hbDebuffBleed[411437]="Brutal Lacerations"
hbDebuffBleed[411700]="Slobbering Bite"
hbDebuffBleed[411924]="Drilljaws"
hbDebuffBleed[412285]="Stonebolt"
hbDebuffBleed[412505]="Rending Cleave"
hbDebuffBleed[413131]="Whirling Dagger"
hbDebuffBleed[413136]="Whirling Dagger"
hbDebuffBleed[414466]="Jagged Gills"
hbDebuffBleed[414552]="Stonecrack"
hbDebuffBleed[416258]="Stonebolt"
hbDebuffBleed[418009]="Serrated Arrows"
hbDebuffBleed[418160]="Sawblade-Storm"
hbDebuffBleed[418624]="Rending Slash"

function HealBot_Aura_setLuVars(vName, vValue)
    --HealBot_setCall("HealBot_Aura_setLuVars - "..vName)
    HealBot_Aura_luVars[vName]=vValue
end

function HealBot_Aura_retLuVars(vName)
    --HealBot_setCall("HealBot_retLuVars"..vName)
    return HealBot_Aura_luVars[vName]
end

function HealBot_Aura_UpdateCheckInterval()
    HealBot_Aura_luVars["AuraUpdate"]=HealBot_Util_PerfVal4(98)
    if HealBot_Aura_luVars["AuraUpdate"]<0.9 then 
        HealBot_Aura_luVars["AuraUpdate"]=0.9 
    elseif HealBot_Aura_luVars["AuraUpdate"]>1 then 
        HealBot_Aura_luVars["AuraUpdate"]=0.99
    end
    HealBot_Debug_PerfUpdate("AuraUpdate", HealBot_Aura_luVars["AuraUpdate"])
end

function HealBot_Aura_setAuxAssigns(vName, frame, vValue)
        --HealBot_setCall("HealBot_Aura_setAuxAssigns")
    HealBot_Aura_AuxAssigns[vName][frame]=vValue
end

function HealBot_Aura_retRaidtargetIcon(id)
        --HealBot_setCall("HealBot_Aura_retRaidtargetIcon")
    return HealBot_TargetIconsTextures[id]
end

function HealBot_Aura_ResetBuffCache()
        --HealBot_setCall("HealBot_Aura_ResetBuffCache")
    for spellId,_ in pairs(HealBot_AuraBuffCache) do
        HealBot_AuraBuffCache[spellId].always=false
        HealBot_AuraBuffCache[spellId].isAuto=false
        HealBot_AuraBuffCache[spellId].reset=true
    end
    HealBot_Timers_Set("AURA","CustomBuffFilterDisabled")
end

function HealBot_Aura_ResetDebuffCache()
        --HealBot_setCall("HealBot_Aura_ResetDebuffCache")
    for spellId,_ in pairs(HealBot_AuraDebuffCache) do
        HealBot_AuraDebuffCache[spellId].always=false
        HealBot_AuraDebuffCache[spellId].isAuto=false
        HealBot_AuraDebuffCache[spellId].reset=true
    end
    HealBot_Timers_Set("AURA","CustomDebuffFilterDisabled")
    HealBot_Timers_Set("AURA","CheckDebuffs")
end

function HealBot_Aura_DeleteExcludeBuffInCache()
        --HealBot_setCall("HealBot_Aura_DeleteExcludeBuffInCache")
    for id,_ in pairs(HealBot_ExcludeBuffInCache) do
        HealBot_ExcludeBuffInCache[id]=nil
    end
    HealBot_setLuVars("UpdateAllAura", 5)
    HealBot_Aura_luVars["updateAll"]=true
    HealBot_Timers_Set("AURA","CheckBuffs")
end

function HealBot_Aura_RemoveIcon(button, index)
      --HealBot_setCall("HealBot_Aura_RemoveIcon", button)
    if not button then return; end;
    button.gref.icon[index]:SetAlpha(0)
    if index<90 then
        button.gref.txt.expire[index]:SetTextColor(1,1,1,0);
        button.gref.txt.count[index]:SetTextColor(1,1,1,0)
        button.gref.txt.expire[index]:SetText(" ");
        button.gref.txt.count[index]:SetText(" ");
        if index<50 then
            if HealBot_UnitBuffIcons[button.id] then
                HealBot_UnitBuffIcons[button.id][index].current=false
            end
            button.gref.indicator.selfcast[index]:SetAlpha(0)
            if button.glow.icon[index]>1 then
                HealBot_Action_DisableIconGlow(button, "ICONBUFF", index)
            end
        else
            if HealBot_UnitDebuffIcons[button.id] then
                HealBot_UnitDebuffIcons[button.id][index].current=false
            end
            if button.glow.icon[index]>1 then
                HealBot_Action_DisableIconGlow(button, "ICONDEBUFF", index)
            end
        end
        button.gref.iconf[index]:SetFrameLevel(0)
    else
        if HealBot_UnitExtraIcons[button.id] then
            HealBot_UnitExtraIcons[button.id][index].current=false
        end
        if index == 91 then
            button.icon.extra.classtexture=false
        elseif index == 92 then
            button.icon.extra.targeticon=0
        elseif index == 93 then
            button.icon.extra.readycheck=false
        end
    end
end

function HealBot_Aura_RemoveBuffIcons(button)
        --HealBot_setCall("HealBot_Aura_RemoveBuffIcons", button)
    if button.frame>0 then
        for i=1,button.icon.buff.count[1] do
            HealBot_Aura_RemoveIcon(button, i)
        end
        for i=9,8+button.icon.buff.count[2] do
            HealBot_Aura_RemoveIcon(button, i)
        end
        for i=11,10+button.icon.buff.count[3] do
            HealBot_Aura_RemoveIcon(button, i)
        end
        HealBot_Aura_ClearBuff(button)
    end
end

function HealBot_Aura_RemoveUnusedBuffIconsButton(button)
    if Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][button.frame][1]["MAXBICONS"]<8 then
        for i=Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][button.frame][1]["MAXBICONS"]+1,8 do
            HealBot_Aura_RemoveIcon(button, i)
        end
    end
    if Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][button.frame][2]["MAXBICONS"]<2 then
        for i=Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][button.frame][2]["MAXBICONS"]+9,10 do
            HealBot_Aura_RemoveIcon(button, i)
        end
    end
    if Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][button.frame][3]["MAXBICONS"]<2 then
        for i=Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][button.frame][3]["MAXBICONS"]+11,12 do
            HealBot_Aura_RemoveIcon(button, i)
        end
    end
end

function HealBot_Aura_RemoveDebuffIcons(button)
        --HealBot_setCall("HealBot_Aura_RemoveDebuffIcons", button)
    if button.frame>0 then
        for i=51,50+button.icon.debuff.count[1] do
            HealBot_Aura_RemoveIcon(button, i)
        end
        for i=57,56+button.icon.debuff.count[2] do
            HealBot_Aura_RemoveIcon(button, i)
        end
        for i=59,58+button.icon.debuff.count[3] do
            HealBot_Aura_RemoveIcon(button, i)
        end
        HealBot_Aura_ClearDebuff(button)
    end
end

function HealBot_Aura_RemoveUnusedDebuffIconsButton(button)
    if Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][button.frame][1]["MAXDICONS"]<6 then
        for i=Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][button.frame][1]["MAXDICONS"]+51,56 do
            HealBot_Aura_RemoveIcon(button, i)
        end
    end
    if Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][button.frame][2]["MAXDICONS"]<2 then
        for i=Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][button.frame][2]["MAXDICONS"]+57,58 do
            HealBot_Aura_RemoveIcon(button, i)
        end
    end
    if Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][button.frame][3]["MAXDICONS"]<2 then
        for i=Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][button.frame][3]["MAXDICONS"]+59,60 do
            HealBot_Aura_RemoveIcon(button, i)
        end
    end
end

function HealBot_Aura_RemoveExtraUnitIcons(button, index)
      --HealBot_setCall("HealBot_Aura_RemoveExtraUnitIcons", button)
    HealBot_Aura_RemoveIcon(button, index)
end

HealBot_Aura_luVars["exIconAlpha"]=0
function HealBot_Aura_UpdateExtraIcon(button, iconData, index)
      --HealBot_setCall("HealBot_Aura_UpdateExtraIcon", button)
    if (index == 91 and Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["CLASSEN"]) or
       (index == 92 and Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["TARGETEN"]) or
       (index == 93 and Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["RCEN"]) or
       (index == 94 and Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["OOREN"]) then
        HealBot_Aura_luVars["exIconAlpha"]=HealBot_Action_BarColourAlpha(button, HealBot_Skins_GetFrameVar("BarCol", "HA", button.framecol), 1)
    else
        HealBot_Aura_luVars["exIconAlpha"]=button.status.alpha
    end
    button.gref.icon[index]:SetAlpha(HealBot_Aura_luVars["exIconAlpha"])
end

local dbSecsLeft, dbRetAlpha, dbFadeDiff, dbNextAuraUpdate, dbMaxAlpha, dbMaxDur=0,0,0,1,1,1
function HealBot_Aura_DebuffIconAlphaValue(button, iconData, secsLeft)
      --HealBot_setCall("HealBot_Aura_DebuffIconAlphaValue", button, nil, nil, true)
    dbNextAuraUpdate=999
    if secsLeft>-3 then
        if Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][button.frame][iconData.iconSet]["DFADE"] then
            if iconData.duration<Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][button.frame][iconData.iconSet]["DFADESECS"] then
                dbMaxDur=iconData.duration
            else
                dbMaxDur=Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][button.frame][iconData.iconSet]["DFADESECS"]
            end
            if secsLeft<dbMaxDur then
                dbNextAuraUpdate=0.122
                if (iconData.expirationTime-HealBot_TimeNow)<0 then
                    dbFadeDiff=0.01
                else
                    dbFadeDiff=(iconData.expirationTime-HealBot_TimeNow)/dbMaxDur
                end
                if dbFadeDiff<0.97 then
                    dbRetAlpha=dbFadeDiff+0.03 --+((1-dbFadeDiff)/3)
                else
                    dbRetAlpha=1
                end
                if Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][button.frame][iconData.iconSet]["DI15EN"] then
                    dbMaxAlpha=HealBot_Action_BarColourAlpha(button, HealBot_Skins_GetFrameVar("BarCol", "HA", button.framecol), 1)
                    if dbRetAlpha>dbMaxAlpha then
                        dbRetAlpha=dbMaxAlpha
                    end
                elseif dbRetAlpha>button.status.alpha then
                    dbRetAlpha=button.status.alpha
                end
            else
                dbNextAuraUpdate=secsLeft-dbMaxDur
                if Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][button.frame][iconData.iconSet]["DI15EN"] then
                    dbRetAlpha=HealBot_Action_BarColourAlpha(button, HealBot_Skins_GetFrameVar("BarCol", "HA", button.framecol), 1)
                else
                    dbRetAlpha=button.status.alpha
                end
            end
        elseif Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][button.frame][iconData.iconSet]["DI15EN"] then
            dbRetAlpha=HealBot_Action_BarColourAlpha(button, HealBot_Skins_GetFrameVar("BarCol", "HA", button.framecol), 1)
        else
            dbRetAlpha=button.status.alpha
        end
    else
        dbRetAlpha=0
        HealBot_DebuffSlowUpdate(button)
    end
    return dbRetAlpha, dbNextAuraUpdate
end

local dbAlphaNextUpdate, dbDurNextUpdate, dbiconAlpha=0,0,0
function HealBot_Aura_DoUpdateDebuffIcon(button, iconData, index, timer, lastSpellId, srcTimer)
      --HealBot_setCall("HealBot_Aura_DoUpdateDebuffIcon", button, nil, nil, true)
    if iconData.current and lastSpellId == iconData.spellId then
        dbAlphaNextUpdate=999
        dbDurNextUpdate=999
        dbSecsLeft=floor((iconData.expirationTime-HealBot_TimeNow)-0.5)
        if iconData.expirationTime>0 then
            dbiconAlpha, dbAlphaNextUpdate=HealBot_Aura_DebuffIconAlphaValue(button, iconData, dbSecsLeft)
        elseif Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][button.frame][iconData.iconSet]["DI15EN"] then
            dbiconAlpha=HealBot_Action_BarColourAlpha(button, HealBot_Skins_GetFrameVar("BarCol", "HA", button.framecol), 1)
        else
            dbiconAlpha=button.status.alpha
        end
        button.gref.icon[index]:SetAlpha(dbiconAlpha)
        if dbiconAlpha<button.status.alpha then
            dbiconAlpha=button.status.alpha
        end
        if dbSecsLeft>-2 and HealBot_Skins_GetIconTextBoolean("DBSDUR", button.frame, iconData.iconSet) then
            if dbSecsLeft<=HealBot_Skins_GetIconTextVar("DBDURTHRH", button.frame, iconData.iconSet) then
                if dbSecsLeft<=HealBot_Skins_GetIconTextVar("DBDURWARN", button.frame, iconData.iconSet) then
                    if UnitIsFriend("player",button.unit) then
                        button.gref.txt.expire[index]:SetTextColor(0,1,0,dbiconAlpha)
                    else
                        button.gref.txt.expire[index]:SetTextColor(1,0,0,dbiconAlpha);
                    end
                    if dbSecsLeft>-1 then
                        button.gref.txt.expire[index]:SetText(dbSecsLeft);
                    else
                        button.gref.txt.expire[index]:SetText("0")
                    end
                else
                    button.gref.txt.expire[index]:SetTextColor(1,1,1,dbiconAlpha);
                    button.gref.txt.expire[index]:SetText(dbSecsLeft)
                end
                dbDurNextUpdate=HealBot_Aura_luVars["AuraUpdate"]
            else
                button.gref.txt.expire[index]:SetTextColor(1,1,1,0)
                button.gref.txt.expire[index]:SetText(" ");
                dbDurNextUpdate=dbSecsLeft-HealBot_Skins_GetIconTextVar("DBDURTHRH", button.frame, iconData.iconSet)
                --if (iconData.expirationTime-HealBot_TimeNow-1)>HealBot_Skins_GetIconTextVar("DBDURTHRH", button.frame, iconData.iconSet) then
                --    dbDurNextUpdate=(iconData.expirationTime-HealBot_TimeNow-1)-HealBot_Skins_GetIconTextVar("DBDURTHRH", button.frame, iconData.iconSet)
                --else
                --    dbDurNextUpdate=HealBot_Aura_luVars["AuraUpdate"]
                --end
            end
        else
            button.gref.txt.expire[index]:SetTextColor(1,1,1,0)
            button.gref.txt.expire[index]:SetText(" ");
        end
        if hbTextureUpdateTime[button.id][lastSpellId] then
            if hbTextureUpdateTime[button.id][lastSpellId]<HealBot_TimeNow then
                hbTextureUpdateTime[button.id][lastSpellId]=nil
                button.gref.icon[index]:SetTexture(HealBot_WoWAPI_SpellTexture(iconData.spellId))
            elseif (dbDurNextUpdate+1)>hbTextureUpdateTime[button.id][lastSpellId]-HealBot_TimeNow then
                dbDurNextUpdate=hbTextureUpdateTime[button.id][lastSpellId]-HealBot_TimeNow
            end
        end
        if not srcTimer then
            if iconData.count > 1 and HealBot_Skins_GetIconTextBoolean("DBSCNT", button.frame, iconData.iconSet) then
                button.gref.txt.count[index]:SetText(iconData.count);
                button.gref.txt.count[index]:SetTextColor(1,1,1,dbiconAlpha);
            else
                button.gref.txt.count[index]:SetTextColor(1,1,1,0)
                button.gref.txt.count[index]:SetText(" ");
            end
        end
        if timer then
            if dbAlphaNextUpdate<dbDurNextUpdate then
                C_Timer.After(dbAlphaNextUpdate, function() HealBot_Aura_DoUpdateDebuffIcon(button, iconData, index, true, lastSpellId, true) end)
            elseif dbDurNextUpdate<999 then
                C_Timer.After(dbDurNextUpdate, function() HealBot_Aura_DoUpdateDebuffIcon(button, iconData, index, true, lastSpellId, true) end)
            end
        end
    end
end

local hbGlowSpellName,hbGlowIdx="",1
local customDebuffPriority=HEALBOT_CUSTOM_en.."15"
function HealBot_Aura_UpdateDebuffIcon(button, iconData, index, timer, spellId)
      --HealBot_setCall("HealBot_Aura_UpdateDebuffIcon", button, nil, nil, true)
    HealBot_Aura_DoUpdateDebuffIcon(button, iconData, index, timer, spellId, false)
    if HealBot_AuraDebuffCache[spellId] then
        hbGlowSpellName=HealBot_AuraDebuffCache[spellId]["name"] or "x"
        hbGlowIdx=HealBot_DebuffIconGlow[spellId] or HealBot_DebuffIconGlow[hbGlowSpellName] or 1
    else
        hbGlowIdx=1
    end
    if hbGlowIdx>1 then
        if HealBot_Globals.CDCBarColour[spellId] then
            HealBot_Action_EnableIconGlow(button, 
                                          HealBot_Globals.CDCBarColour[spellId].R or 1, 
                                          HealBot_Globals.CDCBarColour[spellId].G or 0.25, 
                                          HealBot_Globals.CDCBarColour[spellId].B or 0.25, 
                                          "ICONDEBUFF", 
                                          hbGlowIdx, 
                                          index,
                                          dbiconAlpha)
        elseif HealBot_Globals.CDCBarColour[hbGlowSpellName] then
            HealBot_Action_EnableIconGlow(button, 
                                          HealBot_Globals.CDCBarColour[hbGlowSpellName].R or 1, 
                                          HealBot_Globals.CDCBarColour[hbGlowSpellName].G or 0.25, 
                                          HealBot_Globals.CDCBarColour[hbGlowSpellName].B or 0.25, 
                                          "ICONDEBUFF", 
                                          hbGlowIdx, 
                                          index,
                                          dbiconAlpha)
        else
            HealBot_Action_EnableIconGlow(button,  
                                          HealBot_Globals.CDCBarColour[customDebuffPriority].R or 1, 
                                          HealBot_Globals.CDCBarColour[customDebuffPriority].G or 0.25, 
                                          HealBot_Globals.CDCBarColour[customDebuffPriority].B or 0.25, 
                                          "ICONDEBUFF", 
                                          hbGlowIdx, 
                                          index,
                                          dbiconAlpha)
        end
    elseif button.glow.icon[index]>1 then
        HealBot_Action_DisableIconGlow(button, "ICONDEBUFF", index)
    end
end

local bSecsLeft, bRetAlpha, bFadeDiff, bNextAuraUpdate, bMaxAlpha, bMaxDur=0,0,0,1,1,5
function HealBot_Aura_BuffIconAlphaValue(button, iconData, secsLeft)
      --HealBot_setCall("HealBot_Aura_BuffIconAlphaValue", button, nil, nil, true)
    bNextAuraUpdate=999
    if secsLeft>-3 then
        if Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][button.frame][iconData.iconSet]["BUFFFADE"] then
            if iconData.duration<Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][button.frame][iconData.iconSet]["BUFFFADESECS"] then
                bMaxDur=iconData.duration
            else
                bMaxDur=Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][button.frame][iconData.iconSet]["BUFFFADESECS"]
            end
            if secsLeft<bMaxDur then
                bNextAuraUpdate=0.122
                if (iconData.expirationTime-HealBot_TimeNow)<0 then
                    bFadeDiff=0.01
                else
                    bFadeDiff=(iconData.expirationTime-HealBot_TimeNow)/bMaxDur
                end
                if bFadeDiff<0.97 then
                    bRetAlpha=bFadeDiff+0.03 --+((1-bFadeDiff)/3)
                else
                    bRetAlpha=1
                end
                if Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][button.frame][iconData.iconSet]["BUFFI15EN"] then
                    bMaxAlpha=HealBot_Action_BarColourAlpha(button, HealBot_Skins_GetFrameVar("BarCol", "HA", button.framecol), 1)
                    if bRetAlpha>bMaxAlpha then
                        bRetAlpha=bMaxAlpha
                    end
                elseif bRetAlpha>button.status.alpha then
                    bRetAlpha=button.status.alpha
                end
            else
                bNextAuraUpdate=secsLeft-bMaxDur
                if Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][button.frame][iconData.iconSet]["BUFFI15EN"] then
                    bRetAlpha=HealBot_Action_BarColourAlpha(button, HealBot_Skins_GetFrameVar("BarCol", "HA", button.framecol), 1)
                else
                    bRetAlpha=button.status.alpha
                end
            end
        elseif Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][button.frame][iconData.iconSet]["BUFFI15EN"] then
            bRetAlpha=HealBot_Action_BarColourAlpha(button, HealBot_Skins_GetFrameVar("BarCol", "HA", button.framecol), 1)
        else
            bRetAlpha=button.status.alpha
        end
    else
        bRetAlpha=0
        HealBot_BuffSlowUpdate(button)
    end
    return bRetAlpha, bNextAuraUpdate
end

local bAlphaNextUpdate, bDurNextUpdate, bIconAlpha=0,0,0
function HealBot_Aura_DoUpdateBuffIcon(button, iconData, index, timer, lastSpellId, srcTimer)
      --HealBot_setCall("HealBot_Aura_DoUpdateBuffIcon", button, nil, nil, true)
    if iconData.current and lastSpellId == iconData.spellId then
        bAlphaNextUpdate=999
        bDurNextUpdate=999
        bSecsLeft=floor((iconData.expirationTime-HealBot_TimeNow)-0.5)
        if iconData.expirationTime>0 then
            bIconAlpha, bAlphaNextUpdate=HealBot_Aura_BuffIconAlphaValue(button, iconData, bSecsLeft)
        elseif Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][button.frame][iconData.iconSet]["BUFFI15EN"] then
            bIconAlpha=HealBot_Action_BarColourAlpha(button, HealBot_Skins_GetFrameVar("BarCol", "HA", button.framecol), 1)
        else
            bIconAlpha=button.status.alpha
        end
        button.gref.icon[index]:SetAlpha(bIconAlpha)
        if bIconAlpha<button.status.alpha then
            bIconAlpha=button.status.alpha
        end
        if bSecsLeft>-2 and HealBot_Skins_GetIconTextBoolean("BUFFSDUR", button.frame, iconData.iconSet)
                        and (not HealBot_Skins_GetIconTextBoolean("BUFFSSDUR", button.frame, iconData.iconSet) or UnitIsUnit(iconData.unitCaster,"player")) then
            if bSecsLeft<=HealBot_Skins_GetIconTextVar("BUFFDURTHRH", button.frame, iconData.iconSet) then
                if bSecsLeft<=HealBot_Skins_GetIconTextVar("BUFFDURWARN", button.frame, iconData.iconSet) then
                    if UnitIsFriend("player",button.unit) then
                        button.gref.txt.expire[index]:SetTextColor(1,0.5,0,bIconAlpha)
                    else
                        button.gref.txt.expire[index]:SetTextColor(1,0,0,bIconAlpha);
                    end
                    if bSecsLeft>-1 then
                        button.gref.txt.expire[index]:SetText(bSecsLeft);
                    else
                        button.gref.txt.expire[index]:SetText("0")
                    end
                else
                    button.gref.txt.expire[index]:SetTextColor(1,1,1,bIconAlpha);
                    button.gref.txt.expire[index]:SetText(bSecsLeft)
                end
                bDurNextUpdate=HealBot_Aura_luVars["AuraUpdate"]
            else
                button.gref.txt.expire[index]:SetTextColor(1,1,1,0)
                button.gref.txt.expire[index]:SetText(" ");
                bDurNextUpdate=bSecsLeft-HealBot_Skins_GetIconTextVar("BUFFDURTHRH", button.frame, iconData.iconSet)
                --if (iconData.expirationTime-HealBot_TimeNow-1)>HealBot_Skins_GetIconTextVar("BUFFDURTHRH", button.frame, iconData.iconSet) then
                --    bDurNextUpdate=(iconData.expirationTime-HealBot_TimeNow-1)-HealBot_Skins_GetIconTextVar("BUFFDURTHRH", button.frame, iconData.iconSet)
                --else
                --    bDurNextUpdate=HealBot_Aura_luVars["AuraUpdate"]
                --end
            end
        else
            button.gref.txt.expire[index]:SetTextColor(1,1,1,0)
            button.gref.txt.expire[index]:SetText(" ");
        end
        if hbTextureUpdateTime[button.id][lastSpellId] then
            if hbTextureUpdateTime[button.id][lastSpellId]<HealBot_TimeNow then
                hbTextureUpdateTime[button.id][lastSpellId]=nil
                button.gref.icon[index]:SetTexture(HealBot_WoWAPI_SpellTexture(iconData.spellId))
            elseif (bDurNextUpdate+1)>hbTextureUpdateTime[button.id][lastSpellId]-HealBot_TimeNow then
                bDurNextUpdate=hbTextureUpdateTime[button.id][lastSpellId]-HealBot_TimeNow
            end
        end
        if not srcTimer then
            if Healbot_Config_Skins.IconText[Healbot_Config_Skins.Current_Skin][button.frame]["SELFIND"] and UnitIsUnit(iconData.unitCaster,"player") then
                button.gref.indicator.selfcast[index]:SetAlpha(HealBot_Action_BarColourAlpha(button, 1, 1))
            else
                button.gref.indicator.selfcast[index]:SetAlpha(0)
            end
            if iconData.count > 1 and HealBot_Skins_GetIconTextBoolean("BUFFSCNT", button.frame, iconData.iconSet)
                                  and (not HealBot_Skins_GetIconTextBoolean("BUFFSSCNT", button.frame, iconData.iconSet) or UnitIsUnit(iconData.unitCaster,"player")) then
                button.gref.txt.count[index]:SetText(iconData.count);
                button.gref.txt.count[index]:SetTextColor(1,1,1,bIconAlpha);
            else
                button.gref.txt.count[index]:SetTextColor(1,1,1,0)
                button.gref.txt.count[index]:SetText(" ");
            end
        end
        if timer then
            if bAlphaNextUpdate<bDurNextUpdate then
                C_Timer.After(bAlphaNextUpdate, function() HealBot_Aura_DoUpdateBuffIcon(button, iconData, index, true, lastSpellId, true) end)
            elseif bDurNextUpdate<999 then
                C_Timer.After(bDurNextUpdate, function() HealBot_Aura_DoUpdateBuffIcon(button, iconData, index, true, lastSpellId, true) end)
            end
        end
    end
end

local customBuffPriority=HEALBOT_CUSTOM_en.."Buff"
function HealBot_Aura_UpdateBuffIcon(button, iconData, index, timer, spellId)
      --HealBot_setCall("HealBot_Aura_UpdateBuffIcon", button, nil, nil, true)
    HealBot_Aura_DoUpdateBuffIcon(button, iconData, index, timer, spellId, false)
    if HealBot_AuraBuffCache[spellId] then
        hbGlowSpellName=HealBot_AuraBuffCache[spellId]["name"] or "x"
        hbGlowIdx=HealBot_BuffIconGlow[spellId] or HealBot_BuffIconGlow[hbGlowSpellName] or 1
    else
        hbGlowIdx=1
    end
    if hbGlowIdx>1 then
        if HealBot_Globals.CustomBuffBarColour[spellId] then
            HealBot_Action_EnableIconGlow(button, 
                                          HealBot_Globals.CustomBuffBarColour[spellId].R or 0.25, 
                                          HealBot_Globals.CustomBuffBarColour[spellId].G or 0.58, 
                                          HealBot_Globals.CustomBuffBarColour[spellId].B or 0.8, 
                                          "ICONBUFF", 
                                          hbGlowIdx, 
                                          index,
                                          bIconAlpha)
        elseif HealBot_Globals.CustomBuffBarColour[hbGlowSpellName] then
            HealBot_Action_EnableIconGlow(button, 
                                          HealBot_Globals.CustomBuffBarColour[hbGlowSpellName].R or 0.25, 
                                          HealBot_Globals.CustomBuffBarColour[hbGlowSpellName].G or 0.58, 
                                          HealBot_Globals.CustomBuffBarColour[hbGlowSpellName].B or 0.8, 
                                          "ICONBUFF", 
                                          hbGlowIdx, 
                                          index,
                                          bIconAlpha)
        elseif HealBot_Globals.CustomBuffBarColour[HEALBOT_CUSTOM_CAT_CUSTOM_AUTOBUFFS] then
            HealBot_Action_EnableIconGlow(button, 
                                          HealBot_Globals.CustomBuffBarColour[HEALBOT_CUSTOM_CAT_CUSTOM_AUTOBUFFS].R or 0.25, 
                                          HealBot_Globals.CustomBuffBarColour[HEALBOT_CUSTOM_CAT_CUSTOM_AUTOBUFFS].G or 0.58, 
                                          HealBot_Globals.CustomBuffBarColour[HEALBOT_CUSTOM_CAT_CUSTOM_AUTOBUFFS].B or 0.8, 
                                          "ICONBUFF", 
                                          hbGlowIdx, 
                                          index,
                                          bIconAlpha)
        else
            HealBot_Action_EnableIconGlow(button, 
                                          HealBot_Globals.CustomBuffBarColour[customBuffPriority].R or 0.25, 
                                          HealBot_Globals.CustomBuffBarColour[customBuffPriority].G or 0.58, 
                                          HealBot_Globals.CustomBuffBarColour[customBuffPriority].B or 0.8, 
                                          "ICONBUFF", 
                                          hbGlowIdx, 
                                          index,
                                          bIconAlpha)
        end
    elseif button.glow.icon[index]>1 then
        HealBot_Action_DisableIconGlow(button, "ICONBUFF", index)
    end
end

function HealBot_Aura_AddExtraIcon(button, index)
    --HealBot_setCall("HealBot_Aura_AddExtraIcon", button)
    button.gref.icon[index]:SetTexture(HealBot_UnitExtraIcons[button.id][index]["texture"])
    --if index == 94 then HealBot_Action_SetDirectionArrow(button) end
    HealBot_Aura_UpdateExtraIcon(button, HealBot_UnitExtraIcons[button.id][index], index)
end

function HealBot_Aura_AddBuffIcon(button, index)
      --HealBot_setCall("HealBot_Aura_AddBuffIcon", button, nil, nil, true)
    button.gref.iconf[index]:SetFrameLevel(200)
    button.gref.icon[index]:SetTexture(HealBot_UnitBuffIcons[button.id][index]["icon"])
    HealBot_Aura_UpdateBuffIcon(button, HealBot_UnitBuffIcons[button.id][index], index, true, HealBot_UnitBuffIcons[button.id][index]["spellId"])
end

function HealBot_Aura_DebuffAddIcon(button, index)
      --HealBot_setCall("HealBot_Aura_DebuffAddIcon", button, nil, nil, true)
    button.gref.iconf[index]:SetFrameLevel(200)
    button.gref.icon[index]:SetTexture(HealBot_UnitDebuffIcons[button.id][index]["icon"])
    HealBot_Aura_UpdateDebuffIcon(button, HealBot_UnitDebuffIcons[button.id][index], index, true, HealBot_UnitDebuffIcons[button.id][index]["spellId"])
end

local hbAuraWatchRaidTarget={}
function HealBot_Aura_AuraWatchRaidTarget(guid, state)
        --HealBot_setCall("HealBot_Aura_AuraWatchRaidTarget", nil, guid)
    if state then
        hbAuraWatchRaidTarget[guid]=true
    else
        hbAuraWatchRaidTarget[guid]=nil
    end
end

function HealBot_Aura_AuraWatchRaidTargetClear()
        --HealBot_setCall("HealBot_Aura_AuraWatchRaidTargetClear")
    hbAuraWatchRaidTarget={}
end

local rtuPrevId=false
function HealBot_Aura_RaidTargetUpdate(button, iconID)
        --HealBot_setCall("HealBot_Aura_RaidTargetUpdate", button)
    rtuPrevId=button.icon.extra.targeticon
    button.icon.extra.targeticon=iconID
    if button.icon.extra.targeticon~=rtuPrevId and HealBot_UnitExtraIcons[button.id] then
        if not HealBot_TargetIconsTextures[button.icon.extra.targeticon] then
            HealBot_Aura_RemoveIcon(button, 92)
        elseif not HealBot_UnitExtraIcons[button.id][92].current or
           HealBot_UnitExtraIcons[button.id][92]["texture"]~=HealBot_TargetIconsTextures[button.icon.extra.targeticon] then
            HealBot_UnitExtraIcons[button.id][92]["texture"]=HealBot_TargetIconsTextures[button.icon.extra.targeticon]
            HealBot_UnitExtraIcons[button.id][92].current=true
            HealBot_Aura_AddExtraIcon(button, 92)
        end
        if hbAuraWatchRaidTarget[button.guid] then
            HealBot_Plugin_AuraWatch_RaidTargetUpdate(button)
        end
    end
end

local cuPrevTexture=false
function HealBot_Aura_ClassUpdate(button, texture)
        --HealBot_setCall("HealBot_Aura_ClassUpdate", button)
    cuPrevTexture=button.icon.extra.classtexture
    button.icon.extra.classtexture=texture
    if button.icon.extra.classtexture~=cuPrevTexture and HealBot_UnitExtraIcons[button.id] then
        if not button.icon.extra.classtexture then 
            HealBot_Aura_RemoveIcon(button, 91)
        elseif not HealBot_UnitExtraIcons[button.id][91].current or
           HealBot_UnitExtraIcons[button.id][91]["texture"]~=button.icon.extra.classtexture then
            HealBot_UnitExtraIcons[button.id][91]["texture"]=button.icon.extra.classtexture
            HealBot_UnitExtraIcons[button.id][91].current=true
            HealBot_Aura_AddExtraIcon(button, 91)
        end
    end
end

local hbIconRanks={[1]="Interface\\Addons\\HealBot\\Images\\leader.tga",
                   [2]="Interface\\Addons\\HealBot\\Images\\assist.tga",
                   [3]="Interface\\Addons\\HealBot\\Images\\looter.tga",
                   [4]="Interface\\Addons\\HealBot\\Images\\leader.tga",
                   }
function HealBot_Aura_UpdateState(button)
        --HealBot_setCall("HealBot_Aura_UpdateState", button)
    if HealBot_UnitExtraIcons[button.id] then
        if button.icon.extra.hostile or button.status.incombat or button.icon.extra.readycheck or button.status.afk then
            if button.status.afk then
                HealBot_UnitExtraIcons[button.id][93]["texture"]="Interface\\Addons\\HealBot\\Images\\afk.tga"
            elseif button.icon.extra.hostile then
                HealBot_UnitExtraIcons[button.id][93]["texture"]="Interface\\Addons\\HealBot\\Images\\hostile.tga"
            elseif button.status.incombat then
                HealBot_UnitExtraIcons[button.id][93]["texture"]="Interface\\Addons\\HealBot\\Images\\incombat.tga"
            else
                if button.icon.extra.readycheck == HealBot_ReadyCheckStatus["WAITING"] then
                    HealBot_UnitExtraIcons[button.id][93]["texture"]="Interface\\RAIDFRAME\\ReadyCheck-Waiting"
                elseif button.icon.extra.readycheck == HealBot_ReadyCheckStatus["NOTREADY"] then
                    HealBot_UnitExtraIcons[button.id][93]["texture"]="Interface\\RAIDFRAME\\ReadyCheck-NotReady"
                else
                    HealBot_UnitExtraIcons[button.id][93]["texture"]="Interface\\RAIDFRAME\\ReadyCheck-Ready"
                end
                if HealBot_Panel_RaidUnitButtonCheck(button.guid) then HealBot_Action_SetGuidData(button, "READYCHECK", button.icon.extra.readycheck) end
            end
            HealBot_UnitExtraIcons[button.id][93].current=true
            HealBot_Aura_AddExtraIcon(button, 93)
        elseif button.rank>0 and Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["SHOWRANK"] then
            HealBot_UnitExtraIcons[button.id][93]["texture"]=hbIconRanks[button.rank]
            HealBot_UnitExtraIcons[button.id][93].current=true
            HealBot_Aura_AddExtraIcon(button, 93)
        elseif button.player and Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["SHOWRESTING"] and IsResting() then 
            HealBot_UnitExtraIcons[button.id][93]["texture"]="Interface\\Addons\\HealBot\\Images\\rested.tga"
            HealBot_UnitExtraIcons[button.id][93].current=true
            HealBot_Aura_AddExtraIcon(button, 93)
        else
            HealBot_Aura_RemoveIcon(button, 93)
        end
    end
end

function HealBot_Aura_OORUpdate(button, texture)
        --HealBot_setCall("HealBot_Aura_OORUpdate", button)
    button.icon.extra.oorarrow=texture
    if HealBot_UnitExtraIcons[button.id] then
        if not button.icon.extra.oorarrow then 
            HealBot_Aura_RemoveIcon(button, 94)
        else
            HealBot_UnitExtraIcons[button.id][94]["texture"]=button.icon.extra.oorarrow
            HealBot_UnitExtraIcons[button.id][94].current=true
            HealBot_Action_SetDirectionArrow(button, 94)
            HealBot_Aura_AddExtraIcon(button, 94)
        end
    end
end

function HealBot_Aura_InitUnitBuffIcons(buttonId)
      --HealBot_setCall("HealBot_Aura_InitUnitBuffIcons")
    HealBot_UnitBuffIcons[buttonId]={}
    uaBuffData[buttonId]={}
    for i=1,12 do
        HealBot_UnitBuffIcons[buttonId][i]={}
        HealBot_UnitBuffIcons[buttonId][i]["count"]=0
        HealBot_UnitBuffIcons[buttonId][i]["expirationTime"]=0
        HealBot_UnitBuffIcons[buttonId][i]["duration"]=0
        HealBot_UnitBuffIcons[buttonId][i]["spellId"]=0
        HealBot_UnitBuffIcons[buttonId][i]["debuffType"]=""
        HealBot_UnitBuffIcons[buttonId][i]["unitCaster"]="x"
        HealBot_UnitBuffIcons[buttonId][i]["iconSet"]=1
        HealBot_UnitBuffIcons[buttonId][i]["icon"]=""
        HealBot_UnitBuffIcons[buttonId][i]["slot"]=1
        HealBot_UnitBuffIcons[buttonId][i].current=false
    end
    for i=1,20 do
        uaBuffData[buttonId][i]={}
        uaBuffData[buttonId][i].name=""
        uaBuffData[buttonId][i].icon=""
        uaBuffData[buttonId][i].count=0
        uaBuffData[buttonId][i].debuffType=""
        uaBuffData[buttonId][i].duration=0
        uaBuffData[buttonId][i].expirationTime=0
        uaBuffData[buttonId][i].sourceUnit="x"
        uaBuffData[buttonId][i].sourceUnitIsPlayer=false
        uaBuffData[buttonId][i].spellId=0
    end
    uaBuffData[buttonId].lastslot=0
end

function HealBot_Aura_InitUnitDebuffIcons(buttonId)
      --HealBot_setCall("HealBot_Aura_InitUnitDebuffIcons")
    HealBot_UnitDebuffIcons[buttonId]={}
    uaDebuffData[buttonId]={}
    for i=51,60 do
        HealBot_UnitDebuffIcons[buttonId][i]={}
        HealBot_UnitDebuffIcons[buttonId][i]["count"]=0
        HealBot_UnitDebuffIcons[buttonId][i]["expirationTime"]=0
        HealBot_UnitDebuffIcons[buttonId][i]["duration"]=0
        HealBot_UnitDebuffIcons[buttonId][i]["spellId"]=0
        HealBot_UnitDebuffIcons[buttonId][i]["debuffType"]=""
        HealBot_UnitDebuffIcons[buttonId][i]["unitCaster"]="x"
        HealBot_UnitDebuffIcons[buttonId][i]["iconSet"]=1
        HealBot_UnitDebuffIcons[buttonId][i]["icon"]=""
        HealBot_UnitDebuffIcons[buttonId][i]["slot"]=1
        HealBot_UnitDebuffIcons[buttonId][i].current=false
    end
    for i=1,20 do
        uaDebuffData[buttonId][i]={}
        uaDebuffData[buttonId][i].name=""
        uaDebuffData[buttonId][i].icon=""
        uaDebuffData[buttonId][i].count=0
        uaDebuffData[buttonId][i].debuffType=""
        uaDebuffData[buttonId][i].duration=0
        uaDebuffData[buttonId][i].expirationTime=0
        uaDebuffData[buttonId][i].sourceUnit="x"
        uaDebuffData[buttonId][i].sourceUnitIsPlayer=false
        uaDebuffData[buttonId][i].spellId=0
        uaDebuffData[buttonId][i].isBossAura=false
    end
    uaDebuffData[buttonId].lastslot=0
end

function HealBot_Aura_InitUnitExtraIcons(buttonId)
      --HealBot_setCall("HealBot_Aura_InitUnitExtraIcons")
    HealBot_UnitExtraIcons[buttonId]={}
    for i=91,94 do
        HealBot_UnitExtraIcons[buttonId][i]={}
        HealBot_UnitExtraIcons[buttonId][i]["texture"]=""
        HealBot_UnitExtraIcons[buttonId][i].current=false
    end
end

local hbClassicAbsorbsTrack={}
local hbClassicAbsorbsAmount={}
function HealBot_Aura_setButtonIcons(buttonId)
      --HealBot_setCall("HealBot_Aura_setButtonIcons")
    HealBot_Aura_InitUnitDebuffIcons(buttonId) 
    HealBot_Aura_InitUnitBuffIcons(buttonId) 
    HealBot_Aura_InitUnitExtraIcons(buttonId)
    hbClassicAbsorbsTrack[buttonId]={}
    hbClassicAbsorbsAmount[buttonId]={}
    hbTextureUpdateId[buttonId]={}
    hbTextureUpdateTime[buttonId]={}
end

function HealBot_Aura_setUnitIcons(unit)
      --HealBot_setCall("HealBot_Aura_setUnitIcons", nil, nil, unit)
    if not HealBot_Aura_WarningFilter[unit] then
        HealBot_Aura_WarningFilter[unit]={}
    end
end

function HealBot_Aura_AutoUpdateCustomDebuff(button, name, spellId)
      --HealBot_setCall("HealBot_Aura_AutoUpdateCustomDebuff", button)
    for dID, x in pairs(HealBot_Globals.HealBot_Custom_Debuffs) do
        if not HealBot_WoWAPI_SpellName(dID) and dID == name then
            HealBot_Globals.Custom_Debuff_Categories[spellId]=HealBot_Globals.Custom_Debuff_Categories[name]
            HealBot_Globals.HealBot_Custom_Debuffs[spellId]=x
            if HealBot_Globals.FilterCustomDebuff[name] then 
                HealBot_Globals.FilterCustomDebuff[spellId]=HealBot_Globals.FilterCustomDebuff[name]
            end
            if HealBot_Globals.HealBot_Custom_Debuffs_ShowBarCol[name] then
                HealBot_Globals.HealBot_Custom_Debuffs_ShowBarCol[spellId]=HealBot_Globals.HealBot_Custom_Debuffs_ShowBarCol[name]
            end
            if HealBot_Globals.CDCBarColour[name] then
                HealBot_Globals.CDCBarColour[spellId]=HealBot_Options_copyTable(HealBot_Globals.CDCBarColour[name])
            end
            if HealBot_Globals.IgnoreCustomDebuff[name] then
                HealBot_Globals.IgnoreCustomDebuff[spellId]=HealBot_Options_copyTable(HealBot_Globals.IgnoreCustomDebuff[name])
            end
            if HealBot_Globals.HealBot_Custom_Debuffs_IconSet[name] then
                HealBot_Globals.HealBot_Custom_Debuffs_IconSet[spellId]=HealBot_Globals.HealBot_Custom_Debuffs_IconSet[name]
            end
            if HealBot_Globals.HealBot_Custom_Debuffs_IconGlow[name] then
                HealBot_Globals.HealBot_Custom_Debuffs_IconGlow[spellId]=HealBot_Globals.HealBot_Custom_Debuffs_IconGlow[name]
            end
            HealBot_Options_DeleteCDebuff(name, name)
            break
        end
    end
    HealBot_Timers_Set("AURA","CustomDebuffListPrep")
end

function HealBot_Aura_CacheDebuffIcon(button, id, spellId, slot)
      --HealBot_setCall("HealBot_Aura_CacheDebuffIcon", button)
    if HealBot_UnitDebuffIcons[button.id][id]["spellId"]~=spellId or
       HealBot_UnitDebuffIcons[button.id][id]["count"]~=uaDebuffData[button.id][slot].count or
       HealBot_UnitDebuffIcons[button.id][id]["expirationTime"]~=uaDebuffData[button.id][slot].expirationTime or
       HealBot_UnitDebuffIcons[button.id][id]["unitCaster"]~=uaDebuffData[button.id][slot].sourceUnit then
        HealBot_UnitDebuffIcons[button.id][id]["count"]=uaDebuffData[button.id][slot].count
        HealBot_UnitDebuffIcons[button.id][id]["duration"]=uaDebuffData[button.id][slot].duration
        HealBot_UnitDebuffIcons[button.id][id]["iconSet"]=HealBot_Aura_IconSet[spellId]
        HealBot_UnitDebuffIcons[button.id][id]["icon"]=uaDebuffData[button.id][slot].icon
        HealBot_UnitDebuffIcons[button.id][id]["slot"]=uaDebuffData[button.id][slot].gSlot
        HealBot_UnitDebuffIcons[button.id][id]["debuffType"]=uaDebuffData[button.id][slot].debuffType
        HealBot_UnitDebuffIcons[button.id][id]["unitCaster"]=uaDebuffData[button.id][slot].sourceUnit
        if HealBot_UnitDebuffIcons[button.id][id].current then
            if HealBot_UnitDebuffIcons[button.id][id]["spellId"]~=spellId then
                HealBot_UnitDebuffIcons[button.id][id]["spellId"]=spellId
                HealBot_UnitDebuffIcons[button.id][id]["expirationTime"]=uaDebuffData[button.id][slot].expirationTime
                button.gref.icon[id]:SetTexture(HealBot_UnitDebuffIcons[button.id][id]["icon"])
                HealBot_Aura_UpdateDebuffIcon(button, HealBot_UnitDebuffIcons[button.id][id], id, true, spellId)
            else
                if HealBot_UnitDebuffIcons[button.id][id]["expirationTime"]~=uaDebuffData[button.id][slot].expirationTime then
                    HealBot_UnitDebuffIcons[button.id][id]["expirationTime"]=uaDebuffData[button.id][slot].expirationTime
                    button.gref.icon[id]:SetTexture(HealBot_UnitDebuffIcons[button.id][id]["icon"])
                end
                HealBot_Aura_UpdateDebuffIcon(button, HealBot_UnitDebuffIcons[button.id][id], id, false, spellId)
            end
        else
            HealBot_UnitDebuffIcons[button.id][id]["spellId"]=spellId
            HealBot_UnitDebuffIcons[button.id][id]["expirationTime"]=uaDebuffData[button.id][slot].expirationTime
        end
    elseif HealBot_UnitDebuffIcons[button.id][id]["slot"]~=uaDebuffData[button.id][slot].gSlot then
        HealBot_UnitDebuffIcons[button.id][id]["slot"]=uaDebuffData[button.id][slot].gSlot
    end
end

local hbCustomDebuffsCastBy={}
local hbCustomDebuffsDisabled={}

local debuffIconIdx,debuffIconPrio=0,0
local function HealBot_Aura_SortDebuffIconSet(button, iconSet, sIndex)
      --HealBot_setCall("HealBot_Aura_SortDebuffIconSet", button)
    button.icon.debuff.count[iconSet]=#debuffSort[iconSet]
    if button.icon.debuff.count[iconSet]>0 then
        table.sort(debuffSort[iconSet])
        if button.icon.debuff.count[iconSet]>Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][button.frame][iconSet]["MAXDICONS"] then
            button.icon.debuff.count[iconSet]=Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][button.frame][iconSet]["MAXDICONS"]
        end
        for j=1, button.icon.debuff.count[iconSet], 1 do
            HealBot_Aura_CacheDebuffIcon(button, sIndex+j, HealBot_AuraDebuffXRef[debuffSort[iconSet][j]]["spellID"], HealBot_AuraDebuffXRef[debuffSort[iconSet][j]]["slot"])
        end
        if HealBot_AuraDebuffCache[HealBot_AuraDebuffXRef[debuffSort[iconSet][1]]["spellID"]]["priority"]<debuffIconPrio then
            debuffIconIdx=sIndex+1
            debuffIconPrio=HealBot_AuraDebuffCache[HealBot_AuraDebuffXRef[debuffSort[iconSet][1]]["spellID"]]["priority"]
        end
    end
end

function HealBot_Aura_SortDebuffIcons(button)
      --HealBot_setCall("HealBot_Aura_SortDebuffIcons", button)
    debuffIconIdx,debuffIconPrio=0,21
    if Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][button.frame][1]["MAXDICONS"]>0 then
        HealBot_Aura_SortDebuffIconSet(button, 1, 50)
    end
    if Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][button.frame][2]["MAXDICONS"]>0 then
        HealBot_Aura_SortDebuffIconSet(button, 2, 56)
    end
    if Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][button.frame][3]["MAXDICONS"]>0 then
        HealBot_Aura_SortDebuffIconSet(button, 3, 58)
    end
    return debuffIconIdx
end

function HealBot_Aura_CacheBuffIcon(button, id, spellId, slot)
      --HealBot_setCall("HealBot_Aura_CacheBuffIcon", button)
    if HealBot_UnitBuffIcons[button.id][id]["spellId"]~=spellId or
       HealBot_UnitBuffIcons[button.id][id]["count"]~=uaBuffData[button.id][slot].count or
       HealBot_UnitBuffIcons[button.id][id]["expirationTime"]~=uaBuffData[button.id][slot].expirationTime or
       HealBot_UnitBuffIcons[button.id][id]["unitCaster"]~=uaBuffData[button.id][slot].sourceUnit then
        HealBot_UnitBuffIcons[button.id][id]["count"]=uaBuffData[button.id][slot].count
        
        HealBot_UnitBuffIcons[button.id][id]["duration"]=uaBuffData[button.id][slot].duration
        HealBot_UnitBuffIcons[button.id][id]["iconSet"]=HealBot_Aura_IconSet[spellId]
        HealBot_UnitBuffIcons[button.id][id]["icon"]=uaBuffData[button.id][slot].icon
        HealBot_UnitBuffIcons[button.id][id]["debuffType"]=uaBuffData[button.id][slot].debuffType
        HealBot_UnitBuffIcons[button.id][id]["slot"]=uaBuffData[button.id][slot].gSlot
        HealBot_UnitBuffIcons[button.id][id]["unitCaster"]=uaBuffData[button.id][slot].sourceUnit
        if HealBot_UnitBuffIcons[button.id][id].current then
            if HealBot_UnitBuffIcons[button.id][id]["spellId"]~=spellId then
                HealBot_UnitBuffIcons[button.id][id]["spellId"]=spellId
                HealBot_UnitBuffIcons[button.id][id]["expirationTime"]=uaBuffData[button.id][slot].expirationTime
                button.gref.icon[id]:SetTexture(HealBot_UnitBuffIcons[button.id][id]["icon"])
                HealBot_Aura_UpdateBuffIcon(button, HealBot_UnitBuffIcons[button.id][id], id, true, spellId)
            else
                if HealBot_UnitBuffIcons[button.id][id]["expirationTime"]~=uaBuffData[button.id][slot].expirationTime then
                    HealBot_UnitBuffIcons[button.id][id]["expirationTime"]=uaBuffData[button.id][slot].expirationTime
                    button.gref.icon[id]:SetTexture(HealBot_UnitBuffIcons[button.id][id]["icon"])
                end
                HealBot_Aura_UpdateBuffIcon(button, HealBot_UnitBuffIcons[button.id][id], id, false, spellId)
            end
        else
            HealBot_UnitBuffIcons[button.id][id]["spellId"]=spellId
            HealBot_UnitBuffIcons[button.id][id]["expirationTime"]=uaBuffData[button.id][slot].expirationTime
        end
    elseif HealBot_UnitBuffIcons[button.id][id]["slot"]~=uaBuffData[button.id][slot].gSlot then
        HealBot_UnitBuffIcons[button.id][id]["slot"]=uaBuffData[button.id][slot].gSlot
    end
end

function HealBot_Aura_Counts(button)
      --HealBot_setCall("HealBot_Aura_Counts", button)
    HealBot_AddDebug("button count="..button.icon.debuff.count[1].."  Aura Count="..HealBot_Aura_prevIconCount["DEBUFF"][1],"DebuffSet",true)
end

function HealBot_Aura_CheckUnitDebuffIcons(button)
      --HealBot_setCall("HealBot_Aura_CheckUnitDebuffIcons", button)
    for i=51,56 do
        if i<=(50+button.icon.debuff.count[1]) then
            if not HealBot_UnitDebuffIcons[button.id][i].current then
                HealBot_UnitDebuffIcons[button.id][i].current=true
                HealBot_Aura_DebuffAddIcon(button, i)
            end
        elseif i<=(50+HealBot_Aura_prevIconCount["DEBUFF"][1]) then
            HealBot_Aura_RemoveIcon(button, i)
        else
            break
        end
    end
    for i=57,58 do
        if i<=(56+button.icon.debuff.count[2]) then
            --if not HealBot_UnitDebuffIcons[button.id][i].current then
                HealBot_UnitDebuffIcons[button.id][i].current=true
                HealBot_Aura_DebuffAddIcon(button, i)
            --end
        elseif i<=(56+HealBot_Aura_prevIconCount["DEBUFF"][2]) then
            HealBot_Aura_RemoveIcon(button, i)
        else
            break
        end
    end
    for i=59,60 do
        if i<=(58+button.icon.debuff.count[3]) then
            if not HealBot_UnitDebuffIcons[button.id][i].current then
                HealBot_UnitDebuffIcons[button.id][i].current=true
                HealBot_Aura_DebuffAddIcon(button, i)
            end
        elseif i<=(58+HealBot_Aura_prevIconCount["DEBUFF"][3]) then
            HealBot_Aura_RemoveIcon(button, i)
        else
            break
        end
    end
end

local hasBuffTypes, ownBlessing=false, false
function HealBot_Aura_HasBuffTypes(spellName, pBuffTypes)
      --HealBot_setCall("HealBot_Aura_HasBuffTypes")
    hasBuffTypes=false
    if HealBot_BuffNameTypes[spellName] then
        if pBuffTypes[HealBot_BuffNameTypes[spellName]] or (ownBlessing and HealBot_BuffNameTypes[spellName]<7 and HealBot_Config_Buffs.PalaBlessingsAsOne) then
            hasBuffTypes=true
        end
    end
    return hasBuffTypes
end

local curBuffName=false
local curBuffxTime={}
local buffCheckThis, buffWatchTarget, buffSpellStart, buffSpellDur=false,false,0,0
local weaponEnchantState={[1]={["Active"]=false,["Expire"]=0},[2]={["Active"]=false,["Expire"]=0}}
function HealBot_Aura_SetGeneralBuff(button, bName)
      --HealBot_setCall("HealBot_Aura_SetGeneralBuff", button)
    curBuffName=bName
    if button.aura.buff.missingbuff~=bName then
        button.aura.buff.missingbuff=bName
        if HealBot_Text_TagInUse(button.framecol, "BUFF") then
            HealBot_Text_setNameTag(button)
        end
    end
    button.aura.buff.colbar=(HealBot_Globals.HealBot_Custom_Buffs_ShowBarCol["DEFAULT"] or 4)-1
    if HealBot_Aura_ID[bName] and HealBot_AuraBuffCache[uaBuffData[button.id][uaBuffSlot].spellId] then
        if not button.aura.buff.temp.active or button.aura.buff.temp.priority>HealBot_AuraBuffCache[uaBuffData[button.id][uaBuffSlot].spellId]["priority"] then
            button.aura.buff.temp.active=true
            button.aura.buff.temp.id=HealBot_Aura_ID[bName]
            button.aura.buff.temp.name=bName
            button.aura.buff.temp.priority=HealBot_AuraBuffCache[HealBot_Aura_ID[bName]]["priority"]
        end
    end
    --button.aura.buff.priority=21
end

local buffWatchName=""
local PlayerBuffsList={}
function HealBot_Aura_CheckGeneralBuff(button)
      --HealBot_setCall("HealBot_Aura_CheckGeneralBuff", button)
    PlayerBuffsList=button.aura.buff.recheck
    for bName,nexttime in pairs (PlayerBuffsList) do
        if not PlayerBuffs[bName] then
            PlayerBuffsList[bName]=nil
            HealBot_Aura_MarkCheckBuffsTime(button)
        elseif nexttime < HealBot_TimeNow then
            PlayerBuffs[bName]=false
        end
    end
    for j=1, #HealBot_BuffWatchList do
        buffWatchName=HealBot_BuffWatchList[j]
        if HEALBOT_GAME_VERSION<4 and HealBot_BuffMinLevels[buffWatchName] then
            if button.level<HealBot_BuffMinLevels[buffWatchName] then
                PlayerBuffs[buffWatchName]=true
            end
        end
        if not PlayerBuffs[buffWatchName] and not HealBot_Aura_HasBuffTypes(buffWatchName, PlayerBuffTypes) then
            buffSpellStart, buffSpellDur=HealBot_WoWAPI_SpellCooldown(buffWatchName)
            if HealBot_Buff_ItemIDs[buffWatchName] and (not buffSpellStart or not buffSpellDur) then
                buffSpellStart, buffSpellDur=HealBot_GetItemCooldown(HealBot_Buff_ItemIDs[buffWatchName])
            end
            buffSpellStart=buffSpellStart or 0
            buffSpellDur=buffSpellDur or 0
            if (buffSpellStart+buffSpellDur)-HealBot_TimeNow<2 then
                buffCheckThis=false;
                buffWatchTarget=HealBot_Options_retBuffWatchTarget(buffWatchName) or "";
                if buffWatchTarget["Raid"] then
                    buffCheckThis=true;
                elseif buffWatchTarget["Self"] and button.player then
                    if HealBot_Aura_luVars["ManaDrink"]~=buffWatchName or button.mana.pct<HealBot_Config_Buffs.ManaDrinkThreshold then
                        buffCheckThis=true
                    end
                elseif buffWatchTarget["Party"] and button.group == HealBot_Data["PLAYERGROUP"] then 
                    buffCheckThis=true
                elseif buffWatchTarget["Solo"] and not IsInRaid() and not IsInGroup() then
                    buffCheckThis=true
                elseif buffWatchTarget["MainTanks"] and HealBot_Panel_IsTank(button.guid) then
                    buffCheckThis=true;
                elseif buffWatchTarget["SingleTank"] and button.guid == HealBot_Aura_luVars["TankGUID1"] then
                    buffCheckThis=true
                elseif buffWatchTarget[button.text.classtrim] then
                    buffCheckThis=true
                elseif buffWatchTarget["Name"] and button.guid == HealBot_Config.MyFriend then
                    buffCheckThis=true
                elseif buffWatchTarget["Focus"] and UnitIsUnit(button.unit, "focus") then
                    buffCheckThis=true
                elseif buffWatchTarget["PvP"] and UnitIsPVP(button.unit) then
                    buffCheckThis=true
                elseif buffWatchTarget["PvE"] and not UnitIsPVP(button.unit) then
                    buffCheckThis=true
                elseif buffWatchTarget["MyTargets"] and HealBot_Panel_IsMyTarget(button.guid) then
                    buffCheckThis=true;
                end
                if buffCheckThis then
                    HealBot_Aura_SetGeneralBuff(button, buffWatchName)
                    break
                end
            else
                button.aura.buff.recheck[buffWatchName]=(HealBot_TimeNow-buffSpellStart)+buffSpellDur
                HealBot_Aura_MarkCheckBuffsTime(button)
            end
        end
    end
    if button.player and (HealBot_Weapon_Enchant[1] or HealBot_Weapon_Enchant[2]) and not button.aura.buff.missingbuff and (not HealBot_Config_Buffs.ExtraBuffsOnlyInInstance or IsInInstance()) then
        weaponEnchantState[1]["Active"], weaponEnchantState[1]["Expire"], _, _, weaponEnchantState[2]["Active"], weaponEnchantState[2]["Expire"]=GetWeaponEnchantInfo()
        -- local hasMainHandEnchant, mainHandExpiration, _, mainHandEnchantID, hasOffHandEnchant, offHandExpiration, _, offHandEnchantID=GetWeaponEnchantInfo()
        for x=1,2 do
            if HealBot_Weapon_Enchant[x] then
                if weaponEnchantState[x]["Active"] then
                    if not weaponEnchantState[x]["Expire"] then weaponEnchantState[x]["Expire"]=30*60*1000 end
                    if (weaponEnchantState[x]["Expire"]/1000)<HealBot_Config_Buffs.LongBuffTimer then
                        HealBot_Aura_SetGeneralBuff(button, HealBot_Weapon_Enchant[x])
                    else
                        button.aura.buff.recheck[HealBot_Weapon_Enchant[x]]=ceil(HealBot_TimeNow+(weaponEnchantState[x]["Expire"]/1000)-HealBot_Config_Buffs.LongBuffTimer)
                        if not button.aura.buff.nextcheck or button.aura.buff.nextcheck>button.aura.buff.recheck[HealBot_Weapon_Enchant[x]] then
                            HealBot_Aura_MarkCheckBuffsTime(button)
                        end
                    end
                else
                    HealBot_Aura_SetGeneralBuff(button, HealBot_Weapon_Enchant[x])
                    button.aura.buff.recheck[HealBot_Weapon_Enchant[x]]=nil
                    HealBot_Aura_MarkCheckBuffsTime(button)
                end
            end
        end
    end
end

local hbCustomBuffsDisabled={}
function HealBot_Aura_setCustomBuffFilterDisabled()
      --HealBot_setCall("HealBot_Aura_setCustomBuffFilterDisabled")
    for id,_ in pairs(hbCustomBuffsDisabled) do
        hbCustomBuffsDisabled[id]=false
    end
    for id, _ in pairs(HealBot_Globals.IgnoreCustomBuff) do
        local name=HealBot_WoWAPI_SpellName(id)
        if (HealBot_Globals.CustomBuffIDMethod[id] or 3)<3 then
            if HealBot_Globals.CustomBuffIDMethod[id] == 1 then
                hbCustomBuffsDisabled[id]={}
            elseif name then 
                hbCustomBuffsDisabled[name]={}
            end
        else
            if name then hbCustomBuffsDisabled[name]={} end
            hbCustomBuffsDisabled[id]={}
        end
        for instName, disabled in pairs(HealBot_Globals.IgnoreCustomBuff[id]) do
            if (HealBot_Globals.CustomBuffIDMethod[id] or 3)<3 then
                if HealBot_Globals.CustomBuffIDMethod[id] == 1 then
                    hbCustomBuffsDisabled[id][instName]=disabled
                elseif name then 
                    hbCustomBuffsDisabled[name][instName]=disabled
                end
            else
                if name then hbCustomBuffsDisabled[name][instName]=disabled end
                hbCustomBuffsDisabled[id][instName]=disabled
            end
        end
    end
    for id,_ in pairs(hbCustomBuffsDisabled) do
        if not hbCustomBuffsDisabled[id] then hbCustomBuffsDisabled[id]=nil end
    end
    HealBot_Timers_Set("AURA","DeleteExcludeBuffInCache")
end

local buffCustomType,scbUnitClassEN=false,"XXXX"
function HealBot_Aura_ShowCustomBuff(button)
      --HealBot_setCall("HealBot_Aura_ShowCustomBuff", button)
    if (hbCustomBuffsDisabled[uaBuffData[button.id][uaBuffSlot].spellId] and (hbCustomBuffsDisabled[uaBuffData[button.id][uaBuffSlot].spellId][HealBot_Aura_luVars["mapName"]] or hbCustomBuffsDisabled[uaBuffData[button.id][uaBuffSlot].spellId]["ALL"])) or
       (hbCustomBuffsDisabled[uaBuffData[button.id][uaBuffSlot].name] and (hbCustomBuffsDisabled[uaBuffData[button.id][uaBuffSlot].name][HealBot_Aura_luVars["mapName"]] or hbCustomBuffsDisabled[uaBuffData[button.id][uaBuffSlot].name]["ALL"])) then
       return false, true, true
    else
        buffCustomType=HealBot_Watch_HoT[uaBuffData[button.id][uaBuffSlot].name] or HealBot_Watch_HoT[uaBuffData[button.id][uaBuffSlot].spellId] or false
        if buffCustomType then
            if buffCustomType == "S" then
                if uaBuffData[button.id][uaBuffSlot].sourceUnitIsPlayer then
                    HealBot_Options_MissingBuffPrio(uaBuffData[button.id][uaBuffSlot].spellId)
                    return true, true, false
                else
                    return false, true, false
                end
            elseif buffCustomType == "C" then
                _, scbUnitClassEN=UnitClass(uaBuffData[button.id][uaBuffSlot].sourceUnit)
                if scbUnitClassEN and HealBot_Data["PCLASSTRIM"] == strsub(scbUnitClassEN,1,4) then
                    HealBot_Options_MissingBuffPrio(uaBuffData[button.id][uaBuffSlot].spellId)
                    HealBot_AuraBuffCache[uaBuffData[button.id][uaBuffSlot].spellId].always=true
                    return true, true, false
                else
                    return false, true, true
                end
            elseif buffCustomType == "A" then
                HealBot_Options_MissingBuffPrio(uaBuffData[button.id][uaBuffSlot].spellId)
                HealBot_AuraBuffCache[uaBuffData[button.id][uaBuffSlot].spellId].always=true
                return true, true, false
            end
        else
            if uaBuffData[button.id][uaBuffSlot].expirationTime>0 then
                if HealBot_Config_Buffs.AutoBuff == 3 or (HealBot_Config_Buffs.AutoBuff == 2 and uaBuffData[button.id][uaBuffSlot].duration<HealBot_Config_Buffs.AutoBuffExpireTime) then
                    if HealBot_Config_Buffs.AutoBuffCastBy == 1 then
                        if uaBuffData[button.id][uaBuffSlot].sourceUnitIsPlayer then
                            HealBot_AuraBuffCache[uaBuffData[button.id][uaBuffSlot].spellId].isAuto=true
                            return true, true, false
                        else
                            return false, true, false
                        end
                    elseif HealBot_Config_Buffs.AutoBuffCastBy == 3 then
                        HealBot_AuraBuffCache[uaBuffData[button.id][uaBuffSlot].spellId].always=true
                        HealBot_AuraBuffCache[uaBuffData[button.id][uaBuffSlot].spellId].isAuto=true
                        return true, true, false
                    else
                        _, scbUnitClassEN=UnitClass(uaBuffData[button.id][uaBuffSlot].sourceUnit)
                        if scbUnitClassEN and HealBot_Data["PCLASSTRIM"] == strsub(scbUnitClassEN,1,4) then
                            HealBot_AuraBuffCache[uaBuffData[button.id][uaBuffSlot].spellId].always=true
                            HealBot_AuraBuffCache[uaBuffData[button.id][uaBuffSlot].spellId].isAuto=true
                            return true, true, false
                        else
                            return false, true, true
                        end
                    end
                end
            end
            return false, false, true
        end
    end
    return false, false, false
end

local ciCurrentBuff,ciCustomBuff,ciCanExclude=false,true
function HealBot_Aura_CheckCurBuff(button)
      --HealBot_setCall("HealBot_Aura_CheckCurBuff", button)
    ciCurrentBuff,ciCustomBuff,ciCanExclude=HealBot_Aura_ShowCustomBuff(button)
    if HealBot_BuffWatch[uaBuffData[button.id][uaBuffSlot].name] or HealBot_BuffNameTypes[uaBuffData[button.id][uaBuffSlot].name] then
        ciCurrentBuff=true
    end
    return ciCurrentBuff, ciCustomBuff, ciCanExclude
end

local buffIconIdx,buffIconPrio=0,0
function HealBot_Aura_SortBuffIconSet(button, iconSet, sIndex)
      --HealBot_setCall("HealBot_Aura_SortBuffIconSet", button)
    button.icon.buff.count[iconSet]=#buffSort[iconSet]
    if button.icon.buff.count[iconSet]>0 then
        table.sort(buffSort[iconSet])
        if button.icon.buff.count[iconSet]>Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][button.frame][iconSet]["MAXBICONS"] then
            button.icon.buff.count[iconSet]=Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][button.frame][iconSet]["MAXBICONS"]
        end
        for j=1, button.icon.buff.count[iconSet], 1 do
            HealBot_Aura_CacheBuffIcon(button, sIndex+j, HealBot_AuraBuffXRef[buffSort[iconSet][j]]["spellID"], HealBot_AuraBuffXRef[buffSort[iconSet][j]]["slot"])
        end
        if HealBot_AuraBuffCache[HealBot_AuraBuffXRef[buffSort[iconSet][1]]["spellID"]]["priority"]<buffIconPrio then
            buffIconIdx=sIndex+1
            buffIconPrio=HealBot_AuraBuffCache[HealBot_AuraBuffXRef[buffSort[iconSet][1]]["spellID"]]["priority"]
        end
    end
end

function HealBot_Aura_SortBuffIcons(button)
      --HealBot_setCall("HealBot_Aura_SortBuffIcons", button)
    buffIconIdx,buffIconPrio=0,21
    if Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][button.frame][1]["MAXBICONS"]>0 then
        HealBot_Aura_SortBuffIconSet(button, 1, 0)
    end
    if Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][button.frame][2]["MAXBICONS"]>0 then
        HealBot_Aura_SortBuffIconSet(button, 2, 8)
    end
    if Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][button.frame][3]["MAXBICONS"]>0 then
        HealBot_Aura_SortBuffIconSet(button, 3, 10)
    end
    return buffIconIdx
end

local castByListIndexed={[HEALBOT_CUSTOM_CASTBY_EVERYONE]=1,
                         [HEALBOT_CUSTOM_CASTBY_ENEMY]=2,
                         [HEALBOT_CUSTOM_CASTBY_FRIEND]=3,
                         [HEALBOT_OPTIONS_SELFHEALS]=4,
                        }
function HealBot_Aura_setCDebuffCasyByIndexed(CDebuffCasyByList)
      --HealBot_setCall("HealBot_Aura_setCDebuffCasyByIndexed")
    castByListIndexed=CDebuffCasyByList
end

function HealBot_Aura_setCustomDebuffFilterCastBy()
      --HealBot_setCall("HealBot_Aura_setCustomDebuffFilterCastBy")
    for id,_ in pairs(hbCustomDebuffsCastBy) do
        hbCustomDebuffsCastBy[id]=false
    end
    for id, x in pairs(HealBot_Globals.FilterCustomDebuff) do
        local name=HealBot_WoWAPI_SpellName(id)
        if (HealBot_Globals.CustomDebuffIDMethod[id] or 3)<3 then
            if HealBot_Globals.CustomDebuffIDMethod[id] == 1 then
                hbCustomDebuffsCastBy[id]=x
            elseif name then 
                hbCustomDebuffsCastBy[name]=x
            end
        else
            if name then hbCustomDebuffsCastBy[name]=x end
            hbCustomDebuffsCastBy[id]=x
        end
    end
    for id,_ in pairs(hbCustomDebuffsCastBy) do
        if not hbCustomDebuffsCastBy[id] then hbCustomDebuffsCastBy[id]=nil end
    end
    HealBot_Timers_Set("AURA","CheckDebuffs")
end

function HealBot_Aura_setCustomDebuffFilterDisabled()
      --HealBot_setCall("HealBot_Aura_setCustomDebuffFilterDisabled")
    for id,_ in pairs(hbCustomDebuffsDisabled) do
        hbCustomDebuffsDisabled[id]=false
    end
    for id, _ in pairs(HealBot_Globals.IgnoreCustomDebuff) do
        local name=HealBot_WoWAPI_SpellName(id)
        if (HealBot_Globals.CustomDebuffIDMethod[id] or 3)<3 then
            if HealBot_Globals.CustomDebuffIDMethod[id] == 1 then
                hbCustomDebuffsDisabled[id]={}
            elseif name then 
                hbCustomDebuffsDisabled[name]={}
            end
        else
            if name then hbCustomDebuffsDisabled[name]={} end
            hbCustomDebuffsDisabled[id]={}
        end
        for instName, disabled in pairs(HealBot_Globals.IgnoreCustomDebuff[id]) do
            if disabled then
                if (HealBot_Globals.CustomDebuffIDMethod[id] or 3)<3 then
                    if HealBot_Globals.CustomDebuffIDMethod[id] == 1 then
                        hbCustomDebuffsDisabled[id][instName]=disabled
                    elseif name then 
                        hbCustomDebuffsDisabled[name][instName]=disabled
                    end
                else
                    if name then hbCustomDebuffsDisabled[name][instName]=disabled end
                    hbCustomDebuffsDisabled[id][instName]=disabled
                end
            end
        end
    end
    for id,_ in pairs(hbCustomDebuffsDisabled) do
        if not hbCustomDebuffsDisabled[id] then hbCustomDebuffsDisabled[id]=nil end
    end
    HealBot_Timers_Set("AURA","CheckDebuffs")
end

local cureSpellCD, cureSpellName=0, ""
local debuffIsCurrent, cDebuffPrio=true, 15
local ccdbCasterID, ccdbUnitCasterID, ccdbCheckthis, ccdbAlways=0,1,false,false
local ccdbWatchTarget={}
function HealBot_Aura_CheckCurCustomDebuff(button, canBeAlways)
      --HealBot_setCall("HealBot_Aura_CheckCurCustomDebuff", button)
    ccdbCasterID=hbCustomDebuffsCastBy[uaDebuffData[button.id][uaDebuffSlot].spellId] or hbCustomDebuffsCastBy[uaDebuffData[button.id][uaDebuffSlot].name] or HealBot_Globals.CureCustomDefaultCastBy
    if ccdbCasterID~=castByListIndexed[HEALBOT_CUSTOM_CASTBY_EVERYONE] then
        if uaDebuffData[button.id][uaDebuffSlot].sourceUnitIsPlayer then
            ccdbUnitCasterID=castByListIndexed[HEALBOT_OPTIONS_SELFHEALS]
            if ccdbCasterID == castByListIndexed[HEALBOT_CUSTOM_CASTBY_FRIEND] then 
                ccdbCasterID=castByListIndexed[HEALBOT_OPTIONS_SELFHEALS]
            end
        elseif UnitIsFriend("player",uaDebuffData[button.id][uaDebuffSlot].sourceUnit) then
            ccdbUnitCasterID=castByListIndexed[HEALBOT_CUSTOM_CASTBY_FRIEND]
        else
            ccdbUnitCasterID=castByListIndexed[HEALBOT_CUSTOM_CASTBY_ENEMY]
        end
        if ccdbUnitCasterID == ccdbCasterID then 
            HealBot_AuraDebuffCache[uaDebuffData[button.id][uaDebuffSlot].spellId]["debuffType"]=HEALBOT_CUSTOM_en
            cDebuffPrio=HealBot_AuraDebuffCache[uaDebuffData[button.id][uaDebuffSlot].spellId]["customPrio"]
        else
            debuffIsCurrent=false
        end
    else
        HealBot_AuraDebuffCache[uaDebuffData[button.id][uaDebuffSlot].spellId]["debuffType"]=HEALBOT_CUSTOM_en
        cDebuffPrio=HealBot_AuraDebuffCache[uaDebuffData[button.id][uaDebuffSlot].spellId]["customPrio"]
        if canBeAlways then
            HealBot_AuraDebuffCache[uaDebuffData[button.id][uaDebuffSlot].spellId].always=true 
        end
    end
end

function HealBot_Aura_setDebuffXRefUID(uid, spellID, slot)
    if not HealBot_AuraDebuffXRef[uid] then HealBot_AuraDebuffXRef[uid]={} end
    HealBot_AuraDebuffXRef[uid]["spellID"]=spellID
    HealBot_AuraDebuffXRef[uid]["slot"]=slot
    table.insert(debuffSort[HealBot_Aura_IconSet[spellID]],uid)
end

function HealBot_Aura_CheckCurDebuff(button)
      --HealBot_setCall("HealBot_Aura_CheckCurDebuff", button)
    debuffIsCurrent, cDebuffPrio=true, 20
    if (hbCustomDebuffsDisabled[uaDebuffData[button.id][uaDebuffSlot].spellId] and (hbCustomDebuffsDisabled[uaDebuffData[button.id][uaDebuffSlot].spellId][HealBot_Aura_luVars["mapName"]] or hbCustomDebuffsDisabled[uaDebuffData[button.id][uaDebuffSlot].spellId]["ALL"])) or
       (hbCustomDebuffsDisabled[uaDebuffData[button.id][uaDebuffSlot].name] and (hbCustomDebuffsDisabled[uaDebuffData[button.id][uaDebuffSlot].name][HealBot_Aura_luVars["mapName"]] or hbCustomDebuffsDisabled[uaDebuffData[button.id][uaDebuffSlot].name]["ALL"])) then
        debuffIsCurrent=false
    elseif HealBot_AuraDebuffCache[uaDebuffData[button.id][uaDebuffSlot].spellId]["typePrio"]>HealBot_AuraDebuffCache[uaDebuffData[button.id][uaDebuffSlot].spellId]["customPrio"] and HealBot_AuraDebuffCache[uaDebuffData[button.id][uaDebuffSlot].spellId]["customPrio"]<21 then
        HealBot_Aura_CheckCurCustomDebuff(button, true)
    else
        ccdbCheckthis=false
        if HealBot_AuraDebuffCache[uaDebuffData[button.id][uaDebuffSlot].spellId]["typePrio"]<21 and
          (not HealBot_Config_Cures.IgnoreCannotDispell or HealBot_Aura_CanDispel[uaDebuffData[button.id][uaDebuffSlot].spellId]) and
          (not hbDebuffOnCD[uaDebuffData[button.id][uaDebuffSlot].debuffType] or hbDebuffOnCD[uaDebuffData[button.id][uaDebuffSlot].debuffType]<HealBot_TimeNow) and 
          (not HealBot_Config_Cures.IgnoreFriendDebuffs or not UnitIsFriend("player",uaDebuffData[button.id][uaDebuffSlot].sourceUnit)) and
          (uaDebuffData[button.id][uaDebuffSlot].duration == 0 or uaDebuffData[button.id][uaDebuffSlot].duration>=HealBot_Aura_luVars["IgnoreFastDurDebuffsSecs"]) then
            ccdbWatchTarget=HealBot_Options_retDebuffWatchTarget(uaDebuffData[button.id][uaDebuffSlot].debuffType);
            if ccdbWatchTarget then
                if ccdbWatchTarget["Raid"] then
                    ccdbCheckthis=true;
                    if not HealBot_Config_Cures.IgnoreOnCooldownDebuffs then HealBot_AuraDebuffCache[uaDebuffData[button.id][uaDebuffSlot].spellId].always=true end
                elseif ccdbWatchTarget["Party"] and button.group == HealBot_Data["PLAYERGROUP"] then 
                    ccdbCheckthis=true;
                elseif ccdbWatchTarget["MainTanks"] and HealBot_Panel_IsTank(button.guid) then
                    ccdbCheckthis=true;
                elseif ccdbWatchTarget["SingleTank"] and button.guid == HealBot_Aura_luVars["TankGUID1"] then
                    ccdbCheckthis=true
                elseif ccdbWatchTarget["Self"] and button.player then
                    ccdbCheckthis=true
                elseif ccdbWatchTarget["Solo"] and not IsInRaid() and not IsInGroup() then
                    ccdbCheckthis=true
                elseif ccdbWatchTarget[button.text.classtrim] then
                    ccdbCheckthis=true;
                elseif ccdbWatchTarget["Name"] and button.guid == HealBot_Config.MyFriend then
                    ccdbCheckthis=true
                elseif ccdbWatchTarget["Focus"] and UnitIsUnit(button.unit, "focus") then
                    ccdbCheckthis=true;
                elseif ccdbWatchTarget["PvP"] and UnitIsPVP(button.unit) then
                    ccdbCheckthis=true
                elseif ccdbWatchTarget["PvE"] and not UnitIsPVP(button.unit) then
                    ccdbCheckthis=true
                elseif ccdbWatchTarget["MyTargets"] and HealBot_Panel_IsMyTarget(button.guid) then
                    ccdbCheckthis=true
                end
            end
        end
        if ccdbCheckthis and HealBot_AuraDebuffCache[uaDebuffData[button.id][uaDebuffSlot].spellId]["typePrio"]<16 then
            cDebuffPrio=HealBot_AuraDebuffCache[uaDebuffData[button.id][uaDebuffSlot].spellId]["typePrio"]
            HealBot_AuraDebuffCache[uaDebuffData[button.id][uaDebuffSlot].spellId]["debuffType"]=uaDebuffData[button.id][uaDebuffSlot].debuffType
        elseif (not UnitIsFriend("player",uaDebuffData[button.id][uaDebuffSlot].sourceUnit) and uaDebuffData[button.id][uaDebuffSlot].isBossAura and HealBot_Config_Cures.AlwaysShowBoss and UnitExists("boss1")) or 
           (HealBot_Config_Cures.AlwaysShowTimed and uaDebuffData[button.id][uaDebuffSlot].duration>0 and uaDebuffData[button.id][uaDebuffSlot].duration<HealBot_Config_Cures.ShowTimeMaxDuration) or 
           (HealBot_Config_Cures.HealBot_Custom_Debuffs_All[uaDebuffData[button.id][uaDebuffSlot].debuffType]) then
            HealBot_AuraDebuffCache[uaDebuffData[button.id][uaDebuffSlot].spellId]["debuffType"]=HEALBOT_CUSTOM_en
            cDebuffPrio=15
            HealBot_AuraDebuffCache[uaDebuffData[button.id][uaDebuffSlot].spellId].isAuto=true
            if HealBot_AuraDebuffCache[uaDebuffData[button.id][uaDebuffSlot].spellId]["typePrio"]>15 then
                HealBot_AuraDebuffCache[uaDebuffData[button.id][uaDebuffSlot].spellId].always=true
            end
        elseif ccdbCheckthis then
            cDebuffPrio=HealBot_AuraDebuffCache[uaDebuffData[button.id][uaDebuffSlot].spellId]["typePrio"]
        elseif HealBot_AuraDebuffCache[uaDebuffData[button.id][uaDebuffSlot].spellId]["customPrio"]<21 then
            HealBot_Aura_CheckCurCustomDebuff(button, false)
        elseif uaDebuffData[button.id][uaDebuffSlot].sourceUnitIsPlayer and not UnitIsFriend("player",button.unit) then
            HealBot_AuraDebuffCache[uaDebuffData[button.id][uaDebuffSlot].spellId]["debuffType"]=HEALBOT_CUSTOM_en
            cDebuffPrio=20
        else
            debuffIsCurrent=false
        end
    end
    if debuffIsCurrent and HealBot_AuraDebuffCache[uaDebuffData[button.id][uaDebuffSlot].spellId]["priority"]~=cDebuffPrio then
        HealBot_AuraDebuffCache[uaDebuffData[button.id][uaDebuffSlot].spellId]["priority"]=cDebuffPrio
        if HealBot_AuraDebuffCache[uaDebuffData[button.id][uaDebuffSlot].spellId]["priority"]<10 then
            HealBot_AuraDebuffCache[uaDebuffData[button.id][uaDebuffSlot].spellId]["pid"]="x0"..HealBot_AuraDebuffCache[uaDebuffData[button.id][uaDebuffSlot].spellId]["priority"]..uaDebuffData[button.id][uaDebuffSlot].spellId
        else
            HealBot_AuraDebuffCache[uaDebuffData[button.id][uaDebuffSlot].spellId]["pid"]="x"..HealBot_AuraDebuffCache[uaDebuffData[button.id][uaDebuffSlot].spellId]["priority"]..uaDebuffData[button.id][uaDebuffSlot].spellId
        end
    end
    return debuffIsCurrent
end

function HealBot_Aura_AuxSetAuraBuffBars(button)
        --HealBot_setCall("HealBot_Aura_AuxSetAuraBuffBars", button)
    HealBot_Aux_UpdateAuraBuffBars(button)
    if HealBot_Aura_AuxAssigns["NameOverlayBuff"][button.frame] then
        HealBot_Aux_UpdateNameOverLay(button, 8, true)
    end
    if HealBot_Aura_AuxAssigns["HealthOverlayBuff"][button.frame] then
        HealBot_Aux_UpdateHealthOverLay(button, 8, true)
    end
end

function HealBot_Aura_AuxClearAuraBuffBars(button)
        --HealBot_setCall("HealBot_Aura_AuxClearAuraBuffBars", button)
    HealBot_Aux_ClearAuraBuffBars(button)
    if HealBot_Aura_AuxAssigns["NameOverlayBuff"][button.frame] then
        HealBot_Aux_UpdateNameOverLay(button, 8, false)
    end
    if HealBot_Aura_AuxAssigns["HealthOverlayBuff"][button.frame] then
        HealBot_Aux_UpdateHealthOverLay(button, 8, false)
    end
end

function HealBot_Aura_BuffWarnings(button, buffName, force)
        --HealBot_setCall("HealBot_Aura_BuffWarnings", button)
    if button.aura.buff.name~=buffName or force then
        button.aura.buff.name=buffName
        HealBot_Emerg_Button[button.id].buffupdate=true
        button.aura.buff.r,button.aura.buff.g,button.aura.buff.b=HealBot_Options_RetBuffRGB(button)
        if HealBot_Range_WarnInRange(button, button.aura.buff.name, HealBot_Config_Buffs.WarnRange_Bar) then
            if button.aura.buff.colbar == 4 then
                HealBot_Action_EnableBorderHazardType(button, button.aura.buff.r, button.aura.buff.g, button.aura.buff.b, "BUFF")
            elseif button.hazard.buff then
                HealBot_Action_DisableBorderHazardType(button, "BUFF")
            end
            if button.aura.buff.colbar>4 then
                HealBot_Action_EnableButtonGlowType(button, button.aura.buff.r, button.aura.buff.g, button.aura.buff.b, "BUFF", "", button.aura.buff.colbar)
            elseif button.glow.buff then
                HealBot_Action_DisableButtonGlowType(button, "BUFF")
            end
            if button.aura.buff.colbar>0 then 
                HealBot_Aura_AuxSetAuraBuffBars(button)
            else
                HealBot_Aura_AuxClearAuraBuffBars(button)
            end
        else
            if button.hazard.buff then HealBot_Action_DisableBorderHazardType(button, "BUFF") end
            if button.glow.buff then HealBot_Action_DisableButtonGlowType(button, "BUFF") end
            HealBot_Aura_AuxClearAuraBuffBars(button) 
        end
        if button.mouseover and HealBot_Data["TIPBUTTON"] then 
            HealBot_setTooltipUpdateNow()
        end
        if buffWarnings and (not HealBot_Aura_WarningFilter[button.unit][buffName] or HealBot_Aura_WarningFilter[button.unit][buffName]<HealBot_TimeNow) then
            if button.aura.buff.missingbuff and HealBot_BuffWatch[button.aura.buff.name] then
                HealBot_Aura_WarningFilter[button.unit][buffName]=HealBot_TimeNow+1
            else
                HealBot_Aura_WarningFilter[button.unit][buffName]=curBuffxTime[buffName] or HealBot_TimeNow+5
            end
            if HealBot_Config_Buffs.ShowBuffWarning and (button.aura.buff.missingbuff or not HealBot_Config_Buffs.ShowBuffWarningMissingOnly) and
               HealBot_Range_WarnInRange(button, button.aura.buff.name, HealBot_Config_Buffs.WarnRange_Screen) then
                UIErrorsFrame:AddMessage(button.text.nameonly.." requires "..button.aura.buff.name, 
                                         button.aura.buff.r, button.aura.buff.g, button.aura.buff.b, 1, UIERRORS_HOLD_TIME);
            end
            if HealBot_Config_Buffs.SoundBuffWarning and (button.aura.buff.missingbuff or not HealBot_Config_Buffs.SoundBuffWarningMissingOnly) and
               HealBot_Range_WarnInRange(button, button.aura.buff.name, HealBot_Config_Buffs.WarnRange_Sound) then
                HealBot_Media_PlaySound(HealBot_Config_Buffs.SoundBuffPlay)
            end
        end
        HealBot_RefreshUnit(button)
    end
end

function HealBot_Aura_AuxSetAuraDebuffBars(button)
        --HealBot_setCall("HealBot_Aura_AuxSetAuraDebuffBars", button)
    HealBot_Aux_UpdateAuraDebuffBars(button)
    if HealBot_Aura_AuxAssigns["NameOverlayDebuff"][button.frame] then
        HealBot_Aux_UpdateNameOverLay(button, 3, true)
    end
    if HealBot_Aura_AuxAssigns["HealthOverlayDebuff"][button.frame] then
        HealBot_Aux_UpdateHealthOverLay(button, 3, true)
    end
end

function HealBot_Aura_AuxClearAuraDebuffBars(button)
        --HealBot_setCall("HealBot_Aura_AuxClearAuraDebuffBars", button)
    HealBot_Aux_ClearAuraDebuffBars(button)
    if HealBot_Aura_AuxAssigns["NameOverlayDebuff"][button.frame] then
        HealBot_Aux_UpdateNameOverLay(button, 3, false)
    end
    if HealBot_Aura_AuxAssigns["HealthOverlayDebuff"][button.frame] then
        HealBot_Aux_UpdateHealthOverLay(button, 3, false)
    end
end

function HealBot_Aura_IsCureSpell(button)
        --HealBot_setCall("HealBot_Aura_IsCureSpell", button)
    if button.aura.debuff.curespell and HealBot_Spells_KnownByName(button.aura.debuff.curespell) then
        return true
    else
        return false
    end
end

function HealBot_Aura_DebuffWarnings(button, debuffName, force, debuffIconIndex)
        --HealBot_setCall("HealBot_Aura_DebuffWarnings", button)
    if button.aura.debuff.name~=debuffName or force then
        button.aura.debuff.name=debuffName
        if HealBot_Text_TagInUse(button.framecol, "DEBUFF") then
            HealBot_Text_setNameTag(button)
        end
        HealBot_Emerg_Button[button.id].debuffupdate=true
        button.aura.debuff.r,button.aura.debuff.g,button.aura.debuff.b=HealBot_Options_RetDebuffRGB(button)
        button.aura.debuff.curespell=HealBot_Options_retDebuffCureSpell(button.aura.debuff.type)
        if HealBot_Range_WarnInRange(button, button.aura.debuff.curespell, HealBot_Config_Cures.WarnRange_Bar) then
            if button.aura.debuff.colbar == 4 then
                HealBot_Action_EnableBorderHazardType(button, button.aura.debuff.r, button.aura.debuff.g, button.aura.debuff.b, "DEBUFF")
            elseif button.hazard.debuff then
                HealBot_Action_DisableBorderHazardType(button, "DEBUFF")
            end
            if button.aura.debuff.colbar>4 then
                HealBot_Action_EnableButtonGlowType(button, button.aura.debuff.r, button.aura.debuff.g, button.aura.debuff.b, "DEBUFF", "", button.aura.debuff.colbar)
            elseif button.glow.debuff then
                HealBot_Action_DisableButtonGlowType(button, "DEBUFF")
            end
            if button.aura.debuff.colbar>0 then 
                HealBot_Aura_AuxSetAuraDebuffBars(button) 
            else
                HealBot_Aura_AuxClearAuraDebuffBars(button)
            end
        else
            if button.hazard.debuff then HealBot_Action_DisableBorderHazardType(button, "DEBUFF") end
            if button.glow.debuff then HealBot_Action_DisableButtonGlowType(button, "DEBUFF") end
            HealBot_Aura_AuxClearAuraDebuffBars(button)
        end
        if button.mouseover and HealBot_Data["TIPBUTTON"] then 
            HealBot_setTooltipUpdateNow()
        end
        if button.status.range>0 and button.isplayer and button.frame<10 and button.aura.debuff.priority<=HealBot_Aura_retLuVars("HotBarDebuff") then
            HealBot_Action_BarHotEnable(button, "DEBUFF")
        elseif button.hotbars.debuff then
            HealBot_Action_BarHotDisable(button, "DEBUFF")
        end
        if debuffWarnings and (not HealBot_Aura_WarningFilter[button.unit][button.aura.debuff.name] or HealBot_Aura_WarningFilter[button.unit][button.aura.debuff.name]<HealBot_TimeNow) then
            if debuffIconIndex == 0 then debuffIconIndex=51 end
            HealBot_Aura_WarningFilter[button.unit][button.aura.debuff.name]=HealBot_UnitDebuffIcons[button.id][debuffIconIndex]["expirationTime"]
            if HealBot_Config_Cures.ShowDebuffWarning and (button.aura.debuff.dispellable or not HealBot_Config_Cures.ShowDebuffWarningDispelOnly) then
                if HealBot_Range_WarnInRange(button, button.aura.debuff.curespell, HealBot_Config_Cures.WarnRange_Screen) and type(button.aura.debuff.name) == "string" then
                    UIErrorsFrame:AddMessage(button.text.nameonly.." suffers from "..button.aura.debuff.name, 
                                             button.aura.debuff.r,button.aura.debuff.g,button.aura.debuff.b, 1, UIERRORS_HOLD_TIME);
                end
            end
            if HealBot_Config_Cures.SoundDebuffWarning and (button.aura.debuff.dispellable or not HealBot_Config_Cures.SoundDebuffWarningDispelOnly) then
                if HealBot_Range_WarnInRange(button, button.aura.debuff.curespell, HealBot_Config_Cures.WarnRange_Sound) then
                    HealBot_Media_PlaySound(HealBot_Config_Cures.SoundDebuffPlay)
                end
            end
        end
        HealBot_RefreshUnit(button)
    end
end

local asbtPrevEndTime=0
function HealBot_Aura_SetUnitBuffTimer(button)
      --HealBot_setCall("HealBot_Aura_SetUnitBuffTimer", button)
    asbtPrevEndTime=button.aura.buff.recheck[uaBuffData[button.id][uaBuffSlot].name] or 0
    if HealBot_ShortBuffs[uaBuffData[button.id][uaBuffSlot].name] then 
        button.aura.buff.recheck[uaBuffData[button.id][uaBuffSlot].name]=uaBuffData[button.id][uaBuffSlot].expirationTime-HealBot_Config_Buffs.ShortBuffTimer
    else
        button.aura.buff.recheck[uaBuffData[button.id][uaBuffSlot].name]=uaBuffData[button.id][uaBuffSlot].expirationTime-HealBot_Config_Buffs.LongBuffTimer
    end
    if asbtPrevEndTime~=button.aura.buff.recheck[uaBuffData[button.id][uaBuffSlot].name] then
        HealBot_Aura_MarkCheckBuffsTime(button)
    end
end

function HealBot_Aura_CheckUnitBuffIcons(button)
      --HealBot_setCall("HealBot_Aura_CheckUnitBuffIcons", button)
    for i=1,8 do
        if i<=button.icon.buff.count[1] then
            if not HealBot_UnitBuffIcons[button.id][i].current then
                HealBot_UnitBuffIcons[button.id][i].current=true
                HealBot_Aura_AddBuffIcon(button, i)
            end
        elseif i<=HealBot_Aura_prevIconCount["BUFF"][1] then
            HealBot_Aura_RemoveIcon(button, i)
        else
            break
        end
    end
    for i=9,10 do
        if i<=(8+button.icon.buff.count[2]) then
            if not HealBot_UnitBuffIcons[button.id][i].current then
                HealBot_UnitBuffIcons[button.id][i].current=true
                HealBot_Aura_AddBuffIcon(button, i)
            end
        elseif i<=(8+HealBot_Aura_prevIconCount["BUFF"][2]) then
            HealBot_Aura_RemoveIcon(button, i)
        else
            break
        end
    end
    for i=11,12 do
        if i<=(10+button.icon.buff.count[3]) then
            if not HealBot_UnitBuffIcons[button.id][i].current then
                HealBot_UnitBuffIcons[button.id][i].current=true
                HealBot_Aura_AddBuffIcon(button, i)
            end
        elseif i<=(10+HealBot_Aura_prevIconCount["BUFF"][3]) then
            HealBot_Aura_RemoveIcon(button, i)
        else
            break
        end
    end
end

local hbAuraRequests={}
function HealBot_Aura_Requests(guid, buff)
      --HealBot_setCall("HealBot_Aura_Requests", nil, guid)
    if buff then
        if not hbAuraRequests[guid] then 
            hbAuraRequests[guid]={} 
            HealBot_Aura_AddWatch(guid)
        end
        hbAuraRequests[guid][buff]=true
    else
        hbAuraRequests[guid]=nil
        HealBot_Aura_DelWatch(guid)
    end
end

function HealBot_Aura_RequestsClear()
      --HealBot_setCall("HealBot_Aura_RequestsClear")
    hbAuraRequests={}
end

local hbAuraWatch={}
local hbAuraBuffWatch={}
local hbAuraBuffTagWatch={}
local hbAuraDebuffWatch={}
local hbAuraDebuffTagWatch={}
local hbAuraActionBuffWatch={}
local hbAuraActionBuffTagWatch={}
local hbAuraActionDebuffWatch={}
local hbAuraActionDebuffTagWatch={}

function HealBot_Aura_AddWatch(guid)
      --HealBot_setCall("HealBot_Aura_AddWatch", nil, guid)
    if not hbAuraWatch[guid] then
        hbAuraWatch[guid]=true
    end
end

function HealBot_Aura_DelWatch(guid)
      --HealBot_setCall("HealBot_Aura_DelWatch", nil, guid)
    if hbAuraWatch[guid] then
        if not hbAuraRequests[guid] and 
           not hbAuraBuffWatch[guid] and not hbAuraBuffTagWatch[guid] and not hbAuraActionBuffWatch[guid] and not hbAuraActionBuffTagWatch[guid] and 
           not hbAuraDebuffWatch[guid] and not hbAuraDebuffTagWatch[guid] and not hbAuraActionDebuffWatch[guid] and not hbAuraActionDebuffTagWatch[guid] then
            hbAuraWatch[guid]=nil
        end
    end
end

function HealBot_Aura_BuffWatch(guid, buff, active, actionicon)
      --HealBot_setCall("HealBot_Aura_BuffWatch", nil, guid)
    local hbbwa=nil
    if actionicon then
        hbbwa=hbAuraActionBuffWatch
    else
        hbbwa=hbAuraBuffWatch
    end
    if buff then
        if active then
            if not hbbwa[guid] then 
                hbbwa[guid]={}
                HealBot_Aura_AddWatch(guid)
            end
            if not hbbwa[guid][buff] then
                if HealBot_Aura_CurrentBuff(guid, buff) then
                    hbbwa[guid][buff]=1
                else
                    hbbwa[guid][buff]=0
                end
            end
        elseif hbbwa[guid] and hbbwa[guid][buff] then
            hbbwa[guid][buff]=nil
        end
    else
        hbbwa[guid]=nil
        HealBot_Aura_DelWatch(guid)
    end
end

function HealBot_Aura_BuffTagWatch(guid, tag, active, actionicon)
      --HealBot_setCall("HealBot_Aura_BuffTagWatch", nil, guid)
    local hbbwta=nil
    if actionicon then
        hbbwta=hbAuraActionBuffTagWatch
    else
        hbbwta=hbAuraBuffTagWatch
    end
    if tag then
        if active then
            if not hbbwta[guid] then 
                hbbwta[guid]={}
                HealBot_Aura_AddWatch(guid)
            end
            if not hbbwta[guid][tag] then
                hbbwta[guid][tag]=0
                if HealBot_UnitBuffCurrent[guid] then
                    for bName, _ in pairs(HealBot_UnitBuffCurrent[guid]) do
                        if (HealBot_BuffTagNames[bName] and HealBot_BuffTagNames[bName] == tag) or
                           (HealBot_Aura_ID[bName] and HealBot_Globals.CustomBuffTag[HealBot_Aura_ID[bName]] and HealBot_Globals.CustomBuffTag[HealBot_Aura_ID[bName]] == tag) then
                            hbbwta[guid][tag]=1
                            break
                        end
                    end
                end
            end
            --HealBot_AddDebug("Buff Tag="..tag,"AuraWatch",true)
        elseif hbbwta[guid] and hbbwta[guid][tag] then
            hbbwta[guid][tag]=nil
        end
    else
        hbbwta[guid]=nil
        HealBot_Aura_DelWatch(guid)
    end
end

function HealBot_Aura_AuraWatchClear()
      --HealBot_setCall("HealBot_Aura_AuraWatchClear")
    for guid,_ in pairs(hbAuraBuffWatch) do
        hbAuraBuffWatch[guid]=nil
        HealBot_Aura_DelWatch(guid)
    end
    for guid,_ in pairs(hbAuraBuffTagWatch) do
        hbAuraBuffWatch[guid]=nil
        hbAuraBuffTagWatch(guid)
    end
    for guid,_ in pairs(hbAuraDebuffWatch) do
        hbAuraBuffWatch[guid]=nil
        hbAuraDebuffWatch(guid)
    end
    for guid,_ in pairs(hbAuraDebuffTagWatch) do
        hbAuraBuffWatch[guid]=nil
        hbAuraDebuffTagWatch(guid)
    end
end

function HealBot_Aura_DebuffWatch(guid, debuff, active, actionicon)
      --HealBot_setCall("HealBot_Aura_DebuffWatch", nil, guid)
    local hbdwa=nil
    if actionicon then
        hbdwa=hbAuraActionDebuffWatch
    else
        hbdwa=hbAuraDebuffWatch
    end
    if debuff then
        if active then
            if not hbdwa[guid] then 
                hbdwa[guid]={}
                HealBot_Aura_AddWatch(guid)
            end
            if not hbdwa[guid][debuff] then
                if HealBot_Aura_CurrentDebuff(guid, debuff) then
                    hbdwa[guid][debuff]=1
                else
                    hbdwa[guid][debuff]=0
                end
            end
        elseif hbdwa[guid] and hbdwa[guid][debuff] then
            hbdwa[guid][debuff]=nil
        end
    else
        hbdwa[guid]=nil
        HealBot_Aura_DelWatch(guid)
    end
end

function HealBot_Aura_DebuffTagWatch(guid, tag, active, actionicon)
      --HealBot_setCall("HealBot_Aura_DebuffTagWatch", nil, guid)
    local hbdwta=nil
    if actionicon then
        hbdwta=hbAuraActionDebuffTagWatch
    else
        hbdwta=hbAuraDebuffTagWatch
    end
    if tag then
        if active then
            if not hbdwta[guid] then 
                hbdwta[guid]={}
                HealBot_Aura_AddWatch(guid)
            end
            if not hbdwta[guid][tag] then
                hbdwta[guid][tag]=0
                if HealBot_UnitDebuffCurrent[guid] then
                    for dName, _ in pairs(HealBot_UnitDebuffCurrent[guid]) do
                        if (HealBot_DebuffTagNames[dName] and HealBot_DebuffTagNames[dName] == tag) or
                           (HealBot_Aura_ID[dName] and HealBot_Globals.CDCTag[HealBot_Aura_ID[dName]] and HealBot_Globals.CDCTag[HealBot_Aura_ID[dName]] == tag) then
                            hbdwta[guid][tag]=1
                            break
                        end
                    end
                end
            end
        elseif hbdwta[guid] and hbdwta[guid][tag] then
            hbdwta[guid][tag]=nil
        end
    else
        hbdwta[guid]=nil
        HealBot_Aura_DelWatch(guid)
    end
end

function HealBot_Aura_CurrentBuffTag(guid, tag)
      --HealBot_setCall("HealBot_Aura_CurrentBuffTag", nil, guid)
    if hbAuraBuffTagWatch[guid] and (hbAuraBuffTagWatch[guid][tag] or 0) == 1 then
        return true
    else
        return false
    end
end

function HealBot_Aura_ActionIconBuffTag(guid, tag)
      --HealBot_setCall("HealBot_Aura_ActionIconBuffTag", nil, guid)
    if hbAuraActionBuffTagWatch[guid] and (hbAuraActionBuffTagWatch[guid][tag] or 0) == 1 then
        return true
    else
        return false
    end
end

function HealBot_Aura_CurrentBuff(guid, bName)
      --HealBot_setCall("HealBot_Aura_CurrentBuff", nil, guid)
    if HealBot_UnitBuffCurrent[guid] then
        return HealBot_UnitBuffCurrent[guid][bName]
    else
        return false
    end
end

function HealBot_Aura_CurrentDebuff(guid, dName)
      --HealBot_setCall("HealBot_Aura_CurrentDebuff", nil, guid)
    if HealBot_UnitDebuffCurrent[guid] then
        return HealBot_UnitDebuffCurrent[guid][dName]
    else
        return false
    end
end

function HealBot_Aura_CurrentDebuffTag(guid, tag)
      --HealBot_setCall("HealBot_Aura_CurrentDebuffTag", nil, guid)
    if hbAuraDebuffTagWatch[guid] and (hbAuraDebuffTagWatch[guid][tag] or 0) == 1 then
        return true
    else
        return false
    end
end

function HealBot_Aura_ActionIconDebuffTag(guid, tag)
      --HealBot_setCall("HealBot_Aura_ActionIconDebuffTag", nil, guid)
    if hbAuraActionDebuffTagWatch[guid] and (hbAuraActionDebuffTagWatch[guid][tag] or 0) == 1 then
        return true
    else
        return false
    end
end

local uaIsCurrent, uaIsCustom, uaNever, uaZ, tGeneralBuffs=false, false, false, 1, true
local onlyPlayers,prevMissingbuff=false,false
function HealBot_Aura_CheckUnitBuff(button)
      --HealBot_setCall("HealBot_Aura_CheckUnitBuff", button)
    if uaBuffData[button.id][uaBuffSlot].name == HEALBOT_SPIRIT_OF_REDEMPTION_NAME and button.health.current>0 then 
        C_Timer.After(0.1, function() HealBot_Action_UpdateTheDeadButton(button) end)
    end
    if HealBot_Buff_Aura2Item[uaBuffData[button.id][uaBuffSlot].name] then
        uaBuffData[button.id][uaBuffSlot].name=HealBot_WoWAPI_ItemInfo(HealBot_Buff_Aura2Item[uaBuffData[button.id][uaBuffSlot].name]) or uaBuffData[button.id][uaBuffSlot].name
    end
    if not uaBuffData[button.id][uaBuffSlot].isCurrent then
        uaIsCurrent, uaIsCustom, uaNever=HealBot_Aura_CheckCurBuff(button)
        if uaIsCurrent then 
            uaBuffData[button.id][uaBuffSlot].isCurrent=true
            HealBot_AuraBuffCache[uaBuffData[button.id][uaBuffSlot].spellId].isCustom=uaIsCustom
        end
    else
        uaIsCurrent=true
        uaIsCustom=HealBot_AuraBuffCache[uaBuffData[button.id][uaBuffSlot].spellId].isCustom
    end
    if uaIsCurrent then
        if not button.status.isspirit or uaBuffData[button.id][uaBuffSlot].name == HEALBOT_SPIRIT_OF_REDEMPTION_NAME then
            curBuffxTime[uaBuffData[button.id][uaBuffSlot].name]=uaBuffData[button.id][uaBuffSlot].expirationTime
            if uaIsCustom then
                HealBot_Aura_setBuffXRefUID(HealBot_AuraBuffCache[uaBuffData[button.id][uaBuffSlot].spellId]["pid"]..uaBuffSlot, uaBuffData[button.id][uaBuffSlot].spellId, uaBuffSlot)
            end
            if tGeneralBuffs and onlyPlayers and (HealBot_BuffWatch[uaBuffData[button.id][uaBuffSlot].name] or HealBot_BuffNameTypes[uaBuffData[button.id][uaBuffSlot].name]) then
                if not button.aura.buff.recheck[uaBuffData[button.id][uaBuffSlot].name] or button.aura.buff.recheck[uaBuffData[button.id][uaBuffSlot].name]>HealBot_TimeNow then
                    if HealBot_BuffNameTypes[uaBuffData[button.id][uaBuffSlot].name] then
                        if HealBot_BuffNameTypes[uaBuffData[button.id][uaBuffSlot].name]<7 and uaBuffData[button.id][uaBuffSlot].sourceUnitIsPlayer then ownBlessing=true end
                        PlayerBuffTypes[HealBot_BuffNameTypes[uaBuffData[button.id][uaBuffSlot].name]]=true
                    end
                end
                PlayerBuffs[uaBuffData[button.id][uaBuffSlot].name]=true
                if HealBot_CheckBuffs[uaBuffData[button.id][uaBuffSlot].name] and uaBuffData[button.id][uaBuffSlot].expirationTime>0 and (HEALBOT_GAME_VERSION>1 or uaBuffData[button.id][uaBuffSlot].sourceUnitIsPlayer) then
                    HealBot_Aura_SetUnitBuffTimer(button)
                elseif button.aura.buff.recheck[uaBuffData[button.id][uaBuffSlot].name] then
                    button.aura.buff.recheck[uaBuffData[button.id][uaBuffSlot].name]=nil
                    HealBot_Aura_MarkCheckBuffsTime(button)
                end
            end
        end
    elseif uaNever and not HealBot_BuffWatch[uaBuffData[button.id][uaBuffSlot].name] and not HealBot_BuffNameTypes[uaBuffData[button.id][uaBuffSlot].name] then
        HealBot_ExcludeBuffInCache[uaBuffData[button.id][uaBuffSlot].spellId]=true
    end
end

function HealBot_Aura_CheckUnitDebuff(button)
      --HealBot_setCall("HealBot_Aura_CheckUnitDebuff", button)
    if not uaDebuffData[button.id][uaDebuffSlot].isCurrent then
        uaIsCurrent=HealBot_Aura_CheckCurDebuff(button)
        if uaIsCurrent and (hbDebuffOnCD[uaDebuffData[button.id][uaDebuffSlot].debuffType] or 0)<(HealBot_TimeNow+2) then
            uaDebuffData[button.id][uaDebuffSlot].isCurrent=true
        end
    else
        uaIsCurrent=true
    end
    if uaIsCurrent then
        HealBot_Aura_setDebuffXRefUID(HealBot_AuraDebuffCache[uaDebuffData[button.id][uaDebuffSlot].spellId]["pid"]..uaDebuffSlot, uaDebuffData[button.id][uaDebuffSlot].spellId, uaDebuffSlot)
        if not button.aura.debuff.temp.active or button.aura.debuff.temp.priority>HealBot_AuraDebuffCache[uaDebuffData[button.id][uaDebuffSlot].spellId]["priority"] then
            button.aura.debuff.temp.active=true
            button.aura.debuff.temp.id=uaDebuffData[button.id][uaDebuffSlot].spellId
            button.aura.debuff.temp.priority=HealBot_AuraDebuffCache[uaDebuffData[button.id][uaDebuffSlot].spellId]["priority"]
        end
    end
end

local uaID,uaSlot="",0
function HealBot_Aura_setBuffXRefUID(uid, spellID, slot)
    if not HealBot_AuraBuffXRef[uid] then HealBot_AuraBuffXRef[uid]={} end
    HealBot_AuraBuffXRef[uid]["spellID"]=spellID
    HealBot_AuraBuffXRef[uid]["slot"]=slot
    table.insert(buffSort[HealBot_Aura_IconSet[spellID]],uid)
end

local function HealBot_Aura_PostUpdateUnitBuffsData(button, spellID, spellName)
      --HealBot_setCall("HealBot_Aura_PostUpdateUnitBuffsData", button)
    if not HealBot_AuraBuffCache[spellID] or HealBot_AuraBuffCache[spellID].reset then
        if not HealBot_AuraBuffCache[spellID] then 
            HealBot_AuraBuffCache[spellID]={}
            HealBot_AuraBuffCache[spellID]["name"]=spellName
            HealBot_Aura_ID[spellName]=spellID
            if HealBot_SpellID_LookupData[spellName] and HealBot_SpellID_LookupData[spellName]["CHECK"] then
                HealBot_SpellID_LookupData[spellName]["CHECK"]=false
                HealBot_SpellID_LookupData[spellName]["ID"]=spellID
                table.insert(HealBot_SpellID_LookupIdx,spellName)
                HealBot_Timers_Set("OOC","BuffIdLookup",0.1)
            end
        end
        HealBot_AuraBuffCache[spellID]["priority"]=HealBot_Globals.HealBot_Custom_Buffs[spellName] or HealBot_Globals.HealBot_Custom_Buffs[spellID] or 20
        if HealBot_AuraBuffCache[spellID]["priority"]<10 then
            HealBot_AuraBuffCache[spellID]["pid"]="x0"..HealBot_AuraBuffCache[spellID]["priority"]..spellID
        else
            HealBot_AuraBuffCache[spellID]["pid"]="x"..HealBot_AuraBuffCache[spellID]["priority"]..spellID
        end
        HealBot_Aura_IconSet[spellID]=HealBot_BuffIconSet[spellID] or HealBot_BuffIconSet[spellName] or 1
        HealBot_AuraBuffCache[spellID]["always"]=false
        HealBot_AuraBuffCache[spellID]["isCustom"]=false
        uaBuffData[button.id][uaSlot].isCurrent=false
        HealBot_AuraBuffCache[spellID].reset=false
    end
end

local function HealBot_Aura_PostUpdateUnitBuffsCurrent(button, spellID, spellName, count, casterIsPlayer)
    HealBot_UnitBuffCurrent[button.guid][spellName]=true
    HealBot_Aura_BuffUpdate_Plugins(button, spellName, HealBot_Globals.CustomBuffTag[spellID] or HealBot_BuffTagNames[spellName], count, true, casterIsPlayer)
end

local function HealBot_Aura_UpdateUnitBuffsData(button, selfOnly, gSlot)
      --HealBot_setCall("HealBot_Aura_UpdateUnitBuffsData", button)
      
    if uaExpirationTime then
        uaExpirationTime=HealBot_Util_Round(uaExpirationTime,1)
        if not uaUnitCaster then uaUnitCaster="nil" end
        if UnitIsUnit(uaUnitCaster,"player") then
            uaUnitIsPlayer=true
        else
            uaUnitIsPlayer=false
        end
        if not HealBot_ExcludeBuffInCache[uaSpellId] and uaSlot<20 and (uaUnitIsPlayer or not selfOnly) then
            uaSlot=uaSlot+1
            if uaBuffData[button.id][uaSlot].spellId~=uaSpellId or uaBuffData[button.id][uaSlot].sourceUnit~=(uaUnitCaster or "nil") then
                uaBuffData[button.id][uaSlot].name=uaName
                if hbDebuffBleed[uaSpellId] and (not uaDebuffType or not HealBot_Options_retDebuffCureType(uaDebuffType)) then
                    uaBuffData[button.id][uaSlot].debuffType=HEALBOT_BLEED_en
                else
                    uaBuffData[button.id][uaSlot].debuffType=uaDebuffType
                end
                uaBuffData[button.id][uaSlot].duration=uaDuration or 15
                uaBuffData[button.id][uaSlot].sourceUnit=uaUnitCaster
                uaBuffData[button.id][uaSlot].gSlot=gSlot
                uaBuffData[button.id][uaSlot].sourceUnitIsPlayer=uaUnitIsPlayer
                uaBuffData[button.id][uaSlot].spellId=uaSpellId
                if not HealBot_AuraBuffCache[uaSpellId] or not HealBot_AuraBuffCache[uaSpellId].always then
                    uaBuffData[button.id][uaSlot].isCurrent=false
                end
            end
            uaBuffData[button.id][uaSlot].icon=uaTexture
            uaBuffData[button.id][uaSlot].count=uaCount
            uaBuffData[button.id][uaSlot].expirationTime=uaExpirationTime
            uaBuffData[button.id].lastslot=uaSlot
            HealBot_Aura_PostUpdateUnitBuffsData(button, uaSpellId, uaName)
            if hbTextureUpdate[uaName] and (not hbTextureUpdateId[button.id][uaName] or (hbTextureUpdateId[button.id][uaName]+1)<uaExpirationTime) then
                hbTextureUpdateId[button.id][uaName]=uaExpirationTime
                hbTextureUpdateTime[button.id][uaSpellId]=HealBot_TimeNow+hbTextureUpdate[uaName]
            end
        end
        HealBot_Aura_PostUpdateUnitBuffsCurrent(button, uaSpellId, uaName, uaCount, uaUnitIsPlayer)
    end
end

function HealBot_Aura_StartCheckClassicAbsorbs(button)
    for n,_ in pairs(hbClassicAbsorbsTrack[button.id]) do
        hbClassicAbsorbsTrack[button.id][n]=false
    end
end

local debugTime={}
function HealBot_Aura_CheckClassicAbsorbs(button)
    if HealBot_Classic_Absorbs[uaName] then
        hbClassicAbsorbsAmount[button.id][uaName]=0
        if uaExtra17 and type(uaExtra17) == "number" then
            hbClassicAbsorbsAmount[button.id][uaName]=uaExtra17
        end
        if uaExtra18 and type(uaExtra18) == "number" and uaExtra18>hbClassicAbsorbsAmount[button.id][uaName] then
            hbClassicAbsorbsAmount[button.id][uaName]=uaExtra18
        end
        if uaExtra19 and type(uaExtra19) == "number" and uaExtra19>hbClassicAbsorbsAmount[button.id][uaName] then
            hbClassicAbsorbsAmount[button.id][uaName]=uaExtra19
        end
        if not debugTime[uaName] then debugTime[uaName]=0 end
        if debugTime[uaName]<HealBot_TimeNow then
            debugTime[uaName]=HealBot_TimeNow+30
            HealBot_AddDebug("ClassicAbsorbs  17="..(uaExtra17 or "nil").."  18="..(uaExtra18 or "nil").."  19="..(uaExtra19 or "nil"),"Absorbs "..uaName,true)
        end
        hbClassicAbsorbsTrack[button.id][uaName]=true
    end
end

local hbClassicAbsorbValues=0
function HealBot_Aura_EndCheckClassicAbsorbs(button)
    hbClassicAbsorbValues=0
    for n,t in pairs(hbClassicAbsorbsTrack[button.id]) do
        if not hbClassicAbsorbsTrack[button.id][n] then
            hbClassicAbsorbsTrack[button.id][n]=nil;
        else
            hbClassicAbsorbValues=hbClassicAbsorbValues+hbClassicAbsorbsAmount[button.id][n]
        end
    end
    if button.health.auraabsorbs~=hbClassicAbsorbValues then
        button.health.auraabsorbs=hbClassicAbsorbValues
        HealBot_Events_AbsorbsUpdate(button)
    end
end

local hbClassicAbsorbTotal=0
function HealBot_Aura_UpdateUnitBuffsV1(button, selfOnly)
      --HealBot_setCall("HealBot_Aura_UpdateUnitBuffsV1", button)
    uaZ=1
    hbClassicAbsorbTotal=0
    while true do
        uaName, uaTexture, uaCount, uaDebuffType, uaDuration, uaExpirationTime, uaUnitCaster, _, _, uaSpellId, _, _, _, _, _, _, uaExtra17, uaExtra18, uaExtra19=UnitAura(button.unit,uaZ,"HELPFUL")
        if uaSpellId then
            HealBot_Aura_UpdateUnitBuffsData(button, selfOnly, uaZ)
            if HealBot_Classic_Absorbs[uaName] then
                hbClassicAbsorbValues=(HealBot_Classic_Absorbs[uaName][uaSpellId] or HealBot_Classic_Absorbs[uaName][0] or 0) + (classicAbsorbBonusV1[button.guid] or classicAbsorbBonusV1["DEFAULT"])
                hbClassicAbsorbTotal=hbClassicAbsorbTotal+hbClassicAbsorbValues
                if HealBot_Classic_AbsorbsV1Track[uaName]~=uaExpirationTime then
                    HealBot_Classic_AbsorbsV1Track[uaName]=uaExpirationTime
                    button.health.auraabsorbs=0
                end
            end
            uaZ=uaZ+1
        else
            break
        end
    end
    if button.health.auraabsorbs~=hbClassicAbsorbTotal then
        button.health.auraabsorbs=hbClassicAbsorbTotal
        HealBot_Events_AbsorbsUpdate(button)
    end
end

function HealBot_Aura_UpdateUnitBuffsV2(button, selfOnly)
      --HealBot_setCall("HealBot_Aura_UpdateUnitBuffsV2", button)
    uaZ=1
    HealBot_Aura_StartCheckClassicAbsorbs(button)
    while true do
        uaName, uaTexture, uaCount, uaDebuffType, uaDuration, uaExpirationTime, uaUnitCaster, _, _, uaSpellId, _, _, _, _, _, _, uaExtra17, uaExtra18, uaExtra19=UnitBuff(button.unit,uaZ)
        if uaSpellId then
            HealBot_Aura_UpdateUnitBuffsData(button, selfOnly, uaZ)
            HealBot_Aura_CheckClassicAbsorbs(button)
            uaZ=uaZ+1
        else
            break
        end
    end
    HealBot_Aura_EndCheckClassicAbsorbs(button)
end

function HealBot_Aura_UpdateUnitBuffsV9(button, selfOnly)
      --HealBot_setCall("HealBot_Aura_UpdateUnitBuffsV9", button)
    uaZ=0
    AuraUtil.ForEachAura(button.unit, "HELPFUL", nil, function(...)
        uaName, uaTexture, uaCount, uaDebuffType, uaDuration, uaExpirationTime, uaUnitCaster, _, _, uaSpellId=...
        uaZ=uaZ+1
        HealBot_Aura_UpdateUnitBuffsData(button, selfOnly, uaZ)
    end)
end

local HealBot_Aura_UpdateUnitBuffs=HealBot_Aura_UpdateUnitBuffsV2
if HEALBOT_GAME_VERSION>8 then
    HealBot_Aura_UpdateUnitBuffs=HealBot_Aura_UpdateUnitBuffsV9
elseif HEALBOT_GAME_VERSION<2 then
    HealBot_Aura_UpdateUnitBuffs=HealBot_Aura_UpdateUnitBuffsV1
end

local bExists=false
function HealBot_Aura_CheckUnitBuffExistsV2(button, buffName)
      --HealBot_setCall("HealBot_Aura_CheckUnitBuffExistsV2", button)
    uaZ=1
    bExists=false
    while true do
        uaName=UnitBuff(button.unit,uaZ)
        if uaName then
            if uaName == buffName then
                bExists=true
                break
            end
            uaZ=uaZ+1
        else
            break
        end
    end
    return bExists
end

function HealBot_Aura_CheckUnitBuffExistsV9(button, buffName)
    if C_UnitAuras.GetAuraDataBySpellName(button.unit, buffName, "HELPFUL") then
        return true
    else
        return false
    end
end

local HealBot_Aura_CheckUnitBuffExists=HealBot_Aura_CheckUnitBuffExistsV2
if HEALBOT_GAME_VERSION>8 then
    HealBot_Aura_CheckUnitBuffExists=HealBot_Aura_CheckUnitBuffExistsV9
end

function HealBot_Aura_CheckUnitBuffCurrent(button, buffName)
    return HealBot_Aura_CheckUnitBuffExists(button, buffName)
end

function HealBot_Aura_PostUpdateUnitDebuffsData(button, spellID, spellName, debuffType)
      --HealBot_setCall("HealBot_Aura_PostUpdateUnitDebuffsData", button)
    if not HealBot_AuraDebuffCache[spellID] or HealBot_AuraDebuffCache[spellID].reset then
        if not HealBot_AuraDebuffCache[spellID] then 
            HealBot_AuraDebuffCache[spellID]={} 
            HealBot_AuraDebuffCache[spellID]["priority"]=99
            HealBot_AuraDebuffCache[spellID]["name"]=spellName
            HealBot_Aura_ID[spellName]=spellID
            if not HealBot_Globals.HealBot_Custom_Debuffs[spellID] then
                HealBot_Aura_AutoUpdateCustomDebuff(button, spellName, spellID)
            end
            if HealBot_Aura_CanDispel[spellID] == nil then
                local aSpellId=nil
                if HEALBOT_GAME_VERSION>8 then
                    AuraUtil.ForEachAura(button.unit, "HARMFUL|RAID", nil, function(...)
                        _, _, _, _, _, _, _, _, _, aSpellId=...
                        HealBot_Aura_CanDispel[aSpellId]=true
                    end)
                else
                    local aId=1
                    while true do
                        _, _, _, _, _, _, _, _, _, aSpellId=UnitAura(button.unit,aId,"HARMFUL|RAID")
                        if aSpellId then
                            aId=aId+1
                            HealBot_Aura_CanDispel[aSpellId]=true
                        else
                            break
                        end
                    end
                end
                if HealBot_Aura_CanDispel[spellID] == nil then
                    HealBot_Aura_CanDispel[spellID]=false
                end
            end
        end
        HealBot_Aura_IconSet[spellID]=HealBot_DebuffIconSet[spellID] or HealBot_DebuffIconSet[spellName] or 1
        HealBot_AuraDebuffCache[spellID]["customPrio"], HealBot_AuraDebuffCache[spellID]["typePrio"]=HealBot_Options_retDebuffPriority(spellID, spellName, debuffType)
        uaDebuffData[button.id][uaSlot].isCurrent=false
        HealBot_AuraDebuffCache[spellID].reset=false
    elseif (hbDebuffOnCD[debuffType] or 0)>=(HealBot_TimeNow-2) then
        uaDebuffData[button.id][uaSlot].isCurrent=false
    end
end

function HealBot_Aura_PostUpdateUnitDebuffsCurrent(button, spellID, spellName, count, casterIsPlayer)
    HealBot_UnitDebuffCurrent[button.guid][spellName]=true
    HealBot_Aura_DebuffUpdate_Plugins(button, spellName, HealBot_Globals.CDCTag[spellID] or HealBot_DebuffTagNames[spellName], count, true, casterIsPlayer)
end

--hbDebuffBleed[32407]="Strange Aura"
function HealBot_Aura_UpdateUnitDebuffsData(button, selfOnly, gSlot)
      --HealBot_setCall("HealBot_Aura_UpdateUnitDebuffsData", button)
    if uaExpirationTime then
        uaExpirationTime=HealBot_Util_Round(uaExpirationTime,1)
        if not uaUnitCaster then uaUnitCaster="nil" end
        if UnitIsUnit(uaUnitCaster,"player") then
            uaUnitIsPlayer=true
        else
            uaUnitIsPlayer=false
        end
        if uaSlot<20 and (uaUnitIsPlayer or not selfOnly) then
            --if uaSpellId == 32407 or uaName == "Strange Aura" then
            --    uaDebuffType=HEALBOT_DISEASE_en
            --    uaDebuffType=HEALBOT_MAGIC_en
            --    uaDebuffType=HEALBOT_CURSE_en
            --    uaDebuffType=HEALBOT_POISON_en
            --    uaDebuffType=HEALBOT_BLEED_en
            --    HealBot_Aura_CanDispel[uaSpellId]=true
            --    HealBot_Aura_IconSet[uaSpellId].spellId]=3
            --end
            uaSlot=uaSlot+1
            if uaDebuffData[button.id][uaSlot].spellId~=uaSpellId or uaDebuffData[button.id][uaSlot].sourceUnit~=(uaUnitCaster or "nil") then
                uaDebuffData[button.id][uaSlot].name=uaName
                if hbDebuffBleed[uaSpellId] and (not uaDebuffType or not HealBot_Options_retDebuffCureSpell(uaDebuffType)) then
                    uaDebuffData[button.id][uaSlot].debuffType=HEALBOT_BLEED_en
                else
                    uaDebuffData[button.id][uaSlot].debuffType=uaDebuffType or "nil"
                end
                uaDebuffData[button.id][uaSlot].duration=uaDuration or 15
                uaDebuffData[button.id][uaSlot].sourceUnit=uaUnitCaster
                uaDebuffData[button.id][uaSlot].sourceUnitIsPlayer=uaUnitIsPlayer
                uaDebuffData[button.id][uaSlot].spellId=uaSpellId
                uaDebuffData[button.id][uaSlot].gSlot=gSlot
                uaDebuffData[button.id][uaSlot].isBossAura=uaIsBossDebuff
                if not HealBot_AuraDebuffCache[uaSpellId] or not HealBot_AuraDebuffCache[uaSpellId].always then
                    uaDebuffData[button.id][uaSlot].isCurrent=false
                end
            end
            uaDebuffData[button.id][uaSlot].icon=uaTexture
            uaDebuffData[button.id][uaSlot].count=uaCount
            uaDebuffData[button.id][uaSlot].expirationTime=uaExpirationTime
            uaDebuffData[button.id].lastslot=uaSlot
            HealBot_Aura_PostUpdateUnitDebuffsData(button, uaSpellId, uaName, uaDebuffData[button.id][uaSlot].debuffType)
            if hbTextureUpdate[uaName] and (not hbTextureUpdateId[button.id][uaName] or (hbTextureUpdateId[button.id][uaName]+1)<uaExpirationTime) then
                hbTextureUpdateId[button.id][uaName]=uaExpirationTime
                hbTextureUpdateTime[button.id][uaSpellId]=HealBot_TimeNow+hbTextureUpdate[uaName]
            end
        end
        HealBot_Aura_PostUpdateUnitDebuffsCurrent(button, uaSpellId, uaName, uaCount, uaUnitIsPlayer)
    end
end

function HealBot_Aura_IsBoss(unit)
      --HealBot_setCall("HealBot_Aura_IsBoss", nil, nil, unit)
    if unit and (UnitClassification(unit) == "worldboss" or (UnitClassification(unit) == 'elite' and (UnitLevel(unit) == -1 or UnitHealthMax(unit)>HealBot_Aura_luVars["bossHlth"]))) then
        return true
    else
        return false
    end
end

function HealBot_Aura_UpdateUnitDebuffsV2(button, selfOnly)
      --HealBot_setCall("HealBot_Aura_UpdateUnitDebuffsV2", button)
    uaZ=1
    while true do
        uaName, uaTexture, uaCount, uaDebuffType, uaDuration, uaExpirationTime, uaUnitCaster, _, _, uaSpellId=UnitDebuff(button.unit,uaZ)
        if uaSpellId then
            uaIsBossDebuff=HealBot_Aura_IsBoss(uaUnitCaster)
            HealBot_Aura_UpdateUnitDebuffsData(button, selfOnly, uaZ)
            uaZ=uaZ+1
        else
            break
        end
    end
end

function HealBot_Aura_UpdateUnitDebuffsV9(button, selfOnly)
      --HealBot_setCall("HealBot_Aura_UpdateUnitDebuffsV9", button)
    uaZ=0
    AuraUtil.ForEachAura(button.unit, "HARMFUL", nil, function(...)
        uaName, uaTexture, uaCount, uaDebuffType, uaDuration, uaExpirationTime, uaUnitCaster, _, _, uaSpellId, _, uaIsBossDebuff=...
        uaZ=uaZ+1
        HealBot_Aura_UpdateUnitDebuffsData(button, selfOnly, uaZ)
    end)
end

local HealBot_Aura_UpdateUnitDebuffs=HealBot_Aura_UpdateUnitDebuffsV2
if HEALBOT_GAME_VERSION>8 then
    HealBot_Aura_UpdateUnitDebuffs=HealBot_Aura_UpdateUnitDebuffsV9
end

function HealBot_Aura_ClearUnitBuffOverDebuff(button, callerIsBuff)
      --HealBot_setCall("HealBot_Aura_ClearUnitBuffOverDebuff", button)
    button.aura.buff.overdb=false
    button.aura.debuff.bodupd=true
    if callerIsBuff then HealBot_Events_UnitDebuff(button) end
end

local hbOverDebuff=false
function HealBot_Aura_SetUnitBuffOverDebuff(button, dCol)
      --HealBot_setCall("HealBot_Aura_SetUnitBuffOverDebuff", button)
    button.aura.debuff.colbar=dCol
    button.aura.buff.overdb=true
    hbOverDebuff=true
end

function HealBot_Aura_CheckUnitBuffOverDebuff(button, callerIsBuff)
      --HealBot_setCall("HealBot_Aura_CheckUnitBuffOverDebuff", button)
    hbOverDebuff=false
    if button.aura.buff.priority<button.aura.debuff.priority then
        if (button.aura.buff.colbar<5 or button.aura.buff.colbar == 7) and (button.aura.debuff.colbar<5 or button.aura.debuff.colbar == 7) then
            if button.aura.buff.colbar == button.aura.debuff.colbar or (button.aura.buff.colbar == 2 and button.aura.debuff.colbar<4) then
                HealBot_Aura_SetUnitBuffOverDebuff(button, 0)
            elseif button.aura.debuff.colbar == 2 then
                if button.aura.buff.colbar == 1 then
                    HealBot_Aura_SetUnitBuffOverDebuff(button, 3)
                elseif button.aura.buff.colbar == 3 then
                    HealBot_Aura_SetUnitBuffOverDebuff(button, 1)
                end
            end
        end
    end
    if button.aura.buff.overdb and not hbOverDebuff then
        HealBot_Aura_ClearUnitBuffOverDebuff(button, callerIsBuff)
    end
end

local buffBarCol,buffPrio,buffIconIndex=0,99,0
function HealBot_Aura_CheckUnitBuffs(button, selfOnly)
      --HealBot_setCall("HealBot_Aura_CheckUnitBuffs", button)
    prevMissingbuff=button.aura.buff.missingbuff
    button.aura.buff.missingbuff=false
    if buffCheck and (not button.status.isdead or button.status.isspirit) then
        button.aura.buff.priority=99
        button.aura.buff.colbar=0
        curBuffName=false;
        tGeneralBuffs=generalBuffs
        
        if not HealBot_Data["PALIVE"] then
            tGeneralBuffs=false
        end
        if tGeneralBuffs then
            if button.player then
                onlyPlayers=true
            elseif HEALBOT_GAME_VERSION>3 then
                onlyPlayers=button.isplayer
            else
                onlyPlayers=UnitIsFriend("player",button.unit)
            end
            if onlyPlayers then 
                for x,_ in pairs(PlayerBuffs) do
                    PlayerBuffs[x]=false;
                end
                for x,_ in pairs(PlayerBuffTypes) do
                    PlayerBuffTypes[x]=false;
                end
                ownBlessing=false
            end
        end

        if button.aura.buff.update then
            if not HealBot_UnitBuffCurrent[button.guid] then HealBot_UnitBuffCurrent[button.guid]={} end
            for bName, _ in pairs(HealBot_UnitBuffCurrent[button.guid]) do
                HealBot_UnitBuffCurrent[button.guid][bName]=false
            end
            button.aura.buff.update=false
            button.aura.buff.temp.active=false
            uaSlot=0
            uaBuffData[button.id].lastslot=0
            HealBot_Aura_UpdateUnitBuffs(button, selfOnly)
            for bName, _ in pairs(HealBot_UnitBuffCurrent[button.guid]) do
                if not HealBot_UnitBuffCurrent[button.guid][bName] then
                    HealBot_UnitBuffCurrent[button.guid][bName]=nil
                    HealBot_Aura_BuffUpdate_Plugins(button, bName, HealBot_Globals.CustomBuffTag[HealBot_Aura_ID[bName]] or HealBot_BuffTagNames[bName], 0, false)
                end
            end
        end
        for z=1,3 do
            HealBot_Aura_prevIconCount["BUFF"][z]=button.icon.buff.count[z]
            for x,_ in pairs(buffSort[z]) do
                buffSort[z][x]=nil;
            end
        end
        if uaBuffData[button.id].lastslot>0 then
            for x=1,uaBuffData[button.id].lastslot do
                uaBuffSlot=x
                HealBot_Aura_CheckUnitBuff(button)
            end
        end
    --    if buffCheck then
            if tGeneralBuffs and onlyPlayers then
                HealBot_Aura_CheckGeneralBuff(button)
            end
            buffIconIndex=HealBot_Aura_SortBuffIcons(button)
            HealBot_Aura_CheckUnitBuffIcons(button)

            if not curBuffName then
                if buffIconIndex>0 then
                    button.aura.buff.id=HealBot_UnitBuffIcons[button.id][buffIconIndex]["spellId"]
                    curBuffName=HealBot_AuraBuffCache[button.aura.buff.id]["name"]
                    buffPrio=HealBot_AuraBuffCache[button.aura.buff.id]["priority"]
                elseif button.aura.buff.temp.active then
                    button.aura.buff.id=button.aura.buff.temp.id
                    curBuffName=button.aura.buff.temp.name
                    buffPrio=button.aura.buff.temp.priority
                end
                if curBuffName then
                    if HealBot_AuraBuffCache[button.aura.buff.id].isAuto then
                        buffBarCol=HealBot_Globals.HealBot_Custom_Buffs_ShowBarCol[HEALBOT_CUSTOM_CAT_CUSTOM_AUTOBUFFS] or 1
                    else
                        buffBarCol=HealBot_Globals.HealBot_Custom_Buffs_ShowBarCol[HealBot_AuraBuffCache[button.aura.buff.id]["name"]] or 1
                    end
                    if (HealBot_Globals.HealBot_Custom_Buffs_ShowBarCol[button.aura.buff.id] or 1) > buffBarCol then
                        buffBarCol=HealBot_Globals.HealBot_Custom_Buffs_ShowBarCol[button.aura.buff.id] or 1
                    end
                    if buffBarCol>1 and button.aura.buff.colbar == 0 then
                        button.aura.buff.colbar=buffBarCol-1
                        button.aura.buff.priority=buffPrio
                        HealBot_Aura_CheckUnitBuffOverDebuff(button, true)
                    elseif button.aura.buff.overdb then
                        HealBot_Aura_ClearUnitBuffOverDebuff(button)
                    end
                end
            end
            if curBuffName then               
                if prevMissingbuff~=button.aura.buff.missingbuff or HealBot_Aura_luVars["updateAll"] then
                    button.aura.buff.name="needUpdate"
                end
                HealBot_Aura_BuffWarnings(button, curBuffName)
            else
                HealBot_Aura_ClearBuff(button)
            end
    --    else
    --        HealBot_Aura_ClearBuff(button)
    --    end
    else
        HealBot_Aura_ClearBuff(button)
    end
    if button.text.tagbuff and not button.aura.buff.missingbuff then
        HealBot_Text_setNameTag(button)
    end
end

function HealBot_Aura_resetSpellCD()
      --HealBot_setCall("HealBot_Aura_resetSpellCD")
    hbDebuffOnCD[HEALBOT_DISEASE_en]=0
    hbDebuffOnCD[HEALBOT_MAGIC_en]=0
    hbDebuffOnCD[HEALBOT_CURSE_en]=0
    hbDebuffOnCD[HEALBOT_POISON_en]=0
    hbDebuffOnCD[HEALBOT_BLEED_en]=0
end
HealBot_Aura_resetSpellCD()

function HealBot_Aura_setDebuffTypeCD(dType, eTime)
    hbDebuffOnCD[dType]=eTime
end

HealBot_Aura_luVars["bossHlth"]=250000
function HealBot_Aura_SetBossHealth(inInst)
      --HealBot_setCall("HealBot_Aura_SetBossHealth")
    if HealBot_Data["PLEVEL"]<50 then
        HealBot_Aura_luVars["bossHlth"]=HealBot_Data["PLEVEL"]*750
    elseif HealBot_Data["PLEVEL"]<60 then
        HealBot_Aura_luVars["bossHlth"]=HealBot_Data["PLEVEL"]*900
    elseif HealBot_Data["PLEVEL"]<70 then
        HealBot_Aura_luVars["bossHlth"]=HealBot_Data["PLEVEL"]*1000
    elseif HealBot_Data["PLEVEL"]<75 then
        HealBot_Aura_luVars["bossHlth"]=HealBot_Data["PLEVEL"]*1100
    elseif HealBot_Data["PLEVEL"]<80 then
        HealBot_Aura_luVars["bossHlth"]=HealBot_Data["PLEVEL"]*1250
    elseif HealBot_Data["PLEVEL"]<85 then
        HealBot_Aura_luVars["bossHlth"]=HealBot_Data["PLEVEL"]*1500
    else
        HealBot_Aura_luVars["bossHlth"]=250000
    end
    if inInst then
        local difficultyID=GetDungeonDifficultyID()
        if difficultyID~=1 and difficultyID~=173 then
            HealBot_Aura_luVars["bossHlth"]=HealBot_Aura_luVars["bossHlth"]*2
        end
    end
    --HealBot_AddDebug("Boss Min Health "..HealBot_Aura_luVars["bossHlth"],"Mobs",true)
end

function HealBot_Aura_UnitDebuffsUpdateWhenActive(button)
    if uaDebuffData[button.id].lastslot>0 then
        for x=1,uaDebuffData[button.id].lastslot do
            uaDebuffData[button.id][x].isCurrent=false
        end
    end
end

local debuffBarCol,debuffIconIndex=0,0
function HealBot_Aura_CheckUnitDebuffs(button, selfOnly)
      --HealBot_setCall("HealBot_Aura_CheckUnitDebuffs", button)
    if debuffCheck and button.status.current<HealBot_Unit_Status["DEAD"] then
        for z=1,3 do
            HealBot_Aura_prevIconCount["DEBUFF"][z]=button.icon.debuff.count[z]
        end
        --button.aura.debuff.type=false
        if button.aura.debuff.update then
            if not HealBot_UnitDebuffCurrent[button.guid] then HealBot_UnitDebuffCurrent[button.guid]={} end
            for dName, _ in pairs(HealBot_UnitDebuffCurrent[button.guid]) do
                HealBot_UnitDebuffCurrent[button.guid][dName]=false
            end
            button.aura.debuff.update=false
            button.aura.debuff.temp.active=false
            uaSlot=0
            uaDebuffData[button.id].lastslot=0
            HealBot_Aura_UpdateUnitDebuffs(button, selfOnly)
            for dName, _ in pairs(HealBot_UnitDebuffCurrent[button.guid]) do
                if not HealBot_UnitDebuffCurrent[button.guid][dName] then
                    HealBot_UnitDebuffCurrent[button.guid][dName]=nil
                    HealBot_Aura_DebuffUpdate_Plugins(button, dName, HealBot_Globals.CDCTag[HealBot_Aura_ID[dName]] or HealBot_DebuffTagNames[dName], 0, false)
                end
            end
        end

        for z=1,3 do
            for x,_ in pairs(debuffSort[z]) do
                debuffSort[z][x]=nil;
            end
        end
        if uaDebuffData[button.id].lastslot>0 then
            for x=1,uaDebuffData[button.id].lastslot do
                uaDebuffSlot=x
                HealBot_Aura_CheckUnitDebuff(button)
            end
        end

        debuffIconIndex=HealBot_Aura_SortDebuffIcons(button)
        HealBot_Aura_CheckUnitDebuffIcons(button)
        if debuffIconIndex>0 then
            button.aura.debuff.id=HealBot_UnitDebuffIcons[button.id][debuffIconIndex]["spellId"]
            button.aura.debuff.priority=HealBot_AuraDebuffCache[button.aura.debuff.id]["priority"]
        elseif button.aura.debuff.temp.active then
            button.aura.debuff.id=button.aura.debuff.temp.id
            button.aura.debuff.priority=button.aura.debuff.temp.priority
        else
            button.aura.debuff.id=0
        end
        if button.aura.debuff.id>0 and HealBot_Panel_RaidPetUnitButtonCheck(button.guid) then
            if HealBot_AuraDebuffCache[button.aura.debuff.id].isAuto then 
                debuffBarCol=HealBot_Globals.HealBot_Custom_Debuffs_ShowBarCol[HEALBOT_CUSTOM_CAT_CUSTOM_AUTOMATIC] or 4
            elseif HealBot_AuraDebuffCache[button.aura.debuff.id]["debuffType"] == HEALBOT_CUSTOM_en then
                debuffBarCol=HealBot_Globals.HealBot_Custom_Debuffs_ShowBarCol[button.aura.debuff.id] or 
                             HealBot_Globals.HealBot_Custom_Debuffs_ShowBarCol[HealBot_AuraDebuffCache[button.aura.debuff.id]["name"]] or 4
            else
                debuffBarCol=HealBot_Globals.HealBot_Custom_Debuffs_ShowBarCol["DEFAULT"] or 4
            end
            button.aura.debuff.dispellable=HealBot_Aura_CanDispel[button.aura.debuff.id]
            button.aura.debuff.colbar=debuffBarCol-1
            HealBot_Aura_CheckUnitBuffOverDebuff(button)
            if button.aura.debuff.type~=HealBot_AuraDebuffCache[button.aura.debuff.id]["debuffType"] or button.aura.debuff.bodupd then
                button.aura.debuff.bodupd=false
                button.aura.debuff.name="needUpdate"
                button.aura.debuff.type=HealBot_AuraDebuffCache[button.aura.debuff.id]["debuffType"]
            end
            HealBot_Aura_DebuffWarnings(button, HealBot_AuraDebuffCache[button.aura.debuff.id]["name"], false, debuffIconIndex)
        else
            HealBot_Aura_ClearDebuff(button)
        end
    else
        HealBot_Aura_ClearDebuff(button)
    end
end

function HealBot_Aura_CheckUnitAuras(button, debuff, selfOnly)
      --HealBot_setCall("HealBot_Aura_CheckUnitAuras", button)
    if not HealBot_Aura_luVars["TestBarsOn"] then
        if debuff then
            button.aura.debuff.updtime=HealBot_TimeNow
            HealBot_Aura_CheckUnitDebuffs(button, selfOnly)
        else
            button.aura.buff.updtime=HealBot_TimeNow
            HealBot_Aura_CheckUnitBuffs(button, selfOnly)
        end
    end
end

local lowTime=0
function HealBot_Aura_ResetCheckBuffsTime(button)
      --HealBot_setCall("HealBot_Aura_ResetCheckBuffsTime", button)
    lowTime=HealBot_TimeNow+10000000
    PlayerBuffsList=button.aura.buff.recheck
    button.aura.buff.resetcheck=false
    button.aura.buff.nextcheck=false
    for name,nexttime in pairs (PlayerBuffsList) do
        if nexttime<0 then
            PlayerBuffsList[name]=nil
        elseif nexttime < lowTime then
            lowTime=nexttime
            if nexttime<HealBot_TimeNow+5 then nexttime=HealBot_TimeNow+5 end
            button.aura.buff.nextcheck=nexttime
        end
    end
end

function HealBot_Aura_MarkCheckBuffsTime(button)
        --HealBot_setCall("HealBot_Aura_MarkCheckBuffsTime", button)
    if not button.aura.buff.nextcheck then button.aura.buff.nextcheck=HealBot_TimeNow+5 end
    button.aura.buff.resetcheck=true
end

function HealBot_Aura_SetAuraWarningFlags()
        --HealBot_setCall("HealBot_Aura_SetAuraWarningFlags")
    if HealBot_Config_Buffs.SoundBuffWarning or HealBot_Config_Buffs.ShowBuffWarning then
        buffWarnings=true
    else
        buffWarnings=false
    end
    if HealBot_Config_Cures.SoundDebuffWarning or HealBot_Config_Cures.ShowDebuffWarning then
        debuffWarnings=true
    else
        debuffWarnings=false
    end
end

function HealBot_Aura_SetAuraCheckFlags(debuffMounted, buffMounted, onTaxi, resting, inVehicle)
        --HealBot_setCall("HealBot_Aura_SetAuraCheckFlags")
    tmpBCheck=buffCheck
    tmpGBuffs=generalBuffs
    tmpDCheck=debuffCheck
    tmpNumGroup=GetNumGroupMembers() or 0
    if (not HealBot_Config_Buffs.BuffWatchWhenGrouped or tmpNumGroup>0) then
        tmpBGroup=false
    else
        tmpBGroup=true
    end
    if (not HealBot_Config_Buffs.DebuffWatchWhenGrouped or tmpNumGroup>0) then
        tmpDGroup=false
    else
        tmpDGroup=true
    end

    if resting or onTaxi or buffMounted or inVehicle or tmpBGroup or not HealBot_Config_Buffs.BuffWatch then 
        buffCheck=false
        HealBot_Action_setLuVars("CheckManaDrink", false)
    elseif (HealBot_Config_Buffs.BuffCustomWatchInCombat or not HealBot_Data["UILOCK"]) then
        buffCheck=true
        if (HealBot_Config_Buffs.BuffWatchInCombat or not HealBot_Data["UILOCK"]) then
            generalBuffs=true
            if HealBot_Config_Buffs.CheckManaDrink then
                HealBot_Action_setLuVars("CheckManaDrink", true)
            else
                HealBot_Action_setLuVars("CheckManaDrink", false)
            end
        else
            generalBuffs=false
            HealBot_Action_setLuVars("CheckManaDrink", false)
        end
    else
        buffCheck=false
        HealBot_Action_setLuVars("CheckManaDrink", false)
    end
    
    if resting or onTaxi or debuffMounted or tmpDGroup or inVehicle or not HealBot_Config_Cures.DebuffWatch then 
        debuffCheck=false 
    elseif (HealBot_Config_Cures.DebuffWatchInCombat or not HealBot_Data["UILOCK"]) then
        debuffCheck=true
    else
        debuffCheck=false
    end
    
    if tmpBCheck~=buffCheck or tmpGBuffs~=generalBuffs then
        if tmpBCheck~=buffCheck then
            if tmpBCheck then
                HealBot_Timers_Set("AURA","RemoveAllBuffIcons")
                if HealBot_retLuVars("pluginAuraWatch") then HealBot_Plugin_AuraWatch_RemoveAllBuffAlerts() end
            elseif HealBot_retLuVars("pluginAuraWatch") then 
                HealBot_Plugin_AuraWatch_CheckAfterCancelBuff()
            end
            HealBot_ActionIcons_setLuVars("AllowBuffs", buffCheck)
            HealBot_Timers_Set("SKINS","ActionIconsStateChange",0.1)
        end
        HealBot_Timers_Set("AURA","CheckBuffs")
    end    
    if tmpDCheck~=debuffCheck then
        if tmpDCheck then
            HealBot_Timers_Set("AURA","RemoveAllDebuffIcons")
            if HealBot_retLuVars("pluginAuraWatch") then HealBot_Plugin_AuraWatch_RemoveAllDebuffAlerts() end
        elseif HealBot_retLuVars("pluginAuraWatch") then 
            HealBot_Plugin_AuraWatch_CheckAfterCancelDebuff()
        end
        HealBot_Timers_Set("AURA","CheckDebuffs")
        HealBot_ActionIcons_setLuVars("AllowDebuffs", debuffCheck)
        HealBot_Timers_Set("SKINS","ActionIconsStateChange",0.1)
    end
end

function HealBot_Aura_ClearDebuff(button)
        --HealBot_setCall("HealBot_Aura_ClearDebuff", button)
    if button.aura.debuff.name then
        button.aura.debuff.type=false;
        button.aura.debuff.name=false;
        button.aura.debuff.dispellable=false
        button.aura.debuff.colbar=0
        button.aura.debuff.curespell=false
        button.aura.debuff.id=0
        button.aura.debuff.priority=99;
        HealBot_Aura_AuxClearAuraDebuffBars(button)
        if button.hotbars.debuff then
            HealBot_Action_BarHotDisable(button, "DEBUFF")
        end
        if button.glow.debuff then
            HealBot_Action_DisableButtonGlowType(button, "DEBUFF")
        end
        if button.hazard.debuff then
            HealBot_Action_DisableBorderHazardType(button, "DEBUFF")
        end
        if button.text.tagdebuff then
            HealBot_Text_setNameTag(button)
        end
        HealBot_RefreshUnit(button)
    end
end

function HealBot_Aura_ClearBuff(button)
        --HealBot_setCall("HealBot_Aura_ClearBuff", button)
    if button.aura.buff.name then
        button.aura.buff.name=false
        button.aura.buff.colbar=0
        button.aura.buff.missingbuff=false
        if button.glow.buff then
            HealBot_Action_DisableButtonGlowType(button, "BUFF")
        end
        if button.aura.buff.overdb then
            HealBot_Aura_ClearUnitBuffOverDebuff(button)
        end
        if button.hazard.buff then
            HealBot_Action_DisableBorderHazardType(button, "BUFF")
        end
        HealBot_Aura_AuxClearAuraBuffBars(button)
        HealBot_RefreshUnit(button)
    end
end

local function HealBot_Aura_AuraWatch_PlayerBuffUpdate(guid, aura, count, active, casterIsPlayer)
    xButton, pButton=HealBot_Panel_AllUnitButton(guid)
    if xButton then HealBot_Plugin_AuraWatch_PlayerBuffUpdate(xButton, aura, count, active, casterIsPlayer) end
    if pButton then HealBot_Plugin_AuraWatch_PlayerBuffUpdate(pButton, aura, count, active, casterIsPlayer) end
end

function HealBot_Aura_BuffUpdate_Plugins(button, aura, tag, count, active, casterIsPlayer)
      --HealBot_setCall("HealBot_Aura_BuffUpdate_Plugins", button)
    if hbAuraWatch[button.guid] then
        if active and not count or count<1 then count=1 end
        if hbAuraRequests[button.guid] and hbAuraRequests[button.guid][aura] and active and button.frame<7 then
            HealBot_Plugin_Requests_CancelGUID(button.guid)
            hbAuraRequests[button.guid][aura]=false
        end
        if hbAuraBuffWatch[button.guid] and hbAuraBuffWatch[button.guid][aura] then
            if not active then
                hbAuraBuffWatch[button.guid][aura]=0
                HealBot_Aura_AuraWatch_PlayerBuffUpdate(button.guid, aura, count, active, casterIsPlayer)
            elseif hbAuraBuffWatch[button.guid][aura]~=count then
                hbAuraBuffWatch[button.guid][aura]=count
                HealBot_Aura_AuraWatch_PlayerBuffUpdate(button.guid, aura, count, active, casterIsPlayer)
            end
        end
        if hbAuraActionBuffWatch[button.guid] and hbAuraActionBuffWatch[button.guid][aura] then
            if not active then
                hbAuraActionBuffWatch[button.guid][aura]=0
                HealBot_ActionIcons_BuffUpdate(button.guid, aura, count, active, casterIsPlayer)
            elseif hbAuraActionBuffWatch[button.guid][aura]~=count then
                hbAuraActionBuffWatch[button.guid][aura]=count
                HealBot_ActionIcons_BuffUpdate(button.guid, aura, count, active, casterIsPlayer)
            end
        end
        if tag then
            if not active and ((hbAuraBuffTagWatch[button.guid] and hbAuraBuffTagWatch[button.guid][tag]) or
                               (hbAuraActionBuffTagWatch[button.guid] and hbAuraActionBuffTagWatch[button.guid][tag])) then
                if HealBot_UnitBuffCurrent[button.guid] then
                    for bName, _ in pairs(HealBot_UnitBuffCurrent[button.guid]) do
                        if (HealBot_BuffTagNames[bName] and HealBot_BuffTagNames[bName] == tag) or
                           (HealBot_Globals.CustomBuffTag[HealBot_Aura_ID[bName]] and HealBot_Globals.CustomBuffTag[HealBot_Aura_ID[bName]] == tag) then
                            active=true
                            break
                        end
                    end
                end
            end
            if hbAuraBuffTagWatch[button.guid] and hbAuraBuffTagWatch[button.guid][tag] then
                if not active then
                    hbAuraBuffTagWatch[button.guid][tag]=0
                    HealBot_Plugin_AuraWatch_PlayerBuffTagUpdate(button, tag, count, active, casterIsPlayer)
                elseif hbAuraBuffTagWatch[button.guid][tag] == 0 then
                    hbAuraBuffTagWatch[button.guid][tag]=1
                    HealBot_Plugin_AuraWatch_PlayerBuffTagUpdate(button, tag, count, active, casterIsPlayer)
                end
            end
            if hbAuraActionBuffTagWatch[button.guid] and hbAuraActionBuffTagWatch[button.guid][tag] then
                if not active then
                    hbAuraActionBuffTagWatch[button.guid][tag]=0
                    HealBot_ActionIcons_BuffTagUpdate(button.guid, tag, count, active, casterIsPlayer)
                elseif hbAuraActionBuffTagWatch[button.guid][tag] == 0 then
                    hbAuraActionBuffTagWatch[button.guid][tag]=1
                    HealBot_ActionIcons_BuffTagUpdate(button.guid, tag, count, active, casterIsPlayer)
                end
            end
        end
    end
end

local function HealBot_Aura_AuraWatch_PlayerDebuffUpdate(guid, aura, count, active, casterIsPlayer)
    xButton, pButton=HealBot_Panel_AllUnitButton(guid)
    if xButton then HealBot_Plugin_AuraWatch_PlayerDebuffUpdate(xButton, aura, count, active, casterIsPlayer) end
    if pButton then HealBot_Plugin_AuraWatch_PlayerDebuffUpdate(pButton, aura, count, active, casterIsPlayer) end
end

function HealBot_Aura_DebuffUpdate_Plugins(button, aura, tag, count, active, casterIsPlayer)
      --HealBot_setCall("HealBot_Aura_DebuffUpdate_Plugins", button)
    if hbAuraWatch[button.guid] then
        if count<1 then count=1 end
        if hbAuraDebuffWatch[button.guid] and hbAuraDebuffWatch[button.guid][aura] then
            if not active then
                hbAuraDebuffWatch[button.guid][aura]=0
                HealBot_Aura_AuraWatch_PlayerDebuffUpdate(button.guid, aura, count, active, casterIsPlayer)
            elseif hbAuraDebuffWatch[button.guid][aura]~=count then
                hbAuraDebuffWatch[button.guid][aura]=count
                HealBot_Aura_AuraWatch_PlayerDebuffUpdate(button.guid, aura, count, active, casterIsPlayer)
            end
        end
        if hbAuraActionDebuffWatch[button.guid] and hbAuraActionDebuffWatch[button.guid][aura] then
            if not active then
                hbAuraActionDebuffWatch[button.guid][aura]=0
                HealBot_ActionIcons_DebuffUpdate(button.guid, aura, count, active, casterIsPlayer)
            elseif hbAuraActionDebuffWatch[button.guid][aura]~=count then
                hbAuraActionDebuffWatch[button.guid][aura]=count
                HealBot_ActionIcons_DebuffUpdate(button.guid, aura, count, active, casterIsPlayer)
            end
        end
        if tag then
            if not active and ((hbAuraDebuffTagWatch[button.guid] and hbAuraDebuffTagWatch[button.guid][tag]) or
                               (hbAuraActionDebuffTagWatch[button.guid] and hbAuraActionDebuffTagWatch[button.guid][tag])) then
                if HealBot_UnitDebuffCurrent[button.guid] then
                    for dName, _ in pairs(HealBot_UnitDebuffCurrent[button.guid]) do
                        if (HealBot_DebuffTagNames[dName] and HealBot_DebuffTagNames[dName] == tag) or
                           (HealBot_Globals.CDCTag[HealBot_Aura_ID[dName]] and HealBot_Globals.CDCTag[HealBot_Aura_ID[dName]] == tag) then
                            active=true
                            break
                        end
                    end
                end
            end
            if hbAuraDebuffTagWatch[button.guid] and hbAuraDebuffTagWatch[button.guid][tag] then
                if not active then
                    hbAuraDebuffTagWatch[button.guid][tag]=0
                    HealBot_Plugin_AuraWatch_PlayerDebuffTagUpdate(button, tag, count, active, casterIsPlayer)
                elseif hbAuraDebuffTagWatch[button.guid][tag] == 0 then
                    hbAuraDebuffTagWatch[button.guid][tag]=1
                    HealBot_Plugin_AuraWatch_PlayerDebuffTagUpdate(button, tag, count, active, casterIsPlayer)
                end
            end
            if hbAuraActionDebuffTagWatch[button.guid] and hbAuraActionDebuffTagWatch[button.guid][tag] then
                if not active then
                    hbAuraActionDebuffTagWatch[button.guid][tag]=0
                    HealBot_ActionIcons_DebuffTagUpdate(button.guid, tag, count, active, casterIsPlayer)
                elseif hbAuraActionDebuffTagWatch[button.guid][tag] == 0 then
                    hbAuraActionDebuffTagWatch[button.guid][tag]=1
                    HealBot_ActionIcons_DebuffTagUpdate(button.guid, tag, count, active, casterIsPlayer)
                end
            end
        end
    end
end

function HealBot_Aura_ClearBuffWatch(buffName)
      --HealBot_setCall("HealBot_Aura_ClearBuffWatch")
    if buffName then
        for j=1, #HealBot_BuffWatchList do
            if buffName == HealBot_BuffWatchList[j] then
                table.remove(HealBot_BuffWatchList, j)
                break;
            end
        end
        HealBot_BuffWatch[buffName]=nil
    else
        for x,_ in pairs(HealBot_BuffWatch) do
            HealBot_BuffWatch[x]=nil;
        end
        for x,_ in pairs(HealBot_BuffWatchList) do
            HealBot_BuffWatchList[x]=nil;
        end
    end
end

local addBuffToWatch=true
function HealBot_Aura_SetBuffWatch(buffName)
      --HealBot_setCall("HealBot_Aura_SetBuffWatch")
    addBuffToWatch=true
    for j=1, #HealBot_BuffWatchList do
        if buffName == HealBot_BuffWatchList[j] then
            addBuffToWatch=false
            break;
        end
    end
    if addBuffToWatch then
        table.insert(HealBot_BuffWatchList,buffName)
    end
    HealBot_BuffWatch[buffName]=true
end

function HealBot_Aura_ClearCheckBuffs()
      --HealBot_setCall("HealBot_Aura_ClearCheckBuffs")
    for x,_ in pairs(HealBot_CheckBuffs) do
        HealBot_CheckBuffs[x]=nil;
    end
end

function HealBot_Aura_SetCheckBuffs(buffName)
      --HealBot_setCall("HealBot_Aura_SetCheckBuffs")
    HealBot_CheckBuffs[buffName]=true;
end

local isBuffSpellName=""
function HealBot_Aura_IsBuffSpell(spellId)
      --HealBot_setCall("HealBot_Aura_IsBuffSpell")
    isBuffSpellName=HealBot_WoWAPI_SpellName(spellId) or spellId
    return HealBot_CheckBuffs[isBuffSpellName]
end

function HealBot_Aura_RetMyBuffTime(button,buffName)
      --HealBot_setCall("HealBot_Aura_RetMyBuffTime", button)
    if not button.aura.buff.recheck[buffName] then return end
    if HealBot_ShortBuffs[buffName] then
        return button.aura.buff.recheck[buffName]+HealBot_Config_Buffs.ShortBuffTimer
    else
        return button.aura.buff.recheck[buffName]+HealBot_Config_Buffs.LongBuffTimer
    end
end

local rdType=HEALBOT_CUSTOM_en
function HealBot_Aura_retDebufftype(id)
      --HealBot_setCall("HealBot_Aura_retDebufftype")
    rdType=HEALBOT_CUSTOM_en
    if HealBot_AuraDebuffCache[id] then rdType=HealBot_AuraDebuffCache[id]["debuffType"] end
    return rdType
end

function HealBot_Aura_UpdateActiveDebuffs()
    for _,xButton in pairs(HealBot_Unit_Button) do
        if uaDebuffData[xButton.id].lastslot>0 then
            for x=1,uaDebuffData[xButton.id].lastslot do
                uaDebuffData[xButton.id][x].isCurrent=false
            end
            HealBot_Events_UnitDebuff(xButton)
        end
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        if uaDebuffData[xButton.id].lastslot>0 then
            for x=1,uaDebuffData[xButton.id].lastslot do
                uaDebuffData[xButton.id][x].isCurrent=false
            end
            HealBot_Events_UnitDebuff(xButton)
        end
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        if uaDebuffData[xButton.id].lastslot>0 then
            for x=1,uaDebuffData[xButton.id].lastslot do
                uaDebuffData[xButton.id][x].isCurrent=false
            end
            HealBot_Events_UnitDebuff(xButton)
        end
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        if uaDebuffData[xButton.id].lastslot>0 then
            for x=1,uaDebuffData[xButton.id].lastslot do
                uaDebuffData[xButton.id][x].isCurrent=false
            end
            HealBot_Events_UnitDebuff(xButton)
        end
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        if uaDebuffData[xButton.id].lastslot>0 then
            for x=1,uaDebuffData[xButton.id].lastslot do
                uaDebuffData[xButton.id][x].isCurrent=false
            end
            HealBot_Events_UnitDebuff(xButton)
        end
    end
end

function HealBot_Aura_UpdateAllBuffIcons(button)
      --HealBot_setCall("HealBot_Aura_UpdateAllBuffIcons", button)
    if button then
        for i=1,button.icon.buff.count[1] do
            HealBot_Aura_UpdateBuffIcon(button, HealBot_UnitBuffIcons[button.id][i], i, false, HealBot_UnitBuffIcons[button.id][i]["spellId"])
        end
        for i=9,button.icon.buff.count[2]+8 do
            HealBot_Aura_UpdateBuffIcon(button, HealBot_UnitBuffIcons[button.id][i], i, false, HealBot_UnitBuffIcons[button.id][i]["spellId"])
        end
        for i=11,button.icon.buff.count[3]+10 do
            HealBot_Aura_UpdateBuffIcon(button, HealBot_UnitBuffIcons[button.id][i], i, false, HealBot_UnitBuffIcons[button.id][i]["spellId"])
        end
    else
        for _,xButton in pairs(HealBot_Unit_Button) do
            for i=1,xButton.icon.buff.count[1] do
                HealBot_Aura_UpdateBuffIcon(xButton, HealBot_UnitBuffIcons[xButton.id][i], i, false, HealBot_UnitBuffIcons[xButton.id][i]["spellId"])
            end
            for i=9,xButton.icon.buff.count[2]+8 do
                HealBot_Aura_UpdateBuffIcon(xButton, HealBot_UnitBuffIcons[xButton.id][i], i, false, HealBot_UnitBuffIcons[xButton.id][i]["spellId"])
            end
            for i=11,xButton.icon.buff.count[3]+10 do
                HealBot_Aura_UpdateBuffIcon(xButton, HealBot_UnitBuffIcons[xButton.id][i], i, false, HealBot_UnitBuffIcons[xButton.id][i]["spellId"])
            end
        end
        for _,xButton in pairs(HealBot_Private_Button) do
            for i=1,xButton.icon.buff.count[1] do
                HealBot_Aura_UpdateBuffIcon(xButton, HealBot_UnitBuffIcons[xButton.id][i], i, false, HealBot_UnitBuffIcons[xButton.id][i]["spellId"])
            end
            for i=9,xButton.icon.buff.count[2]+8 do
                HealBot_Aura_UpdateBuffIcon(xButton, HealBot_UnitBuffIcons[xButton.id][i], i, false, HealBot_UnitBuffIcons[xButton.id][i]["spellId"])
            end
            for i=11,xButton.icon.buff.count[3]+10 do
                HealBot_Aura_UpdateBuffIcon(xButton, HealBot_UnitBuffIcons[xButton.id][i], i, false, HealBot_UnitBuffIcons[xButton.id][i]["spellId"])
            end
        end
        for _,xButton in pairs(HealBot_Pet_Button) do
            for i=1,xButton.icon.buff.count[1] do
                HealBot_Aura_UpdateBuffIcon(xButton, HealBot_UnitBuffIcons[xButton.id][i], i, false, HealBot_UnitBuffIcons[xButton.id][i]["spellId"])
            end
            for i=9,xButton.icon.buff.count[2]+8 do
                HealBot_Aura_UpdateBuffIcon(xButton, HealBot_UnitBuffIcons[xButton.id][i], i, false, HealBot_UnitBuffIcons[xButton.id][i]["spellId"])
            end
            for i=11,xButton.icon.buff.count[3]+10 do
                HealBot_Aura_UpdateBuffIcon(xButton, HealBot_UnitBuffIcons[xButton.id][i], i, false, HealBot_UnitBuffIcons[xButton.id][i]["spellId"])
            end
        end
        for _,xButton in pairs(HealBot_Vehicle_Button) do
            for i=1,xButton.icon.buff.count[1] do
                HealBot_Aura_UpdateBuffIcon(xButton, HealBot_UnitBuffIcons[xButton.id][i], i, false, HealBot_UnitBuffIcons[xButton.id][i]["spellId"])
            end
            for i=9,xButton.icon.buff.count[2]+8 do
                HealBot_Aura_UpdateBuffIcon(xButton, HealBot_UnitBuffIcons[xButton.id][i], i, false, HealBot_UnitBuffIcons[xButton.id][i]["spellId"])
            end
            for i=11,xButton.icon.buff.count[3]+10 do
                HealBot_Aura_UpdateBuffIcon(xButton, HealBot_UnitBuffIcons[xButton.id][i], i, false, HealBot_UnitBuffIcons[xButton.id][i]["spellId"])
            end
        end
        for _,xButton in pairs(HealBot_Extra_Button) do
            for i=1,xButton.icon.buff.count[1] do
                HealBot_Aura_UpdateBuffIcon(xButton, HealBot_UnitBuffIcons[xButton.id][i], i, false, HealBot_UnitBuffIcons[xButton.id][i]["spellId"])
            end
            for i=9,xButton.icon.buff.count[2]+8 do
                HealBot_Aura_UpdateBuffIcon(xButton, HealBot_UnitBuffIcons[xButton.id][i], i, false, HealBot_UnitBuffIcons[xButton.id][i]["spellId"])
            end
            for i=11,xButton.icon.buff.count[3]+10 do
                HealBot_Aura_UpdateBuffIcon(xButton, HealBot_UnitBuffIcons[xButton.id][i], i, false, HealBot_UnitBuffIcons[xButton.id][i]["spellId"])
            end
        end
    end
end

function HealBot_Aura_UpdateAllDebuffIcons(button)
      --HealBot_setCall("HealBot_Aura_UpdateAllDebuffIcons", button)
    if button then
        for i=51,button.icon.debuff.count[1]+50 do
            HealBot_Aura_UpdateDebuffIcon(button, HealBot_UnitDebuffIcons[button.id][i], i, false, HealBot_UnitDebuffIcons[button.id][i]["spellId"])
        end
        for i=57,button.icon.debuff.count[2]+56 do
            HealBot_Aura_UpdateDebuffIcon(button, HealBot_UnitDebuffIcons[button.id][i], i, false, HealBot_UnitDebuffIcons[button.id][i]["spellId"])
        end
        for i=59,button.icon.debuff.count[3]+58 do
            HealBot_Aura_UpdateDebuffIcon(button, HealBot_UnitDebuffIcons[button.id][i], i, false, HealBot_UnitDebuffIcons[button.id][i]["spellId"])
        end
    else
        for _,xButton in pairs(HealBot_Unit_Button) do
            for i=51,xButton.icon.debuff.count[1]+50 do
                HealBot_Aura_UpdateDebuffIcon(xButton, HealBot_UnitDebuffIcons[xButton.id][i], i, false, HealBot_UnitDebuffIcons[xButton.id][i]["spellId"])
            end
            for i=57,xButton.icon.debuff.count[2]+56 do
                HealBot_Aura_UpdateDebuffIcon(xButton, HealBot_UnitDebuffIcons[xButton.id][i], i, false, HealBot_UnitDebuffIcons[xButton.id][i]["spellId"])
            end
            for i=59,xButton.icon.debuff.count[3]+58 do
                HealBot_Aura_UpdateDebuffIcon(xButton, HealBot_UnitDebuffIcons[xButton.id][i], i, false, HealBot_UnitDebuffIcons[xButton.id][i]["spellId"])
            end
        end
        for _,xButton in pairs(HealBot_Private_Button) do
            for i=51,xButton.icon.debuff.count[1]+50 do
                HealBot_Aura_UpdateDebuffIcon(xButton, HealBot_UnitDebuffIcons[xButton.id][i], i, false, HealBot_UnitDebuffIcons[xButton.id][i]["spellId"])
            end
            for i=57,xButton.icon.debuff.count[2]+56 do
                HealBot_Aura_UpdateDebuffIcon(xButton, HealBot_UnitDebuffIcons[xButton.id][i], i, false, HealBot_UnitDebuffIcons[xButton.id][i]["spellId"])
            end
            for i=59,xButton.icon.debuff.count[3]+58 do
                HealBot_Aura_UpdateDebuffIcon(xButton, HealBot_UnitDebuffIcons[xButton.id][i], i, false, HealBot_UnitDebuffIcons[xButton.id][i]["spellId"])
            end
        end
        for _,xButton in pairs(HealBot_Pet_Button) do
            for i=51,xButton.icon.debuff.count[1]+50 do
                HealBot_Aura_UpdateDebuffIcon(xButton, HealBot_UnitDebuffIcons[xButton.id][i], i, false, HealBot_UnitDebuffIcons[xButton.id][i]["spellId"])
            end
            for i=57,xButton.icon.debuff.count[2]+56 do
                HealBot_Aura_UpdateDebuffIcon(xButton, HealBot_UnitDebuffIcons[xButton.id][i], i, false, HealBot_UnitDebuffIcons[xButton.id][i]["spellId"])
            end
            for i=59,xButton.icon.debuff.count[3]+58 do
                HealBot_Aura_UpdateDebuffIcon(xButton, HealBot_UnitDebuffIcons[xButton.id][i], i, false, HealBot_UnitDebuffIcons[xButton.id][i]["spellId"])
            end
        end
        for _,xButton in pairs(HealBot_Vehicle_Button) do
            for i=51,xButton.icon.debuff.count[1]+50 do
                HealBot_Aura_UpdateDebuffIcon(xButton, HealBot_UnitDebuffIcons[xButton.id][i], i, false, HealBot_UnitDebuffIcons[xButton.id][i]["spellId"])
            end
            for i=57,xButton.icon.debuff.count[2]+56 do
                HealBot_Aura_UpdateDebuffIcon(xButton, HealBot_UnitDebuffIcons[xButton.id][i], i, false, HealBot_UnitDebuffIcons[xButton.id][i]["spellId"])
            end
            for i=59,xButton.icon.debuff.count[3]+58 do
                HealBot_Aura_UpdateDebuffIcon(xButton, HealBot_UnitDebuffIcons[xButton.id][i], i, false, HealBot_UnitDebuffIcons[xButton.id][i]["spellId"])
            end
        end
        for _,xButton in pairs(HealBot_Extra_Button) do
            for i=51,xButton.icon.debuff.count[1]+50 do
                HealBot_Aura_UpdateDebuffIcon(xButton, HealBot_UnitDebuffIcons[xButton.id][i], i, false, HealBot_UnitDebuffIcons[xButton.id][i]["spellId"])
            end
            for i=57,xButton.icon.debuff.count[2]+56 do
                HealBot_Aura_UpdateDebuffIcon(xButton, HealBot_UnitDebuffIcons[xButton.id][i], i, false, HealBot_UnitDebuffIcons[xButton.id][i]["spellId"])
            end
            for i=59,xButton.icon.debuff.count[3]+58 do
                HealBot_Aura_UpdateDebuffIcon(xButton, HealBot_UnitDebuffIcons[xButton.id][i], i, false, HealBot_UnitDebuffIcons[xButton.id][i]["spellId"])
            end
        end
    end
end

function HealBot_Update_AllExtraIcons(button, index)
      --HealBot_setCall("HealBot_Update_AllExtraIcons", button)
    if button then
        if HealBot_UnitExtraIcons[button.id][index].current then
            HealBot_Aura_UpdateExtraIcon(button, HealBot_UnitExtraIcons[button.id][index], index)
        end
    else
        for _,xButton in pairs(HealBot_Unit_Button) do
            if HealBot_UnitExtraIcons[xButton.id] and HealBot_UnitExtraIcons[xButton.id][index].current then
                HealBot_Aura_UpdateExtraIcon(xButton, HealBot_UnitExtraIcons[xButton.id][index], index)
            end
        end
        for _,xButton in pairs(HealBot_Private_Button) do
            if HealBot_UnitExtraIcons[xButton.id] and HealBot_UnitExtraIcons[xButton.id][index].current then
                HealBot_Aura_UpdateExtraIcon(xButton, HealBot_UnitExtraIcons[xButton.id][index], index)
            end
        end
        for _,xButton in pairs(HealBot_Pet_Button) do
            if HealBot_UnitExtraIcons[xButton.id] and HealBot_UnitExtraIcons[xButton.id][index].current then
                HealBot_Aura_UpdateExtraIcon(xButton, HealBot_UnitExtraIcons[xButton.id][index], index)
            end
        end
        for _,xButton in pairs(HealBot_Vehicle_Button) do
            if HealBot_UnitExtraIcons[xButton.id] and HealBot_UnitExtraIcons[xButton.id][index].current then
                HealBot_Aura_UpdateExtraIcon(xButton, HealBot_UnitExtraIcons[xButton.id][index], index)
            end
        end
        for _,xButton in pairs(HealBot_Extra_Button) do
            if HealBot_UnitExtraIcons[xButton.id] and HealBot_UnitExtraIcons[xButton.id][index].current then
                HealBot_Aura_UpdateExtraIcon(xButton, HealBot_UnitExtraIcons[xButton.id][index], index)
            end
        end
    end
end

function HealBot_Aura_Update_AllIcons(button)
      --HealBot_setCall("HealBot_Aura_Update_AllIcons", button)
    HealBot_Aura_UpdateAllBuffIcons(button)
    HealBot_Aura_UpdateAllDebuffIcons(button)
    for i=91,94 do
        HealBot_Update_AllExtraIcons(button, i)
    end
end

function HealBot_Aura_ReturnHoTdetails(buttonId)
      --HealBot_setCall("HealBot_Aura_ReturnHoTdetails")
    return HealBot_UnitBuffIcons[buttonId]
end

function HealBot_Aura_ReturnBuffSpellId(buttonId, iconId)
      --HealBot_setCall("HealBot_Aura_ReturnBuffSpellId")
    return HealBot_UnitBuffIcons[buttonId][iconId]["spellId"]
end

function HealBot_Aura_ReturnHoTdetailsname(spellId)
      --HealBot_setCall("HealBot_Aura_ReturnHoTdetailsname")
    if HealBot_AuraBuffCache[spellId] then
        return HealBot_AuraBuffCache[spellId]["name"]
    else
        return false
    end
end

function HealBot_Aura_ReturnDebuffdetails(buttonId)
      --HealBot_setCall("HealBot_Aura_ReturnDebuffdetails")
    return HealBot_UnitDebuffIcons[buttonId]
end

function HealBot_Aura_ReturnDebuffSpellId(buttonId, iconId)
      --HealBot_setCall("HealBot_Aura_ReturnDebuffSpellId")
    return HealBot_UnitDebuffIcons[buttonId][iconId]["spellId"]
end

function HealBot_Aura_ReturnDebuffdetailsname(spellId)
      --HealBot_setCall("HealBot_Aura_ReturnDebuffdetailsname")
    if HealBot_AuraDebuffCache[spellId] then
        return HealBot_AuraDebuffCache[spellId]["name"]
    else
        return false
    end
end

function HealBot_Aura_RemoveIcons(button)
      --HealBot_setCall("HealBot_Aura_RemoveIcons", button)
    HealBot_Aura_RemoveBuffIcons(button)
    HealBot_Aura_RemoveDebuffIcons(button)
    for i=91,94 do
        HealBot_Aura_RemoveExtraUnitIcons(button, i)
    end
end

local function HealBot_Aura_ConfigClassAllHoT(id, sName, wType)
      --HealBot_setCall("HealBot_Aura_ConfigClassAllHoT")
    if (HealBot_Globals.CustomBuffIDMethod[id] or 3)<3 then
        if HealBot_Globals.CustomBuffIDMethod[id] == 2 and sName then
            HealBot_Watch_HoT[sName]=wType
        else
            HealBot_Watch_HoT[id]=wType
        end
    else
        HealBot_Watch_HoT[id]=wType
        if sName then HealBot_Watch_HoT[sName]=wType end
    end
end

local function HealBot_Aura_ConfigBuffIconSetId(id, sName, set)
      --HealBot_setCall("HealBot_Aura_ConfigBuffIconSetId")
    if (HealBot_Globals.CustomBuffIDMethod[id] or 3)<3 then
        if HealBot_Globals.CustomBuffIDMethod[id] == 2 and sName then
            HealBot_BuffIconSet[sName]=set
        else
            HealBot_BuffIconSet[id]=set
        end
    else
        HealBot_BuffIconSet[id]=set
        if sName then HealBot_BuffIconSet[sName]=set end
    end
end

local function HealBot_Aura_ConfigBuffIconGlowId(id, sName, glow)
      --HealBot_setCall("HealBot_Aura_ConfigBuffIconGlowId")
    if (HealBot_Globals.CustomBuffIDMethod[id] or 3)<3 then
        if HealBot_Globals.CustomBuffIDMethod[id] == 2 and sName then
            HealBot_BuffIconGlow[sName]=glow
        else
            HealBot_BuffIconGlow[id]=glow
        end
    else
        HealBot_BuffIconGlow[id]=glow
        if sName then HealBot_BuffIconGlow[sName]=glow end
    end
end

function HealBot_Aura_ConfigClassHoT()
      --HealBot_setCall("HealBot_configClassHoT")
    local hbClassHoTwatch=HealBot_Globals.WatchHoT
    for id,_ in pairs(HealBot_Watch_HoT) do
        HealBot_Watch_HoT[id]=nil
    end
    for id,_ in pairs(HealBot_BuffIconSet) do
        HealBot_BuffIconSet[id]=nil
    end
    for id,_ in pairs(HealBot_BuffIconGlow) do
        HealBot_BuffIconGlow[id]=nil
    end
    for xClass,_  in pairs(hbClassHoTwatch) do
        local HealBot_configClassHoTClass=HealBot_Globals.WatchHoT[xClass]
        for id,x  in pairs(HealBot_configClassHoTClass) do
            local sName=false
            if type(id)~="number" and not HealBot_SpellID_LookupData[id] then
                HealBot_SpellID_LookupData[id]={}
                HealBot_SpellID_LookupData[id]["CHECK"]=true
                HealBot_SpellID_LookupData[id]["CLASS"]=xClass
                sName=id
            elseif HealBot_WoWAPI_SpellName(id) then
                sName=HealBot_WoWAPI_SpellName(id)
            end
            if x == 1 then
                HealBot_Aura_ConfigClassAllHoT(id, sName, "S")
            elseif x == 2 then
                HealBot_Aura_ConfigClassAllHoT(id, sName, "C")
            else
                HealBot_Aura_ConfigClassAllHoT(id, sName, "A")
            end
            if HealBot_Globals.HealBot_Custom_Buffs_IconSet[id] then
                HealBot_Aura_ConfigBuffIconSetId(id, sName, HealBot_Globals.HealBot_Custom_Buffs_IconSet[id])
            end
            if HealBot_Globals.HealBot_Custom_Buffs_IconGlow[id] then
                HealBot_Aura_ConfigBuffIconGlowId(id, sName, HealBot_Globals.HealBot_Custom_Buffs_IconGlow[id])
            end
        end
    end
    HealBot_Timers_Set("AURA","ResetBuffCache")
    HealBot_Timers_Set("AURA","UpdateAllBuffIcons")
end

local function HealBot_Aura_ConfigDebuffIconSetId(id, sName, set)
      --HealBot_setCall("HealBot_Aura_ConfigDebuffIconSetId")
    if (HealBot_Globals.CustomDebuffIDMethod[id] or 3)<3 then
        if HealBot_Globals.CustomDebuffIDMethod[id] == 2 and sName then
            HealBot_DebuffIconSet[sName]=set
        else
            HealBot_DebuffIconSet[id]=set
        end
    else
        HealBot_DebuffIconSet[id]=set
        if sName then HealBot_DebuffIconSet[sName]=set end
    end
end

local function HealBot_Aura_ConfigDebuffIconSetGlow(id, sName, glow)
      --HealBot_setCall("HealBot_Aura_ConfigDebuffIconSetGlow")
    if (HealBot_Globals.CustomDebuffIDMethod[id] or 3)<3 then
        if HealBot_Globals.CustomDebuffIDMethod[id] == 2 and sName then
            HealBot_DebuffIconGlow[sName]=glow
        else
            HealBot_DebuffIconGlow[id]=glow
        end
    else
        HealBot_DebuffIconGlow[id]=glow
        if sName then HealBot_DebuffIconGlow[sName]=glow end
    end
end

function HealBot_Aura_ConfigDebuffs()
      --HealBot_setCall("HealBot_Aura_ConfigDebuffs")
    for id,_ in pairs(HealBot_DebuffIconGlow) do
        HealBot_DebuffIconGlow[id]=nil
    end
    for id,_ in pairs(HealBot_DebuffIconSet) do
        HealBot_DebuffIconSet[id]=nil
    end
    for id, _ in pairs(HealBot_Globals.HealBot_Custom_Debuffs) do
        if HealBot_Globals.HealBot_Custom_Debuffs_IconSet[id] then
            local sName=HealBot_WoWAPI_SpellName(id)
            HealBot_Aura_ConfigDebuffIconSetId(id, sName, HealBot_Globals.HealBot_Custom_Debuffs_IconSet[id])
        end
        if HealBot_Globals.HealBot_Custom_Debuffs_IconGlow[id] then
            local sName=HealBot_WoWAPI_SpellName(id)
            HealBot_Aura_ConfigDebuffIconSetGlow(id, sName, HealBot_Globals.HealBot_Custom_Debuffs_IconGlow[id])
        end
    end
    HealBot_Timers_Set("AURA","UpdateAllDebuffIcons")
end

function HealBot_Aura_BuffTagNames()
      --HealBot_setCall("HealBot_Aura_BuffTagNames")
    for x,_ in pairs(HealBot_BuffTagNames) do
        HealBot_BuffTagNames[x]=nil;
    end
    for id,tag in pairs(HealBot_Globals.CustomBuffTag) do
        if (HealBot_Globals.CustomBuffIDMethod[id] or 3)>1 then
            local sName=HealBot_Options_SpellGetName(id)
            if sName then HealBot_BuffTagNames[sName]=tag end
        end
    end
end

function HealBot_Aura_DebuffTagNames()
      --HealBot_setCall("HealBot_Aura_DebuffTagNames")
    for x,_ in pairs(HealBot_DebuffTagNames) do
        HealBot_DebuffTagNames[x]=nil;
    end
    for id,tag in pairs(HealBot_Globals.CDCTag) do
        if (HealBot_Globals.CustomDebuffIDMethod[id] or 3)>1 then
            local sName=HealBot_Options_SpellGetName(id)
            if sName then HealBot_DebuffTagNames[sName]=tag end
        end
    end
end

function HealBot_Aura_BuffIdLookup()
      --HealBot_setCall("HealBot_Aura_BuffIdLookup")
    if HealBot_SpellID_LookupIdx[1] then
        local sName=HealBot_SpellID_LookupIdx[1]
        local sID=HealBot_SpellID_LookupData[sName]["ID"]
        local class=HealBot_SpellID_LookupData[sName]["CLASS"]
        table.remove(HealBot_SpellID_LookupIdx,1)
        if HealBot_WoWAPI_SpellName(sID) and HealBot_WoWAPI_SpellName(sID) == sName and HealBot_Globals.WatchHoT[class][sName] then
            HealBot_Globals.WatchHoT[class][sID]=HealBot_Globals.WatchHoT[class][sName]
            if HealBot_Globals.IgnoreCustomBuff[sName] then
                HealBot_Globals.IgnoreCustomBuff[sID]=HealBot_Options_copyTable(HealBot_Globals.IgnoreCustomBuff[sName])
            end
            if HealBot_Globals.HealBot_Custom_Buffs[sName] then
                HealBot_Globals.HealBot_Custom_Buffs[sID]=HealBot_Globals.HealBot_Custom_Buffs[sName]
            end
            if HealBot_Globals.CustomBuffBarColour[sName] then
                HealBot_Globals.CustomBuffBarColour[sID]=HealBot_Options_copyTable(HealBot_Globals.CustomBuffBarColour[sName])
            end
            if HealBot_Globals.HealBot_Custom_Buffs_ShowBarCol[sName] then
                HealBot_Globals.HealBot_Custom_Buffs_ShowBarCol[sID]=HealBot_Globals.HealBot_Custom_Buffs_ShowBarCol[sName]
            end
            if HealBot_Globals.HealBot_Custom_Buffs_IconSet[sName] then
                HealBot_Globals.HealBot_Custom_Buffs_IconSet[sID]=HealBot_Globals.HealBot_Custom_Buffs_IconSet[sName]
            end
            if HealBot_Globals.HealBot_Custom_Buffs_IconGlow[sName] then
                HealBot_Globals.HealBot_Custom_Buffs_IconGlow[sID]=HealBot_Globals.HealBot_Custom_Buffs_IconGlow[sName]
            end
            HealBot_Options_DeleteBuffHoT(class, sName, sName)
        end
        HealBot_Timers_Set("OOC","BuffIdLookup",0.2)
    end
end

local function HealBot_Aura_InitItem2BuffsNames(buffId, itemId)
      --HealBot_setCall("HealBot_Aura_InitItem2BuffsNames")
    if HealBot_IsItemInBag(itemId) then
        local sName=HealBot_WoWAPI_SpellName(buffId)
        if sName then HealBot_Buff_Aura2Item[sName]=itemId end
    end
end

local hbWeaponEnchants={}
function HealBot_Aura_WeaponEnchants(spell, x)
      --HealBot_setCall("HealBot_Aura_WeaponEnchants")
    if hbWeaponEnchants[spell] and HealBot_WoWAPI_SpellName(spell) then
        HealBot_Weapon_Enchant[x]=HealBot_WoWAPI_SpellName(spell)
    elseif hbWeaponEnchants[spell] and HealBot_WoWAPI_ItemInfo(spell) then
        HealBot_Weapon_Enchant[x]=HealBot_WoWAPI_ItemInfo(spell)
    else
        HealBot_Weapon_Enchant[x]=false
    end
end

function HealBot_Aura_UpdateItemData(iName, id)
      --HealBot_setCall("HealBot_Aura_UpdateItemData")
    if iName then
        if HealBot_IsItemInBag(id) then 
            hbWeaponEnchants[iName]=true
        else
            hbWeaponEnchants[iName]=false 
        end
        HealBot_Aura_WeaponEnchants(iName, 1)
        if hbWeaponEnchants[1] then
            return hbWeaponEnchants[iName]
        end
    end
    return false
end

local InitItemsDataPrev={["MANADRINK"]=false, ["WELLFED"]=false, ["Vanilla1"]=false, ["Vanilla2"]=false, ["Vanilla3"]=false, ["Vanilla4"]=false, ["Vanilla5"]=false}
local InitItemsDataUpdate=false
function HealBot_Aura_InitItemsDataReady()
      --HealBot_setCall("HealBot_Aura_InitItemsDataReady")
    local hbCustomItemID,hbCustomSpellID=0,0
    InitItemsDataUpdate=false
    
    if HEALBOT_GAME_VERSION<4 then
        if HealBot_Aura_UpdateItemData(HealBot_WoWAPI_ItemInfo(HEALBOT_BRILLIANT_MANA_OIL_SPELL), HEALBOT_BRILLIANT_MANA_OIL_SPELL) and not InitItemsDataPrev["Vanilla1"] then
            InitItemsDataPrev["Vanilla1"]=true
            InitItemsDataUpdate=true
        elseif InitItemsDataPrev["Vanilla1"] then
            InitItemsDataPrev["Vanilla1"]=false
            InitItemsDataUpdate=true
        end
        if HealBot_Aura_UpdateItemData(HealBot_WoWAPI_ItemInfo(HEALBOT_BRILLIANT_WIZARD_OIL_SPELL), HEALBOT_BRILLIANT_WIZARD_OIL_SPELL) and not InitItemsDataPrev["Vanilla2"] then
            InitItemsDataPrev["Vanilla2"]=true
            InitItemsDataUpdate=true
        elseif InitItemsDataPrev["Vanilla2"] then
            InitItemsDataPrev["Vanilla2"]=false
            InitItemsDataUpdate=true
        end
        if HealBot_Aura_UpdateItemData(HealBot_WoWAPI_ItemInfo(HEALBOT_BLESSED_WIZARD_OIL_SPELL), HEALBOT_BLESSED_WIZARD_OIL_SPELL) and not InitItemsDataPrev["Vanilla3"] then
            InitItemsDataPrev["Vanilla3"]=true
            InitItemsDataUpdate=true
        elseif InitItemsDataPrev["Vanilla3"] then
            InitItemsDataPrev["Vanilla3"]=false
            InitItemsDataUpdate=true
        end
        if HEALBOT_GAME_VERSION>1 then
            if HealBot_Aura_UpdateItemData(HealBot_WoWAPI_ItemInfo(HEALBOT_SUPERIOR_WIZARD_OIL_SPELL), HEALBOT_SUPERIOR_WIZARD_OIL_SPELL) and not InitItemsDataPrev["Vanilla4"] then
                InitItemsDataPrev["Vanilla4"]=true
                InitItemsDataUpdate=true
            elseif InitItemsDataPrev["Vanilla4"] then
                InitItemsDataPrev["Vanilla4"]=false
                InitItemsDataUpdate=true
            end
            if HealBot_Aura_UpdateItemData(HealBot_WoWAPI_ItemInfo(HEALBOT_SUPERIOR_MANA_OIL_SPELL), HEALBOT_SUPERIOR_MANA_OIL_SPELL) and not InitItemsDataPrev["Vanilla5"] then
                InitItemsDataPrev["Vanilla5"]=true
                InitItemsDataUpdate=true
            elseif InitItemsDataPrev["Vanilla5"] then
                InitItemsDataPrev["Vanilla5"]=false
                InitItemsDataUpdate=true
            end
        end
    end

    for x,_ in pairs(HealBot_Buff_Aura2Item) do
        HealBot_Buff_Aura2Item[x]=nil;
    end
    
    HealBot_Aura_luVars["ManaDrink"]=""
    if HealBot_Config_Buffs.CheckManaDrink then
        InitItemsDataPrev["MANADRINK"]=true
        hbCustomItemID=HealBot_WoWAPI_ItemInfoInstant(HealBot_Config_Buffs.ManaDrinkItem or "x") or 0
        if hbCustomItemID>0 and HealBot_IsItemInBag(hbCustomItemID) and (IsInInstance() or not HealBot_Config_Buffs.ExtraBuffsOnlyInInstance) then
            if HealBot_BuffWatch[HealBot_Config_Buffs.BackupManaDrinkItem] then HealBot_Aura_ClearBuffWatch(HealBot_Config_Buffs.BackupManaDrinkItem) end
            HealBot_Buff_Aura2Item[HEALBOT_MANA_DRINK]=hbCustomItemID
            HealBot_Aura_luVars["ManaDrink"]=HealBot_Config_Buffs.ManaDrinkItem
            if not HealBot_BuffWatch[HealBot_Aura_luVars["ManaDrink"]] then
                HealBot_Aura_SetBuffWatch(HealBot_Aura_luVars["ManaDrink"])
                InitItemsDataUpdate=true
            end
        else
            if HealBot_BuffWatch[HealBot_Config_Buffs.ManaDrinkItem] then 
                HealBot_Aura_ClearBuffWatch(HealBot_Config_Buffs.ManaDrinkItem)
                InitItemsDataUpdate=true
            end
            hbCustomItemID=HealBot_WoWAPI_ItemInfoInstant(HealBot_Config_Buffs.BackupManaDrinkItem or "x") or 0
            if hbCustomItemID>0 and HealBot_IsItemInBag(hbCustomItemID) and (IsInInstance() or not HealBot_Config_Buffs.ExtraBuffsOnlyInInstance) then
                HealBot_Buff_Aura2Item[HEALBOT_MANA_DRINK]=hbCustomItemID
                HealBot_Aura_luVars["ManaDrink"]=HealBot_Config_Buffs.BackupManaDrinkItem
                if not HealBot_BuffWatch[HealBot_Aura_luVars["ManaDrink"]] then
                    HealBot_Aura_SetBuffWatch(HealBot_Aura_luVars["ManaDrink"])
                    InitItemsDataUpdate=true
                end
            elseif HealBot_BuffWatch[HealBot_Config_Buffs.BackupManaDrinkItem] then
                HealBot_Aura_ClearBuffWatch(HealBot_Config_Buffs.BackupManaDrinkItem)
                InitItemsDataUpdate=true
            end
        end
    elseif InitItemsDataPrev["MANADRINK"] then
        InitItemsDataPrev["MANADRINK"]=false
        InitItemsDataUpdate=true
    end
    
    if HealBot_Config_Buffs.CheckWellFed then
        InitItemsDataPrev["WELLFED"]=true
        hbCustomItemID=HealBot_WoWAPI_ItemInfoInstant(HealBot_Config_Buffs.WellFedItem or "x") or 0
        if hbCustomItemID>0 and HealBot_IsItemInBag(hbCustomItemID) and (IsInInstance() or not HealBot_Config_Buffs.ExtraBuffsOnlyInInstance) then
            if HealBot_BuffWatch[HealBot_Config_Buffs.BackupWellFedItem] then HealBot_Aura_ClearBuffWatch(HealBot_Config_Buffs.BackupWellFedItem) end
            HealBot_Buff_Aura2Item[HEALBOT_WELL_FED]=hbCustomItemID
            HealBot_Aura_luVars["WellFed"]=HealBot_Config_Buffs.WellFedItem
            if not HealBot_BuffWatch[HealBot_Aura_luVars["WellFed"]] then
                HealBot_Aura_SetBuffWatch(HealBot_Aura_luVars["WellFed"])
                InitItemsDataUpdate=true
            end
        else
            if HealBot_BuffWatch[HealBot_Config_Buffs.WellFedItem] then 
                HealBot_Aura_ClearBuffWatch(HealBot_Config_Buffs.WellFedItem) 
                InitItemsDataUpdate=true
            end
            hbCustomItemID=HealBot_WoWAPI_ItemInfoInstant(HealBot_Config_Buffs.BackupWellFedItem or "x") or 0
            if hbCustomItemID>0 and HealBot_IsItemInBag(hbCustomItemID) and (IsInInstance() or not HealBot_Config_Buffs.ExtraBuffsOnlyInInstance) then
                HealBot_Buff_Aura2Item[HEALBOT_WELL_FED]=hbCustomItemID
                HealBot_Aura_luVars["WellFed"]=HealBot_Config_Buffs.BackupWellFedItem
                if not HealBot_BuffWatch[HealBot_Aura_luVars["WellFed"]] then
                    HealBot_Aura_SetBuffWatch(HealBot_Aura_luVars["WellFed"])
                    InitItemsDataUpdate=true
                end
            elseif HealBot_BuffWatch[HealBot_Config_Buffs.BackupWellFedItem] then
                HealBot_Aura_ClearBuffWatch(HealBot_Config_Buffs.BackupWellFedItem)
                InitItemsDataUpdate=true
            end
        end
    elseif InitItemsDataPrev["WELLFED"] then
        InitItemsDataPrev["WELLFED"]=false
        InitItemsDataUpdate=true
    end

    for x=1,4 do
        if string.len(HealBot_Config_Buffs.CustomBuffName[x])>0 then
            _,_,_,_,_,_,hbCustomSpellID=HealBot_WoWAPI_SpellInfo(HealBot_Config_Buffs.CustomItemName[x])
            InitItemsDataPrev[x]=true
            if not hbCustomSpellID then
                hbCustomItemID=HealBot_WoWAPI_ItemInfoInstant(HealBot_Config_Buffs.CustomItemName[x]) or 0
            end
            if HealBot_Config_Buffs.CustomBuffCheck[x] and hbCustomSpellID and (IsInInstance() or not HealBot_Config_Buffs.ExtraBuffsOnlyInInstance) then
                HealBot_Buff_Aura2Spell[HealBot_Config_Buffs.CustomBuffName[x]]=hbCustomSpellID
                if not HealBot_BuffWatch[HealBot_Config_Buffs.CustomItemName[x]] then
                    HealBot_Aura_SetBuffWatch(HealBot_Config_Buffs.CustomItemName[x])
                    InitItemsDataUpdate=true
                end
            elseif HealBot_Config_Buffs.CustomBuffCheck[x] and hbCustomItemID>0 and HealBot_IsItemInBag(hbCustomItemID) and (IsInInstance() or not HealBot_Config_Buffs.ExtraBuffsOnlyInInstance) then
                HealBot_Buff_Aura2Item[HealBot_Config_Buffs.CustomBuffName[x]]=hbCustomItemID
                if not HealBot_BuffWatch[HealBot_Config_Buffs.CustomItemName[x]] then
                    HealBot_Aura_SetBuffWatch(HealBot_Config_Buffs.CustomItemName[x])
                    InitItemsDataUpdate=true
                end
            elseif HealBot_BuffWatch[HealBot_Config_Buffs.CustomItemName[x]] and not HealBot_Options_retBuffWatchTarget(HealBot_Config_Buffs.CustomItemName[x]) then
                HealBot_Aura_ClearBuffWatch(HealBot_Config_Buffs.CustomItemName[x])
                InitItemsDataUpdate=true
            end
        elseif InitItemsDataPrev[x] then
            InitItemsDataPrev[x]=false
            InitItemsDataUpdate=true
        end
    end
    
    if InitItemsDataUpdate then
        for x,_ in pairs(HealBot_Buff_ItemIDs) do
            HealBot_Buff_ItemIDs[x]=nil;
        end
        for _,id in pairs(HealBot_Buff_Aura2Item) do
            local itemName=HealBot_WoWAPI_ItemInfo(id)
            if itemName then
                HealBot_Buff_ItemIDs[itemName]=id
            end
        end
        HealBot_Options_BuffWeaponEnchantSetAura(1)
        HealBot_Options_BuffWeaponEnchantSetAura(2)
        --HealBot_AddDebug("InitItemsDataReady","Buff",true)
        HealBot_Timers_Set("AURA","ExtraBuffReset")
        HealBot_Timers_Set("AURA","ResetBuffCache")
        HealBot_Timers_Set("AURA","CheckPlayer")
    end
end

function HealBot_Aura_InitItemsData()
      --HealBot_setCall("HealBot_Aura_InitItemsData")
    if HealBot_retLuVars("BagsScanned") then
        HealBot_Timers_Set("AURA","InitItemsDataReady")
    else
        HealBot_Timers_Set("LAST","InitItemsData",1) -- All recall require a delay
        --HealBot_AddDebug("InitItemsData","Buff",true)
    end
end

function HealBot_Aura_InitData()
      --HealBot_setCall("HealBot_Aura_InitData")
    if HealBot_Data["PCLASSTRIM"] then
        local sName=nil
        if HealBot_Data["PCLASSTRIM"] == HealBot_Class_En[HEALBOT_PRIEST] then
            sName=HealBot_WoWAPI_SpellName(HBC_DAMPEN_MAGIC)
            if sName then HealBot_ShortBuffs[sName]=true end
            sName=HealBot_WoWAPI_SpellName(HBC_SHADOW_PROTECTION)
            if sName then HealBot_ShortBuffs[sName]=true end
            sName=HealBot_WoWAPI_SpellName(HEALBOT_FEAR_WARD)
            if sName then HealBot_ShortBuffs[sName]=true end
            if HEALBOT_GAME_VERSION<3 then
                sName=HealBot_WoWAPI_SpellName(HBC_INNER_FIRE)
                if sName then HealBot_ShortBuffs[sName]=true end
            end
        elseif HealBot_Data["PCLASSTRIM"] == HealBot_Class_En[HEALBOT_DRUID] then
            sName=HealBot_WoWAPI_SpellName(HBC_THORNS)
            if sName then HealBot_ShortBuffs[sName]=true end
            if HEALBOT_GAME_VERSION<2 then 
                sName=HealBot_WoWAPI_SpellName(HBC_OMEN_OF_CLARITY)
                if sName then HealBot_ShortBuffs[sName]=true end
            end
        elseif HealBot_Data["PCLASSTRIM"] == HealBot_Class_En[HEALBOT_PALADIN] then
            sName=HealBot_WoWAPI_SpellName(HEALBOT_BEACON_OF_LIGHT)
            if sName then HealBot_ShortBuffs[sName]=true end
            sName=HealBot_WoWAPI_SpellName(HEALBOT_SACRED_SHIELD)
            if sName then HealBot_ShortBuffs[sName]=true end
            sName=HealBot_WoWAPI_SpellName(HBC_BLESSING_OF_KINGS)
            if sName then HealBot_ShortBuffs[sName]=true end
            sName=HealBot_WoWAPI_SpellName(HBC_BLESSING_OF_MIGHT)
            if sName then HealBot_ShortBuffs[sName]=true end
            sName=HealBot_WoWAPI_SpellName(HBC_BLESSING_OF_WISDOM)
            if sName then HealBot_ShortBuffs[sName]=true end
            sName=HealBot_WoWAPI_SpellName(HBC_BLESSING_OF_LIGHT)
            if sName then HealBot_ShortBuffs[sName]=true end
            sName=HealBot_WoWAPI_SpellName(HBC_BLESSING_OF_SANCTUARY)
            if sName then HealBot_ShortBuffs[sName]=true end
            sName=HealBot_WoWAPI_SpellName(HBC_SACRED_SHIELD)
            if sName then HealBot_ShortBuffs[sName]=true end
        elseif HealBot_Data["PCLASSTRIM"] == HealBot_Class_En[HEALBOT_MONK] then
            -- Class buffs
        elseif HealBot_Data["PCLASSTRIM"] == HealBot_Class_En[HEALBOT_WARRIOR] then
            -- Class buffs
        elseif HealBot_Data["PCLASSTRIM"] == HealBot_Class_En[HEALBOT_MAGE] then
            sName=HealBot_WoWAPI_SpellName(HEALBOT_ICE_WARD)
            if sName then HealBot_ShortBuffs[sName]=true end
            sName=HealBot_WoWAPI_SpellName(HEALBOT_ICE_BARRIER)
            if sName then HealBot_ShortBuffs[sName]=true end
            sName=HealBot_WoWAPI_SpellName(HBC_DAMPEN_MAGIC)
            if sName then HealBot_ShortBuffs[sName]=true end
        elseif HealBot_Data["PCLASSTRIM"] == HealBot_Class_En[HEALBOT_WARLOCK] then
            -- Class buffs
        elseif HealBot_Data["PCLASSTRIM"] == HealBot_Class_En[HEALBOT_DEATHKNIGHT] then
            sName=HealBot_WoWAPI_SpellName(HEALBOT_HORN_OF_WINTER)
            if sName then HealBot_ShortBuffs[sName]=true end
        elseif HealBot_Data["PCLASSTRIM"] == HealBot_Class_En[HEALBOT_HUNTER] then
            -- Class buffs
        elseif HealBot_Data["PCLASSTRIM"] == HealBot_Class_En[HEALBOT_SHAMAN] then
            sName=HealBot_WoWAPI_SpellName(HEALBOT_FLAMETONGUE_SPELL)
            if sName then hbWeaponEnchants[sName]=true end
            sName=HealBot_WoWAPI_SpellName(HEALBOT_WINDFURY_SPELL)
            if sName then hbWeaponEnchants[sName]=true end
            sName=HealBot_WoWAPI_SpellName(HBC_ROCKBITER_WEAPON)
            if sName then hbWeaponEnchants[sName]=true end
            sName=HealBot_WoWAPI_SpellName(HBC_EARTHLIVING_WEAPON)
            if sName then hbWeaponEnchants[sName]=true end
            sName=HealBot_WoWAPI_SpellName(HEALBOT_EARTHLIVING_WEAPON)
            if sName then hbWeaponEnchants[sName]=true end
            sName=HealBot_WoWAPI_SpellName(HBC_FLAMETONGUE_WEAPON)
            if sName then hbWeaponEnchants[sName]=true end
            sName=HealBot_WoWAPI_SpellName(HBC_WINDFURY_WEAPON)
            if sName then hbWeaponEnchants[sName]=true end
        elseif HealBot_Data["PCLASSTRIM"] == HealBot_Class_En[HEALBOT_ROGUE] then
            -- Class buffs
        elseif HealBot_Data["PCLASSTRIM"] == HealBot_Class_En[HEALBOT_DEMONHUNTER] then
            -- Class buffs
        end

        if HEALBOT_GAME_VERSION<5 then
            
            local HBC_WISDOM_ID=1 --Mana Regen
            local HBC_LIGHT_ID=2 --Incoming Heals
            local HBC_SALVATION_ID=3 --Threat Reduction
            local HBC_SANCTUARY_ID=4 --Damage Reduction
            local HBC_STATS_ID=5 --Stats
            local HBC_MIGHT_ID=6 --Attack Power
            local HBC_STAMINA_ID=7 --Stamina
            local HBC_INT_ID=8 --Int
            local HBC_SPIRIT_ID=9 --Spirit
            local HBC_SP_ID=10 --Shadow Resistance 
            local HBC_MOTW_ID=11 --Wild 
            local HBC_INV_ID=12
            local HBC_INNER_ID=13
            if HEALBOT_GAME_VERSION<4 then
                if HealBot_Data["PCLASSTRIM"] == HealBot_Class_En[HEALBOT_DRUID] then
                        HealBot_BuffNameTypes={
                            [(HealBot_WoWAPI_SpellName(HEALBOT_MARK_OF_THE_WILD) or "Mark of the Wild")]=HBC_MOTW_ID,
                            [(HealBot_WoWAPI_SpellName(HBC_GIFT_OF_THE_WILD) or "Gift of the Wild")]=HBC_MOTW_ID,
                        }
                elseif HealBot_Data["PCLASSTRIM"] == HealBot_Class_En[HEALBOT_MAGE] then
                    HealBot_BuffNameTypes={
                        [(HealBot_WoWAPI_SpellName(HBC_ARCANE_BRILLIANCE) or "Arcane Brilliance")]=HBC_INT_ID,
                        [(HealBot_WoWAPI_SpellName(HEALBOT_ARCANE_BRILLIANCE) or "Arcane Brilliance")]=HBC_INT_ID,
                        [(HealBot_WoWAPI_SpellName(HEALBOT_DALARAN_BRILLIANCE) or "Dalaran Brilliance")]=HBC_INT_ID,
                    }
                elseif HealBot_Data["PCLASSTRIM"] == HealBot_Class_En[HEALBOT_PALADIN] then
                    HealBot_BuffNameTypes={
                        [(HealBot_WoWAPI_SpellName(HBC_BLESSING_OF_KINGS) or "Blessing of Kings")]=HBC_STATS_ID,
                        [(HealBot_WoWAPI_SpellName(HBC_BLESSING_OF_LIGHT) or "Blessing of Light")]=HBC_LIGHT_ID,
                        [(HealBot_WoWAPI_SpellName(HBC_BLESSING_OF_MIGHT) or "Blessing of Might")]=HBC_MIGHT_ID,
                        [(HealBot_WoWAPI_SpellName(HEALBOT_HAND_OF_SALVATION) or "Hand of Salvation")]=HBC_SALVATION_ID,
                        [(HealBot_WoWAPI_SpellName(HBC_BLESSING_OF_SANCTUARY) or "Blessing of Sanctuary")]=HBC_SANCTUARY_ID,
                        [(HealBot_WoWAPI_SpellName(HBC_BLESSING_OF_WISDOM) or "Blessing of Wisdom")]=HBC_WISDOM_ID,
                        [(HealBot_WoWAPI_SpellName(HBC_GREATER_BLESSING_OF_KINGS) or "Greater Blessing of Kings")]=HBC_STATS_ID,
                        [(HealBot_WoWAPI_SpellName(HBC_GREATER_BLESSING_OF_LIGHT) or "Greater Blessing of Light")]=HBC_LIGHT_ID,
                        [(HealBot_WoWAPI_SpellName(HBC_GREATER_BLESSING_OF_MIGHT) or "Greater Blessing of Might")]=HBC_MIGHT_ID,
                        [(HealBot_WoWAPI_SpellName(HBC_GREATER_BLESSING_OF_SALVATION) or "Greater Blessing of Salvation")]=HBC_SALVATION_ID,
                        [(HealBot_WoWAPI_SpellName(HBC_GREATER_BLESSING_OF_SANCTUARY) or "Greater Blessing of Sanctuary")]=HBC_SANCTUARY_ID,
                        [(HealBot_WoWAPI_SpellName(HBC_GREATER_BLESSING_OF_WISDOM) or "Greater Blessing of Wisdom")]=HBC_WISDOM_ID,
                    }
                elseif HealBot_Data["PCLASSTRIM"] == HealBot_Class_En[HEALBOT_PRIEST] then
                    HealBot_BuffNameTypes={
                        [(HealBot_WoWAPI_SpellName(HBC_POWER_WORD_FORTITUDE) or "Power Word:Fortitude")]=HBC_STAMINA_ID,
                        [(HealBot_WoWAPI_SpellName(HEALBOT_POWER_WORD_FORTITUDE) or "Power Word:Fortitude")]=HBC_STAMINA_ID,
                        [(HealBot_WoWAPI_SpellName(HBC_DIVINE_SPIRIT) or "Divine Spirit")]=HBC_SPIRIT_ID,
                        [(HealBot_WoWAPI_SpellName(HBC_PRAYER_OF_SPIRIT) or "Prayer of Spirit")]=HBC_SPIRIT_ID,
                        [(HealBot_WoWAPI_SpellName(HBC_SHADOW_PROTECTION) or "Shadow Protection")]=HBC_SP_ID,
                        [(HealBot_WoWAPI_SpellName(HBC_PRAYER_OF_SHADOW_PROTECTION) or "Prayer of Shadow Protection")]=HBC_SP_ID,
                    }
                    if HealBot_Data["PLEVEL"]<80 then
                        HealBot_BuffNameTypes[(HealBot_WoWAPI_SpellName(HBC_FEL_INTELLIGENCE) or "Fel Intelligence")]=HBC_SPIRIT_ID
                    end
                elseif HealBot_Data["PCLASSTRIM"] == HealBot_Class_En[HEALBOT_WARLOCK] then
                    HealBot_BuffNameTypes={
                        [(HealBot_WoWAPI_SpellName(HBC_DETECT_LESSER_INVISIBILITY) or "Detect Lesser Invisibility")]=HBC_INV_ID,
                        [(HealBot_WoWAPI_SpellName(HBC_DETECT_INVISIBILITY) or "Detect Invisibility")]=HBC_INV_ID,
                        [(HealBot_WoWAPI_SpellName(HBC_DETECT_GREATER_INVISIBILITY) or "Detect Greater Invisibility")]=HBC_INV_ID,
                    }
                end
            elseif HEALBOT_GAME_VERSION<5 then
                HealBot_BuffNameTypes={
                    [(HealBot_WoWAPI_SpellName(HEALBOT_MARK_OF_THE_WILD) or "Mark of the Wild")]=HBC_STATS_ID,
                    [(HealBot_WoWAPI_SpellName(HBC_BLESSING_OF_KINGS) or "Blessing of Kings")]=HBC_STATS_ID,
                    [(HealBot_WoWAPI_SpellName(HBC_INNER_FIRE) or "Inner Fire")]=HBC_INNER_ID,
                    [(HealBot_WoWAPI_SpellName(HBC_INNER_WILL) or "Inner Will")]=HBC_INNER_ID,
                    [(HealBot_WoWAPI_SpellName(HEALBOT_POWER_WORD_FORTITUDE) or "Power Word: Fortitude")]=HBC_STAMINA_ID,
                    [(HealBot_WoWAPI_SpellName(HEALBOT_COMMANDING_SHOUT) or "Commanding Shout")]=HBC_STAMINA_ID,
                    [(HealBot_WoWAPI_SpellName(HEALBOT_ARCANE_BRILLIANCE) or "Arcane Brilliance")]=HBC_INT_ID,
                    [(HealBot_WoWAPI_SpellName(HEALBOT_DALARAN_BRILLIANCE) or "Dalaran Brilliance")]=HBC_INT_ID,
                }
            end

            if HEALBOT_GAME_VERSION<3 then
                HealBot_BuffMinLevels={[HealBot_WoWAPI_SpellName(HEALBOT_POWER_WORD_FORTITUDE)]=48,
                                       [HealBot_WoWAPI_SpellName(HBC_DIVINE_SPIRIT)]=20,
                                       [HealBot_WoWAPI_SpellName(HBC_PRAYER_OF_SPIRIT)]=60,
                                       [HealBot_WoWAPI_SpellName(HBC_PRAYER_OF_SHADOW_PROTECTION)]=56,
                                       [HealBot_WoWAPI_SpellName(HBC_SHADOW_PROTECTION)]=30,
                                       [HealBot_WoWAPI_SpellName(HBC_GIFT_OF_THE_WILD)]=50,
                                       [HealBot_WoWAPI_SpellName(HBC_THORNS)]=6,
                                       [HealBot_WoWAPI_SpellName(HBC_ARCANE_BRILLIANCE)]=56,
                                       [HealBot_WoWAPI_SpellName(HBC_GREATER_BLESSING_OF_LIGHT)]=60,
                                       [HealBot_WoWAPI_SpellName(HBC_BLESSING_OF_LIGHT)]=40,
                                       [HealBot_WoWAPI_SpellName(HBC_GREATER_BLESSING_OF_MIGHT)]=52,
                                       [HealBot_WoWAPI_SpellName(HBC_BLESSING_OF_MIGHT)]=4,
                                       [HealBot_WoWAPI_SpellName(HBC_GREATER_BLESSING_OF_SALVATION)]=60,
                                       [HealBot_WoWAPI_SpellName(HBC_BLESSING_OF_SALVATION)]=26,
                                       [HealBot_WoWAPI_SpellName(HBC_GREATER_BLESSING_OF_WISDOM)]=54,
                                       [HealBot_WoWAPI_SpellName(HBC_BLESSING_OF_WISDOM)]=14,
                                       [HealBot_WoWAPI_SpellName(HBC_GREATER_BLESSING_OF_SANCTUARY)]=60,
                                       [HealBot_WoWAPI_SpellName(HBC_GREATER_BLESSING_OF_KINGS)]=60,
                                      }
            elseif HEALBOT_GAME_VERSION<4 then
                HealBot_BuffMinLevels={[HealBot_WoWAPI_SpellName(HEALBOT_POWER_WORD_FORTITUDE)]=48,
                                       [HealBot_WoWAPI_SpellName(HBC_DIVINE_SPIRIT)]=20,
                                       [HealBot_WoWAPI_SpellName(HBC_PRAYER_OF_SPIRIT)]=60,
                                       [HealBot_WoWAPI_SpellName(HBC_PRAYER_OF_SHADOW_PROTECTION)]=56,
                                       [HealBot_WoWAPI_SpellName(HBC_SHADOW_PROTECTION)]=30,
                                       [HealBot_WoWAPI_SpellName(HBC_GIFT_OF_THE_WILD)]=50,
                                       [HealBot_WoWAPI_SpellName(HBC_THORNS)]=6,
                                       [HealBot_WoWAPI_SpellName(HBC_ARCANE_BRILLIANCE)]=56,
                                       [HealBot_WoWAPI_SpellName(HEALBOT_DALARAN_BRILLIANCE)]=56,
                                       [HealBot_WoWAPI_SpellName(HBC_GREATER_BLESSING_OF_MIGHT)]=52,
                                       [HealBot_WoWAPI_SpellName(HBC_BLESSING_OF_MIGHT)]=4,
                                       [HealBot_WoWAPI_SpellName(HBC_BLESSING_OF_SALVATION)]=26,
                                       [HealBot_WoWAPI_SpellName(HBC_GREATER_BLESSING_OF_WISDOM)]=54,
                                       [HealBot_WoWAPI_SpellName(HBC_BLESSING_OF_WISDOM)]=14,
                                       [HealBot_WoWAPI_SpellName(HBC_GREATER_BLESSING_OF_SANCTUARY)]=60,
                                       [HealBot_WoWAPI_SpellName(HBC_GREATER_BLESSING_OF_KINGS)]=60,
                                      }
            else
                HealBot_BuffMinLevels={[HealBot_WoWAPI_SpellName(HEALBOT_POWER_WORD_FORTITUDE)]=48,
                                       [HealBot_WoWAPI_SpellName(HEALBOT_SHADOW_PROTECTION)]=56,
                                       [HealBot_WoWAPI_SpellName(HEALBOT_MARK_OF_THE_WILD)]=85,
                                       [HealBot_WoWAPI_SpellName(HBC_THORNS)]=6,
                                       [HealBot_WoWAPI_SpellName(HEALBOT_ARCANE_BRILLIANCE)]=86,
                                       [HealBot_WoWAPI_SpellName(HEALBOT_DALARAN_BRILLIANCE)]=56,
                                       [HealBot_WoWAPI_SpellName(HBC_BLESSING_OF_MIGHT)]=56,
                                       [HealBot_WoWAPI_SpellName(HBC_BLESSING_OF_KINGS)]=65,
                                      }
            end
            
            if HEALBOT_GAME_VERSION<3 then
                classicAbsorbBonusV1["DEFAULT"]=ceil(GetSpellBonusHealing()*0.3)
                classicAbsorbBonusV1[HealBot_Data["PGUID"]]=classicAbsorbBonusV1["DEFAULT"]
                HealBot_Classic_Absorbs={[HealBot_WoWAPI_SpellInfo(HEALBOT_POWER_WORD_SHIELD) or "Power Word: Shield"]={[17]=48,
                                                            [592]=94,
                                                            [600]=166,
                                                           [3747]=244,
                                                           [6065]=313,
                                                           [6066]=394,
                                                          [10898]=499,
                                                          [10899]=622,
                                                          [10900]=783,
                                                          [10901]=942,
                                                          [25217]=1144,
                                                          [25218]=1265,
                                                          [48065]=1951,
                                                          [48066]=2230,
                                                              [0]=2230,},
                                         [(HealBot_WoWAPI_SpellInfo(HEALBOT_ICE_BARRIER) or "Ice Barrier")]={[11426]=455,
                                                                                                 [13031]=569,
                                                                                                 [13032]=700,
                                                                                                 [13033]=824,
                                                                                                 [27134]=952,
                                                                                                 [33405]=1075,
                                                                                                 [43038]=2860,
                                                                                                 [43039]=3300,
                                                                                                     [0]=3300,},
                                         [(HealBot_WoWAPI_SpellInfo(HBC_MANA_SHIELD) or "Mana Shield")]={[1463]=120,
                                                                                             [8494]=210,
                                                                                             [8495]=300,
                                                                                            [10191]=390,
                                                                                            [10192]=480,
                                                                                            [10193]=570,
                                                                                            [27131]=715,
                                                                                            [43019]=1080,
                                                                                            [43020]=1330,
                                                                                                [0]=1330},
                                    }
                HealBot_Classic_AbsorbsV1Track[HealBot_WoWAPI_SpellInfo(HEALBOT_POWER_WORD_SHIELD) or "Power Word: Shield"]=0
                HealBot_Classic_AbsorbsV1Track[(HealBot_WoWAPI_SpellInfo(HEALBOT_ICE_BARRIER) or "Ice Barrier")]=0
                HealBot_Classic_AbsorbsV1Track[(HealBot_WoWAPI_SpellInfo(HBC_MANA_SHIELD) or "Mana Shield")]=0
            else
                if HealBot_Config.ClassicAbsorbsFilter == 1 then
                    HealBot_Classic_Absorbs={[(HealBot_WoWAPI_SpellName(76669) or "Illuminated Healing")]=true}
                else
                    HealBot_Classic_Absorbs={[(HealBot_WoWAPI_SpellName(HEALBOT_POWER_WORD_SHIELD) or "Power Word: Shield")]=true,
                                             [(HealBot_WoWAPI_SpellName(47509) or "Divine Aegis")]=true,
                                             [(HealBot_WoWAPI_SpellName(76669) or "Illuminated Healing")]=true,
                                             [(HealBot_WoWAPI_SpellName(HEALBOT_ICE_BARRIER) or "Ice Barrier")]=true,
                                             [(HealBot_WoWAPI_SpellName(HBC_MANA_SHIELD) or "Mana Shield")]=true,
                                             [(HealBot_WoWAPI_SpellName(HEALBOT_SACRED_SHIELD) or "Sacred Shield")]=true,
                                             [(HealBot_WoWAPI_SpellName(77513) or "Blood Shield")]=true,
                                             [(HealBot_WoWAPI_SpellName(48707) or "Anti-Magic Shell")]=true,
                                            }
                end
            end
        end
        HealBot_Timers_Set("LAST","InitItemsData")
    else
        HealBot_SetPlayerData()
        HealBot_Timers_Set("AURA","InitAuraData",1)
    end
end

function HealBot_Aura_ClearGUID(guid)
      --HealBot_setCall("HealBot_Aura_ClearGUID", nil, guid)
    hbAuraRequests[guid]=nil
    hbAuraWatchRaidTarget[guid]=nil
    hbAuraDebuffTagWatch[guid]=nil
    HealBot_UnitDebuffCurrent[guid]=nil
    hbAuraDebuffWatch[guid]=nil
    hbAuraBuffTagWatch[guid]=nil
    hbAuraBuffWatch[guid]=nil
    HealBot_UnitBuffCurrent[guid]=nil
end
