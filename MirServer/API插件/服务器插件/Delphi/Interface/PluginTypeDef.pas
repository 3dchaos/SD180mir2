unit PluginTypeDef;

//------------------------------------------------------------------------------
// M2Server����ӿ� - ���Ͷ���
//
// �� �� ��: 1.1
// ��������: 2018-03-23
// ���¼�¼:
//     2018-03-23: ���η������������Ĳ���ӿ�
//------------------------------------------------------------------------------

interface

uses
  Windows;

type
  // 32λdll�£��������ռ32bit;  64λdll�£��������ռ64bit
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
  ACTOR_NAME_LEN = 14; // ��ɫ����

  ITEM_PROP_COUNT = 20;
  ITEM_PROP_VALUES_COUNT = 3;

  MAX_FLUTE_COUNT = 8; // ��󰼲�����

  USER_ITEM_ADD_DATA_BYTE_COUNT = 20;
  USER_ITEM_ADD_DATA_INT_COUNT = 10;
  USER_ITEM_ADD_DATA_TEXT_COUNT = 2;

  { ��ɫ���� }
  ACTORNAMELEN = 14;

  //------------------------------------------------------------------------------------------------
  //----------------------------------------------------------------------------������BindTypeȡֵ
  { ��ֹ��}
  BINDTYPE_NODROP = 0;

  { ��ֹ���� }
  BINDTYPE_NODEAL = 1;

  { ��ֹ�� }
  BINDTYPE_NOSTORAGE = 2;

  { ��ֹ�� }
  BINDTYPE_NOREPAIR = 3;

  { ��ֹ�� }
  BINDTYPE_NOSELL = 4;

  { ��ֹ���� }
  BINDTYPE_NOSCATTER = 5;

  { ������ʧ }
  BINDTYPE_DROPDELETE = 6;


  //------------------------------------------------------------------------------------------------
  //--------------------------------------------------------------------�ڴ���ָ�붨λSeekOriginȡֵ

  { ��ͷ��ʼ }
  SEEKORIGN_BEGIN = 0;

  { �ӵ�ǰλ�ÿ�ʼ }
  SEEKORIGN_CURRENT = 1;

  { ���ʼ }
  SEEKORIGN_END = 2;

  //------------------------------------------------------------------------------------------------
  //---------------------------------------------------------------������Ϣ�����Ϣ���� MsgType ȡֵ
  { ���� }
  MSGTYEPE_NOTICE = 0;

  { ��ʾ }
  MSGTYEPE_HINT = 1;

  { ϵͳ }
  MSGTYEPE_SYSTEM = 2;

  { ?? }
  MSGTYEPE_SAY = 3;

  { ?? }
  MSGTYEPE_MON = 4;

  { GM }
  MSGTYEPE_GM = 5;

  { ף�� }
  MSGTYEPE_CUST = 6;

  { ���� }
  MSGTYEPE_CASTLE = 6;

  { ?? }
  MSGTYEPE_CHAR = 7;

  //------------------------------------------------------------------------------------------------
  //----------------------------------------------------------------------------�������� MagAttr ȡֵ

  { ���＼�� }
  MAGATTR_HUM = 0;

  { Ӣ�ۼ��� }
  MAGATTR_HERO = 1;

  { �������� }
  MAGATTR_CONTINUOUS = 2;

  { ��֮���� }
  MAGATTR_Defense = 3;

  { ŭ֮���� }
  MAGATTR_Attack = 4;

  //------------------------------------------------------------------------------------------------
  //-----------------------------------------------------TM2Engine_GetGlobalIniFile����M2IniTypeȡֵ
  
  { !Setup.txt }
  M2INI_SETUP = 0;

  { String.ini }
  M2INI_STRING = 1;

  //------------------------------------------------------------------------------------------------
  //-----------------------------------------------------TM2Engine_GetOtherFileDir����M2FileTypeȡֵ

  { ENVIRĿ¼ }
  M2FILE_ENVIR_DIR = 0;

  { ���Ŀ¼ }
  M2FILE_PLUG_DIR = 1;

  { �л�Ŀ¼ }
  M2FILE_GUILD_DIR = 2;

  { �л��ļ� }
  M2FILE_GUILD_FILE = 3;

  { �Ǳ�Ŀ¼ }
  M2FILE_CASTLE_DIR = 4;

  { �Ǳ��ļ� }
  M2FILE_CASTLE_FILE = 5;

  { ��ͼĿ¼ }
  M2FILE_MAP_DIR = 6;

  { ����Ŀ¼ }
  M2FILE_NOTICE_DIR = 7;

  { ����Ŀ¼ }
  M2FILE_BOX_DIR = 8;

  { �����ļ� }
  M2FILE_BOX_FILE = 9;

  { �Զ������Ŀ¼ }
  M2FILE_CUSTOM_MON = 10;

  { �Զ��弼��Ŀ¼ }
  M2FILE_CUSTOM_MAGIC = 11;

  { �Զ���NPCĿ¼ }
  M2FILE_CUSTOM_NPC = 12;

  { ��Ʒ�������Ŀ¼ }
  M2FILE_ITEMDROP_DIR = 13;

  { ��Ʒ���������־Ŀ¼ }
  M2FILE_ITEMDROPLOG_DIR = 14;

  { ��¼��־Ŀ¼ }
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

  // ����
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
    MaxWeight: LongInt; // 0x1BA   //0x56 0x22  ����
    WearWeight: LongInt; // 0x1BC   //0x58 0x24
    MaxWearWeight: LongInt; // 0x1BD   //0x59 0x25  ����
    HandWeight: LongInt; // 0x1BE   //0x5A 0x26
    MaxHandWeight: LongInt; // 0x1BF   //0x5B 0x27  ����
    CreditPoint: Integer; // ����
    NewValue: array[0..30 - 1] of LongWord;
    // 0������������ 1���ӹ����˺�  2�����˺����� 3ħ���˺�����  4����Ŀ�����
    // 5�����˺����� 6����Ŀ�걩�� 7������������  8����ħ������ 9ŭ���ָ�����
    // 10�ϻ��������� 11 ���ﱩ�� 12 �������� 13 ����� 14 ������ 15 ������
    // 16 ����  17 ���ջ�  18 ����ǽ  19 ������  20 ������
  end;


  // �ڹ�����
  TAbilityNG = packed record
    Level: Word;                                            // �ڹ��ȼ�
    NH: Word;                                               // ��ǰ����ֵ
    MaxNH: Word;                                            // ����ֵ����
    Exp: LongWord;                                          // ��ǰ�ڹ�����
    MaxExp: LongWord;                                       // ��ǰ�ڹ���߾���
  end;
  pTAbilityNG = ^TAbilityNG;

  // ������
  TAbilityAlcohol = packed record
    Alcohol: Word;                                          // ����
    MaxAlcohol: Word;                                       // ��������
    WineDrinkValue: Word;                                   // ��ƶ�
    MedicineLevel: Integer;                                 // ҩ��ֵ�ȼ�
    MedicineValue: Word;                                    // ��ǰҩ��ֵ
    MaxMedicineValue: Word;                                 // ҩ��ֵ����
  end;
  pTAbilityAlcohol = ^TAbilityAlcohol;


  //------------------------------------------------------------------------------------------------
  //------------------------------------------------------------------------------------------------

  // �Զ�����Ʒ������
  TUserItemProgress = packed record
    boOpen: Boolean;
    btNameColor: Byte;
    btCount: Byte;
    btShowType: Byte;                                       // �����ϵ�ֵ��ʾ��ʽ(0:����ʾ; 1:�ٷֱ�; 2:��ֵ;)
    wMax: Word;
    wValue: Word;
    wLevel: Word;
    sName: string[31];
  end;

  // ��������
  PCustomProperty = ^TCustomProperty;
  TCustomProperty = packed record
    btColor: Byte;
    btBindType: Byte;
    btShowFlag: Byte;
    btPercent: Byte;        // 0: ������1: ����װ��%�� 2: ȫ��װ��%
    btHintModule: Byte;
    nValues: array[0..ITEM_PROP_VALUES_COUNT - 1] of Integer;
  end;

  // ��Ʒ����
  PUserItemProperty = ^TUserItemProperty;
  TUserItemProperty = packed record
    sText: string[128]; // NND,��64��Ҫ����128 2019-03-18 17:18:22
    btTextColor: Byte;
    Properties: array[0..ITEM_PROP_COUNT - 1] of TCustomProperty;
  end;

  // ��Ʒ��Դ
  TItemFormType = (ifUnknow{δ֪}, ifGM{GM����}, ifScript{�ű�},
    ifShopBuy{�̵깺��}, ifMonDrop{��ֵ���}, ifSysGive{ϵͳ����},
    ifMine{�ڿ�õ�}, ifBoxGive{����ȡ��}, ifButchItem{����õ�},
    ifCaptureMon{��׽�õ�});

  // ��Ʒ��Դ
  TUserItemFrom = packed record
    ItemForm: TItemFormType;
    sMapName: string[MAP_NAME_LEN];
    sMonName: string[40];
    sMakerName: string[ACTOR_NAME_LEN];
    DateTime: TDateTime;
  end;

  TFluteInfo = packed record
    GemIndex: Word; // ��ʯ����
    GemCount: Word; // ��ʯ��������
  end;

  // ��Ʒ
  pTUserItem = ^TUserItem;
  TUserItem = packed record
    MakeIndex: Integer;
    wIndex: Word; // ��Ʒid
    Name: string[ITEM_NAME_LEN];
    Dura: Word; // ��ǰ�־�ֵ
    DuraMax: Word; // ���־�ֵ
    btValue: array[0..13] of Integer;

    dwHeroM2DressEffect: LongWord;   // ��Ч��� + boHeroM2DressNoBlend  MakeLong(btHeroM2DressEffect + boHeroM2DressNoBlend)

    btUpgradeCount: Byte; // ��������
    boStartTime: Boolean; // �Ƿ�ʼ��ʱ
    nLimitTime: Integer; // ��ʱ��Ʒ ����
    btHeroM2Light: Byte; // HeroM2 SetItemsLight
    btNewValue: array[0..30 - 1] of Word;
    // 0 ������������   1 ���ӹ����˺�   2 �����˺�����  3 ħ���˺�����  4 ����Ŀ�����
    // 5 �����˺�����   6 ����Ŀ�걩��   7 ������������  8 ����ħ������  9 ŭ���ָ�����
    // 10�ϻ���������
    btColor: Byte;

    boIsBind: Boolean; // �Ƿ��
    btBindOption: Byte;
    // ��ѡ���ӦBitλ TUserItemBindValueType
    // 1: ��ֹ��
    // 2: ��ֹ����
    // 3: ��ֹ��
    // 4: ��ֹ��
    // 5: ��ֹ����
    // 6: ��ֹ����
    // 7: ������ʧ


    wEffect: Word; // ��Ч��� ��

    // װ������ chongchong 2015-01-02
    btFluteCount: Byte; // ��������             1
    Flutes: array[0..MAX_FLUTE_COUNT - 1] of TFluteInfo; // ���۱�ʯ��Ϣ         16

    Progress: array[0..1] of TUserItemProgress;
    CustomProperty: TUserItemProperty;

    ItemFrom: TUserItemFrom;

    wInsuranceCount: Word; // Ͷ������
    wNewLooks: Word;
    wNewShape: Word;

    wNewExpand3: Word;
    wNewExpand4: Word;

    btAddDataByte: array[0..USER_ITEM_ADD_DATA_BYTE_COUNT - 1] of Byte;
    nAddDataInt: array[0..USER_ITEM_ADD_DATA_INT_COUNT - 1] of Integer;
    sAddDataText: array[0..USER_ITEM_ADD_DATA_TEXT_COUNT - 1] of string[20];
  end;

  TStdItemEffect = packed record
    FileIndex: SmallInt;                                    // ��Ʒ����Ч�� �ļ���� 0
    ImageStart: Word;                                       // ��Ʒ����Ч�� ��ȡλ��
    ImageCount: Byte;                                       // ��Ʒ����Ч�� ��ȡ����
    IsDrawCenter: Boolean;                                  // ���в���
    IsDrawNoBlend: Boolean;                                 // ��͸������
    IsDrawBelow: Boolean;                                   // �ײ����
    OffsetX: SmallInt;                                      // ��Ʒ����Ч�� ΢��X
    OffsetY: SmallInt;                                      // ��Ʒ����Ч�� ΢��Y
    Time: Word;                                             // �����ٶ�
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
    OverLap: Word;                                          // �Ƿ����ص���Ʒ
    Color: Byte;                                            // ��Ʒ������ɫ
    Stock: Integer;
    Light: Integer;                                         // ���ݿ�����Light�ֶ� piaoyun 2013-08-01

    Horse: Integer;
    Expand1: Integer;
    Expand2: Integer;
    Expand3: Integer;
    Expand4: Integer;
    Expand5: Integer;

    Elements: array[0..23] of Word;

    InsuranceCurrency: Integer;
    InsuranceGold: Integer;

    BagEffect: TStdItemEffect;                              // �����е���Ʒ����Ч��
    BodyEffect: TStdItemEffect;                             // �ڹ�����Ʒ����Ч��
    Effect: Int64;                                          // ָ���Ϊ64λ 2021-01-05
  end;

  PTClientItem = ^TClientItem;
  TClientItem = packed record
    s: TStdItem;
    MakeIndex: Integer;
    Dura: Word;
    DuraMax: Word;

    IsBind: Boolean;                                        // �Ƿ��
    btFluteCount: Byte;

    btUpgradeCount: Byte;                                   // ��������
    btHeroM2Light: Byte;                                    // HeroM2 SetItemsLight

    btValue: array[0..13] of Integer; // ��������
    NewValue: array[0..30 - 1] of Word;

    Flutes: array[0..MAX_FLUTE_COUNT - 1] of TFluteInfo;    // ���۱�ʯ��Ϣ         16

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
    btTrainLv: Byte;                                        // ��߿������ȼ�
    btJob: Byte;
    wMagicIdx: Word;
    dwMagicDelayTime: LongWord;
    wDefSpell: Word;
    wDefPower: Word;
    wMaxPower: Word;
    wDefMaxPower: Word;
    sDescr: string[18];
    CanUpgrade: Integer;                                    // �Ƿ��������� chongchong 2013-12-06
    MaxUpgradeLevel: Integer;                               // ���
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
    boUsesItemAdd: Boolean;                                 // �Ƿ�Ϊװ������
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
    btTrainLv: Byte;                                        // ��߿������ȼ�
    dwMagicDelayTime: LongWord;
    wDefSpell: Word;
    CanUpgrade: Integer;                                    // �Ƿ��������� chongchong 2013-12-06
    MaxUpgradeLevel: Integer;                               // ���
  end;


  TClientMagic = packed record // 84
    Key: AnsiChar;
    Level: Byte;
    NewLevel: Byte;                                         // ����
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
    nFileIndex: SmallInt; // WIL��Դ���
    nIconIndex: Word;
    nIconCount: Byte;
    nX: SmallInt;
    nY: SmallInt;
    boBlend: Boolean;
    btDrawOrder: Byte; // ����˳��
    nPlayTime: SmallInt; // �����ٶ�
    boOnlySelfVisible: Boolean;
  end;
  pTActorIcon = ^TActorIcon;
  TActorIconArray = array[0..10 - 1] of TActorIcon;
  pTActorIconArray = ^TActorIconArray;

implementation

end.
