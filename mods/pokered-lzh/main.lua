return function(mod)

  -- Presentation vocabulary.  Keep internal ids (move/item/trainer/status
  -- keys and scripted identities) in English; only merged display records
  -- and the engine string catalogue are translated here.

  local uiStrings = {
    ["ATTACK"] = "力",
    ["BAIT"] = "擲餌",
    ["BALLx"] = "獲獸毬",
    ["CANCEL"] = "罷",
    ["CONTINUE"] = "續",
    ["NEW GAME"] = "新遊",
    ["OPTION"] = "設",
    ["TEXT SPEED"] = "文速",
    ["FAST"] = "疾",
    ["MEDIUM"] = "中",
    ["SLOW"] = "徐",
    ["BATTLE ANIMATION"] = "戰動畫",
    ["ON"] = "開",
    ["OFF"] = "關",
    ["BATTLE STYLE"] = "戰制",
    ["SHIFT"] = "易",
    ["SET"] = "定",
    ["HAN FORM"] = "字形",
    ["TRADITIONAL"] = "繁體",
    ["SIMPLIFIED"] = "簡體",
    ["SHINJITAI"] = "新字體",
    ["BATTLE LAYOUT"] = "戰幕",
    ["BATTLE SIZE"] = "戰幅",
    ["BATTLE BG"] = "戰景",
    ["UI LAYOUT"] = "幕式",
    ["RULESET"] = "規制",
    ["MUSIC VOL"] = "樂量",
    ["SFX VOL"] = "效量",
    ["PIKACHU VOL"] = "皮卡丘量",
    ["MUSIC FILTER"] = "樂濾",
    ["PERFORMANCE"] = "效能",
    ["COLORS"] = "色彩",
    ["TILT"] = "傾斜",
    ["GBC FX"] = "彩效",
    ["ZOOM"] = "縮放",
    ["VOID FILL"] = "界外",
    ["VIDEO MODE"] = "畫面",
    ["ORIENTATION"] = "屏向",
    ["FAITHFUL RATIO"] = "原比",
    ["MAX FPS"] = "幀限",
    ["OVERWORLD SPEED"] = "行速",
    ["BATTLE SPEED"] = "戰速",
    ["MENU SPEED"] = "幕速",
    ["CONTROLS"] = "操控",
    ["DATE FORMAT"] = "日期式",
    ["TIME FORMAT"] = "時刻式",
    ["TOUCH PAD"] = "觸控",
    ["VIBRATION"] = "震動",
    ["WIDE"] = "廣",
    ["OG"] = "原",
    ["FILL"] = "滿",
    ["FIXED"] = "定",
    ["BLACK"] = "黑",
    ["WORLD"] = "世",
    ["WHITE"] = "白",
    ["DYNAMIC"] = "隨動",
    ["CENTERED"] = "居中",
    ["AUTO"] = "自動",
    ["HIGH"] = "高",
    ["BALANCED"] = "中",
    ["LOW"] = "低",
    ["ADVANCED"] = "進階",
    ["CLASSIC"] = "古式",
    ["FIT"] = "合",
    ["WATER"] = "水",
    ["TREES"] = "林",
    ["WINDOWED"] = "窗",
    ["BORDERLESS"] = "無框",
    ["PORTRAIT"] = "縱",
    ["LANDSCAPE"] = "橫",
    ["REVERSE LANDSCAPE"] = "逆橫",
    ["NORMAL"] = "常",
    ["LIGHT"] = "輕",
    ["STRONG"] = "強",
    ["DEVICE"] = "依器",
    ["gen1_faithful"] = "原制",
    ["modern_clean"] = "新制",
    ["%d INSTALLED"] = "已裝%d",
    ["LINK"] = "聯",
    ["MODS"] = "改",
    ["QUIT"] = "退",
    ["RETURN TO MAIN\nMENU?"] = "返本幕乎？",
    ["\fWould you like to\nSAVE the game?"] = "\f記此遊乎？",
    ["Now saving..."] = "方記……",
    ["DEFENSE"] = "守",
    ["DEPOSIT"] = "䝻",
    ["DEPOSIT <PK><MN>"] = "䝻㬺獸",
    ["DEPOSIT ITEM"] = "䝻物",
    ["EXP POINTS"] = "閱歷",
    ["HP"] = "體力",
    ["HP_SHORT"] = "體",
    ["LEVEL_SUFFIX"] = "級",
    ["Enemy %s"] = "敵%s",
    ["EXIT"] = "返",
    ["EXIT GAME"] = "返",
    ["FIGHT"] = "戰",
    ["HALL OF FAME"] = "凌煙閣",
    ["ITEM"] = "行囊",
    ["ITEMS"] = "行囊",
    ["MOVE"] = "技",
    ["NAME"] = "名",
    ["MONEY"] = "錢",
    ["CURRENCY_UNIT"] = "元",
    ["¥%d"] = "%d元",
    [" ¥%d"] = " %d元",
    ["MONEY/¥%d"] = "錢/%d元",
    ["BUY"] = "購",
    ["SELL"] = "售",
    ["To %s"] = "往%s",
    ["%s's NEST"] = "%s之巢",
    ["%s AREA UNKNOWN"] = "%s棲地不詳",
    ["viridianBlackboard|SLP"] = "寐",
    ["viridianBlackboard|PSN"] = "毒",
    ["viridianBlackboard|PAR"] = "痺",
    ["viridianBlackboard|BRN"] = "燒",
    ["viridianBlackboard|FRZ"] = "凍",
    ["viridianBlackboard|QUIT"] = "罷",
    ["CATERPIE has no\npoison, but\vWEEDLE does.\fWatch out for its\nPOISON STING!"] = "羶鳳蠋無毒，毒角蠋則有。慎其毒刺！",
    ["Oh, OK then!"] = "然則罷矣。",
    ["Crammed full of\nPOKéMON books!"] = "架上㬺獸書充牣。",
    ["There's a slew of\nPOKéMON stuff!"] = "架上㬺獸用物甚多。",
    ["%s?\nThat will be\n¥%d. OK?"] = "%s？價%d元，可乎？",
    ["I can pay you\n¥%d for that."] = "此物可售%d元。",
    ["TIME"] = "時",
    ["BADGES"] = "徽",
    ["YES"] = "然",
    ["NO"] = "否",
    ["NEW NAME"] = "新名",
    ["YOUR NAME?"] = "君名？",
    ["HIS NAME?"] = "彼名？",
    ["Choose a POKéMON."] = "擇獸。",
    ["No POKéMON!"] = "無攜獸！",
    ["OLD MAN"] = "老人",
    ["POKéDEX"] = "㬺獸記機",
    ["POKéMON"] = "攜獸",
    ["DEX KIND SUFFIX"] = "類",
    ["PP"] = "技力",
    ["PROF.OAK"] = "大木博士",
    ["RELEASE"] = "放",
    ["RELEASE <PK><MN>"] = "放㬺獸",
    ["RUN"] = "逃",
    ["SAVE"] = "記",
    ["SPECIAL"] = "異能",
    ["SPEED"] = "速",
    ["STATS"] = "覽",
    ["SWITCH"] = "易",
    ["THROW ROCK"] = "擲石",
    ["TYPE/"] = "屬",
    ["TYPE1/"] = "屬",
    ["TYPE2/"] = "兼",
    ["STATUS/"] = "狀",
    ["OK"] = "無恙",
    ["IDNo/"] = "號",
    ["OT/"] = "主",
    ["LEVEL UP"] = "升級",
    ["RED"] = "赤",
    ["ASH"] = "黃",
    ["JACK"] = "太郎",
    ["BLUE"] = "青",
    ["GARY"] = "次郎",
    ["JOHN"] = "三郎",
    ["ABLE"] = "能",
    ["NOT ABLE"] = "不能",
    ["TRAINER"] = "㬺獸士",
    ["WITHDRAW"] = "取",
    ["WITHDRAW <PK><MN>"] = "取㬺獸",
    ["WITHDRAW ITEM"] = "取物",
    ["WHICH TECHNIQUE?"] = "何技？",
    ["disabled!"] = "見錮！",
    ["FNT"] = "倒",
    ["Move to where?"] = "徙何處？",
    ["Use on which one?"] = "用於何獸？",
    ["CUT"] = "切",
    ["DIG"] = "掘穴",
    ["FLASH"] = "閃光",
    ["FLY"] = "飛",
    ["SOFTBOILED"] = "生卵",
    ["STRENGTH"] = "怪力",
    ["SURF"] = "乘浪",
    ["TELEPORT"] = "瞬移",
  }
  for source, translated in pairs(uiStrings) do
    mod.content.strings:override(source, translated)
  end


  -- Pokédex classifications.  Keep the category itself as data and let the
  -- Pokédex renderer add the shared 類 suffix, so a future wording change
  -- does not require editing 151 records.
  local dexClassifications = {
    BULBASAUR  = "種子", -- 001
    IVYSAUR    = "種子", -- 002
    VENUSAUR   = "種子", -- 003
    CHARMANDER = "螭", -- 004
    CHARMELEON = "炎", -- 005
    CHARIZARD  = "炎", -- 006
    SQUIRTLE   = "小龜", -- 007
    WARTORTLE  = "龜", -- 008
    BLASTOISE  = "貝", -- 009
    CATERPIE   = "蠋", -- 010
    METAPOD    = "蛹", -- 011
    BUTTERFREE = "蝴蝶", -- 012
    WEEDLE     = "毛蠋", -- 013
    KAKUNA     = "蛹", -- 014
    BEEDRILL   = "毒蜂", -- 015
    PIDGEY     = "小鳥", -- 016
    PIDGEOTTO  = "鳥", -- 017
    PIDGEOT    = "鳥", -- 018
    RATTATA    = "鼠", -- 019
    RATICATE   = "鼠", -- 020
    SPEAROW    = "小鳥", -- 021
    FEAROW     = "喙", -- 022
    EKANS      = "蛇", -- 023
    ARBOK      = "蝮", -- 024
    PIKACHU    = "鼠", -- 025
    RAICHU     = "鼠", -- 026
    SANDSHREW  = "鼠", -- 027
    SANDSLASH  = "鼠", -- 028
    NIDORAN_F  = "毒鍼", -- 029
    NIDORINA   = "毒鍼", -- 030
    NIDOQUEEN  = "鑽", -- 031
    NIDORAN_M  = "毒鍼", -- 032
    NIDORINO   = "毒鍼", -- 033
    NIDOKING   = "鑽", -- 034
    CLEFAIRY   = "魄", -- 035
    CLEFABLE   = "魄", -- 036
    VULPIX     = "狐狸", -- 037
    NINETALES  = "狐狸", -- 038
    JIGGLYPUFF = "氣毬", -- 039
    WIGGLYTUFF = "氣毬", -- 040
    ZUBAT      = "蝙蝠", -- 041
    GOLBAT     = "蝙蝠", -- 042
    ODDISH     = "野草", -- 043
    GLOOM      = "野草", -- 044
    VILEPLUME  = "花", -- 045
    PARAS      = "蟲草", -- 046
    PARASECT   = "蟲草", -- 047
    VENONAT    = "蟲", -- 048
    VENOMOTH   = "毒蛾", -- 049
    DIGLETT    = "鼴", -- 050
    DUGTRIO    = "鼴", -- 051
    MEOWTH     = "抓貓", -- 052
    PERSIAN    = "貴貓", -- 053
    PSYDUCK    = "鴨", -- 054
    GOLDUCK    = "鴨", -- 055
    MANKEY     = "豕猴", -- 056
    PRIMEAPE   = "豕猴", -- 057
    GROWLITHE  = "小犬", -- 058
    ARCANINE   = "傳説", -- 059
    POLIWAG    = "蝌蚪", -- 060
    POLIWHIRL  = "蝌蚪", -- 061
    POLIWRATH  = "蝌蚪", -- 062
    ABRA       = "念力", -- 063
    KADABRA    = "念力", -- 064
    ALAKAZAM   = "念力", -- 065
    MACHOP     = "怪力", -- 066
    MACHOKE    = "怪力", -- 067
    MACHAMP    = "怪力", -- 068
    BELLSPROUT = "花", -- 069
    WEEPINBELL = "食蟲植", -- 070
    VICTREEBEL = "食蟲植", -- 071
    TENTACOOL  = "水母", -- 072
    TENTACRUEL = "水母", -- 073
    GEODUDE    = "石", -- 074
    GRAVELER   = "石", -- 075
    GOLEM      = "重石", -- 076
    PONYTA     = "火馬", -- 077
    RAPIDASH   = "火馬", -- 078
    SLOWPOKE   = "忘", -- 079
    SLOWBRO    = "蝞", -- 080
    MAGNEMITE  = "磁", -- 081
    MAGNETON   = "磁", -- 082
    FARFETCHD  = "野鴨", -- 083
    DODUO      = "雙鳥", -- 084
    DODRIO     = "三鳥", -- 085
    SEEL       = "海驢", -- 086
    DEWGONG    = "海驢", -- 087
    GRIMER     = "濁", -- 088
    MUK        = "濁", -- 089
    SHELLDER   = "貝", -- 090
    CLOYSTER   = "貝", -- 091
    GASTLY     = "氛煞", -- 092
    HAUNTER    = "氛煞", -- 093
    GENGAR     = "影", -- 094
    ONIX       = "石蛇", -- 095
    DROWZEE    = "催眠", -- 096
    HYPNO      = "催眠", -- 097
    KRABBY     = "河蟹", -- 098
    KINGLER    = "螯", -- 099
    VOLTORB    = "毬", -- 100
    ELECTRODE  = "毬", -- 101
    EXEGGCUTE  = "卵", -- 102
    EXEGGUTOR  = "椰", -- 103
    CUBONE     = "獨", -- 104
    MAROWAK    = "有髓", -- 105
    HITMONLEE  = "踆", -- 106
    HITMONCHAN = "拳", -- 107
    LICKITUNG  = "舔", -- 108
    KOFFING    = "毒氛煞", -- 109
    WEEZING    = "毒氛煞", -- 110
    RHYHORN    = "刺", -- 111
    RHYDON     = "鑽", -- 112
    CHANSEY    = "卵", -- 113
    TANGELA    = "藤", -- 114
    KANGASKHAN = "母親", -- 115
    HORSEA     = "龍", -- 116
    SEADRA     = "龍", -- 117
    GOLDEEN    = "鯽", -- 118
    SEAKING    = "鯽", -- 119
    STARYU     = "星形", -- 120
    STARMIE    = "玄", -- 121
    MR_MIME    = "障", -- 122
    SCYTHER    = "螳螂", -- 123
    JYNX       = "人形", -- 124
    ELECTABUZZ = "電", -- 125
    MAGMAR     = "噴火", -- 126
    PINSIR     = "鋸鍬形蟲", -- 127
    TAUROS     = "野兕", -- 128
    MAGIKARP   = "魚", -- 129
    GYARADOS   = "殘暴不仁", -- 130
    LAPRAS     = "海車", -- 131
    DITTO      = "變形", -- 132
    EEVEE      = "天演", -- 133
    VAPOREON   = "泡搶", -- 134
    JOLTEON    = "雷", -- 135
    FLAREON    = "炎", -- 136
    PORYGON    = "虛擬", -- 137
    OMANYTE    = "抮貝", -- 138
    OMASTAR    = "抮貝", -- 139
    KABUTO     = "貝", -- 140
    KABUTOPS   = "貝", -- 141
    AERODACTYL = "僵石", -- 142
    SNORLAX    = "睡", -- 143
    ARTICUNO   = "冬", -- 144
    ZAPDOS     = "雷", -- 145
    MOLTRES    = "炎", -- 146
    DRATINI    = "龍", -- 147
    DRAGONAIR  = "龍", -- 148
    DRAGONITE  = "龍", -- 149
    MEWTWO     = "生成", -- 150
    MEW        = "新類", -- 151
  }

  -- Literary Chinese Pokédex descriptions.  These replace the ROM entry
  -- text at runtime; the source ids stay intact for other languages/mods.
  local dexEntries = {
    BULBASAUR  = "初生，背負異種，與身俱長；囊蓄其養，數日不食亦可。", -- 001
    IVYSAUR    = "背囊取養於身而長；囊漸大，後足難立。將華，芳氣先發。", -- 002
    VENUSAUR   = "所負大王花，以日光為養。逐日而行，得陽則止；花香能息鬥。", -- 003
    CHARMANDER = "初生尾已有火，燃而微鳴，寂乃聞。幼者弄焰或自灼；火熄則卒。", -- 004
    CHARMELEON = "猛火螭也。搖炎尾則氣歊然；戰則尾撻爪攫，至敵斃乃已；興則吐縹火。", -- 005
    CHARIZARD  = "振翼可薄高峰；噓焰頃刻銷萬鈞玄冰，失燎林藪亦時有之。", -- 006
    SQUIRTLE   = "初生背耎，久乃凝為介。急則縮頸入甲，旋噀白沫，其勢甚勁。", -- 007
    WARTORTLE  = "尾毿毿若藻，函氣其中，久潛不窒；俗以為延齡之瑞。", -- 008
    BLASTOISE  = "介上雙竇，噴水如砲，石壁可摧；亦乘反衝撞敵，危則藏六體。", -- 009
    CATERPIE   = "蒼膚，首有巨眸斑以詟敵；黏趾善緣墉。犯其觸鬚，羶穢即洩。", -- 010
    METAPOD    = "外殼堅，內質猶濡，唯恃殼拒敵；重擊則柔體先傷。", -- 011
    BUTTERFREE = "翼被毒粉，水澤不沾，雖雨亦飛；鼓翅粉霧四散，吸之中毒。", -- 012
    WEEDLE     = "潛林莽食葉。額有毒芒，長寸餘；刺入肌理，毒旋作。", -- 013
    KAKUNA     = "蜷僵若枯，幾不能動；危則堅殼或出芒螫敵，殼中默自蛻化。", -- 014
    BEEDRILL   = "羣飛甚迅，兩臂各一毒螫，腹末復一；三鋒齊進，所遇連刺。", -- 015
    PIDGEY     = "林薄常見，性憚鬥；敵迫則踆沙自衛。伏草食蟲，或鼓風退弱敵。", -- 016
    PIDGEOTTO  = "疆域甚廣，終日翔巡；鉤爪甚厲，犯境者必遭攢啄，亦能遠攫獵物。", -- 017
    PIDGEOT    = "舒麗翼駭敵，疾翔可倍聲速；獵則貼波攫龍門鯉，翼響方聞，影已杳。", -- 018
    RATTATA    = "軀微趫捷，所在皆有。齒生無已，常齧剛物自砥；見一，近穴往往數十。", -- 019
    RATICATE   = "長髭持衡，剪之則行蹇。後跗有蹼，善泅獵水族；敵至，踞足露齒厲嘯。", -- 020
    SPEAROW    = "翅短，疾鼓乃飛；高舉雖不能，巡境極速。形羸，能摹禽聲惑敵。", -- 021
    FEAROW     = "羽翮恢壯，善御風，終日不下亦不疲。其種古；有虞則扶搖遽去。", -- 022
    EKANS      = "委蛇草莽，行無聲，專吞蒙雀鬼鶪之卵。吐歧舌候四方，夜蟠柯而眠。", -- 023
    ARBOK      = "腹章肖怖面，以詟羸弱；隨方土而文異，已驗六變。敵至則張腹威之。", -- 024
    PIKACHU    = "兩頰藏霆囊，迫則洩電。羣聚一處，陰陽相薄，或震耀滿野；常翹尾候警。", -- 025
    RAICHU     = "霆蓄過滿則躁，夜毛自明；洩之可仆南天竺象。尾曳地，餘電由是而散。", -- 026
    SANDSHREW  = "棲燥土深竇，遠水而活，非覓食不出。危則卷軀如丸；寒夜皮上露凝成珠。", -- 027
    SANDSLASH  = "畏害則蜷作芒毬，因勢轉轢，或攻或遁。脊刺鉤爪並利；折爪旦夕復生。", -- 028
    NIDORAN_F  = "性柔少爭，形小而芒毒甚烈；牝者額角尤微，迫甚亦以角注毒。", -- 029
    NIDORINA   = "牝者馴而少悍，額角歲長。安則周芒帖伏；怒則齧攫，清嘯亂敵。", -- 030
    NIDOQUEEN  = "遍體硬鱗如鋩，隨期自敝而更；怒則鱗戟森張，亦恃沈軀頓壓敵。", -- 031
    NIDORAN_M  = "巨耳常竦，以察微警；欲聽遠響，輒振若雙翮。怒則毒鋒畢出，角愈大毒愈烈。", -- 032
    NIDORINO   = "性躁易怒，額角堅逾金石；暴揮可洞堅質。一中肌膚，毒即沿創而入。", -- 033
    NIDOKING   = "膚革磐凝若石鎧，長角銳而宿毒。戰以巨尾摔撲，復蟠纏敵軀，使骨折。", -- 034
    CLEFAIRY   = "姿狎可親，尤喜嬉游，人多欲豢；然其類至希，僅數處偶見。", -- 035
    CLEFABLE   = "性畏人，耳力尤靈；三百丈外針墜亦辨，喧闐之地是以不居。", -- 036
    VULPIX     = "初生僅一素尾，長則尾杪析為六，茸采甚麗；年深又漸生新尾。", -- 037
    NINETALES  = "九尾燁若流金，壽或千祀。性黠，銜怨亦久；戲挽其尾，傳有千祀之詛。", -- 038
    JIGGLYPUFF = "睛碩如珠，能攝人神；對者既恍惚，乃徐聲而謳，聞者輒寐。", -- 039
    WIGGLYTUFF = "毳毛稠耎，拊之悅手。形質有彈，怒則吞氣自鼓，膨脹如浮囊。", -- 040
    ZUBAT      = "羣棲幽窟，目鼻皆廢。飛發清音，人耳弗聞；聲觸物返耳，遂辨遠近形勢。", -- 041
    GOLBAT     = "潛伺猝襲，銳齒決膚飲血；腹重至不能飛，猶貪飲不止。所飲異，血性亦隨之。", -- 042
    ODDISH     = "晝埋首土中，僅露葉鬣；夜以雙根代足，行百丈許，沿途散實。遽拔則厲號。", -- 043
    GLOOM      = "口流者非涎，乃甘醴以招蟲。蕊臭熏數里，聞者或仆；千人中或一人嗜之。", -- 044
    VILEPLUME  = "花瓣冠羣芳，愈廣則毒粉愈盛。奮瓣，粉霧轟散，聲若裂帛；犯者或病。", -- 045
    PARAS      = "穿壤齧根，背菌與蟲偕長，取其所養；所食十之七八，皆為菌奪。", -- 046
    PARASECT   = "背菌既盛，遂主其趨止；尤嗜陰濕，時播毒孢。震旦醫家亦採以入藥。", -- 047
    VENONAT    = "棲喬木陰，啖蟲，夜逐燈火。雙眸乃眾微睛攢合，能燭幽，亦發異光擊物。", -- 048
    VENOMOTH   = "羽被細鱗，諸色各表一毒。振翅則毒屑四散，黏物難拭；居下風者亦中毒。", -- 049
    DIGLETT    = "穴居地中數尺，食根荄。淺鑿而行，過處土脈墳起；全軀長短，至今莫究。", -- 050
    DUGTRIO    = "三鼴並出，穿地甚深，所經或震丘陵；臨鬥潛伏，忽自敵足畔突出。", -- 051
    MEOWTH     = "嗜圜而有光之物，尤珍孔方。晝伏夜巡里巷，見遺錢，必銜取之。", -- 052
    PERSIAN    = "毛采華美，俗多畜之，然暴悍難馴。額珠自耀；尾忽直豎，頃刻將躍噬。", -- 053
    PSYDUCK    = "恆苦首疾；痛極，念力忽作，隔空移物，己若不知。神貌懵然，反令敵失察。", -- 054
    GOLDUCK    = "薄暮多集澤畔，四肢修而有蹼，泅姿婉且速。貌類倭俗河童，鄉人或誤認。", -- 055
    MANKEY     = "棲樹趫捷，嗔心倏發；方帖然，俄頃便狂擊四旁。少觸其意，鬥遂不休。", -- 056
    PRIMEAPE   = "常若含怒，遇可逐者必窮追；四顧寂然，暴氣方稍弭，故見其和容者罕。", -- 057
    GROWLITHE  = "狎人而忠，守疆甚嚴。有踰界者，先厲吠示警，復牙噬逐出。", -- 058
    ARCANINE   = "震旦舊傳其獸，以姿華著。奔逐若翼生兩腋，倏忽無跡，觀者多眩其英采。", -- 059
    POLIWAG    = "玄膚薄潤，五藏隔皮可見，盤曲成腹文；旋向隨地而異。跗弱，水中便而陸行蹇。", -- 060
    POLIWHIRL  = "水陸皆居，尤戀川澤；離水，膚自出津以潤。敵至則展腹旋章，攝使入寐而遁。", -- 061
    POLIWRATH  = "百骸筋力皆宜水，鳧、蛙、蛺蝶諸泳無不工；疾逾人中善泅者。", -- 062
    ABRA       = "一日大半在寐，夢中猶察危變；敵未及身，已移形遠遁。神術雖睡不弛。", -- 063
    KADABRA    = "野說本異能童子，一朝寤而化此。腦中時起異波，近者輒頭痛；漏刻之器或逆行。", -- 064
    ALAKAZAM   = "神府廣博，聞見終身不忘；臨敵先燭其隙，罕用筋力，唯御念以制之。", -- 065
    MACHOP     = "形若小兒，而筋節遍體凝練，可舉百人而投。朝夕習百家擊技，愈習愈強。", -- 066
    MACHOKE    = "膂力卓絕，不知疲；腰帶束其勁，使發收有節。性謙，常代人荷重。", -- 067
    MACHAMP    = "四臂皆如盤虯，一臂足撼山岳；四臂俱發，二秒千拳，亦能空掌裂石。", -- 068
    BELLSPROUT = "嗜暄濕，根兼代足，徐行吸地泉；藤蔓善縛微蟲以食，蕾形隱肖人面。", -- 069
    WEEPINBELL = "葉鋒若刃。搏則先播毒粉，使敵痿痺，復噴蝕液銷之；飢甚，動物無不吞。", -- 070
    VICTREEBEL = "叢聚邃林，人入鮮返。以蜜香誘物入口，一晝夜間皮肉骨骸俱化為汁。", -- 071
    TENTACOOL  = "眼若澄玉，能射異光。浮游淺海，漁者誤罥，為酸液所螫；擱岸萎縮，投海即蘇。", -- 072
    TENTACRUEL = "垂腕八十，伸縮無定；獵則四布羅絡，纏物雖死不釋。螫毒入體，痛徹骨髓。", -- 073
    GEODUDE    = "山徑野磧多有，形與頑石莫辨，誤踏即怒。軀圓可執；登阪則雙臂攀地曳身。", -- 074
    GRAVELER   = "山中行則因坡自轉；草木岩礫當前皆輾為齏，勢不少衰，亦不知迴避。", -- 075
    GOLEM      = "軀重數百斤，介甲磐固，硝火震擊亦鮮傷。歲一蛻革，新皮見風，頃刻凝硬。", -- 076
    PONYTA     = "蹄堅十倍金剛石，一躍可凌巴黎鐵塔；軀輕足勁，墜地四蹄分受其勢。", -- 077
    RAPIDASH   = "嗜與迅疾者角馳，見火車、汽車亦逐之；極奔每小時四百餘里，四體生焰。", -- 078
    SLOWPOKE   = "終日惘惘，寤寐若一；垂尾入水候魚。受擊之痛，五秒而後方覺。", -- 079
    SLOWBRO    = "鈍饕餮下海覓食，大舌貝誤銜其尾，遂共化此形。貝食其餘瀝；尾脫則復故體。", -- 080
    MAGNEMITE  = "生具卻地之性，以強磁波自懸空中；左右二竅放電，來去無蹤，常忽現人前。", -- 081
    MAGNETON   = "數金磁石聯綴而成，日輪黑子盛時尤多；發強磁波，三百餘丈內氣溫升二度。", -- 082
    FARFETCHD  = "棲蘆荻間，口恆銜異莖，或構巢，或操若劍。近世其類日少，已難見。", -- 083
    DODUO      = "一軀兩首，蓋胚變之異；翅短難高舉，兩足修健，每小時可馳百六十餘里。", -- 084
    DODRIO     = "三首分主喜戚忿，三腦共籌一身；寢則二首眠，一首恆醒候警。原野疾走。", -- 085
    SEEL       = "厚革覆淺碧毛，極耐零下四十度之寒。首生堅角，常撞破厚冰，出沒水下。", -- 086
    DEWGONG    = "遍體皓毳，收熱於內；天愈寒，筋力愈盛。冰水之中，亦能以八節疾游。", -- 087
    GRIMER     = "工坊穢滓久受月中穿透異光，遂凝有生；專啖淤泥棄穢，所經草木亦焦死。", -- 088
    MUK        = "穢泥被體，伏土幾與壤同色。毒甚烈，足跡不可犯；臭足仆人，久失嗅而自不覺。", -- 089
    SHELLDER   = "殼堅逾金剛石，閉則百擊無傷；惟啟甲，內肉乃露。伏海沙，以長舌捲食。", -- 090
    CLOYSTER   = "重甲堅不可破，火硝震擊亦弗損；惟臨攻乃啟。受擊則萬刺迸射，殼中真形未見。", -- 091
    GASTLY     = "軀若薄靄，烈風則散；覆獵物使眠，或頃刻仆倒。南天竺巨象，二秒亦不能支。", -- 092
    HAUNTER    = "能透垣墉如涉虛，故俗謂來自幽界。暗中若覺被窺，或無故仆倒，皆其將至之徵。", -- 093
    GENGAR     = "望夕摹人影，見人驚則竊笑；山中迷途者或為所魘。忽覺切寒，此魅多已近。", -- 094
    ONIX       = "年深則石軀日堅，卒如玄剛；潛地每小時百四十里。所鑿隧多為小潛鼴居。", -- 095
    DROWZEE    = "古貘之裔。施眠術待人入夢，乃食其夢；吞惡夢則己亦病，有時反吐舊夢示其主。", -- 096
    HYPNO      = "手執垂錘，與人目接即使魂魄昏沉，兼善念力；舊傳一童視錘而寐，竟為所攜。", -- 097
    KRABBY     = "棲海壖，橫步而行，雙螯持衡。螯利而能復生；戰中雖折，新萌反益壯。", -- 098
    KINGLER    = "一螯有萬馬力，能擘大舌、刺甲二貝堅介；螯過重，是以舉止稍滯。", -- 099
    VOLTORB    = "多棲發電所，形肖收獸球，誤觸者常遭電擊；稍受驚即自裂，亦盜吸電車之霆。", -- 100
    ELECTRODE  = "腹中蓄電極盛，纖震一及便迸裂如雷；俗因號曰爆毬，近之甚危。", -- 101
    EXEGGCUTE  = "貌如卵，實草木之核；六首相引，環轉乃安。亡一則失衡，餘者猶相聚。", -- 102
    EXEGGUTOR  = "俗號步行雨林。三實皆具面，各有心思，爭鳴聒耳；一實墜壤，遂化爆卵宭。", -- 103
    CUBONE     = "戴亡母髑髏，終身不卸，真面遂無人見；孤處對月哀鳴，聲入髑髏如挽歌。", -- 104
    MAROWAK    = "本羸小，得枯骨為兵，性遂剽悍；善使骨棒，亦能擲之旋返掌中，中者輒仆。", -- 105
    HITMONLEE  = "兩脛伸縮無方，遠敵亦可一蹴而及。踢擊時足底倏硬若金剛石，世號蹴術宗師。", -- 106
    HITMONCHAN = "若古拳師之魄附焉。拳捷逾火車，旋臂可洞石壁；三分鐘一息，少頃復戰。", -- 107
    LICKITUNG  = "舌長倍軀，近七尺，運之如手，取食拒敵皆便；偶為其舐，肌理即麻痺刺痛。", -- 108
    KOFFING    = "皮膜薄如浮囊，腹中雜貯毒氣，近之臭不可當；暑氣盛則囊益張，有時無端自裂。", -- 109
    WEEZING    = "二瘴球久黏而合，兩囊毒氣各異；以塵埃微蟲毒沴為食，多徘徊廢墟污澤。", -- 110
    RHYHORN    = "骨強千倍於人；一怒奮角，重樓可碎。奔勢既起，惟知直前，力竭昏睡乃止。", -- 111
    RHYDON     = "一化，乃以後足直立，慧性亦開；甲皮能耐三千六百度熔岩，額角可貫巨巖。", -- 112
    CHANSEY    = "稀世難致，得者俗以為福瑞。日產數卵，甘美厚養；見傷獸，常分卵與之。", -- 113
    TANGELA    = "通體藍蔓盤結，真形盡掩，藤且生生不已；物近便自攀縛，行時千蔓搖曳。", -- 114
    KANGASKHAN = "牝者腹有育囊，兒伏其中三歲，能自求食乃出。護子時悍不顧死，尤善連拳。", -- 115
    HORSEA     = "卷尾以定身，浮波上噀墨取飛蟲，發必中。危則激水或吐玄汁迷敵。", -- 116
    SEADRA     = "胸鰭如翮，鼓之配尾，可首前而身退；背芒甚毒，觸者麻痺。眠則尾鉤珊瑚自繫。", -- 117
    GOLDEEN    = "尾鰭飄若舞裳，俗號水后；諸鰭筋力甚強，可五節游。產卵時羣聚逆川越瀑。", -- 118
    SEAKING    = "秋令產子，羣集泝流。牡者先以額角鑿巨石成窟為卵所，餘時亦居其中。", -- 119
    STARYU     = "中有赤核，夜則自明；核苟無損，縱肢體碎裂，亦能徐徐復合如故。", -- 120
    STARMIE    = "五體成規矩異形，土人疑自天外墜來。中央靈核夜發七采，或謂藉此與星漢通訊。", -- 121
    MR_MIME    = "長於幻戲，使人以虛為實；仿牆壁，空處亦若有障。演術被擾，輒以巨掌批之。", -- 122
    SCYTHER    = "行疾如忍者，動時似有數身。常自蓊草猝躍，以雙鎌斬獵；雖具翼，鮮肯飛。", -- 123
    JYNX       = "其聲肖人言而莫能解，今尚有好事者究之。步履有節，腰支搖曳，觀者常自隨拍。", -- 124
    ELECTABUZZ = "嗜猛烈之電，常羣集發電所。城邑忽大暗，俗人每歸咎此獸，謂其吞盡電氣。", -- 125
    MAGMAR     = "棲活火山口，體熱近攝氏千二百度，周身橙焰長明；投身火海，則與焰混而難辨。", -- 126
    PINSIR     = "首具雙鉗，夾物死持不解，力能腰裂獵物；若不能斷則旋擲。最畏寒，氣凜則僵。", -- 127
    TAUROS     = "欲觝敵，先以三尾反覆鞭身，怒盛乃直衝；奔勢一起，不能自迴，必撞物而止。", -- 128
    MAGIKARP   = "今種孱弱遲鈍，古本稍健。江海湖澤乃至蹄涔皆能生；遇敵百攻，惟徒躍而已。", -- 129
    GYARADOS   = "性酷烈無常，野外甚罕；古籍謂一怒則城郭為墟。口吐毀滅之光，所燭皆燼。", -- 130
    LAPRAS     = "性溫而慧，能解人語，亦察人情。喜負人涉海；昔捕取過多，近世幾至絕種。", -- 131
    DITTO      = "恆無定狀如流膠；能重組細胞與種性之籙。見物則俄頃摹其形體，毫釐殆不能辨。", -- 132
    EEVEE      = "種性之籙無定式，變化之途尤繁；受炎、霆、水三石射線，各隨其性化為一獸。", -- 133
    VAPOREON   = "微察其胞，與水分子殆無異；入川則散溶無形。修尾具鰭，漁者或疑鮫人。", -- 134
    JOLTEON    = "性敏，哀怒則電自積；吸空中陰離子，可發萬伏之霆。大驚則周毛戟立而射敵。", -- 135
    FLAREON    = "內藏炎囊；深納氣而噓火，近攝氏千七百度。蓄焰之際，體熱亦逾九百度。", -- 136
    PORYGON    = "純以機籙符文造之，人造獸由此始；能往來虛境如履實地。欲使其飛天，迄未成。", -- 137
    OMANYTE    = "太古海獸，久已絕種；近人乃從石化遺蛻復其種性。十腕旋動，如輪鼓水而游。", -- 138
    OMASTAR    = "觸腕盛，如手足而用；纏獵後即以銳喙噬之。殼巨而沈，步泳皆遲，卒以種絕。", -- 139
    KABUTO     = "自古海床石蛻還生，負甲甚固；伏底以背目候物。若浪翻令仰，反不能自正。", -- 140
    KABUTOPS   = "軀狹善泅，雙臂若鎌；搏獵則斫創之，繼而盡吮其膏液。", -- 141
    AERODACTYL = "取琥珀中太古飛龍種性而復成。性猛戾，凌空厲嘯，牙如鋸，尤喜斷敵喉。", -- 142
    SNORLAX    = "日須食近六百七十斤乃饜，一飽即臥；雖腐物亦吞而腹不疾，愈肥愈惰。", -- 143
    ARTICUNO   = "玄冬神羽，修尾皎麗；能凝空中水氣成雪。雪山迷途垂凍者，傳多見其翔影。", -- 144
    ZAPDOS     = "霆部神禽，惟黑雲鬱結雷電交作時乃降。振翮則天鼓轟鳴，巨雷逐翼而行。", -- 145
    MOLTRES    = "炎部靈禽，兩翼若燎原。每一鼓羽，赤曜赫赫，雖夜穹亦映為赭色。", -- 146
    DRATINI    = "古籍素列神物，近歲漁者始偶獲，驗有小羣潛聚；雛體已逾六尺，屢蛻而長。", -- 147
    DRAGONAIR  = "棲湖海中，通體被不可名之神氣；雖無羽翼，世每見其騰空，且能移易陰晴風雨。", -- 148
    DRAGONITE  = "瀚海罕有，智殆與人侔，俗號海守；軀巨而能飛，十六小時可環大地一周。", -- 149
    MEWTWO     = "博物者積年重組種性之籙而造；本籙殆侔混沌蟨，而形性大殊。", -- 150
    MEW        = "南美洲神獸，昔謂絕種，近歲稍見；毳細須透微鏡乃見。神智高，百技一習輒能。", -- 151
  }

  for species, classification in pairs(dexClassifications) do
    local def = mod.content.pokemon:get(species)
    if def and def.dexEntry then
      mod.content.pokemon:patch(species, {
        dexEntry = { kind = classification },
      })
      local text = dexEntries[species]
      if text and def.dexEntry.text then
        mod.content.text:override(def.dexEntry.text, text)
      else
        mod.log:warn("%s has no Pokédex text id; description skipped", species)
      end
    else
      mod.log:warn("%s has no Pokédex entry; classification/description skipped", species)
    end
  end

  -- BattleState uses contextual versions of these three labels.
  mod.content.strings:override("battle|FIGHT", "戰")
  mod.content.strings:override("battle|ITEM", "行囊")
  mod.content.strings:override("battle|RUN", "逃")


  -- Engine-authored Gen 1 battle prose.  Keep these separate from the
  -- general UI lexicon: several English source strings are deliberately
  -- distinct because the same ROM label is reused for different actions
  -- (notably move-use versus item-use text).
  local battleStrings = {
    ["ACCURACY"] = "命中",
    ["EVADE"] = "避",
    ["FOE"] = "敵",
    ["NICKNAME?"] = "別名？",
    ["What will"] = "將使",
    [" do?"] = "何為？",
    ["%s wants\nto fight!"] = "%s請戰！",
    ["%s\nflew up high!"] = "%s飛上高空！",
    ["%s\ndug a hole!"] = "%s掘穴入地！",
    ["%s\nmade a whirlwind!"] = "%s蓄旋風！",
    ["%s\ntook in sunlight!"] = "%s納日光！",
    ["%s\nlowered its head!"] = "%s低首蓄勢！",
    ["%s\nis glowing!"] = "%s發光！",
    ["%s\nis charging up!"] = "%s蓄力！",
    ["%s\nis storing energy!"] = "%s蓄力！",
    ["%s\nfainted!"] = "%s倒矣！",
    ["%s with-\ndrew %s!"] = "%s收還%s！",
    ["%s sent\nout %s!"] = "%s發%s！",
    ["%s\nused %s!"] = "%s發%s！",
    ["%s used\n%s!"] = "%s用%s！",
    ["%s發%s!"] = "%s發%s！",
    ["%s用獸毬!"] = "%s用獸毬！",
    ["行！ %s!"] = "行！%s！",
    ["勉之！ %s!"] = "勉之！%s！",
    ["克之！ %s!"] = "克之！%s！",
    ["侍從： 君獲獸毬尽矣！休矣！"] = "侍從：君獲獸毬盡矣！休矣！",
    ["%s is\nabout to use\v%s!"] = "%s將發%s！",
    ["Will %s\nchange POKéMON?"] = "%s欲易獸乎？",
    ["Use next POKéMON?"] = "更出一獸乎？",
    ["%s is out of\nuseable POKéMON!"] = "%s無可戰之獸！",
    ["%s blacked\nout!"] = "%s昏厥！",
    ["%s 之㬺獸尽矣！"] = "%s之㬺獸盡矣！",
    ["%s 冥矣！"] = "%s昏厥！",
    ["%s used\nSAFARI BALL!"] = "%s擲獲獸毬！",
    ["All right!\n%s was\ncaught!"] = "善哉！獲%s！",
    ["You missed the\nPOKéMON!"] = "擲毬不中！",
    ["Darn! The POKéMON\nbroke free!"] = "獸脫毬而出！",
    ["New POKéDEX data\nwill be added for\n%s!"] = "㬺獸記機增錄%s！",
    ["someone's PC"] = "某人算器",
    ["%s was\ntransferred to\n%s!"] = "%s移於%s！",
    ["But every BOX\nis full!"] = "諸匣皆滿！",
    ["It dodged the\nthrown BALL!"] = "其避所擲之毬！",
    ["This POKéMON\ncan't be caught!"] = "此獸不可獲！",
    ["No! There's no\nrunning from a\vtrainer battle!"] = "與㬺獸士戰，不可逃！",
    ["%s is\nalready out!"] = "%s已在場！",
    ["Sucked health from\n%s!"] = "吸取%s體力！",
    ["%s's\ndream was eaten!"] = "食%s之夢！",
    ["%s's\nhurt by poison!"] = "%s為毒所傷！",
    ["%s's\nhurt by the burn!"] = "%s受燒傷之害！",
    ["%s\nwas afflicted\nby %s!"] = "%s患%s！",
    ["%s is\nprotected by MIST!"] = "%s有白霧護之！",
    ["%s's\n%s rose!"] = "%s之%s升！",
    ["%s's\n%s\ngreatly rose!"] = "%s之%s大升！",
    ["%s's\n%s fell!"] = "%s之%s降！",
    ["%s's\n%s\ngreatly fell!"] = "%s之%s大降！",
    ["%s's\nprotected against\nstat changes!"] = "%s之諸能不受變！",
    ["{RIVAL}: Yeah! Am\nI great or what?"] = "{RIVAL}：善哉！吾強乎？",
  }
  for source, translated in pairs(battleStrings) do
    mod.content.strings:override(source, translated)
  end

  -- Experience quantities use HanNumber at the call site.  The source keeps
  -- its cartridge-era %d directive as the catalog key; translations may use
  -- %s because Strings validates arity, not directive type.
  mod.content.strings:override("%s gained\n%d EXP. Points!", "%s得%s閱歷！")
  mod.content.strings:override("%s gained\nwith EXP.ALL,\v%d EXP. Points!",
    "%s藉閱歷機得\v%s閱歷！")
  mod.content.strings:override("%s gained\na boosted\v%d EXP. Points!",
    "%s得增益\v%s閱歷！")
  mod.content.strings:override("%s grew\nto level %d!", "%s升至%s級！")

  -- Battle prose extracted from pokered.  Semantic ROM-text slots are kept
  -- wherever possible so the same wording works for player and enemy sides.
  -- _ItemUseText001 is intentionally absent: the engine reuses that label for
  -- both moves and items, so the two call-site fallbacks above carry distinct
  -- 發 / 用 translations instead.
  local battleText = {
    _AIBattleUseItemText = "{RAM:wTrainerName}以{RAM:wNameBuffer}施於{RAM:wEnemyMonNick}！",
    _AttackContinuesText = "{USER}攻勢未止！",
    _AttackMissedText = "{USER}擊不中！",
    _BadlyPoisonedText = "{TARGET}毒劇！",
    _BecameConfusedText = "{TARGET}迷亂！",
    _BuildingRageText = "{USER}怒益盛！",
    _BurnedText = "{TARGET}燒傷！",
    _ButItFailedText = "不成！",
    _CantEscapeText = "不得脫！",
    _CantMoveText = "{USER}不能動！",
    _CoinsScatteredText = "金錢散地！",
    _ConfusedNoMoreText = "{USER}迷亂解！",
    _ConvertedTypeText = "屬變如{TARGET}！",
    _CriticalHitText = "中要害！",
    _DidntAffectText = "於{TARGET}無效！",
    _DisabledNoMoreText = "{USER}技錮解！",
    _DoYouWantToNicknameText = "欲為{RAM:wNameBuffer}命別名乎？",
    _DoesntAffectMonText = "於{TARGET}無效！",
    _DreamWasEatenText = "食{TARGET}之夢！",
    _EnemysWeakText = "敵困矣！{USER}，進！",
    _FastAsleepText = "{USER}昏睡！",
    _FellAsleepText = "{TARGET}寐！",
    _FireDefrostedText = "火解{TARGET}之凍！",
    _FlinchedText = "{USER}畏縮不前！",
    _FrozenText = "{TARGET}凍結！",
    _FullyParalyzedText = "{USER}麻痺不能動！",
    _GettingPumpedText = "{USER}聚氣！",
    _GotAwayText = "得脫！",
    _HasSubstituteText = "{USER}已有替身！",
    _HitWithRecoilText = "{USER}反震受傷！",
    _HitXTimesText = "連中{NUM:wEnemyNumHits, 1, 1}次！",
    _HookedMonAttackedText = "所釣{RAM:wEnemyMonNick}來襲！",
    _HurtByBurnText = "{USER}受燒傷之害！",
    _HurtByLeechSeedText = "寄生種吸{USER}體力！",
    _HurtByPoisonText = "{USER}為毒所傷！",
    _HurtItselfText = "迷亂而自傷！",
    _IsConfusedText = "{USER}迷亂！",
    _IsFrozenText = "{USER}凍結！",
    _IsUnaffectedText = "{TARGET}不受其效！",
    _ItemUseBallText03 = "似已獲之！",
    _ItemUseBallText04 = "惜哉！幾獲矣！",
    _KeptGoingAndCrashedText = "{USER}勢過而仆！",
    _LightScreenProtectedText = "{USER}以光壁自護！",
    _MimicLearnedMoveText = "{USER}習得{RAM:wNameBuffer}！",
    _MirrorMoveFailedText = "鳥學仿不成！",
    _MoneyForWinningText = "{PLAYER}獲{NUM:wAmountMoneyWon, 3 | LEADING_ZEROES | LEFT_ALIGN}元！",
    _MoveDisabledText = "技見錮！",
    _MoveIsDisabledText = "{USER}之{RAM:wNameBuffer}見錮！",
    _MoveNoPPText = "此技技力竭矣！",
    _MoveWasDisabledText = "{TARGET}之{RAM:wNameBuffer}見錮！",
    _MultiHitText = "連中敵{NUM:wPlayerNumHits, 1, 1}次！",
    _MustRechargeText = "{USER}力竭，須息！",
    _NoEffectText = "無效！",
    _NoMovesLeftText = "{RAM:wBattleMonNick}無技可發！",
    _NoWillText = "無戰意！",
    _NotVeryEffectiveText = "效不甚著……",
    _NothingHappenedText = "無事！",
    _OHKOText = "一擊而倒！",
    _ParalyzedMayNotAttackText = "{TARGET}麻痺，或不能動！",
    _PlayerBlackedOutText = "{PLAYER}無可戰之獸！\f{PLAYER}昏厥！",
    _PlayerBlackedOutText2 = "{PLAYER}無可戰之獸！\f{PLAYER}昏厥！",
    _PickUpPayDayMoneyText = "{PLAYER}拾{NUM:wTotalPayDayMoney, 3 | LEADING_ZEROES | LEFT_ALIGN}元！",
    _PoisonedText = "{TARGET}中毒！",
    _RanAwayScaredText = "{TARGET}懼而逃！",
    _RanFromBattleText = "{USER}脫戰而逃！",
    _ReflectGainedArmorText = "{USER}以反障護身！",
    _RegainedHealthText = "{USER}體力復！",
    _SafariZoneAngryText = "野{RAM:wEnemyMonNick}怒！",
    _SafariZoneEatingText = "野{RAM:wEnemyMonNick}方食！",
    _ScaredText = "{RAM:wBattleMonNick}怖而不能動！",
    _ShroudedInMistText = "{USER}隱於白霧！",
    _StatusChangesEliminatedText = "諸變悉除！",
    _SubstituteBrokeText = "{TARGET}之替身破！",
    _SubstituteText = "替身成！",
    _SubstituteTookDamageText = "替身代{TARGET}受擊！",
    _SuckedHealthText = "吸取{TARGET}體力！",
    _SuperEffectiveText = "效尤著！",
    _ThrewBaitText = "{PLAYER}擲餌。",
    _ThrewRockText = "{PLAYER}擲石。",
    _ThrowBallAtTrainerMonText1 = "㬺獸士擋毬！",
    _ThrowBallAtTrainerMonText2 = "勿為盜！",
    _TooWeakSubstituteText = "體力不足，替身不成！",
    _TrainerDefeatedText = "{PLAYER}勝{RAM:wTrainerName}！",
    _TransformedText = "{USER}化為{RAM:wNameBuffer}！",
    _UnleashedEnergyText = "{USER}盡發蓄力！",
    _WasBlownAwayText = "{TARGET}為風颺去！",
    _WasSeededText = "{TARGET}中寄生種！",
    _WildMonAppearedText = "野有{RAM:wEnemyMonNick}出！",
    _WildRanText = "野{RAM:wEnemyMonNick}逃！",
    _WokeUpText = "{USER}醒矣！",

    -- Battle-only data.text reads that bypass RomText at their call sites.
    _GetOutText = "鬼：去矣……去矣……",
    _NoRunningText = "與㬺獸士戰，不可逃！",
    _Rival1WinText = "{RIVAL}：善哉！吾強乎？",
    _UnveiledGhostText = "氣仙鬼鏡顯鬼真形！",
    _UseNextMonText = "更出一獸乎？",
  }
  for id, text in pairs(battleText) do
    mod.content.text:override(id, text)
  end

  -- BEGIN AUTO-GENERATED TEXT WORKSPACE
  -- Generated by tools/import_lzh_text_workspace.py from 㬺獸赤青版.xlsx.
  -- Edit the workbook and re-run the importer; do not hand-edit this block.
  local workspaceText = {
    ["_PalletTownOakHeyWaitDontGoOutText"] = "大木：且止！勿出！", -- PalletTown
    ["_PalletTownOakItsUnsafeText"] = "大木：危哉！深草有野㬺獸。 須有己獸，乃可自衛。吾有策矣！ 來，隨我！", -- PalletTown
    ["_PalletTownGirlText"] = "吾亦畜㬺獸。及其壯也，可以自衛！", -- PalletTown
    ["_PalletTownFisherText"] = "機巧之術，奇哉！ 今物與㬺獸皆可化數，藏取於算器！", -- PalletTown
    ["_PalletTownOaksLabSignText"] = "大木㬺獸驗室", -- PalletTown
    ["_PalletTownSignText"] = "素村 行色待君染", -- PalletTown
    ["_PalletTownPlayersHouseSignText"] = "{PLAYER}宅", -- PalletTown
    ["_PalletTownRivalsHouseSignText"] = "{RIVAL}宅", -- PalletTown
    ["_ViridianCityYoungster1Text"] = "腰懸獸毬，是有㬺獸也！ 隨身攜之，隨處可使，善哉！", -- ViridianCity
    ["_ViridianCityGambler1GymAlwaysClosedText"] = "此㬺獸書院常閉。不知山長為誰？", -- ViridianCity
    ["_ViridianCityGambler1GymLeaderReturnedText"] = "碧邑書院山長歸矣！", -- ViridianCity
    ["_ViridianCityYoungster2YouWantToKnowAboutText"] = "欲知二種蠕蟲㬺獸乎？", -- ViridianCity
    ["_ViridianCityGirlHasntHadHisCoffeeYetText"] = "嗟，翁！乃醉臥於此。無奈何，俟其酒醒耳。", -- ViridianCity
    ["_ViridianCityGirlWhenIGoShopText"] = "往灰邑市物，須紆行碧林。", -- ViridianCity
    ["_ViridianCityOldManSleepyPrivatePropertyText"] = "噫！嗝……且住！聽老夫言！ 咄！勿去！吾言之矣！", -- ViridianCity
    ["_ViridianCityFisherReceivedTM42Text"] = "{PLAYER}得技機卌二！", -- ViridianCity
    ["_ViridianCityFisherTM42ExplanationText"] = "技機卌二載食夢……鼾……", -- ViridianCity
    ["_ViridianCityFisherTM42NoRoomText"] = "行囊已滿，不可復納。", -- ViridianCity
    ["_ViridianCityOldManHadMyCoffeeNowText"] = "嗯……適醉甚矣！頭痛甚矣……子有急乎？", -- ViridianCity
    ["_ViridianCityOldManKnowHowToCatchPokemonText"] = "見子用㬺獸記機。獲一獸，其錄自增。何？不知獲獸之法乎？吾示子。", -- ViridianCity
    ["_ViridianCityOldManTimeIsMoneyText"] = "時即金也……行矣。", -- ViridianCity
    ["_ViridianCityOldManYouNeedToWeakenTheTargetText"] = "先弱其獸，乃可獲之。", -- ViridianCity
    ["_ViridianCitySignText"] = "碧邑 長青樂土", -- ViridianCity
    ["_ViridianCityTrainerTips1Text"] = "㬺獸士須知 多獲㬺獸，以廣所藏！獸愈多，戰愈便！", -- ViridianCity
    ["_ViridianCityTrainerTips2Text"] = "㬺獸士須知 技之可施，以技力為限。技力欲復，使疲獸憩於㬺獸中心！", -- ViridianCity
    ["_ViridianCityGymSignText"] = "碧邑㬺獸書院", -- ViridianCity
    ["_ViridianCityGymLockedText"] = "書院門已鎖……", -- ViridianCity
    ["_PewterCityCooltrainerFText"] = "傳言明魄自月而來。月石墜月山後乃見之。", -- PewterCity
    ["_PewterCityCooltrainerMText"] = "此地篤志㬺獸士不多，多不過獵蟲幼子之流。惟灰邑書院岳右夫篤好其道！", -- PewterCity
    ["_PewterCitySuperNerd1DidYouCheckOutMuseumText"] = "觀過博物館乎？", -- PewterCity
    ["_PewterCitySuperNerd1WerentThoseFossilsAmazingText"] = "月山諸僵石，豈不奇哉？", -- PewterCity
    ["_PewterCitySuperNerd1YouHaveToGoText"] = "未觀？必往！", -- PewterCity
    ["_PewterCitySuperNerd1ItsRightHereText"] = "就在此！入須納費，然值得一觀。後會！", -- PewterCity
    ["_PewterCitySuperNerd2DoYouKnowWhatImDoingText"] = "噓！知吾所為乎？", -- PewterCity
    ["_PewterCitySuperNerd2ThatsRightText"] = "是也！甚費力。", -- PewterCity
    ["_PewterCitySuperNerd2ImSprayingRepelText"] = "吾灑驅獸劑，使㬺獸不入吾園！", -- PewterCity
    ["_PewterCityYoungsterYoureATrainerFollowMeText"] = "子是㬺獸士乎？岳右夫正求來挑戰者！隨我。", -- PewterCity
    ["_PewterCityYoungsterGoTakeOnBrockText"] = "若自信有能，便往挑岳右夫！", -- PewterCity
    ["_PewterCityTrainerTipsText"] = "㬺獸士須知 凡參戰之獸，雖頃刻，皆得閱歷。", -- PewterCity
    ["_PewterCityPoliceNoticeSignText"] = "告示 月山有賊竊㬺獸僵石！知情者請告灰邑巡捕。", -- PewterCity
    ["_PewterCityMuseumSignText"] = "灰邑格致博物館", -- PewterCity
    ["_PewterCityGymSignText"] = "灰邑㬺獸書院 山長：岳右夫 守若磐石之㬺獸士！", -- PewterCity
    ["_PewterCitySignText"] = "灰邑 石色蒼然", -- PewterCity
    ["_BluesHouseDaisyRivalAtLabText"] = "{PLAYER}，安！{RIVAL}在大父驗室。", -- BluesHouse
    ["_BluesHouseDaisyOfferMapText"] = "大父使子辦事乎？此物可助子。", -- BluesHouse
    ["_GotMapText"] = "{PLAYER}得{RAM:wStringBuffer}！", -- BluesHouse
    ["_BluesHouseDaisyBagFullText"] = "行囊已滿。", -- BluesHouse
    ["_BluesHouseDaisyUseMapText"] = "用縣圖可知所在。", -- BluesHouse
    ["_BluesHouseDaisyWalkingText"] = "㬺獸亦生物也！疲則使之休息。", -- BluesHouse
    ["_BluesHouseTownMapText"] = "大圖也！甚有用。", -- BluesHouse
    ["_Route1Youngster1MartSampleText"] = "安！吾在雜貨肆供職。其肆便於市物，在碧邑，幸來顧。且贈子一試用品。奉上！", -- Route1
    ["_Route1Youngster1GotPotionText"] = "{PLAYER}得{RAM:wStringBuffer}！", -- Route1
    ["_Route1Youngster1AlsoGotPokeballsText"] = "本肆亦售獸毬，可獲㬺獸！", -- Route1
    ["_Route1Youngster1NoRoomText"] = "行囊已滿！", -- Route1
    ["_Route1Youngster2Text"] = "見路旁高坎乎？稍可怖，然可躍下。由此返素村尤捷。", -- Route1
    ["_Route1SignText"] = "第一道 素村—碧邑", -- Route1
    ["_OaksLabRivalGrampsIsntAroundText"] = "{RIVAL}：嗟，{PLAYER}！大父不在矣。", -- OaksLab
    ["_OaksLabRivalGoAheadAndChooseText"] = "{RIVAL}：吾豈若子貪乎？{PLAYER}，子先擇之！", -- OaksLab
    ["_OaksLabRivalMyPokemonLooksStrongerText"] = "{RIVAL}：觀吾獸，似強多矣。", -- OaksLab
    ["_OaksLabThoseArePokeBallsText"] = "彼皆獸毬，內有㬺獸。", -- OaksLab
    ["_OaksLabYouWantCharmanderText"] = "然！子欲取火獸熛螭乎？", -- OaksLab
    ["_OaksLabYouWantSquirtleText"] = "然！子欲取水獸朋龜乎？", -- OaksLab
    ["_OaksLabYouWantBulbasaurText"] = "然！子欲取草獸奇種蛙乎？", -- OaksLab
    ["_OaksLabMonEnergeticText"] = "此獸甚健！", -- OaksLab
    ["_OaksLabReceivedMonText"] = "{PLAYER}得{RAM:wNameBuffer}！", -- OaksLab
    ["_OaksLabLastMonText"] = "此乃大木博士所餘最後一獸。", -- OaksLab
    ["_OaksLabOak1WhichPokemonDoYouWantText"] = "大木：{PLAYER}，今欲何獸？", -- OaksLab
    ["_OaksLabOak1YourPokemonCanFightText"] = "大木：若野獸出，子之㬺獸可與之鬭！", -- OaksLab
    ["_OaksLabOak1RaiseYourYoungPokemonText"] = "大木：{PLAYER}，令幼獸多戰以長之！", -- OaksLab
    ["_OaksLabOak1DeliverParcelText"] = "大木：哦，{PLAYER}！吾所與之獸如何？觀其甚親子。子必善為㬺獸士！何？有物與我乎？ {PLAYER}以大木所寄之物奉還。", -- OaksLab
    ["_OaksLabOak1ParcelThanksText"] = "啊！此乃吾所訂特製獸毬！多謝。", -- OaksLab
    ["_OaksLabOak1PokemonAroundTheWorldText"] = "天下㬺獸待子矣，{PLAYER}！", -- OaksLab
    ["_OaksLabOak1ReceivedPokeballsText"] = "大木：徒見之不能詳錄㬺獸，必獲之。以此獲野獸。{PLAYER}得獸毬五枚！", -- OaksLab
    ["_OaksLabGivePokeballsExplanationText"] = "野獸既出，即可獲之。投獸毬而試取之！然未必得。健獸或逸，亦須有幸。", -- OaksLab
    ["_OaksLabOak1ComeSeeMeSometimesText"] = "大木：時來見我。我欲知子㬺獸記機所錄如何。", -- OaksLab
    ["_OaksLabOak1HowIsYourPokedexComingText"] = "大木：善來！所錄如何？來，容我一觀！", -- OaksLab
    ["_OaksLabPokedexText"] = "形似圖譜，頁皆空白！", -- OaksLab
    ["_OaksLabOak2Text"] = "？", -- OaksLab
    ["_OaksLabGirlText"] = "大木博士精㬺獸之學，㬺獸士多推重之！", -- OaksLab
    ["_OaksLabRivalFedUpWithWaitingText"] = "{RIVAL}：大父！久待可厭矣！", -- OaksLab
    ["_OaksLabOakChooseMonText"] = "大木：{RIVAL}？容我思之……哦，是矣，吾召子來。且待！來，{PLAYER}！此有㬺獸三。哈哈！皆在獸毬中。吾少時篤為㬺獸士，今老矣，所餘惟三；可與子一。擇之！", -- OaksLab
    ["_OaksLabRivalWhatAboutMeText"] = "{RIVAL}：大父！吾獨無乎？", -- OaksLab
    ["_OaksLabOakBePatientText"] = "大木：毋躁！{RIVAL}，亦與子一。", -- OaksLab
    ["_OaksLabOakDontGoAwayYetText"] = "大木：且住！勿遽去！", -- OaksLab
    ["_OaksLabRivalIllTakeThisOneText"] = "{RIVAL}：然則吾取此。", -- OaksLab
    ["_OaksLabRivalReceivedMonText"] = "{RIVAL}得{RAM:wNameBuffer}！", -- OaksLab
    ["_OaksLabRivalIllTakeYouOnText"] = "{RIVAL}：且住，{PLAYER}！試吾二獸何如？與我鬭！", -- OaksLab
    ["_OaksLabRivalIPickedTheWrongPokemonText"] = "嗟！吾擇錯獸矣！", -- OaksLab
    ["_OaksLabRivalAmIGreatOrWhatText"] = "{RIVAL}：哈哈！吾果強乎？", -- OaksLab
    ["_OaksLabRivalSmellYouLaterText"] = "{RIVAL}：善！吾使獸多戰，以益其強。{PLAYER}！大父！後會！", -- OaksLab
    ["_OaksLabRivalGrampsText"] = "{RIVAL}：大父！", -- OaksLab
    ["_OaksLabRivalWhatDidYouCallMeForText"] = "{RIVAL}：喚我何事？", -- OaksLab
    ["_OaksLabOakIHaveARequestText"] = "大木：哦，是矣！有一事欲託汝二人。", -- OaksLab
    ["_OaksLabOakMyInventionPokedexText"] = "案上者，吾所製㬺獸記機也！凡所見所獲之㬺獸，其詳自錄。此新式圖譜也！", -- OaksLab
    ["_OaksLabOakGotPokedexText"] = "大木：{PLAYER}、{RIVAL}！各攜此去！{PLAYER}自大木得㬺獸記機！", -- OaksLab
    ["_OaksLabOakThatWasMyDreamText"] = "盡錄天下㬺獸，成一完備圖譜……此吾夢也！然吾老矣，力不能及。故欲汝二人代成吾志！速行！此乃㬺獸史上一大業也！", -- OaksLab
    ["_OaksLabRivalLeaveItAllToMeText"] = "{RIVAL}：大父，盡付於我！{PLAYER}，雖不欲言，然此事無須子矣。吾向姊借縣圖，且囑其勿借與{PLAYER}。哈哈！", -- OaksLab
    ["_OaksLabScientistText"] = "吾佐大木博士研究㬺獸。", -- OaksLab
    ["_ViridianMartClerkSayHiToOakText"] = "好！代我問大木博士安。", -- ViridianMart
    ["_ViridianMartClerkYouCameFromPalletTownText"] = "喂！子自素村來乎？", -- ViridianMart
    ["_ViridianMartClerkParcelQuestText"] = "識大木博士乎？其所訂之物已至。可為我送之乎？{PLAYER}得大木所寄之物！", -- ViridianMart
    ["_ViridianMartYoungsterText"] = "此肆多售解毒丸。", -- ViridianMart
    ["_ViridianMartCooltrainerMText"] = "不巧！體補皆售罄矣。", -- ViridianMart
    ["_ViridianSchoolHouseBrunetteGirlText"] = "呼！吾正強記諸筆記。", -- ViridianSchoolHouse
    ["_ViridianSchoolHouseCooltrainerFText"] = "好！黑板所書，須細讀之。", -- ViridianSchoolHouse
    ["_ViridianNicknameHouseBaldingGuyText"] = "命別名可喜而甚難。名簡者最易記。", -- ViridianNicknameHouse
    ["_ViridianNicknameHouseLittleGirlText"] = "吾父亦嗜㬺獸。", -- ViridianNicknameHouse
    ["_ViridianNicknameHouseSpearowText"] = "鶪兒：啾啾！", -- ViridianNicknameHouse
    ["_ViridianNicknameHouseSpearySignText"] = "鬼鶪 名曰鶪兒", -- ViridianNicknameHouse
    ["_PewterNidoranHouseNidoranText"] = "雄鍼兔：汪汪！", -- PewterNidoranHouse
    ["_PewterNidoranHouseLittleBoyText"] = "雄鍼兔，坐！", -- PewterNidoranHouse
    ["_PewterNidoranHouseMiddleAgedManText"] = "吾家此獸得自外人，故難馴。所謂外來獸，乃與他人易得之㬺獸也。其長甚速，然士術未精，戰時或不受命。若有徽章便好了……", -- PewterNidoranHouse
    ["_PewterSpeechHouseGamblerText"] = "㬺獸隨長而習新技；然亦有技，須士授之。", -- PewterSpeechHouse
    ["_PewterSpeechHouseYoungsterText"] = "獸傷或寐，則較易獲。然亦未必。", -- PewterSpeechHouse
    ["_Route2TradeHouseScientistText"] = "獸既仆，不能戰；然切等技猶可用。", -- Route2TradeHouse
    ["_ViridianPokecenterGentlemanText"] = "彼角算器可用，接待員告我。甚厚意！", -- ViridianPokecenter
    ["_ViridianPokecenterCooltrainerMText"] = "前方諸邑皆有㬺獸中心，且不取費！", -- ViridianPokecenter
    ["_RedsHouse1FMomWakeUpText"] = "母：是矣。男兒終有離家之日，電視亦云然。鄰家大木博士正尋子。", -- RedsHouse1F
    ["_RedsHouse1FMomYouShouldRestText"] = "母：{PLAYER}！少息片時罷。", -- RedsHouse1F
    ["_RedsHouse1FMomLookingGreatText"] = "母：善！子與所攜㬺獸氣色俱佳。善自珍重！", -- RedsHouse1F
    ["_RedsHouse1FTVStandByMeMovieText"] = "電視有影戲。四童子行於鐵道。吾亦當行矣。", -- RedsHouse1F
    ["_RedsHouse1FTVWrongSideText"] = "噫，面反矣。", -- RedsHouse1F
    ["_Route2SignText"] = "第二道 碧邑—灰邑", -- Route2
    ["_Route2DiglettsCaveSignText"] = "小潛鼴穴", -- Route2
    ["_Museum1FScientist1ComeAgainText"] = "後當復來！", -- Museum1F
    ["_Museum1FScientist1WouldYouLikeToComeInText"] = "童券五十元，欲入乎？", -- Museum1F
    ["_Museum1FScientist1ThankYouText"] = "然，五十元。多謝！", -- Museum1F
    ["_Museum1FScientist1DontHaveEnoughMoneyText"] = "錢不足。", -- Museum1F
    ["_Museum1FScientist1DoYouKnowWhatAmberIsText"] = "後門不可偷入！罷了。子知琥珀乎？", -- Museum1F
    ["_Museum1FScientist1TheresALabSomewhereText"] = "有驗室正試由琥珀復生古㬺獸。", -- Museum1F
    ["_Museum1FScientist1AmberIsFossilizedTreeSapText"] = "琥珀者，樹脂久化而成也。", -- Museum1F
    ["_Museum1FScientist1GoToOtherSideText"] = "請往彼側！", -- Museum1F
    ["_Museum1FScientist1TakePlentyOfTimeText"] = "徐徐觀之！", -- Museum1F
    ["_Museum1FGamblerText"] = "好一巨麗僵石！", -- Museum1F
    ["_Museum1FScientist2TakeThisToAPokemonLabText"] = "噓！吾疑此琥珀內存㬺獸遺傳質。若由此可復生㬺獸，豈不妙哉！然同僚皆不理吾。故有一請：持此至㬺獸驗室，使之檢驗！", -- Museum1F
    ["_Museum1FScientist2ReceivedOldAmberText"] = "{PLAYER}得古琥珀！", -- Museum1F
    ["_Museum1FScientist2GetTheOldAmberCheckText"] = "噓！須將古琥珀驗之！", -- Museum1F
    ["_Museum1FScientist2YouDontHaveSpaceText"] = "行囊無隙。", -- Museum1F
    ["_Museum1FScientist3Text"] = "館藏二僵石，皆上古極罕㬺獸，吾等以此為榮！", -- Museum1F
    ["_Museum1FOldAmberText"] = "此琥珀澄澈金黃。", -- Museum1F
    ["_Museum2FYoungsterText"] = "月石？有何異乎？", -- Museum2F
    ["_Museum2FGrampsText"] = "一九六九年七月廾日！人類初登月！吾特買彩色電視觀之。", -- Museum2F
    ["_Museum2FScientistText"] = "今有宇宙展。", -- Museum2F
    ["_Museum2FBrunetteGirlText"] = "吾欲小電蟨！甚可愛！已請父為我獲一。", -- Museum2F
    ["_Museum2FHikerText"] = "好，不久即給子小電蟨，吾許之。", -- Museum2F
    ["_Museum2FSpaceShuttleSignText"] = "航天梭 哥倫比亞號", -- Museum2F
    ["_Museum2FMoonStoneSignText"] = "墜於月山之隕石 （月石？）", -- Museum2F
    ["_PewterGymBrockPreBattleText"] = "吾岳右夫，灰邑書院山長也！吾信守堅如岩，志不可奪。故所使皆岩屬㬺獸。子猶欲挑戰乎？善！盡其技來！", -- PewterGym
    ["_PewterGymBrockPostBattleAdviceText"] = "天下㬺獸士其術各異。觀子於此道頗有才。往縹邑書院試技去！", -- PewterGym
    ["_PewterGymBrockWaitTakeThisText"] = "且住！攜此去！", -- PewterGym
    ["_PewterGymReceivedTM34Text"] = "{PLAYER}得技機卅四！", -- PewterGym
    ["_TM34ExplanationText"] = "技機中載可授㬺獸之技。技機一用即盡，故授新技時，須慎擇其獸。技機卅四載忍耐。此技受敵傷而蓄之，後倍返之。", -- PewterGym
    ["_PewterGymTM34NoRoomText"] = "行囊無隙。", -- PewterGym
    ["_PewterGymBrockReceivedBoulderBadgeText"] = "吾先前輕子矣。以勝之證，授子灰徽！{PLAYER}得灰徽！", -- PewterGym
    ["_PewterGymBrockBoulderBadgeInfoText"] = "此㬺獸聯會所認之徽也！持者所攜之獸力益強。今閃光之技可隨時用。", -- PewterGym
    ["_PewterGymCooltrainerMBattleText"] = "小子，止！距見岳右夫尚有光年之遙！", -- PewterGym
    ["_PewterGymCooltrainerMEndBattleText"] = "可惱！光年非時，乃量遠近也！", -- PewterGym
    ["_PewterGymCooltrainerMAfterBattleText"] = "子頗有本事，然未及岳右夫！", -- PewterGym
    ["_PewterGymGuidePreAdviceText"] = "嗨！一見便知子有㬺獸師之材！吾雖非㬺獸士，卻知取勝之法。吾引子登頂！", -- PewterGym
    ["_PewterGymGuideBeginAdviceText"] = "善！即始！", -- PewterGym
    ["_PewterGymGuideAdviceText"] = "戰時首出者，即攜獸列首者。易其先後，可使戰事較易。", -- PewterGym
    ["_PewterGymGuideFreeServiceText"] = "此教不取金！即始！", -- PewterGym
    ["_PewterGymGuidePostBattleText"] = "果如吾料！子真有㬺獸師之材！", -- PewterGym
    ["_PewterPokecenterGentlemanText"] = "何！？火箭隊在月山？嗯？我正通電話！去去！", -- PewterPokecenter
    ["_PewterPokecenterJigglypuffText"] = "謳毬毚：噗噗噗！", -- PewterPokecenter
    ["_ViridianForestNorthGateSuperNerdText"] = "多有㬺獸惟生林穴。欲得異種，須遍求諸處。", -- ViridianForestNorthGate
    ["_ViridianForestNorthGateGrampsText"] = "見道旁灌木乎？有一特技可斫除之。", -- ViridianForestNorthGate
    ["_Route2GateOaksAideFlashExplanationText"] = "祕傳機閃光，雖幽穴亦能照之。", -- Route2Gate
    ["_Route2GateYoungsterText"] = "㬺獸既習閃光，即可通岩山隧。", -- Route2Gate
    ["_ViridianForestSouthGateGirlText"] = "欲入碧林乎？慎之，其天然如迷宮。", -- ViridianForestSouthGate
    ["_ViridianForestSouthGateLittleGirlText"] = "幼鼠雖小，齧甚厲！子得一乎？", -- ViridianForestSouthGate
    ["_ViridianForestYoungster1Text"] = "吾與友偕來，彼等正求與人鬭獸！", -- ViridianForest
    ["_ViridianForestYoungster2BattleText"] = "喂！子有㬺獸！來，鬭一場！", -- ViridianForest
    ["_ViridianForestYoungster2EndBattleText"] = "不！羶鳳蠋不堪戰！", -- ViridianForest
    ["_ViridianForestYoungster2AfterBattleText"] = "噓！將驚走諸蟲！", -- ViridianForest
    ["_ViridianForestYoungster3BattleText"] = "喂！既為㬺獸士，豈可避戰！", -- ViridianForest
    ["_ViridianForestYoungster3EndBattleText"] = "咦？吾獸盡矣！", -- ViridianForest
    ["_ViridianForestYoungster3AfterBattleText"] = "可惱！吾當更獲強者！", -- ViridianForest
    ["_ViridianForestYoungster4BattleText"] = "且住！何其急也？", -- ViridianForest
    ["_ViridianForestYoungster4EndBattleText"] = "服矣！子甚善戰。", -- ViridianForest
    ["_ViridianForestYoungster4AfterBattleText"] = "地上時有遺物。吾正尋所失之物。", -- ViridianForest
    ["_ViridianForestYoungster5Text"] = "吾獸毬用盡，無以獲獸！宜多備之。", -- ViridianForest
    ["_ViridianForestTrainerTips1Text"] = "㬺獸士須知 欲避戰，勿入草叢。", -- ViridianForest
    ["_ViridianForestUseAntidoteSignText"] = "中毒用解毒丸！雜貨肆有售。", -- ViridianForest
    ["_ViridianForestTrainerTips2Text"] = "㬺獸士須知 以算器聯大木博士，可請評㬺獸記機之錄。", -- ViridianForest
    ["_ViridianForestTrainerTips3Text"] = "㬺獸士須知 不可竊他士之獸！惟獲野獸。", -- ViridianForest
    ["_ViridianForestTrainerTips4Text"] = "㬺獸士須知 欲獲獸，先弱之。健則或逸。", -- ViridianForest
    ["_ViridianForestLeavingSignText"] = "出碧林 前至灰邑", -- ViridianForest
    ["_PewterMartYoungsterText"] = "一可疑老翁哄吾買此怪魚獸！弱甚，竟費五百元！", -- PewterMart
    ["_PewterMartSuperNerdText"] = "縱弱獸，勤養之亦或有佳報。", -- PewterMart
    ["_MartSignText"] = "百物俱備 雜貨肆", -- Draft
    ["_PokeCenterSignText"] = "療㬺獸 㬺獸中心", -- Draft
    ["_GymStatueText1"] = "{RAM:wGymCityName}㬺獸書院 山長：{RAM:wGymLeaderName} 勝者：{RIVAL}", -- Draft
    ["_GymStatueText2"] = "{RAM:wGymCityName}㬺獸書院 山長：{RAM:wGymLeaderName} 勝者：{RIVAL} {PLAYER}", -- Draft
    ["_ViridianCityPokecenterGuyText"] = "㬺獸中心可療疲、傷、仆倒之獸！", -- Draft
    ["_PewterCityPokecenterGuyText"] = "呵欠……謳毬毚一謳，㬺獸即昏昏欲寐……我亦然……呼……", -- Draft
    ["_BookcaseText"] = "架上㬺獸書充牣。", -- Draft
    ["_TurnPageText"] = "翻頁乎？", -- Draft
    ["_ViridianSchoolNotebookText5"] = "女：咄！勿窺吾筆記！", -- Draft
    ["_ViridianSchoolNotebookText1"] = "閱其筆記。第一頁……獸毬所以獲㬺獸。至多可攜六獸。畜獸而使之鬭者，謂之㬺獸士。", -- Draft
    ["_ViridianSchoolNotebookText2"] = "第二頁……健獸難獲，宜先弱之。中毒、燒傷諸患皆有助。", -- Draft
    ["_ViridianSchoolNotebookText3"] = "第三頁……㬺獸士常訪同道而鬭獸。諸書院亦常有戰。", -- Draft
    ["_ViridianSchoolNotebookText4"] = "第四頁……㬺獸士之志，在勝八書院山長，乃得進而挑戰㬺獸聯會四天王。", -- Draft
    ["_ViridianSchoolBlackboardText1"] = "黑板載㬺獸戰中諸異狀。", -- Draft
    ["_ViridianSchoolBlackboardText2"] = "欲讀何項？", -- Draft
    ["_ViridianBlackboardSleepText"] = "㬺獸寐則不能攻。戰畢猶或寐。用惺惺散可醒之！", -- Draft
    ["_ViridianBlackboardPoisonText"] = "中毒則體力漸減，戰畢毒猶存。用解毒丸治之！", -- Draft
    ["_ViridianBlackboardPrlzText"] = "痺則施技或失。戰畢痺猶存。用蠲痺湯治之！", -- Draft
    ["_ViridianBlackboardBurnText"] = "燒傷則力與速皆減，且體力續損。戰畢傷猶存。用獨聖散治之！", -- Draft
    ["_ViridianBlackboardFrozenText"] = "凍結則全不能動，戰畢猶凍。用溫劑解之！", -- Draft
    ["_PokemonBooksText"] = "架上㬺獸書充牣。", -- Draft
    ["_DiglettSculptureText"] = "小潛鼴像也。", -- Draft
    ["_ElevatorText"] = "升降機也。", -- Draft
    ["_TownMapText"] = "縣圖也。", -- Draft
    ["_PokemonStuffText"] = "架上㬺獸用物甚多。", -- Draft
    ["_OakSpeechText1"] = "無恙！幸會。此㬺獸世界也！ 吾名大木，人稱㬺獸博士。", -- Ready
    ["_OakSpeechText2A"] = "此世有生物，名曰㬺獸。", -- Ready
    ["_OakSpeechText2B"] = "或畜為寵，或使之鬭。至於吾……以研究㬺獸為業。", -- Ready
    ["_IntroducePlayerText"] = "先問：足下何名？", -- Ready
    ["_IntroduceRivalText"] = "此吾孫也。自襁褓時，與子爭勝至今。呃……吾忘矣。其名何也？", -- Ready
    ["_OakSpeechText3"] = "{PLAYER}！子之㬺獸傳，今將始矣！㬺獸之世，夢與遊歷皆待子。行矣！", -- Ready
    ["_YourNameIsText"] = "是矣！子名{PLAYER}！", -- Ready
    ["_HisNameIsText"] = "是矣！吾憶矣！其名{RIVAL}！", -- Ready
    ["_PokemartGreetingText"] = "安！有何所需？", -- Draft
    ["_RepelWoreOffText"] = "驅獸劑之效已盡。", -- Draft
    ["_PokemartBuyingGreetingText"] = "徐徐選之。", -- Draft
    ["_PokemartTellBuyPriceText"] = "{RAM:wStringBuffer}？價{NUM:hMoney, 3 | LEADING_ZEROES | LEFT_ALIGN}元，可乎？", -- Draft
    ["_PokemartBoughtItemText"] = "奉上！多謝。", -- Draft
    ["_PokemartNotEnoughMoneyText"] = "錢不足。", -- Draft
    ["_PokemartItemBagFullText"] = "行囊已滿。", -- Draft
    ["_PokemonSellingGreetingText"] = "欲售何物？", -- Draft
    ["_PokemartTellSellPriceText"] = "此物可售{NUM:hMoney, 3 | LEADING_ZEROES | LEFT_ALIGN}元。", -- Draft
    ["_PokemartItemBagEmptyText"] = "無物可售。", -- Draft
    ["_PokemartUnsellableItemText"] = "此物不可估價。", -- Draft
    ["_PokemartThankYouText"] = "多謝！", -- Draft
    ["_PokemartAnythingElseText"] = "尚有所需乎？", -- Draft
    ["_PokemonCenterWelcomeText"] = "歡迎至㬺獸中心！此處可療㬺獸，使復全健。", -- Draft
    ["_ShallWeHealYourPokemonText"] = "可為子療獸乎？", -- Draft
    ["_NeedYourPokemonText"] = "善，請交所攜之獸。", -- Draft
    ["_PokemonFightingFitText"] = "多謝！諸獸皆健矣！", -- Draft
    ["_PokemonCenterFarewellText"] = "願後會！", -- Draft
  }
  for id, text in pairs(workspaceText) do
    mod.content.text:override(id, text)
  end
  -- END AUTO-GENERATED TEXT WORKSPACE

  -- New-game defaults are data, while every preset choice is localized through
  -- uiStrings above (RED/ASH/JACK and BLUE/GARY/JOHN).  The naming screen
  -- writes the localized display value to the save, so the chosen Han name is
  -- the actual player/rival identity rather than a label painted over English.
  mod.content.field:patch("boot", {
    playerName = "赤", rivalName = "青",
  })

  local moveNames = {
    ["ABSORB"] = "吸取",
    ["ACID"] = "蝕液",
    ["ACID_ARMOR"] = "溶身",
    ["AGILITY"] = "高速",
    ["AMNESIA"] = "健忘",
    ["AURORA_BEAM"] = "極光",
    ["BARRAGE"] = "投毬",
    ["BARRIER"] = "障",
    ["BIDE"] = "忍耐",
    ["BIND"] = "緊",
    ["BITE"] = "咬",
    ["BLIZZARD"] = "暴雪",
    ["BODY_SLAM"] = "身壓",
    ["BONEMERANG"] = "返骨",
    ["BONE_CLUB"] = "骨棒",
    ["BUBBLE"] = "泡",
    ["BUBBLEBEAM"] = "泡光",
    ["CLAMP"] = "殼夾",
    ["COMET_PUNCH"] = "複拳",
    ["CONFUSE_RAY"] = "迷光",
    ["CONFUSION"] = "念力",
    ["CONSTRICT"] = "絞纏",
    ["CONVERSION"] = "紋理",
    ["COUNTER"] = "反擊",
    ["CRABHAMMER"] = "蟹鉗槌",
    ["CUT"] = "切",
    ["DEFENSE_CURL"] = "蜷身",
    ["DIG"] = "掘穴",
    ["DISABLE"] = "定身",
    ["DIZZY_PUNCH"] = "眩拳",
    ["DOUBLESLAP"] = "複批",
    ["DOUBLE_EDGE"] = "捨身撞",
    ["DOUBLE_KICK"] = "複踆",
    ["DOUBLE_TEAM"] = "分身",
    ["DRAGON_RAGE"] = "龍怒",
    ["DREAM_EATER"] = "食夢",
    ["DRILL_PECK"] = "鑽啄",
    ["EARTHQUAKE"] = "地震",
    ["EGG_BOMB"] = "爆卵",
    ["EMBER"] = "火星",
    ["EXPLOSION"] = "大爆",
    ["FIRE_BLAST"] = "炎大文",
    ["FIRE_PUNCH"] = "火拳",
    ["FIRE_SPIN"] = "火渦",
    ["FISSURE"] = "地裂",
    ["FLAMETHROWER"] = "噴焰",
    ["FLASH"] = "閃光",
    ["FLY"] = "飛",
    ["FOCUS_ENERGY"] = "聚氣",
    ["FURY_ATTACK"] = "亂刺",
    ["FURY_SWIPES"] = "亂抓",
    ["GLARE"] = "蛇瞪",
    ["GROWL"] = "叫",
    ["GROWTH"] = "生長",
    ["GUILLOTINE"] = "斷首",
    ["GUST"] = "風",
    ["HARDEN"] = "堅",
    ["HAZE"] = "黑霧",
    ["HEADBUTT"] = "頭觸",
    ["HI_JUMP_KICK"] = "飛膝踆",
    ["HORN_ATTACK"] = "牴",
    ["HORN_DRILL"] = "角鑽",
    ["HYDRO_PUMP"] = "水砲",
    ["HYPER_BEAM"] = "毀光",
    ["HYPER_FANG"] = "必殺牙",
    ["HYPNOSIS"] = "行捨",
    ["ICE_BEAM"] = "凍光",
    ["ICE_PUNCH"] = "冰拳",
    ["JUMP_KICK"] = "飛踆",
    ["KARATE_CHOP"] = "空手劈",
    ["KINESIS"] = "折勺",
    ["LEECH_LIFE"] = "吸血",
    ["LEECH_SEED"] = "寄生種",
    ["LEER"] = "瞪眼",
    ["LICK"] = "舐",
    ["LIGHT_SCREEN"] = "光壁",
    ["LOVELY_KISS"] = "魔吻",
    ["LOW_KICK"] = "掃足",
    ["MEDITATE"] = "瑜伽",
    ["MEGA_DRAIN"] = "嵩吸",
    ["MEGA_KICK"] = "嵩力踆",
    ["MEGA_PUNCH"] = "嵩力拳",
    ["METRONOME"] = "揮指",
    ["MIMIC"] = "仿",
    ["MINIMIZE"] = "縮小",
    ["MIRROR_MOVE"] = "鳥學仿",
    ["MIST"] = "白霧",
    ["NIGHT_SHADE"] = "夜影",
    ["PAY_DAY"] = "聚朋擊",
    ["PECK"] = "啄",
    ["PETAL_DANCE"] = "花舞",
    ["PIN_MISSILE"] = "飛針",
    ["POISONPOWDER"] = "毒粉",
    ["POISON_GAS"] = "毒氣",
    ["POISON_STING"] = "毒刺",
    ["POUND"] = "擊",
    ["PSYBEAM"] = "念光",
    ["PSYCHIC_M"] = "念動",
    ["PSYWAVE"] = "念波",
    ["QUICK_ATTACK"] = "須臾撇",
    ["RAGE"] = "怒",
    ["RAZOR_LEAF"] = "葉刀",
    ["RAZOR_WIND"] = "旋風刀",
    ["RECOVER"] = "自愈",
    ["REFLECT"] = "反障",
    ["REST"] = "安寐",
    ["ROAR"] = "吼",
    ["ROCK_SLIDE"] = "岩崩",
    ["ROCK_THROW"] = "擲石",
    ["ROLLING_KICK"] = "圓踆",
    ["SAND_ATTACK"] = "潑沙",
    ["SCRATCH"] = "抓",
    ["SCREECH"] = "厲聲",
    ["SEISMIC_TOSS"] = "地球擲",
    ["SELFDESTRUCT"] = "自爆",
    ["SHARPEN"] = "礪",
    ["SING"] = "唱",
    ["SKULL_BASH"] = "火箭頭觸",
    ["SKY_ATTACK"] = "神鳥擊",
    ["SLAM"] = "摔",
    ["SLASH"] = "劈",
    ["SLEEP_POWDER"] = "寐粉",
    ["SLUDGE"] = "污泥",
    ["SMOG"] = "濁霧",
    ["SMOKESCREEN"] = "煙幕",
    ["SOFTBOILED"] = "生卵",
    ["SOLARBEAM"] = "日光",
    ["SONICBOOM"] = "音爆",
    ["SPIKE_CANNON"] = "刺炮",
    ["SPLASH"] = "躍",
    ["SPORE"] = "蕈孢",
    ["STOMP"] = "踐",
    ["STRENGTH"] = "怪力",
    ["STRING_SHOT"] = "吐絲",
    ["STRUGGLE"] = "掙扎",
    ["STUN_SPORE"] = "痺粉",
    ["SUBMISSION"] = "地獄輪",
    ["SUBSTITUTE"] = "替身",
    ["SUPERSONIC"] = "超聲",
    ["SUPER_FANG"] = "怒牙",
    ["SURF"] = "乘浪",
    ["SWIFT"] = "倏忽星",
    ["SWORDS_DANCE"] = "劍舞",
    ["TACKLE"] = "撞",
    ["TAIL_WHIP"] = "搖尾",
    ["TAKE_DOWN"] = "猛撞",
    ["TELEPORT"] = "瞬移",
    ["THRASH"] = "狂擊",
    ["THUNDER"] = "㷸㷸震電",
    ["THUNDERBOLT"] = "十萬伏特",
    ["THUNDERPUNCH"] = "電拳",
    ["THUNDERSHOCK"] = "電擊",
    ["THUNDER_WAVE"] = "電磁浪",
    ["TOXIC"] = "劇毒",
    ["TRANSFORM"] = "變身",
    ["TRI_ATTACK"] = "三擊",
    ["TWINEEDLE"] = "雙刺",
    ["VICEGRIP"] = "重掎",
    ["VINE_WHIP"] = "藤鞭",
    ["WATERFALL"] = "攀瀑",
    ["WATER_GUN"] = "噴水",
    ["WHIRLWIND"] = "飆",
    ["WING_ATTACK"] = "翼擊",
    ["WITHDRAW"] = "入甲",
    ["WRAP"] = "纏",
  }
  for id, name in pairs(moveNames) do
    if mod.content.moves:get(id) then mod.content.moves:patch(id, { name = name }) end
  end

  local itemNames = {
    ["ANTIDOTE"] = "解毒丸",
    ["AWAKENING"] = "惺惺散",
    ["BICYCLE"] = "自轉車",
    ["BIKE_VOUCHER"] = "自轉車票",
    ["BOULDERBADGE"] = "灰徽",
    ["BURN_HEAL"] = "獨聖散",
    ["CALCIUM"] = "鈣丸",
    ["CARBOS"] = "消炎痛丸",
    ["CARD_KEY"] = "管鑰票",
    ["CASCADEBADGE"] = "青徽",
    ["COIN_CASE"] = "籌匣",
    ["DIRE_HIT"] = "中要害丸",
    ["DOME_FOSSIL"] = "兜僵石",
    ["EARTHBADGE"] = "綠徽",
    ["ELIXER"] = "技力補",
    ["ESCAPE_ROPE"] = "返穴之繩",
    ["ETHER"] = "技補",
    ["EXP_ALL"] = "閱歷機",
    ["FIRE_STONE"] = "火石",
    ["FRESH_WATER"] = "甘水",
    ["FULL_HEAL"] = "萬病丸",
    ["FULL_RESTORE"] = "全復",
    ["GOLD_TEETH"] = "金齒",
    ["GOOD_ROD"] = "良竿",
    ["GREAT_BALL"] = "良毬",
    ["GUARD_SPEC"] = "守常",
    ["HELIX_FOSSIL"] = "貝僵石",
    ["HP_UP"] = "益氣丸",
    ["HYPER_POTION"] = "善體補",
    ["ICE_HEAL"] = "溫劑",
    ["IRON"] = "鐵丸",
    ["ITEMFINDER"] = "覓物機",
    ["ITEM_32"] = "技力增",
    ["LEAF_STONE"] = "葉石",
    ["LEMONADE"] = "果汁",
    ["LIFT_KEY"] = "昇降機管鑰",
    ["MARSHBADGE"] = "金徽",
    ["MASTER_BALL"] = "聖毬",
    ["MAX_ELIXER"] = "技力復滿",
    ["MAX_ETHER"] = "技復滿",
    ["MAX_POTION"] = "體復滿",
    ["MAX_REPEL"] = "金驅獸劑",
    ["MAX_REVIVE"] = "元氣塊",
    ["MOON_STONE"] = "月石",
    ["NUGGET"] = "金珠",
    ["OAKS_PARCEL"] = "大木之包",
    ["OLD_AMBER"] = "古琥珀",
    ["OLD_ROD"] = "舊竿",
    ["PARLYZ_HEAL"] = "蠲痺湯",
    ["POKE_BALL"] = "獸毬",
    ["POKE_DOLL"] = "明魄偶",
    ["POKE_FLUTE"] = "㬺獸籥",
    ["POTION"] = "體補",
    ["PP_UP"] = "技力增",
    ["PROTEIN"] = "牛磺酸丸",
    ["RAINBOWBADGE"] = "虹徽",
    ["RARE_CANDY"] = "奇飴",
    ["REPEL"] = "驅獸劑",
    ["REVIVE"] = "元氣片",
    ["SAFARI_BALL"] = "獲獸毬",
    ["SECRET_KEY"] = "隱管鑰",
    ["SILPH_SCOPE"] = "氣仙鬼鏡",
    ["SODA_POP"] = "氣水",
    ["SOULBADGE"] = "縓徽",
    ["SUPER_POTION"] = "良體補",
    ["SUPER_REPEL"] = "銀驅獸劑",
    ["SUPER_ROD"] = "善竿",
    ["S_S_TICKET"] = "船票",
    ["THUNDERBADGE"] = "橙徽",
    ["THUNDER_STONE"] = "雷石",
    ["TOWN_MAP"] = "縣圖",
    ["ULTRA_BALL"] = "善毬",
    ["VOLCANOBADGE"] = "絳徽",
    ["WATER_STONE"] = "水石",
    ["X_ACCURACY"] = "必中丸",
    ["X_ATTACK"] = "增力丸",
    ["X_DEFEND"] = "增守丸",
    ["X_SPECIAL"] = "增異能丸",
    ["X_SPEED"] = "增速丸",
  }
  for id, name in pairs(itemNames) do
    if mod.content.items:get(id) then mod.content.items:patch(id, { name = name }) end
  end

  local trainerNames = {
    ["OPP_AGATHA"] = "菊子",
    ["OPP_BLAINE"] = "桂夏",
    ["OPP_BROCK"] = "岳右夫",
    ["OPP_BRUNO"] = "岩崎芝",
    ["OPP_ERIKA"] = "麥恵梨香",
    ["OPP_GIOVANNI"] = "榊岸邊",
    ["OPP_KOGA"] = "桔杏",
    ["OPP_LANCE"] = "阿渡",
    ["OPP_LORELEI"] = "蕉美雪",
    ["OPP_LT_SURGE"] = "馬志士",
    ["OPP_MISTY"] = "霞海花",
    ["OPP_RIVAL1"] = "青",
    ["OPP_RIVAL2"] = "青",
    ["OPP_RIVAL3"] = "青",
    ["OPP_SABRINA"] = "棗夢",
  }
  local trainerClassNames = {
    ["OPP_BEAUTY"] = "娘子",
    ["OPP_BIKER"] = "暴走徒",
    ["OPP_BIRD_KEEPER"] = "鳥使",
    ["OPP_BLACKBELT"] = "空手王",
    ["OPP_BUG_CATCHER"] = "獵蟲幼子",
    ["OPP_BURGLAR"] = "趁火打劫之徒",
    ["OPP_CHANNELER"] = "覡巫",
    ["OPP_CHIEF"] = "氣仙渠帥",
    ["OPP_COOLTRAINER_F"] = "高手",
    ["OPP_COOLTRAINER_M"] = "高手",
    ["OPP_CUE_BALL"] = "髡徒",
    ["OPP_ENGINEER"] = "機師",
    ["OPP_FISHER"] = "漁",
    ["OPP_GAMBLER"] = "博徒",
    ["OPP_GENTLEMAN"] = "紳士",
    ["OPP_HIKER"] = "山客",
    ["OPP_JR_TRAINER_F"] = "女童軍",
    ["OPP_JR_TRAINER_M"] = "童子軍",
    ["OPP_JUGGLER"] = "跳丸",
    ["OPP_LASS"] = "短裙妹",
    ["OPP_POKEMANIAC"] = "怪獸癡",
    ["OPP_PROF_OAK"] = "大木博士",
    ["OPP_PSYCHIC_TR"] = "念士",
    ["OPP_ROCKER"] = "電氣伶",
    ["OPP_ROCKET"] = "火箭皂隸",
    ["OPP_SAILOR"] = "水手",
    ["OPP_SCIENTIST"] = "叛士",
    ["OPP_SUPER_NERD"] = "廩生",
    ["OPP_SWIMMER"] = "健泅",
    ["OPP_TAMER"] = "猛獸使",
    ["OPP_UNUSED_JUGGLER"] = "跳丸",
    ["OPP_YOUNGSTER"] = "短褲童",
  }
  for id, name in pairs(trainerClassNames) do
    trainerNames[id] = name
  end
  for id, name in pairs(trainerNames) do
    if mod.content.trainers:get(id) then mod.content.trainers:patch(id, { name = name }) end
  end

  -- Type names come from the workbook too.  type_chart uses a write-routed
  -- registry, so preserve each built-in record's category while replacing
  -- only its presentation name.
  local typeNames = {
    NORMAL = "常", FIGHTING = "鬥", FLYING = "飛", POISON = "毒",
    GROUND = "土", ROCK = "石", BUG = "蟲", GHOST = "鬼",
    FIRE = "火", WATER = "水", GRASS = "草", ELECTRIC = "雷",
    PSYCHIC_TYPE = "念", ICE = "冰", DRAGON = "龍",
  }
  for id, name in pairs(typeNames) do
    local current = mod.content.type_chart:get(id)
    if current then
      mod.content.type_chart:override(id, {
        name = name, category = current.category, index = current.index,
      })
    end
  end

  local statusNames = {
    ["BRN"] = { label = "燒傷", hudLabel = "燒" },
    ["FRZ"] = { label = "凍", hudLabel = "凍" },
    ["PAR"] = { label = "痺", hudLabel = "痺" },
    ["PSN"] = { label = "毒", hudLabel = "毒" },
    ["SLP"] = { label = "寐", hudLabel = "寐" },
  }
  for id, patch in pairs(statusNames) do
    if mod.content.statuses:get(id) then mod.content.statuses:patch(id, patch) end
  end

  -- The base dataset already has a ttf record.  api-2 `register` collides
  -- with that record and rolls back the WHOLE mod, which is why the earlier
  -- lexicon import left FIGHT/move names in English.  Override it instead.
  -- Keep ordinary ASCII on the cartridge tiles so untranslated UI remains
  -- an 8px safety net while Han text uses the 16px Wenjin grid.
  mod.content.font:override("ttf", {
    file = "assets/fonts/wenjin-mincho/WenJinMinchoP0-Regular.ttf",
    size = 16,
    numberStyle = "han",
    numberSize = 12,
    tiles = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 !\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~é",
    advances = {
      ["，"] = 8, ["。"] = 8, ["、"] = 8, ["；"] = 8,
      ["："] = 8, ["！"] = 8, ["？"] = 8,
    },
  })

end
