unit PluginTypeDef;

//------------------------------------------------------------------------------
// M2Server插件接口 - 类型定义
//
// 版 本 号: 1.1
// 发布日期: 2018-03-23
// 更新记录:
//     2018-03-23: 初次发布重新整理后的插件接口
//------------------------------------------------------------------------------

interface

uses
  Windows;

type
  // 32位dll下，下面对象占32bit;  64位dll下，下面对象占64bit
  _TList = TObject;
  _TStringList = TObject;
  _TObject = TObject;
  _TMemoryStream = TObject;
  _TMenuItem = TObject;
  _TIniFile = TObject;
  _TMagicACList = TObject;
  _TEnvirnoment = TObject;
  _TBaseObject = TObject;
  _TSmartObject = TObject;
  _TPlayObject = TObject;
  _TDummyObject = TObject;
  _THeroObject = TObject;
  _TNormNpc = TObject;
  _TGuild = TObject;

  PScriptCmdParam = ^TScriptCmdParam;
  TScriptCmdParam = record
    Npc: _TNormNpc;
    PlayObject: _TPlayObject;
    BaseObject: _TBaseObject;
    nCMDCode: Integer;

    sRawParam01: PAnsiChar;
    sRawParam02: PAnsiChar;
    sRawParam03: PAnsiChar;
    sRawParam04: PAnsiChar;
    sRawParam05: PAnsiChar;
    sRawParam06: PAnsiChar;
    sRawParam07: PAnsiChar;
    sRawParam08: PAnsiChar;
    sRawParam09: PAnsiChar;
    sRawParam10: PAnsiChar;

    sParam01: PAnsiChar;
    nParam01: Integer;
    sParam02: PAnsiChar;
    nParam02: Integer;
    sParam03: PAnsiChar;
    nParam03: Integer;
    sParam04: PAnsiChar;
    nParam04: Integer;
    sParam05: PAnsiChar;
    nParam05: Integer;
    sParam06: PAnsiChar;
    nParam06: Integer;
    sParam07: PAnsiChar;
    nParam07: Integer;
    sParam08: PAnsiChar;
    nParam08: Integer;
    sParam09: PAnsiChar;
    nParam09: Integer;
    sParam10: PAnsiChar;
    nParam10: Integer
  end;

const
  MAXFLUTECOUNT = 8;
  ITEMNAMELEN = 30;
  MAP_NAME_LEN = 30;
  ITEM_NAME_LEN = 60;
  ACTOR_NAME_LEN = 14; // 角色长度

  ITEM_PROP_COUNT = 20;
  ITEM_PROP_VALUES_COUNT = 3;

  MAX_FLUTE_COUNT = 8; // 最大凹槽数量

  USER_ITEM_ADD_DATA_BYTE_COUNT = 20;
  USER_ITEM_ADD_DATA_INT_COUNT = 10;
  USER_ITEM_ADD_DATA_TEXT_COUNT = 2;

  { 角色长度 }
  ACTORNAMELEN = 14;

  //------------------------------------------------------------------------------------------------
  //----------------------------------------------------------------------------绑定属性BindType取值
  { 禁止扔}
  BINDTYPE_NODROP = 0;

  { 禁止交易 }
  BINDTYPE_NODEAL = 1;

  { 禁止存 }
  BINDTYPE_NOSTORAGE = 2;

  { 禁止修 }
  BINDTYPE_NOREPAIR = 3;

  { 禁止卖 }
  BINDTYPE_NOSELL = 4;

  { 禁止爆出 }
  BINDTYPE_NOSCATTER = 5;

  { 丢弃消失 }
  BINDTYPE_DROPDELETE = 6;


  //------------------------------------------------------------------------------------------------
  //--------------------------------------------------------------------内存流指针定位SeekOrigin取值

  { 从头开始 }
  SEEKORIGN_BEGIN = 0;

  { 从当前位置开始 }
  SEEKORIGN_CURRENT = 1;

  { 最后开始 }
  SEEKORIGN_END = 2;

  //------------------------------------------------------------------------------------------------
  //---------------------------------------------------------------发关消息相关消息类型 MsgType 取值
  { 公告 }
  MSGTYEPE_NOTICE = 0;

  { 提示 }
  MSGTYEPE_HINT = 1;

  { 系统 }
  MSGTYEPE_SYSTEM = 2;

  { ?? }
  MSGTYEPE_SAY = 3;

  { ?? }
  MSGTYEPE_MON = 4;

  { GM }
  MSGTYEPE_GM = 5;

  { 祝福 }
  MSGTYEPE_CUST = 6;

  { 城主 }
  MSGTYEPE_CASTLE = 6;

  { ?? }
  MSGTYEPE_CHAR = 7;

  //------------------------------------------------------------------------------------------------
  //----------------------------------------------------------------------------技能类型 MagAttr 取值

  { 人物技能 }
  MAGATTR_HUM = 0;

  { 英雄技能 }
  MAGATTR_HERO = 1;

  { 连击技能 }
  MAGATTR_CONTINUOUS = 2;

  { 静之技能 }
  MAGATTR_Defense = 3;

  { 怒之技能 }
  MAGATTR_Attack = 4;

  //------------------------------------------------------------------------------------------------
  //-----------------------------------------------------TM2Engine_GetGlobalIniFile参数M2IniType取值
  
  { !Setup.txt }
  M2INI_SETUP = 0;

  { String.ini }
  M2INI_STRING = 1;

  //------------------------------------------------------------------------------------------------
  //-----------------------------------------------------TM2Engine_GetOtherFileDir参数M2FileType取值

  { ENVIR目录 }
  M2FILE_ENVIR_DIR = 0;

  { 插件目录 }
  M2FILE_PLUG_DIR = 1;

  { 行会目录 }
  M2FILE_GUILD_DIR = 2;

  { 行会文件 }
  M2FILE_GUILD_FILE = 3;

  { 城堡目录 }
  M2FILE_CASTLE_DIR = 4;

  { 城堡文件 }
  M2FILE_CASTLE_FILE = 5;

  { 地图目录 }
  M2FILE_MAP_DIR = 6;

  { 公告目录 }
  M2FILE_NOTICE_DIR = 7;

  { 宝箱目录 }
  M2FILE_BOX_DIR = 8;

  { 宝箱文件 }
  M2FILE_BOX_FILE = 9;

  { 自定义怪物目录 }
  M2FILE_CUSTOM_MON = 10;

  { 自定义技能目录 }
  M2FILE_CUSTOM_MAGIC = 11;

  { 自定义NPC目录 }
  M2FILE_CUSTOM_NPC = 12;

  { 物品掉落规则目录 }
  M2FILE_ITEMDROP_DIR = 13;

  { 物品掉落规则日志目录 }
  M2FILE_ITEMDROPLOG_DIR = 14;

  { 登录日志目录 }
  M2FILE_CONLOG_DIR = 15;

type
  //------------------------------------------------------------------------------------------------
  //------------------------------------------------------------------------------------------------
  TDefaultMessage = record
    Recog: Int64;
    Ident: Word;
    Param: Word;
    Tag: Word;
    Series: Word;
  end;
  pTDefaultMessage = ^TDefaultMessage;

  //------------------------------------------------------------------------------------------------
  //------------------------------------------------------------------------------------------------

  PMagicACInfo = ^TMagicACInfo;
  TMagicACInfo = record
    wMagicId: Word;
    boEnabled: Boolean;
    btHum: Byte;
    btMon: Byte;
    btHero: Byte;
    btDefenceHum: Byte;
    btDefenceMon: Byte;
    btDefenceHero: Byte;
    sMagicName: string;
  end;

  // 属性
  pTAbility = ^TAbility;
  TAbility = packed record
    Level: LongWord; // 0x198  //0x34  0x00
    AC1: Integer; // 0x19A  //0x36  0x02
    AC2: Integer; // 0x19A  //0x36  0x02
    MAC1: Integer; // 0x19C  //0x38  0x04
    MAC2: Integer; // 0x19C  //0x38  0x04
    DC1: Integer; // 0x19E  //0x3A  0x06
    DC2: Integer; // 0x19E  //0x3A  0x06
    MC1: Integer; // 0x1A0  //0x3C  0x08
    MC2: Integer; // 0x1A0  //0x3C  0x08
    SC1: Integer; // 0x1A2  //0x3E  0x0A
    SC2: Integer; // 0x1A2  //0x3E  0x0A
    HP: LongWord; // 0x1A4  //0x40  0x0C
    MP: LongWord; // 0x1A6  //0x42  0x0E
    MaxHP: LongWord; // 0x1A8  //0x44  0x10
    MaxMP: LongWord; // 0x1AA  //0x46  0x12
    Exp: LongWord; // 0x1B0  //0x4C 0x18
    MaxExp: LongWord; // 0x1B4  //0x50 0x1C
    Weight: LongInt; // 0x1B8   //0x54 0x20
    MaxWeight: LongInt; // 0x1BA   //0x56 0x22  背包
    WearWeight: LongInt; // 0x1BC   //0x58 0x24
    MaxWearWeight: LongInt; // 0x1BD   //0x59 0x25  负重
    HandWeight: LongInt; // 0x1BE   //0x5A 0x26
    MaxHandWeight: LongInt; // 0x1BF   //0x5B 0x27  腕力
    CreditPoint: Integer; // 声望
    NewValue: array[0..30 - 1] of LongWord;
    // 0暴击几率增加 1增加攻击伤害  2物理伤害减少 3魔法伤害减少  4忽视目标防御
    // 5所有伤害反弹 6增加目标暴率 7人物体力增加  8人物魔力增加 9怒气恢复增加
    // 10合击攻击增加 11 怪物暴率 12 防暴几率 13 防麻痹 14 防护身 15 防复活
    // 16 防毒  17 防诱惑  18 防火墙  19 防冰冻  20 防蛛网
  end;


  // 内功属性
  TAbilityNG = packed record
    Level: Word;                                            // 内功等级
    NH: Word;                                               // 当前内力值
    MaxNH: Word;                                            // 内力值上限
    Exp: LongWord;                                          // 当前内功经验
    MaxExp: LongWord;                                       // 当前内功最高经验
  end;
  pTAbilityNG = ^TAbilityNG;

  // 酒属性
  TAbilityAlcohol = packed record
    Alcohol: Word;                                          // 酒量
    MaxAlcohol: Word;                                       // 酒量上限
    WineDrinkValue: Word;                                   // 醉酒度
    MedicineLevel: Integer;                                 // 药力值等级
    MedicineValue: Word;                                    // 当前药力值
    MaxMedicineValue: Word;                                 // 药力值上限
  end;
  pTAbilityAlcohol = ^TAbilityAlcohol;


  //------------------------------------------------------------------------------------------------
  //------------------------------------------------------------------------------------------------

  // 自定义物品进度条
  TUserItemProgress = packed record
    boOpen: Boolean;
    btNameColor: Byte;
    btCount: Byte;
    btShowType: Byte;                                       // 进度上的值显示方式(0:不显示; 1:百分比; 2:数值;)
    wMax: Word;
    wValue: Word;
    wLevel: Word;
    sName: string[31];
  end;

  // 单个属性
  PCustomProperty = ^TCustomProperty;
  TCustomProperty = packed record
    btColor: Byte;
    btBindType: Byte;
    btShowFlag: Byte;
    btPercent: Byte;        // 0: 点数；1: 单件装备%； 2: 全身装备%
    btHintModule: Byte;
    nValues: array[0..ITEM_PROP_VALUES_COUNT - 1] of Integer;
  end;

  // 物品属性
  PUserItemProperty = ^TUserItemProperty;
  TUserItemProperty = packed record
    sText: string[128]; // NND,从64又要整到128 2019-03-18 17:18:22
    btTextColor: Byte;
    Properties: array[0..ITEM_PROP_COUNT - 1] of TCustomProperty;
  end;

  // 物品来源
  TItemFormType = (ifUnknow{未知}, ifGM{GM制造}, ifScript{脚本},
    ifShopBuy{商店购买}, ifMonDrop{打怪掉落}, ifSysGive{系统给予},
    ifMine{挖矿得到}, ifBoxGive{宝箱取得}, ifButchItem{挖肉得到},
    ifCaptureMon{捕捉得到});

  // 物品来源
  TUserItemFrom = packed record
    ItemForm: TItemFormType;
    sMapName: string[MAP_NAME_LEN];
    sMonName: string[40];
    sMakerName: string[ACTOR_NAME_LEN];
    DateTime: TDateTime;
  end;

  TFluteInfo = packed record
    GemIndex: Word; // 宝石索引
    GemCount: Word; // 宝石叠加数量
  end;

  // 物品
  pTUserItem = ^TUserItem;
  TUserItem = packed record
    MakeIndex: Integer;
    wIndex: Word; // 物品id
    Name: string[ITEM_NAME_LEN];
    Dura: Word; // 当前持久值
    DuraMax: Word; // 最大持久值
    btValue: array[0..13] of Integer;

    dwHeroM2DressEffect: LongWord;   // 特效编号 + boHeroM2DressNoBlend  MakeLong(btHeroM2DressEffect + boHeroM2DressNoBlend)

    btUpgradeCount: Byte; // 升级次数
    boStartTime: Boolean; // 是否开始计时
    nLimitTime: Integer; // 限时物品 分钟
    btHeroM2Light: Byte; // HeroM2 SetItemsLight
    btNewValue: array[0..30 - 1] of Word;
    // 0 暴击几率增加   1 增加攻击伤害   2 物理伤害减少  3 魔法伤害减少  4 忽视目标防御
    // 5 所有伤害反弹   6 增加目标暴率   7 人物体力增加  8 人物魔力增加  9 怒气恢复增加
    // 10合击攻击增加
    btColor: Byte;

    boIsBind: Boolean; // 是否绑定
    btBindOption: Byte;
    // 绑定选项对应Bit位 TUserItemBindValueType
    // 1: 禁止扔
    // 2: 禁止交易
    // 3: 禁止存
    // 4: 禁止修
    // 5: 禁止出售
    // 6: 禁止爆出
    // 7: 丢弃消失


    wEffect: Word; // 特效编号 新

    // 装备凹槽 chongchong 2015-01-02
    btFluteCount: Byte; // 凹槽数量             1
    Flutes: array[0..MAX_FLUTE_COUNT - 1] of TFluteInfo; // 凹槽宝石信息         16

    Progress: array[0..1] of TUserItemProgress;
    CustomProperty: TUserItemProperty;

    ItemFrom: TUserItemFrom;

    wInsuranceCount: Word; // 投保次数
    wNewLooks: Word;
    wNewShape: Word;

    wNewExpand3: Word;
    wNewExpand4: Word;

    btAddDataByte: array[0..USER_ITEM_ADD_DATA_BYTE_COUNT - 1] of Byte;
    nAddDataInt: array[0..USER_ITEM_ADD_DATA_INT_COUNT - 1] of Integer;
    sAddDataText: array[0..USER_ITEM_ADD_DATA_TEXT_COUNT - 1] of string[20];
  end;

  TStdItemEffect = packed record
    FileIndex: SmallInt;                                    // 物品发光效果 文件编号 0
    ImageStart: Word;                                       // 物品发光效果 读取位置
    ImageCount: Byte;                                       // 物品发光效果 读取张数
    IsDrawCenter: Boolean;                                  // 居中播放
    IsDrawNoBlend: Boolean;                                 // 非透明绘制
    IsDrawBelow: Boolean;                                   // 底层绘制
    OffsetX: SmallInt;                                      // 物品发光效果 微调X
    OffsetY: SmallInt;                                      // 物品发光效果 微调Y
    Time: Word;                                             // 播放速度
  end;

  pTStdItem = ^TStdItem;
  TStdItem = packed record
    Name: string[ITEM_NAME_LEN];
    DBName: string[ITEM_NAME_LEN];
    StdMode: Byte;
    Shape: Word;
    Weight: Byte;
    AniCount: Word;
    Source: Integer;
    Reserved: Byte;
    NeedIdentify: Byte;
    Looks: Word;
    DuraMax: Word;
    Reserved1: Word;
    HP: Integer;
    MP: Integer;
    AC1: Integer;
    AC2: Integer;
    MAC1: Integer;
    MAC2: Integer;
    DC1: Integer;
    DC2: Integer;
    MC1: Integer;
    MC2: Integer;
    SC1: Integer;
    SC2: Integer;
    Need: Integer;
    NeedLevel: Integer;
    Price: Integer;
    OverLap: Word;                                          // 是否是重叠物品
    Color: Byte;                                            // 物品名称颜色
    Stock: Integer;
    Light: Integer;                                         // 数据库增加Light字段 piaoyun 2013-08-01

    Horse: Integer;
    Expand1: Integer;
    Expand2: Integer;
    Expand3: Integer;
    Expand4: Integer;
    Expand5: Integer;

    Elements: array[0..23] of Word;

    InsuranceCurrency: Integer;
    InsuranceGold: Integer;

    BagEffect: TStdItemEffect;                              // 包裹中的物品发光效果
    BodyEffect: TStdItemEffect;                             // 内观中物品发光效果
    Effect: Int64;                                          // 指针改为64位 2021-01-05
  end;

  PTClientItem = ^TClientItem;
  TClientItem = packed record
    s: TStdItem;
    MakeIndex: Integer;
    Dura: Word;
    DuraMax: Word;

    IsBind: Boolean;                                        // 是否绑定
    btFluteCount: Byte;

    btUpgradeCount: Byte;                                   // 升级次数
    btHeroM2Light: Byte;                                    // HeroM2 SetItemsLight

    btValue: array[0..13] of Integer; // 附加属性
    NewValue: array[0..30 - 1] of Word;

    Flutes: array[0..MAX_FLUTE_COUNT - 1] of TFluteInfo;    // 凹槽宝石信息         16

    Progress: array[0..1] of TUserItemProgress;

    CustomProperty: TUserItemProperty;

    ItemFrom: TUserItemFrom;
    wInsuranceCount: Word;
  end;


  //------------------------------------------------------------------------------------------------
  //------------------------------------------------------------------------------------------------

  TMagicAttr = (mtHum, mtHero, mtContinuous, mtDefense, mtAttack);

  TMagic = packed record
    MagicAttr: TMagicAttr;
    wMagicId: Word;
    sMagicName: string[ITEM_NAME_LEN];
    btEffectType: Byte;
    btEffect: Byte;
    wSpell: Word;
    wPower: Word;
    TrainLevel: array[0..15] of Byte;
    MaxTrain: array[0..15] of Integer;
    btTrainLv: Byte;                                        // 最高可升级等级
    btJob: Byte;
    wMagicIdx: Word;
    dwMagicDelayTime: LongWord;
    wDefSpell: Word;
    wDefPower: Word;
    wMaxPower: Word;
    wDefMaxPower: Word;
    sDescr: string[18];
    CanUpgrade: Integer;                                    // 是否允许升级 chongchong 2013-12-06
    MaxUpgradeLevel: Integer;                               // 最高
  end;
  pTMagic = ^TMagic;


  pTUserMagic = ^TUserMagic;
  TUserMagic = packed record
    MagicInfo: pTMagic;
    MagicAttr: TMagicAttr;
    wMagIdx: Word;
    btLevel: Byte;
    btNewLevel: Byte;
    btKey: Byte;
    nTranPoint: Integer;
    boUsesItemAdd: Boolean;                                 // 是否为装备触发
  end;

  pTMagic_C = ^TMagic_C;
  TMagic_C = packed record
    MagicAttr: TMagicAttr;
    wMagicId: Word;
    sMagicName: string[ITEM_NAME_LEN];
    btEffectType: Byte;
    btEffect: Byte;
    wSpell: Word;
    MaxTrain: array[0..15] of Integer;
    btTrainLv: Byte;                                        // 最高可升级等级
    dwMagicDelayTime: LongWord;
    wDefSpell: Word;
    CanUpgrade: Integer;                                    // 是否允许升级 chongchong 2013-12-06
    MaxUpgradeLevel: Integer;                               // 最高
  end;


  TClientMagic = packed record // 84
    Key: AnsiChar;
    Level: Byte;
    NewLevel: Byte;                                         // 九重
    CurTrain: Integer;
    Def: TMagic_C;
    dwInterval: LongWord;
    dwRealInterval: LongWord;
    dwLastUseTick: LongWord;
  end;
  PTClientMagic = ^TClientMagic;

  //------------------------------------------------------------------------------------------------
  //------------------------------------------------------------------------------------------------

  TActorIcon = packed record
    nFileIndex: SmallInt; // WIL资源编号
    nIconIndex: Word;
    nIconCount: Byte;
    nX: SmallInt;
    nY: SmallInt;
    boBlend: Boolean;
    btDrawOrder: Byte; // 绘制顺序
    nPlayTime: SmallInt; // 播放速度
    boOnlySelfVisible: Boolean;
  end;
  pTActorIcon = ^TActorIcon;
  TActorIconArray = array[0..10 - 1] of TActorIcon;
  pTActorIconArray = ^TActorIconArray;

implementation

end.
