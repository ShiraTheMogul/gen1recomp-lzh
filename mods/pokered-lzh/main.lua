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
    ["MONEY"] = "金",
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
    ["BLUE"] = "青",
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
    BULBASAUR    = "種子", -- 001
    IVYSAUR      = "種子", -- 002
    VENUSAUR     = "種子", -- 003
    CHARMANDER   = "螭", -- 004
    CHARMELEON   = "炎", -- 005
    CHARIZARD    = "炎", -- 006
    SQUIRTLE     = "小龜", -- 007
    WARTORTLE    = "龜", -- 008
    BLASTOISE    = "貝", -- 009
    CATERPIE     = "蠋", -- 010
    METAPOD      = "蛹", -- 011
    BUTTERFREE   = "蝴蝶", -- 012
    WEEDLE       = "毛蠋", -- 013
    KAKUNA       = "蛹", -- 014
    BEEDRILL     = "毒蜂", -- 015
    PIDGEY       = "小鳥", -- 016
    PIDGEOTTO    = "鳥", -- 017
    PIDGEOT      = "鳥", -- 018
    RATTATA      = "鼠", -- 019
    RATICATE     = "鼠", -- 020
    SPEAROW      = "小鳥", -- 021
    FEAROW       = "喙", -- 022
    EKANS        = "蛇", -- 023
    ARBOK        = "蝮", -- 024
    PIKACHU      = "鼠", -- 025
    RAICHU       = "鼠", -- 026
    SANDSHREW    = "鼠", -- 027
    SANDSLASH    = "鼠", -- 028
    NIDORAN_F    = "毒鍼", -- 029
    NIDORINA     = "毒鍼", -- 030
    NIDOQUEEN    = "鑽", -- 031
    NIDORAN_M    = "毒鍼", -- 032
    NIDORINO     = "毒鍼", -- 033
    NIDOKING     = "鑽", -- 034
    CLEFAIRY     = "魄", -- 035
    CLEFABLE     = "魄", -- 036
    VULPIX       = "狐狸", -- 037
    NINETALES    = "狐狸", -- 038
    JIGGLYPUFF   = "氣毬", -- 039
    WIGGLYTUFF   = "氣毬", -- 040
    ZUBAT        = "蝙蝠", -- 041
    GOLBAT       = "蝙蝠", -- 042
    ODDISH       = "野草", -- 043
    GLOOM        = "野草", -- 044
    VILEPLUME    = "花", -- 045
    PARAS        = "蟲草", -- 046
    PARASECT     = "蟲草", -- 047
    VENONAT      = "蟲", -- 048
    VENOMOTH     = "毒蛾", -- 049
    DIGLETT      = "鼴", -- 050
    DUGTRIO      = "鼴", -- 051
    MEOWTH       = "抓貓", -- 052
    PERSIAN      = "貴貓", -- 053
    PSYDUCK      = "鴨", -- 054
    GOLDUCK      = "鴨", -- 055
    MANKEY       = "豕猴", -- 056
    PRIMEAPE     = "豕猴", -- 057
    GROWLITHE    = "小犬", -- 058
    ARCANINE     = "傳説", -- 059
    POLIWAG      = "蝌蚪", -- 060
    POLIWHIRL    = "蝌蚪", -- 061
    POLIWRATH    = "蝌蚪", -- 062
    ABRA         = "念力", -- 063
    KADABRA      = "念力", -- 064
    ALAKAZAM     = "念力", -- 065
    MACHOP       = "怪力", -- 066
    MACHOKE      = "怪力", -- 067
    MACHAMP      = "怪力", -- 068
    BELLSPROUT   = "花", -- 069
    WEEPINBELL   = "食蟲植", -- 070
    VICTREEBEL   = "食蟲植", -- 071
    TENTACOOL    = "水母", -- 072
    TENTACRUEL   = "水母", -- 073
    GEODUDE      = "石", -- 074
    GRAVELER     = "石", -- 075
    GOLEM        = "重石", -- 076
    PONYTA       = "火馬", -- 077
    RAPIDASH     = "火馬", -- 078
    SLOWPOKE     = "忘", -- 079
    SLOWBRO      = "蝞", -- 080
    MAGNEMITE    = "磁", -- 081
    MAGNETON     = "磁", -- 082
    FARFETCHD    = "野鴨", -- 083
    DODUO        = "雙鳥", -- 084
    DODRIO       = "三鳥", -- 085
    SEEL         = "海驢", -- 086
    DEWGONG      = "海驢", -- 087
    GRIMER       = "濁", -- 088
    MUK          = "濁", -- 089
    SHELLDER     = "貝", -- 090
    CLOYSTER     = "貝", -- 091
    GASTLY       = "氛煞", -- 092
    HAUNTER      = "氛煞", -- 093
    GENGAR       = "影", -- 094
    ONIX         = "石蛇", -- 095
    DROWZEE      = "催眠", -- 096
    HYPNO        = "催眠", -- 097
    KRABBY       = "河蟹", -- 098
    KINGLER      = "螯", -- 099
    VOLTORB      = "毬", -- 100
    ELECTRODE    = "毬", -- 101
    EXEGGCUTE    = "卵", -- 102
    EXEGGUTOR    = "椰", -- 103
    CUBONE       = "獨", -- 104
    MAROWAK      = "有髓", -- 105
    HITMONLEE    = "踆", -- 106
    HITMONCHAN   = "拳", -- 107
    LICKITUNG    = "舔", -- 108
    KOFFING      = "毒氛煞", -- 109
    WEEZING      = "毒氛煞", -- 110
    RHYHORN      = "刺", -- 111
    RHYDON       = "鑽", -- 112
    CHANSEY      = "卵", -- 113
    TANGELA      = "藤", -- 114
    KANGASKHAN   = "母親", -- 115
    HORSEA       = "龍", -- 116
    SEADRA       = "龍", -- 117
    GOLDEEN      = "鯽", -- 118
    SEAKING      = "鯽", -- 119
    STARYU       = "星形", -- 120
    STARMIE      = "玄", -- 121
    MR_MIME      = "障", -- 122
    SCYTHER      = "螳螂", -- 123
    JYNX         = "人形", -- 124
    ELECTABUZZ   = "電", -- 125
    MAGMAR       = "噴火", -- 126
    PINSIR       = "鋸鍬形蟲", -- 127
    TAUROS       = "野兕", -- 128
    MAGIKARP     = "魚", -- 129
    GYARADOS     = "殘暴不仁", -- 130
    LAPRAS       = "海車", -- 131
    DITTO        = "變形", -- 132
    EEVEE        = "天演", -- 133
    VAPOREON     = "泡搶", -- 134
    JOLTEON      = "雷", -- 135
    FLAREON      = "炎", -- 136
    PORYGON      = "虛擬", -- 137
    OMANYTE      = "抮貝", -- 138
    OMASTAR      = "抮貝", -- 139
    KABUTO       = "貝", -- 140
    KABUTOPS     = "貝", -- 141
    AERODACTYL   = "僵石", -- 142
    SNORLAX      = "睡", -- 143
    ARTICUNO     = "冬", -- 144
    ZAPDOS       = "雷", -- 145
    MOLTRES      = "炎", -- 146
    DRATINI      = "龍", -- 147
    DRAGONAIR    = "龍", -- 148
    DRAGONITE    = "龍", -- 149
    MEWTWO       = "生成", -- 150
    MEW          = "新種", -- 151
  }

  -- Literary Chinese Pokédex descriptions.  These replace the ROM entry
  -- text at runtime; the source ids stay intact for other languages/mods.
  local dexEntries = {
    BULBASAUR    = "初生，背植奇種，與身俱長。囊中多子，蓄氣其中，故數日不食亦可。", -- 001
    IVYSAUR      = "背有囊，取養於身而長。囊既大，後足不能立；將華則芳，養足乃發大英。", -- 002
    VENUSAUR     = "植名曰大王花，吸日光為養。求日則遊，得之則止。花發異香，聞者息鬥。", -- 003
    CHARMANDER   = "初生尾火，燃而微鳴，寂乃聞。幼螭戲尾或自灼。遇雨氣蒸，火熄則卒。喜炎地。", -- 004
    CHARMELEON   = "猛火螭也。搖其炎尾，乃氣為熱。尾頓敵而抓之至死。興時噴縹火。", -- 005
    CHARIZARD    = "振翼能及富士之高，冰川重千六百七十六萬斤，噴火能銷之。有時誤焚林。", -- 006
    SQUIRTLE     = "初生背柔，久乃堅而成甲。遇危，引長項藏甲中，輒吐水沫，其勢甚猛。", -- 007
    WARTORTLE    = "常伏水中，伺其所食。因其尾多毛能蓄氧，乃久潛水下。故世人以其尾為壽徵。", -- 008
    BLASTOISE    = "甲上有水炮，噴水能崩城，亦借水勢撞敵。又以重軀壓敵，使之昏仆。遇危藏甲中。", -- 009
    CATERPIE     = "皮綠，首具大目文懾敵。短足有吸盤，緣壁不倦。觸其鬚，輒出惡臭自禦。", -- 010
    METAPOD      = "唯外甲能堅，中體常柔。以甲自守，重擊則不能堪。", -- 011
    BUTTERFREE   = "翼傅毒粉，水滴不能濡，故雨中亦飛。振翼則粉散，人吸其粉則蠱。", -- 012
    WEEDLE       = "林野草莽間，食銀杏葉。首有毒角，長約一寸六分，刺則蠱。", -- 013
    KAKUNA       = "雖幾不動若僵，猶有短臂。遇危能堅甲而螫。甲中方脫胎換骨。", -- 014
    BEEDRILL     = "羣飛甚疾。又有二螫於手，且一螫於腹，以三枚鄭重擊敵。", -- 015
    PIDGEY       = "林藪常見，不喜戰，遇敵則踆沙。伏草間獵小蟲，亦以飆颺弱小敵。", -- 016
    PIDGEOTTO    = "境甚廣，巢其中，終日巡飛求獵。足爪甚利，侵境者輒猛啄。能攫爆卵宭，遠百六十八里負歸巢。", -- 017
    PIDGEOT      = "張麗翼以懾敵，飛速為音速二倍。獵則掠水面攫龍門鯉；振翼聲方至，而身已遠。", -- 018
    RATTATA      = "小而甚捷，隨處皆見。長牙銳而生不息，故輒齧堅物以磨之。見一，則近必有四十。", -- 019
    RATICATE     = "以鬚持衡，斷之則遲。後足三趾有蹼，能泅川獵食。遇敵立後足，露牙厲鳴以懾之。", -- 020
    SPEAROW      = "草間食蟲。翼短，鄭重振之乃能飛；不能高遠，然巡境甚疾。體雖弱，能以鳥學仿應敵。", -- 021
    FEAROW       = "翼廣而壯，善乘風高翔，終日不下亦不倦。此鳥自古有之，遇危則須臾高飛而去。", -- 022
    EKANS        = "草莽中潛行無聲，吞蒙雀與鬼鶪之卵。吐舌以察四方。年久身益長，夜纏樹枝而寐。", -- 023
    ARBOK        = "腹有怖面文，以懾弱敵。其文因地而異，今驗得六式。遇敵則昂首示文，使之遁。", -- 024
    PIKACHU      = "頰各有小電囊，遇危則放電。羣聚則電積，或致㷸㷸震電。常舉尾察四方，牽之則咬。", -- 025
    RAICHU       = "體蓄電則躁而夜光。放電可至十萬伏特，觸之能仆天竺象。長尾接地泄電，故不自傷。", -- 026
    SANDSHREW    = "居乾地深穴，遠水而生，唯獵食乃出。遇危則蜷身成毬。夜寒則乾皮凝細露。", -- 027
    SANDSLASH    = "遇危蜷成刺毬，轉以撞敵或遁。背刺爪皆銳，善以爪劈敵；爪折，一日復生。", -- 028
    NIDORAN_F    = "性馴不喜戰，體雖小而毒鍼甚烈。雌者角尤小，遇逼乃以角螫敵。", -- 029
    NIDORINA     = "性馴，角徐長。休於深穴則諸刺皆伏。怒乃咬抓，亦發超聲以亂敵。", -- 030
    NIDOQUEEN    = "周身剛鱗如鍼，循期更生。興則鱗皆竪，以堅鱗自守，又以重軀身壓敵。", -- 031
    NIDORAN_M    = "大耳常竪以察危，欲聞遠聲則振之如翼。怒則伸毒鍼；角愈大，其毒愈烈。", -- 032
    NIDORINO     = "易怒，角堅過金剛石。狂揮能穿之；刺敵則毒從創入。", -- 033
    NIDOKING     = "皮堅若石如甲，長角銳且毒。戰則以巨尾摔敵，復絞纏之至骨折。", -- 034
    CLEFAIRY     = "貌可愛而善戲，人多欲畜之。然甚稀，唯數地可見。", -- 035
    CLEFABLE     = "性怯，聞人即遁。耳極聰，三百十四丈外針墜亦聞，故惡喧處。", -- 036
    VULPIX       = "初生僅一白尾，長則自端分為六，毛尾皆美。年益長，尾亦益多。", -- 037
    NINETALES    = "九尾金光，壽千年。相傳九聖合化而成。性黠而記怨，戲牽其尾者受千年呪。", -- 038
    JIGGLYPUFF   = "目大而圓，發光以魅敵。既惑，乃唱妙曲，使聞者皆寐。", -- 039
    WIGGLYTUFF   = "毛密而柔，觸之甚美。身有彈性，怒則吸氣自鼓，能脹無窮如氣毬。", -- 040
    ZUBAT        = "羣居常暗之所，無目無鼻。飛則發超聲，聲返大耳，因知物所在。", -- 041
    GOLBAT       = "潛襲獵物，以尖牙咬而吸血，一飲逾七兩六錢。雖腹重不能飛亦不止；其血型亦隨獵物而變。", -- 042
    ODDISH       = "晝埋面土中，唯葉露。夜以雙根行九十五丈餘，遍播其種。人拔之則厲聲號。", -- 043
    GLOOM        = "口液非涎，乃甘汁以誘食。蕊臭遠三里半，聞者或仆；千人中乃一喜嗅之。", -- 044
    VILEPLUME    = "花瓣天下最大，愈大則毒粉愈多。振瓣散粉，聲甚響，能使人過敏。", -- 045
    PARAS        = "穴地齧樹根，背生蟲草。草與蟲俱長，取養於蟲，故所食多歸於草。", -- 046
    PARASECT     = "背蕈奪主蟲之身，代之思動，喜濕地。蕈蓋散毒蕈孢，中國人或採以為藥。", -- 047
    VENONAT      = "居高樹陰，食蟲，夜逐光。大目由眾小目聚成，能如雷達察暗，又射念光。", -- 048
    VENOMOTH     = "翼覆細鱗粉，其色各表毒類。每振翼則毒粉散，附物難去；居下風者亦中毒。", -- 049
    DIGLETT      = "居地下約二尺九寸，食草根。掘穴淺行，所過土隆。時露首六寸餘，然全身大小至今未詳。", -- 050
    DUGTRIO      = "三鼴同出，能掘穴深入百六十八里，故或致地震。戰則伏地而出，突擊不備之敵。", -- 051
    MEOWTH       = "愛圓光之物，尤五銖錢。晝寐，夜目光巡境，拾遺錢不已。", -- 052
    PERSIAN      = "毛美，人多畜之，然性暴難馴。額珠自光，步如后。尾忽竪則將躍咬，宜戒。", -- 053
    PSYDUCK      = "常患頭痛，貌若無知。痛劇則發念動異能，然己亦似不知所為；敵見其呆貌反易受惑。", -- 054
    GOLDUCK      = "暮則湖濱常見，四肢長而有蹼，故游甚雅且疾。姿似日本河童，世人或誤認之。", -- 055
    MANKEY       = "居樹而捷，性易怒。方馴，頃刻即狂擊；稍忤之，輒與物鬥，不可近。", -- 056
    PRIMEAPE     = "常怒不息，見獵則逐之，雖遠不舍。唯四顧無人時怒暫解，然鮮有見者。", -- 057
    GROWLITHE    = "性親人而忠，然守境甚嚴。有侵境者，則厲吠而咬以逐之。", -- 058
    ARCANINE     = "中國古傳有之，以美見稱。奔走輕疾若生翼，觀者多為其姿所魅。", -- 059
    POLIWAG      = "黑皮薄而濕，臟腑透皮可見，成腹上旋文，其向因地而異。新足未便，故善游而拙行。", -- 060
    POLIWHIRL    = "水陸皆能居，然喜水。出水則汗以潤皮；遇敵示腹旋文，使之寐而遁。", -- 061
    POLIWRATH    = "周身筋肉皆助游，善自由泳、蛙泳、蝶泳諸法，疾過人中泳冠，且久行少息。", -- 062
    ABRA         = "日寐十八時，睡中亦能察危。敵將至，輒以瞬移遠遁，異能未嘗息。", -- 063
    KADABRA      = "相傳異能童晨寤化此獸。其身發阿爾法浪，近者頭痛；所至鐘表或倒行。", -- 064
    ALAKAZAM     = "腦勝超級電算機，智商五千，所學不忘。遇敵即知其弱，鮮以身搏，多用異能制之。", -- 065
    MACHOP       = "身雖如童，筋肉遍體，能擲百成人。日習諸武術以益其力，愈練愈強。", -- 066
    MACHOKE      = "力甚大而不倦，以腰帶約其力，故動止可制。性謙，常助人負重。", -- 067
    MACHAMP      = "四臂皆壯，一臂能移山。四臂齊發，二秒間出千拳，兼能空手劈。", -- 068
    BELLSPROUT   = "喜溫濕，根兼為足，行而吸水。以藤縛小蟲而食，蕾貌近人面。", -- 069
    WEEPINBELL   = "葉銳如刀。戰則散毒粉使敵痺，復噴蝕液以溶之；飢則吞一切動物。", -- 070
    VICTREEBEL   = "叢生深林，入者未有返。以蜜香誘獵入口，一日溶之，骨亦盡。", -- 071
    TENTACOOL    = "眼澄如水晶，能射怪光。漂淺海，誤釣者為其蝕液所螫；曝岸枯縮，投海復甦。", -- 072
    TENTACRUEL   = "有觸手八十，皆能伸縮。獵則展而纏敵，既纏不釋；螫之則中毒劇痛。", -- 073
    GEODUDE      = "山野路旁常見，狀若石，人多誤踐而致怒。體圓易執，人或執而相擲為戲；登坡以雙臂引身。", -- 074
    GRAVELER     = "山中行則自坡轉下，遇草木石障皆碾之，不減速亦不迴。", -- 075
    GOLEM        = "體重逾五百斤，甲堅如磐，炸藥爆亦不傷。每歲蛻皮一次，初白柔，遇氣乃堅。", -- 076
    PONYTA       = "蹄堅十倍金剛石，一躍能越巴黎鐵塔。體輕足強，落地則以四足受其衝。", -- 077
    RAPIDASH     = "好逐疾者與之競，見快車亦追。極速一時四百十九里，奔時周身火然。", -- 078
    SLOWPOKE     = "終日恍惚，寤寐無別，以尾垂水釣食。受擊五秒乃知痛。", -- 079
    SLOWBRO      = "鈍饕餮入海獵食，大舌貝咬其尾，遂化隱檮杌。貝食其餘屑；若脫尾，則復為鈍饕餮。", -- 080
    MAGNEMITE    = "生而能反重力，以強電磁浪浮空。兩側器官亦放電磁浪，忽現人前。", -- 081
    MAGNETON     = "由數金磁石相連而成，日有黑子時多現。發高壓磁浪及怪無線信號，近二里氣溫升二度。", -- 082
    FARFETCHD    = "居蘆葦間，常銜不知名莖，一以築巢，一以為劍。今數漸少，故罕見。", -- 083
    DODUO        = "雙首乃突變所生，翼短不能善飛，以長足疾走，一時百六十八里，留巨跡。", -- 084
    DODRIO       = "三首各表喜哀怒，三腦共謀。寐則二首眠而一首警；草原奔走一時百十二里。", -- 085
    SEEL         = "皮厚覆淡青毛，耐寒至零下四十度。首角甚堅，以之破厚冰而游。", -- 086
    DEWGONG      = "周身皤毛，藏熱於體，寒愈甚則愈健。冰水中一時能游二十六里。", -- 087
    GRIMER       = "工廠污泥受月之X光而化，吸濁泥廢物為食。所過臭烈，草亦不生。", -- 088
    MUK          = "污泥遍體，藏土中不可辨。毒甚，足跡亦有毒；臭可使人仆，而己鼻退化不能聞。", -- 089
    SHELLDER     = "甲堅過金剛石，閉則百擊不能傷；唯開時中體柔弱。伏海沙，以軟舌捕食。", -- 090
    CLOYSTER     = "甲堅至炸彈不能破，唯攻敵乃開。受擊則發刺炮；中體古今無人見。", -- 091
    GASTLY       = "身若薄氣，風烈則不現。覆獵物使之寐或仆，二秒能仆天竺象。", -- 092
    HAUNTER      = "能穿壁，故傳自異界。暗中無物而若被視，或無故仆，皆其兆也；舐人則吸命。", -- 093
    GENGAR       = "月望則仿人影，笑其驚。山中迷路者或為其奪命；忽覺寒者，蓋近而將呪之。", -- 094
    ONIX         = "年長則身石硬若黑金剛石。地下掘穴一時百四十里，所留隧道小潛鼴居之。", -- 095
    DROWZEE      = "傳自古獸貘。以行捨使敵寐，乃食夢；夢惡則己亦病，所食舊夢有時復示人。", -- 096
    HYPNO        = "手持懸錘，與敵目交則行捨，亦用念力。昔有童見其錘而寐，遂為所攜去。", -- 097
    KRABBY       = "居海濱，橫行以雙鉗持衡。鉗為利器，戰折亦速復生，且新者愈強。", -- 098
    KINGLER      = "大螯有萬馬力，能擘大舌貝、刺甲貝之甲，然重甚，舉動不便。", -- 099
    VOLTORB      = "常見發電廠，形似獲獸毬，人誤觸多被電。稍受刺激則厲聲或自爆，亦竊電車之電。", -- 100
    ELECTRODE    = "體內高壓蓄電極多，微震即大爆，故人號「爆毬」。甚危。", -- 101
    EXEGGCUTE    = "貌似卵，實近植物種子。六首相引而旋，少一則失衡；若人逐一枚，餘者不覺而集。", -- 102
    EXEGGUTOR    = "人號「行雨林」。三果皆有面，各自思，故鳴甚譁；一果墜地，傳即化爆卵宭。", -- 103
    CUBONE       = "戴亡母髑髏，終身不脫，故真面無人見。孤則月下悲號，聲迴髑髏成哀曲。", -- 104
    MAROWAK      = "本小弱，得骨為兵後性轉猛。善骨棒，亦擲返骨，飛還其手，能擊仆敵。", -- 105
    HITMONLEE    = "雙腿伸縮自如，能及遠敵。踆時足底瞬堅若金剛石；人號踆術之師。", -- 106
    HITMONCHAN   = "拳師之魂附身。出拳疾逾新幹線，旋拳能穿水泥壁；每三分而息。", -- 107
    LICKITUNG    = "舌長近六尺七寸，倍其身，運之如手以取食攻敵。為其所舐者，麻痺刺痛。", -- 108
    KOFFING      = "皮薄若氣毬，腹蓄數種毒氣，近之臭甚。炎處氣脹，或無兆自爆。", -- 109
    WEEZING      = "毒氣聚處，二瘴球久則合成此獸，二氣各異。吸塵、菌、毒氣為養，故常近污廢。", -- 110
    RHYHORN      = "骨堅人骨千倍，衝則高樓亦碎。意專一，既撞則直奔不止，至倦寐乃休。", -- 111
    RHYDON       = "天演後以後足行，漸有智。甲皮能禦近二千度熔岩，又以角鑽穿巨石。", -- 112
    CHANSEY      = "罕見難獲，得之者傳有福。日生數卵，味美且滋養；見傷獸則分卵與之。", -- 113
    TANGELA      = "周身藍藤如海藻，纏蔽真形，且生長不息。近之者皆為藤所纏，行則藤搖。", -- 114
    KANGASKHAN   = "雌腹有袋，育子其中三年，至能自覓食乃出。護子不避戰，善以複拳擊敵。", -- 115
    HORSEA       = "卷尾以持衡，浮水面以墨射飛蟲，甚準。遇危則自口噴水或墨。", -- 116
    SEADRA       = "胸鰭如翼，急振與尾則面前而身退游。背刺銳，觸之麻痺或仆；寐時尾鉤珊瑚。", -- 117
    GOLDEEN      = "尾鰭飄若舞衣，人號水后。諸鰭筋壯，一時游十六里；產卵時羣泝川瀑。", -- 118
    SEAKING      = "秋產卵，羣泝江溪。雄者以角鑽穿巨石作巢，他時居其中。", -- 119
    STARYU       = "中心紅核夜發光。核若無傷，縱身碎亦能自愈而全。", -- 120
    STARMIE      = "身成幾何形，故土人疑天外物。中心之核夜放七色光，或謂以此通宇宙。", -- 121
    MR_MIME      = "善仿戲，使人信無為有；仿壁則虛空成障。演時若被擾，則以廣手批之。", -- 122
    SCYTHER      = "行疾如忍者，能成分身之幻。自草中躍出，以雙鎌劈獵；有翼而罕飛。", -- 123
    JYNX         = "言聲類人而不可解，今有人考其義。行步自有節，搖腰若舞，見者或不覺與之俱舞。", -- 124
    ELECTABUZZ   = "好食強電，常集發電廠。城忽大停電，必謂此獸食廠電也。", -- 125
    MAGMAR       = "生活火山口，體溫近千二百度，周身橙炎不息，入火則形不可辨。", -- 126
    PINSIR       = "首有雙鉗，以重掎獵物則不釋，能裂之；若甲堅不可碎，乃旋擲之。畏寒，冷則不能動。", -- 127
    TAUROS       = "欲撞敵，先以三尾鄭重鞭身，乃直衝；既奔不能迴，必至觸物方止。", -- 128
    MAGIKARP     = "今世至弱且遲，古種稍強。海河湖乃至淺窪皆生；敵雖猛攻，唯躍而已。", -- 129
    GYARADOS     = "性極暴虐，野中罕見。古傳怒則盡毀城邑；口發毀光，所中皆燼。", -- 130
    LAPRAS       = "性柔而智，能解人言，亦察人心。喜負人渡海；昔捕者眾，今幾絕種。", -- 131
    DITTO        = "常無定形，若涎一團，能重排細胞及遺傳碼；見敵則頃刻變身，形幾無差。", -- 132
    EEVEE        = "遺傳碼不定，故天演之途多。受火石、雷石、水石之放射，則變三類；存者甚少。", -- 133
    VAPOREON     = "細胞之構近水分子，故入水能溶而不見。長尾有鰭，人或誤為人魚。", -- 134
    JOLTEON      = "性敏，哀怒輒蓄電。吸空氣陰離子，放電至萬伏特；驚怒則周毛竪如鍼射敵。", -- 135
    FLAREON      = "體內有炎囊，深吸氣後噴焰近千七百度。蓄熱時體溫可逾八百七十度。", -- 136
    PORYGON      = "純以程式碼造成，乃人造㬺獸之始。能自在行虛擬空間；人望其飛太空，迄今未成。", -- 137
    OMANYTE      = "古海獸久絕，今由僵石遺傳復生。以十觸手旋轉而游。", -- 138
    OMASTAR      = "觸手發達如手足，纏獵即啄咬。口周利喙；甲大而重，行遲難獵，故遂絕種。", -- 139
    KABUTO       = "由古海床僵石復生，甲堅。伏海底則以背目視物；若翻覆則不能自正。", -- 140
    KABUTOPS     = "身狹善游，以鎌臂劈獵，既傷則吸盡其體液。", -- 141
    AERODACTYL   = "取琥珀中古龍遺傳質而復生。性猛，飛而厲鳴，鋸齒狀牙專噬敵喉。", -- 142
    SNORLAX      = "日食逾六百六十九斤乃飽，食畢即寐。黴食亦吞而腹不病；愈肥愈惰，醒唯為食。", -- 143
    ARTICUNO     = "冬之神鳥，尾羽長麗。凍空氣中水而為雪；迷雪山將凍死者，傳常見之。", -- 144
    ZAPDOS       = "雷之神鳥，黑雲㷸㷸震電時乃現。飛則電聲轟裂，巨雷隨之。", -- 145
    MOLTRES      = "炎之神鳥，雙翼若火。每振翼則火光赫然，夜空亦為之赤。", -- 146
    DRATINI      = "古傳為神獸，近世漁人始獲，水下又驗有小羣。幼者身已逾六尺二寸，數蛻皮而長。", -- 147
    DRAGONAIR    = "居海湖，周身有異氣。雖無翼而時見飛，且能變天候。", -- 148
    DRAGONITE    = "海中罕見，智與人等，人稱海守。體大而能飛，十六時環地球一周。", -- 149
    MEWTWO       = "學者累年剪接重組遺傳碼造之，與混沌蟨之碼幾同，而形性大異。因反覆重組遂暴，冷眼懾敵。", -- 150
    MEW          = "南美洲之神獸，昔謂已絕，今見者漸多，然仍甚稀。毛極細，唯顯微鏡可見；智高，百技皆能學。", -- 151
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

  -- Experience quantities use HanNumber at the call site.  The source keeps
  -- its cartridge-era %d directive as the catalog key; translations may use
  -- %s because Strings validates arity, not directive type.
  mod.content.strings:override("%s gained\n%d EXP. Points!", "%s得%s閱歷！")
  mod.content.strings:override("%s gained\nwith EXP.ALL,\v%d EXP. Points!",
    "%s藉閱歷機得\v%s閱歷！")
  mod.content.strings:override("%s gained\na boosted\v%d EXP. Points!",
    "%s得增益\v%s閱歷！")
  mod.content.strings:override("%s grew\nto level %d!", "%s升至%s級！")

  -- Status vocabulary that lives in ROM text rather than the persistent
  -- status registry.  These use semantic placeholders, so 敵 is supplied
  -- by the engine when the target/user is the opponent.
  local statusText = {
    _PoisonedText = "{TARGET}中毒！",
    _BadlyPoisonedText = "{TARGET}毒劇！",
    _BurnedText = "{TARGET}燒傷！",
    _ParalyzedMayNotAttackText = "{TARGET}麻痺，或不能動！",
    _FellAsleepText = "{TARGET}寐！",
    _FastAsleepText = "{USER}昏睡！",
    _FrozenText = "{TARGET}凍結！",
    _IsFrozenText = "{USER}凍結！",
    _BecameConfusedText = "{TARGET}迷亂！",
    _IsConfusedText = "{USER}迷亂！",
    _FlinchedText = "{USER}畏縮不前！",
    _FullyParalyzedText = "{USER}麻痺不能動！",
    _MoveDisabledText = "其技見錮！",
    _MoveIsDisabledText = "{USER}之{RAM:wNameBuffer}見錮！",
    _MoveWasDisabledText = "{TARGET}之{RAM:wNameBuffer}見錮！",
    _PartyMenuNormalText = "擇獸。",
    _PartyMenuBattleText = "出何獸？",
    _PartyMenuUseTMText = "用於何獸？",
    _MoneyForWinningText = "{PLAYER}獲金{NUM:wAmountMoneyWon, 3 | LEADING_ZEROES | LEFT_ALIGN}！",
  }
  for id, text in pairs(statusText) do
    mod.content.text:override(id, text)
  end

  -- Red/Blue are characters as well as version colours.  Patch only the
  -- new-game defaults; never rewrite colour words in dialogue or data.  The
  -- naming screen localizes its preset values before writing them to the save,
  -- so choosing RED/BLUE becomes an actual 赤/青 identity rather than a label
  -- painted over an English OT.
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
