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
  for species, classification in pairs(dexClassifications) do
    local def = mod.content.pokemon:get(species)
    if def and def.dexEntry then
      mod.content.pokemon:patch(species, {
        dexEntry = { kind = classification },
      })
    else
      mod.log:warn("%s has no Pokédex entry; classification skipped", species)
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
