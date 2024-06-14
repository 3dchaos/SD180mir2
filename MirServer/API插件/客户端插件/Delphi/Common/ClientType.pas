unit ClientType;

interface

const
  MAP_NAME_LEN = 30;
  ITEM_NAME_LEN = 60;
  ACTOR_NAME_LEN = 14;    // 角色长度
  ACCOUNT_LEN = 10;       // 账号长度
  DEF_BLOCK_SIZE = 22;    // 16 - 64位修改 2021-01-04

  MAX_FLUTE_COUNT = 8;    // 最大凹槽数量

  ITEM_PROP_COUNT = 20;
  ITEM_PROP_VALUES_COUNT = 3;

  MAX_USE_ITEM_COUNT = 30; // 身上装备数量

  DEF_MAX_BAG_ITEM = 46; // 人物背包物品数量
  MAX_EXT_BAG_PAGE_COUNT = 4; // 最扩展背包页数
  MAX_EXT_ONE_PAGE_ITEM_COUNT = 40; // 扩展背包每页最大格数

  ALL_BAG_ITEM_COUNT = DEF_MAX_BAG_ITEM + MAX_EXT_BAG_PAGE_COUNT * MAX_EXT_ONE_PAGE_ITEM_COUNT;

  MAX_HERO_BAG_ITEM = 40; // 英雄包裹


  mtBagItem = 0;
  mtUseItem = 1;
  mtHeroBagItem = 2;
  mtHeroUseItem = 3;
  mtDealItem = 4;
  mtBagGold = 5;
  mtDealGold = 6;
  mtGameGoldDeal = 7;
  mtChallengeGold = 8;
  mtChallengeItem = 9;
  mtUpgradeItem = 10;
  mtWineMatItem = 11;

//----------------------------------绘制模式------------------------------------
  BLEND_COLORADD = 1;
  BLEND_COLORMUL = 0;
  BLEND_ALPHABLEND = 2;
  BLEND_ALPHAADD = 0;
  BLEND_ZWRITE = 4;
  BLEND_NOZWRITE = 0;

  Blend_Default = BLEND_COLORMUL or BLEND_ALPHABLEND or BLEND_NOZWRITE;
  Blend_Default_Z = BLEND_COLORMUL or BLEND_ALPHABLEND or BLEND_ZWRITE;

  Blend_Add = 100;
  Blend_SrcAlpha = 101;
  Blend_SrcAlphaAdd = 102;
  Blend_SrcColor = 103;
  Blend_SrcColorAdd = 104;
  Blend_Invert = 105;
  Blend_SrcBright = 106;
  Blend_Multiply = 107;
  Blend_InvMultiply = 108;
  Blend_MultiplyAlpha = 109;
  Blend_InvMultiplyAlpha = 110;
  Blend_DestBright = 111;
  Blend_InvSrcBright = 112;
  Blend_InvDestBright = 113;
  Blend_Bright = 114;
  Blend_BrightAdd = 115;
  Blend_GrayScale = 116;
  Blend_Light = 117;
  Blend_LightAdd = 118;
  Blend_Add2X = 119;
  Blend_OneColor = 120;
  Blend_XOR = 121;
  Blend_Blend = 122;
//------------------------------------------------------------------------------
///////////////////////////////8个方向//////////////////////////////////////////
  DR_UP = 0;
  DR_UPRIGHT = 1;
  DR_RIGHT = 2;
  DR_DOWNRIGHT = 3;
  DR_DOWN = 4;
  DR_DOWNLEFT = 5;
  DR_LEFT = 6;
  DR_UPLEFT = 7;
////////////////////////////////////////////////////////////////////////////////


  U_DRESS = 0;                                              // 衣服
  U_WEAPON = 1;                                             // 武器
  U_RIGHTHAND = 2;                                          // 照明物品
  U_NECKLACE = 3;                                           // 项链
  U_HELMET = 4;                                             // 头盔
  U_ARMRINGL = 5;                                           // 左手镯
  U_ARMRINGR = 6;                                           // 右手镯
  U_RINGL = 7;                                              // 左戒指
  U_RINGR = 8;                                              // 右戒指
  U_BUJUK = 9;                                              // 符
  U_BELT = 10;                                              // 腰带
  U_BOOTS = 11;                                             // 鞋
  U_CHARM = 12;                                             // 宝石
  U_HAT = 13;                                               // 斗笠
  U_DRUM = 14;                                              // 鼓
  U_HORSE = 15;                                             // 马

///////////////////////常用角色类型常量值 piaoyun 2013-07-23////////////////////
  RC_PLAYOBJECT = 0;                                        // 玩家
  RC_HEROOBJECT = 1;                                        // 英雄
  RC_PLAYMOSTER = 150;                                      // 人形怪物 JS-->60;
  RC_MOONOBJECT = 99;                                       // 月灵
  RC_GUARD = 11;                                            // 大刀守卫
  RC_PEACENPC = 15;                                         // 和平NPC
  RC_ANIMAL = 50;                                           // 攻击NPC
  RC_MONSTER = 80;                                          // 怪物
  RC_NPC = 10;                                              // 普通NPC
  RC_ARCHERGUARD = 112;                                     // 弓箭手
  RC_TRUCKOBJECT = 128;                                     // 押镖车


//==============================================================================
// ------------------------------------------------------------------------------
// ------------------------------------------------------------------------------
// ------------------------------------------------------------------------------
// ------------------------------------------------------------------------------
  CM_QUERYUSERNAME = 80;                                    // 进入游戏,服务器返回角色名到客户端 47;
  CM_QUERYCHR = 100;                                        // 登录成功,客户端显出左右角色的那一瞬 3000;
  CM_NEWCHR = 101;                                          // 创建角色 3001;
  CM_DELCHR = 102;                                          // 删除角色 3002;
  CM_SELCHR = 103;                                          // 选择角色 3003;
  CM_SELECTSERVER = 104;                                    // 服务器,注意不是选区,盛大一区往往有(至多8个??group.dat中是这么写的)不止一个的服务器 3004;
  CM_QUERYDELCHR = 105;                                     // 查询删除过的角色信息 3005;
  CM_GETBACKDELCHR = 3006;
  CM_GETBACKPASSWORD = 2010;                                // 密码找回 3007;
  CM_PROTOCOL = 2000;                                       // 3008;
  CM_IDPASSWORD = 2001;                                     // 3009;
  CM_ADDNEWUSER = 2002;                                     // 3010;
  CM_CHANGEPASSWORD = 2003;                                 // 3011;
  CM_UPDATEUSER = 2004;                                     // 3012;
  CM_RANDOMCODE = 2006;                                     // 3013;
  CM_CHANGERANDOMCODE = 3014;
//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
  CM_SPELL = 3017;                                          // 施魔法
  CM_HORSERUN = 3009;                                       // 骑马
  CM_TURN = 3010;                                           // 转身(方向改变)
  CM_WALK = 3011;                                           // 走
  CM_SITDOWN = 3012;                                        // 挖(蹲下)
  CM_RUN = 3013;                                            // 跑
  CM_HIT = 3014;                                            // 普通物理近身攻击
  CM_HEAVYHIT = 3015;                                       // 跳起来打的动作
  CM_BIGHIT = 3016;                                         // 强攻
  CM_POWERHIT = 3018;                                       // 攻杀
  CM_LONGHIT = 3019;                                        // 刺杀
  CM_WIDEHIT = 3024;                                        // 半月
  CM_FIREHIT = 3025;                                        // 烈火
  CM_CRSHIT = 3036;                                         // 抱月刀 双龙斩 ID=40
  CM_TWNHIT = 3037;                                         // 龙影剑法      ID=42

  // 下面开始是新技能
  CM_43HIT = 3043;                                          // 雷霆剑法     ID=43
  CM_SWORDHIT = 3056;                                       // 逐日剑法     ID=56
  // CM_114HIT = 3114;  // 倚天劈地  ID = 3114

  // 这三个还需要测试。不知道有没有问题 2013-07-13
  CM_60HIT = 3060;                                          // 18;                                //破魂斩
  CM_61HIT = 3061;                                          // 19;                                //劈星斩
  CM_62HIT = 3062;                                          // 20;                                //雷霆一击

  CM_66HIT = 3066;                                          // 开天斩


  CM_100HIT = 3100;                                         // 追心刺
  CM_101HIT = 3101;                                         // 三绝杀
  CM_102HIT = 3102;                                         // 断岳斩
  CM_103HIT = 3103;                                         // 横扫千军


  CM_DROPITEM = 1000;                                       // 从包裹里扔出物品到地图,此时人物如果在安全区可能会提示安全区不允许扔东西 48;
  CM_PICKUP = 1001;                                         // 捡东西 49;
  CM_TAKEONITEM = 1003;                                     // 装配装备到身上的装备位置 50;
  CM_TAKEOFFITEM = 1004;                                    // 从身上某个装备位置取下某个装备 51;
  CM_EAT = 1006;                                            // 吃药 52;
  CM_BUTCH = 1007;                                          // 挖 53;
  CM_MAGICKEYCHANGE = 1008;                                 // 魔法快捷键改变 54;

  // 与商店NPC交易相关
  CM_CLICKNPC = 1010;                                       // 用户点击了某个NPC进行交互 55;
  CM_MERCHANTDLGSELECT = 1011;                              // 商品选择,大类 56;
  CM_MERCHANTQUERYSELLPRICE = 1012;                         // 返回价格,标准价格,我们知道商店用户卖入的有些东西掉持久或有特殊 57;
  CM_USERSELLITEM = 1013;                                   // 用户卖东西 58;
  CM_USERBUYITEM = 1014;                                    // 用户买入东西 59;
  CM_USERGETDETAILITEM = 1015;                              // 取得商品清单,比如点击"蛇眼戒指"大类,会出现一列蛇眼戒指供你选择 60;
  CM_DROPGOLD = 1016;                                       // 用户放下金钱到地上 61;
  CM_LOGINNOTICEOK = 1018;                                  // 健康游戏忠告点了确实,进入游戏 62;
  CM_GROUPMODE = 1019;                                      // 关组还是开组 63;
  CM_CREATEGROUP = 1020;                                    // 新建组队 64;
  CM_ADDGROUPMEMBER = 1021;                                 // 组内添人 65;
  CM_DELGROUPMEMBER = 1022;                                 // 组内删人 66;
  CM_USERREPAIRITEM = 1023;                                 // 用户修理东西 67;
  CM_MERCHANTQUERYREPAIRCOST = 1024;                        // 客户端向NPC取得修理费用 68;
  CM_DEALTRY = 1025;                                        // 开始交易,交易开始 69;
  CM_DEALADDITEM = 1026;                                    // 加东东到交易物品栏上 70;
  CM_DEALDELITEM = 1027;                                    // 从交易物品栏上撤回东东???好像不允许哦 71;
  CM_DEALCANCEL = 1028;                                     // 取消交易 72;
  CM_DEALCHGGOLD = 1029;                                    // 本来交易栏上金钱为0,,如有金钱交易,交易双方都会有这个消息 73;
  CM_DEALEND = 1030;                                        // 交易成功,完成交易 74;
  CM_USERSTORAGEITEM = 1031;                                // 用户寄存东西 75;
  CM_USERTAKEBACKSTORAGEITEM = 1032;                        // 用户向保管员取回东西 76;
  CM_WANTMINMAP = 1033;                                     // 用户点击了"小地图"按钮 77;
  CM_USERMAKEDRUGITEM = 1034;                               // 用户制造毒药(其它物品) 78;
  CM_OPENGUILDDLG = 1035;                                   // 用户点击了"行会"按钮 79;
  CM_GUILDHOME = 1036;                                      // 点击"行会主页" 80;
  CM_GUILDMEMBERLIST = 1037;                                // 点击"成员列表" 81;
  CM_GUILDADDMEMBER = 1038;                                 // 增加成员 82;
  CM_GUILDDELMEMBER = 1039;                                 // 踢人出行会 83;
  CM_GUILDUPDATENOTICE = 1040;                              // 修改行会公告 84;
  CM_GUILDUPDATERANKINFO = 1041;                            // 更新联盟信息(取消或建立联盟) 85;
  CM_ADJUST_BONUS = 1043;                                   // 用户得到奖励??私服中比较明显,小号升级时会得出金钱声望等,不是很确定,//求经过测试的高手的验证 86;
  CM_PASSWORD = 1105;                                       // 87;
  CM_SAY = 3030;                                            // 角色发言 88;
  CM_QUERYUSERSTATE = 82;                                   // 89;
  CM_QUERYBAGITEMS = 81;                                    // 查询包裹物品 90;
  CM_OPENDOOR = 1002;                                       // 开门,人物走到地图的某个过门点时 91;
  CM_SOFTCLOSE = 1009;                                      // 退出传奇(游戏程序,可能是游戏中大退,也可能时选人时退出) 92;
  CM_GUILDALLY = 1044;                                      // 93;
  CM_GUILDBREAKALLY = 1045;                                 // 94;
  // 商铺相关
  CM_GETSHOPITEMS = 95;
  CM_BUYSHOPITEM = 9002;                                    // 96;
  // 排行榜
  CM_GETRANKING = 97;
  CM_GETMYRANKING = 98;
  // 开宝箱
  CM_OPENBOX = 99;                                          // 钥匙放入钥匙孔打开箱子
  CM_ROTATIONBOX = 100;                                     // 转动箱子
  CM_SENDGETSELBOXITEM = 101;                               // 获取宝箱自己选择的物品
  CM_SENDSELLGAMEGOLDDALITEM = 102;                         // 元宝交易装备
  CM_SENDBUYGAMEGOLDDALITEM = 103;                          // 购买元宝交易装备
  CM_SENDCANCELGAMEGOLDDALITEM = 104;                       // 取消元宝交易装备
  CM_OVERLAPITEM = 105;                                     // 重叠物品
  CM_HEROOVERLAPITEM = 106;                                 // 英雄包裹重叠物品
  CM_PACKAGEITEM = 107;                                     // 分开重叠物品
  CM_HEROPACKAGEITEM = 108;                                 // 分开英雄包裹重叠物品
  CM_QUERYUSERSHOPS = 109;                                  // 搜索传奇店铺
  CM_GETUSERSHOPS = 110;                                    // 传奇店铺
  CM_QUERYUSERSHOPITEMS = 111;                              // 搜索指定用户店铺物品
  CM_GETUSERSHOPITEMS = 112;                                // 搜索指定用户店铺物品
  CM_SEARCHSHOPITEMS = 113;                                 // 搜索用户店铺物品
  CM_SEARCHGETSHOPITEMS = 114;                              //
  CM_QUERYMYSHOPSELLINGITEMS = 115;                         // 搜索我的店铺正在物品
  CM_QUERYMYSHOPSELLEDITEMS = 116;                          // 搜索我的店铺已经物品
  CM_QUERYMYSHOPSTORAGEITEMS = 117;                         // 搜索我的店铺仓库物品
  CM_GETMYSHOPITEMS = 118;                                  // 搜索我的店铺物品
  CM_SENDADDTOMYSHOP = 119;
  CM_SENDCHANGEMYSHOPITEM = 120;
  CM_SENDMOVEMYSHOPITEM = 121;
  CM_QUERYSELECTSHOPINFO = 122;
  CM_SENDSHOPSTALLSTATUS = 123;
  CM_SENDBUYUSERSHOPITEM = 124;
  CM_SENDDELETESELLEDITEM = 125;
  CM_SENDUSERSPEEDING = 126;                                // 用户超速
  CM_UPGRADEDLGITEM = 127;                                  // OK对话框物品
  CM_CANCELUPGRADEDLGITEM = 128;                            // 取消对话框物品
  CM_CHALLENGETRY = 129;                                    // 挑战
  CM_CHALLENGEADDITEM = 130;                                // 增加挑战物品
  CM_CHALLENGEDELITEM = 131;                                // 删除挑战物品
  CM_CHALLENGECANCEL = 132;                                 // 取消挑战
  CM_CHALLENGECHGGOLD = 133;                                // 修改挑战金币
  CM_CHALLENGECHGGAMEDIAMOND = 134;                         // 修改挑战金刚石
  CM_CHALLENGEEND = 135;                                    // 开始挑战
  CM_SENDUPGRADEDIALOG = 136;                               // 包裹宝石装备升级
  CM_HELPBUTTONCLICK = 137;                                 // 点击帮助按钮
  CM_SENDPLEASEDRINK = 138;                                 // 发送请酒
  CM_SENDGIVENPCWINE = 139;                                 // 发送斗酒
  CM_SENDSELECTFINGER = 140;                                // 发送选择的剪刀石头布
  CM_SENDDRINK = 141;                                       // 喝酒
  CM_SENDGETBACKHERO = 142;                                 // 用户取回寄存的英雄                                  //
  CM_ASSESSMENTHERO = 143;                                  // 评定英雄
  CM_SENDHEROAUTOPRACTICE = 144;                            // 用确定英雄自动修炼
  CM_SENDACUPOINTCLICK = 145;                               // 点击穴位 series=0 人物 series=1 英雄
  CM_SENDTRAININGMERIDIANCLICK = 146;                       // 修炼经络 series=0 人物 series=1 英雄
  CM_CONTINUOUSMAGIC = 147;                                 // 开始请求连击
  CM_CHANGECONTINUOUSMAGICORDER = 148;                      // 改变连击魔法顺序  连击顺序  series=0 人物 series=1 英雄
  CM_SENDMODULEMD5 = 149;                                   // 登录器上传的模块MD5
  CM_SENDSHOPNAME = 150;                                    // 摆摊商铺名称
  CM_HEROLOGON = 151;                                       // 召唤英雄
  CM_HEROLOGOUT = 152;                                      // 英雄退出
  CM_MASTERBAGTOHEROBAG = 153;                              // 主人包裹物品放到英雄包裹
  CM_HEROBAGTOMASTERBAG = 154;                              // 英雄包裹物品放到主人包裹
  CM_HEROTAKEONITEM = 155;                                  // 英雄穿装备
  CM_HEROTAKEOFFITEM = 156;                                 // 英雄脱装备
  CM_HEROEAT = 157;                                         // 英雄吃药
  CM_HEROTARGET = 158;                                      // 锁定//Ident: 1105 Recog: 260806992 Param: 0 Tag: 32 Series: 0   Recog= 锁定对象   Param=X  Tag=Y
  CM_HERODROPITEM = 159;                                    // 英雄扔物品
  CM_HEROGROUPATTACK = 160;                                 // 合击
  CM_HEROMAGICKEYCHANGE = 161;
  CM_HEROPROTECT = 162;
  CM_HEROM2STARTSHOPSTALL = 163;                            // 开始摆摊
  CM_HEROM2STOPSHOPSTALL = 164;                             // 停止摆摊
  CM_HEROM2BUYUSERSHOPITEM = 165;                           // 购买摆摊物品
  CM_HEROM2ADDUSERSHOPITEM = 166;                           // 增加摆摊物品
  CM_HEROM2DELUSERSHOPITEM = 167;                           // 删除摆摊物品
  CM_HEROM2SENDCLOSESHOP = 168;                             // 关闭购买摆摊物品窗口

// ------------------------------------------------------------------------------
// ------------------------------------------------------------------------------
// ------------------------------------------------------------------------------
// ------------------------------------------------------------------------------
  SM_PASSWD_FAIL = 503;                                     // 验证失败,"服务器验证失败,需要重新登录"?? 1000;
  SM_NEWID_SUCCESS = 504;                                   // 创建新账号成功 1001;
  SM_NEWID_FAIL = 505;                                      // 创建新账号失败 1002;
  SM_CHGPASSWD_SUCCESS = 506;                               // 修改密码成功 1003;
  SM_CHGPASSWD_FAIL = 507;                                  // 修改密码失败 1004;
  SM_GETBACKPASSWD_SUCCESS = 508;                           // 密码找回成功 1005;
  SM_GETBACKPASSWD_FAIL = 509;                              // 密码找回失败 1006;
  SM_QUERYCHR = 520;                                        // 返回角色信息到客户端 1007;
  SM_NEWCHR_SUCCESS = 521;                                  // 新建角色成功 1008;
  SM_NEWCHR_FAIL = 522;                                     // 新建角色失败 1009;
  SM_DELCHR_SUCCESS = 523;                                  // 删除角色成功 1010;
  SM_DELCHR_FAIL = 524;                                     // 删除角色失败 1011;
  SM_STARTPLAY = 525;                                       // 开始进入游戏世界(点了健康游戏忠告后进入游戏画面) 1012;
  SM_STARTFAIL = 526;                                       // 开始失败,玩传奇深有体会,有时选择角色,点健康游戏忠告后黑屏 1013; //SM_USERFULL
  SM_QUERYCHR_FAIL = 527;                                   // 返回角色信息到客户端失败1014;
  SM_OUTOFCONNECTION = 528;                                 // 超过最大连接数,强迫用户下线 1027;
  SM_PASSOK_SELECTSERVER = 529;                             // 密码验证完成且密码正确,开始选服 1015;
  SM_SELECTSERVER_OK = 530;                                 // 选服成功 1016;
  SM_NEEDUPDATE_ACCOUNT = 531;                              // 1017;
  SM_UPDATEID_SUCCESS = 532;                                // 更新成功 1018;
  SM_UPDATEID_FAIL = 533;                                   // 更新失败 1019;
  SM_QUERYDELCHR = 534;                                     // 返回删除过的角色 1020;
  SM_GETBAKCHAR_SUCCESS = 1021;                             // 找回人物成功
  SM_GETBAKCHAR_FAIL = 1022;                                // 找回人物失败
  SM_RANDOMCODE = 2007;                                     // 1023;
  SM_NEEDPASSWORD = 8004;                                   // 1024;
  SM_CERTIFICATION_SUCCESS = 500;                           // 1025;
  SM_CERTIFICATION_FAIL = 501;                              // 1026;
  SM_CHECKISMYSELFSERVER = 8889;

  SM_HORSERUN = 5;                                          // 1106;
  SM_TURN = 10;                                             // 1102; //转向
  SM_WALK = 11;                                             // 1103; //走
  SM_SITDOWN = 12;                                          // 1104;
  SM_RUN = 13;                                              // 1105; //跑
  SM_HIT = 14;                                              // 1107; //砍
  SM_HEAVYHIT = 15;                                         // 1108; //
  SM_BIGHIT = 16;                                           // 1109; //
  SM_SPELL = 17;                                            // 1101; //使用魔法
  SM_POWERHIT = 18;                                         // 1110;
  SM_LONGHIT = 19;                                          // 1111; //刺杀
  SM_WIDEHIT = 24;                                          // 1112; //半月
  SM_FIREHIT = 8;                                           // 1113; //烈火
  SM_CRSHIT = 25;                                           // 1114; //抱月刀 双龙斩   ID=40
  SM_TWNHIT = 26;                                           // 1115; //龙影剑法     ID=42

  /////战士////
  SM_43HIT = 43;                                            // 雷霆剑法    ID=43
  SM_SWORDHIT = 56;                                         // 逐日剑法  ID=56
  /////////////

  // //// 合击//////
  SM_60HIT = 1118;                                          // 破魂斩
  SM_61HIT = 1119;                                          // 劈星斩
  SM_62HIT = 1120;                                          // 雷霆一击
  // ////////////////
  SM_66HIT = 66;                                            // 开天斩
  SM_100HIT = 1122;                                         // 追心刺
  SM_101HIT = 9101;                                         // 三绝杀
  SM_102HIT = 9102;                                         // 断岳斩
  SM_103HIT = 9103;                                         // 横扫千军

  SM_RUSH = 6;                                              // 1147;
  SM_RUSHKUNG = 7;                                          // 1148; //
  SM_BACKSTEP = 9;                                          // 1149;
  SM_DIGUP = 20;                                            // 挖是一"起"一"坐",这里是挖动作的"起" 1150;
  SM_DIGDOWN = 21;                                          // 挖动作的"坐" 1151;
  SM_FLYAXE = 22;                                           // 飞斧,半兽统领的攻击方式? 1152;
  SM_LIGHTING = 23;                                         // 免蜡开关 1153;
  SM_ALIVE = 27;                                            // 复活??复活戒指 1154; //
  SM_MOVEFAIL = 28;                                         // 移动失败,走动或跑动 1155; //
  SM_HIDE = 29;                                             // 隐身? 1156; //
  SM_DISAPPEAR = 30;                                        // 地上物品消失 1157;
  SM_STRUCK = 31;                                           // 受攻击 1158; //弯腰
  SM_DEATH = 32;                                            // 正常死亡 1159;
  SM_SKELETON = 33;                                         // 尸体 1160;
  SM_NOWDEATH = 34;                                         // 秒杀? 1161;
  SM_SPELL2 = 117;                                          // 1162;
  SM_HEAR = 40;                                             // 有人回你的话 1163;
  SM_FEATURECHANGED = 41;                                   // 1164;
  SM_USERNAME = 42;                                         // 1165;
  SM_WINEXP = 44;                                           // 获得经验 1166;
  SM_LEVELUP = 45;                                          // 升级,左上角出现墨绿的升级字样 1167;
  SM_DAYCHANGING = 46;                                      // 传奇界面右下角的太阳星星月亮 1168;
  SM_LOGON = 50;                                            // logon 1169;
  SM_NEWMAP = 51;                                           // 新地图?? 1170;
  SM_ABILITY = 52;                                          // 打开属性对话框,F11 1171;
  SM_HEALTHSPELLCHANGED = 53;                               // 治愈术使你的体力增加 1172;
  SM_MAPDESCRIPTION = 54;                                   // 地图描述,行会战地图?攻城区域?安全区域? 1173;
  SM_SYSMESSAGE = 100;                                      // 系统消息,盛大一般红字,私服蓝字 1174;
  SM_GROUPMESSAGE = 101;                                    // 组内聊天!! 1175;
  SM_CRY = 102;                                             // 喊话 1176;
  SM_WHISPER = 103;                                         // 私聊 1177;
  SM_GUILDMESSAGE = 104;                                    // 行会聊天!~ 1178;
  SM_MOVEMESSAGE = 99;                                      // 1179;
  SM_SCREENMESSAGE = 98;                                    // 1179;
  SM_DELAYMESSAGE = 1180;
  SM_CENTERMESSAGE = 1181;
  SM_TOPCHATBOARDMESSAGE = 1182;
  SM_ADDITEM = 200;                                         // 1183;
  SM_BAGITEMS = 201;                                        // 1184;
  SM_DELITEM = 202;                                         // 1185;
  SM_UPDATEITEM = 203;                                      // 1186;
  SM_ADDMAGIC = 210;                                        // 1187;
  SM_SENDMYMAGIC = 211;                                     // 1188;
  SM_DELMAGIC = 212;                                        // 1189;
  SM_DROPITEM_SUCCESS = 600;                                // 1190;
  SM_DROPITEM_FAIL = 601;                                   // 1191;
  SM_ITEMSHOW = 610;                                        // 1192;
  SM_ITEMHIDE = 611;                                        // 1193;
// SM_DOOROPEN = 1194;
  SM_OPENDOOR_OK = 612;                                     // 通过过门点成功 //1195;
  SM_OPENDOOR_LOCK = 613;                                   // 发现过门口是封锁的,以前盛大秘密通道去赤月的门要5分钟开一次 1196;
  SM_CLOSEDOOR = 614;                                       // 用户过门,门自行关闭 1197;
  SM_TAKEON_OK = 615;                                       // 1198;
  SM_TAKEON_FAIL = 616;                                     // 1199;
  SM_TAKEOFF_OK = 619;                                      // 1200;
  SM_TAKEOFF_FAIL = 620;                                    // 1201;
  SM_SENDUSEITEMS = 621;                                    // 1202;
  SM_WEIGHTCHANGED = 622;                                   // 1203;
  SM_CLEAROBJECTS = 633;                                    // 1204;
  SM_CHANGEMAP = 634;                                       // 地图改变,进入新地图 1205;
  SM_EAT_OK = 635;                                          // 1206;
  SM_EAT_FAIL = 636;                                        // 1207;
  SM_BUTCH = 637;                                           // 野蛮? 1208;
  SM_MAGICFIRE = 638;                                       // 地狱火,火墙?? 1209;
  SM_MAGICFIRE_FAIL = 639;                                  // 1210;
  SM_MAGIC_LVEXP = 640;                                     // 1211;
  SM_DURACHANGE = 642;                                      // 1212;
  SM_MERCHANTSAY = 643;                                     // 1213;
  SM_MERCHANTDLGCLOSE = 644;                                // 1214;
  SM_SENDGOODSLIST = 645;                                   // 1215;
  SM_SENDUSERSELL = 646;                                    // 1216;
  SM_SENDBUYPRICE = 647;                                    // 1217;
  SM_USERSELLITEM_OK = 648;                                 // 1218;
  SM_USERSELLITEM_FAIL = 649;                               // 1219;
  SM_BUYITEM_SUCCESS = 650;                                 // ? 1220; //?
  SM_BUYITEM_FAIL = 651;                                    // ? 1221; //?
  SM_SENDDETAILGOODSLIST = 652;                             // 1222;
  SM_GOLDCHANGED = 653;                                     // 1223;
  SM_CHANGELIGHT = 654;                                     // 负重改变 1224;
  SM_LAMPCHANGEDURA = 655;                                  // 蜡烛持久改变 1225;
  SM_CHANGENAMECOLOR = 656;                                 // 名字颜色改变,白名,灰名,红名,黄名 1226;
  SM_CHARSTATUSCHANGED = 657;                               // 1227;
  SM_SENDNOTICE = 658;                                      // 发送健康游戏忠告(公告) 1228;
  SM_GROUPMODECHANGED = 659;                                // 组队模式改变 1229;
  SM_CREATEGROUP_OK = 660;                                  // 1230;
  SM_CREATEGROUP_FAIL = 661;                                // 1231;
  SM_GROUPADDMEM_OK = 662;                                  // 1232;
  SM_GROUPDELMEM_OK = 663;                                  // 1233;
  SM_GROUPADDMEM_FAIL = 664;                                // 1234;
  SM_GROUPDELMEM_FAIL = 665;                                // 1235;
  SM_GROUPCANCEL = 666;                                     // 1236;
  SM_GROUPMEMBERS = 667;                                    // 1237;
  SM_SENDUSERREPAIR = 668;                                  // 1238;
  SM_USERREPAIRITEM_OK = 669;                               // 1239;
  SM_USERREPAIRITEM_FAIL = 670;                             // 1240;
  SM_SENDREPAIRCOST = 671;                                  // 1241;
  SM_DEALMENU = 673;                                        // 1242;
  SM_DEALTRY_FAIL = 674;                                    // 1243;
  SM_DEALADDITEM_OK = 675;                                  // 1244;
  SM_DEALADDITEM_FAIL = 676;                                // 1245;
  SM_DEALDELITEM_OK = 677;                                  // 1246;
  SM_DEALDELITEM_FAIL = 678;                                // 1247;
  SM_DEALCANCEL = 681;                                      // 1248;
  SM_DEALREMOTEADDITEM = 682;                               // 1249;
  SM_DEALREMOTEDELITEM = 683;                               // 1250;
  SM_DEALCHGGOLD_OK = 684;                                  // 1251;
  SM_DEALCHGGOLD_FAIL = 685;                                // 1252;
  SM_DEALREMOTECHGGOLD = 686;                               // 1253;
  SM_DEALSUCCESS = 687;                                     // 1254;
  SM_SENDUSERSTORAGEITEM = 700;                             // 1255;
  SM_STORAGE_OK = 701;                                      // 1256;
  SM_STORAGE_FULL = 702;                                    // 1257;   // 仓库已满
  SM_STORAGE_FAIL = 703;                                    // 1258;
  SM_SAVEITEMLIST = 704;                                    // 1259;
  SM_TAKEBACKSTORAGEITEM_OK = 705;                          // 1260;
  SM_TAKEBACKSTORAGEITEM_FAIL = 706;                        // 1261;
  SM_TAKEBACKSTORAGEITEM_FULLBAG = 707;                     // 1262;
  SM_AREASTATE = 708;                                       // 周围状态 1263;
  SM_MYSTATUS = 766;                                        // 我的状态,最近一次下线状态,如是否被毒,挂了就强制回城 1264;
  SM_DELITEMS = 709;                                        // 1265;
  SM_READMINIMAP_OK = 710;                                  // 1266;
  SM_READMINIMAP_FAIL = 711;                                // 1267;
  SM_SENDUSERMAKEDRUGITEMLIST = 712;                        // 1268;
  SM_MAKEDRUG_SUCCESS = 713;                                // 1269;
  // 714
  // 716
  SM_MAKEDRUG_FAIL = 749;                                   // 65036; //1270;
  SM_CHANGEGUILDNAME = 750;                                 // 1271;
  SM_SENDUSERSTATE = 751;                                   // 1272; //
  SM_SUBABILITY = 752;                                      // 打开输助属性对话框 1273;
  SM_OPENGUILDDLG = 753;                                    // 1274; //
  SM_OPENGUILDDLG_FAIL = 754;                               // 1275; //
  SM_SENDGUILDMEMBERLIST = 756;                             // 1276; //
  SM_GUILDADDMEMBER_OK = 757;                               // 1277; //
  SM_GUILDADDMEMBER_FAIL = 758;                             // 1278;
  SM_GUILDDELMEMBER_OK = 759;                               // 1279;
  SM_GUILDDELMEMBER_FAIL = 760;                             // 1280;
  SM_GUILDRANKUPDATE_FAIL = 761;                            // 1281;
  SM_BUILDGUILD_OK = 762;                                   // 1282;
  SM_BUILDGUILD_FAIL = 763;                                 // 1283;
  SM_DONATE_OK = 764;                                       // 1284;
  SM_DONATE_FAIL = 765;                                     // 1285;
  SM_MENU_OK = 767;                                         // ? 1286; //?
  SM_GUILDMAKEALLY_OK = 768;                                // 1287;
  SM_GUILDMAKEALLY_FAIL = 769;                              // 1288;
  SM_GUILDBREAKALLY_OK = 770;                               // 1289; //?
  SM_GUILDBREAKALLY_FAIL = 771;                             // 1290; //?
  SM_DLGMSG = 772;                                          // 1291; //Jacky
  SM_SPACEMOVE_HIDE = 800;                                  // 道士走一下隐身 1292;
  SM_SPACEMOVE_SHOW = 801;                                  // 道士走一下由隐身变为现身 1293;
  SM_RECONNECT = 802;                                       // 与服务器重连 1294;
  SM_GHOST = 803;                                           // 尸体清除,虹魔教主死的效果? 1295;
  SM_SHOWEVENT = 804;                                       // 显示事件 1296;
  SM_HIDEEVENT = 805;                                       // 隐藏事件 1297;
  SM_SPACEMOVE_HIDE2 = 806;                                 // 1298;
  SM_SPACEMOVE_SHOW2 = 807;                                 // 1299;
  SM_TIMECHECK_MSG = 810;                                   // 时钟检测,以免客户端作弊 1300;
  SM_ADJUST_BONUS = 811;                                    // 1301; //?
  SM_OPENHEALTH = 1100;                                     // 1302;
  SM_CLOSEHEALTH = 1101;                                    // 1303;
  SM_BREAKWEAPON = 1102;                                    // 武器破碎 1304;
  SM_INSTANCEHEALGUAGE = 1103;                              // 实时治愈 1305;
  SM_CHANGEFACE = 1104;                                     // 变脸,发型改变? 1306;
  SM_VERSION_FAIL = 1106;                                   // 客户端版本验证失败 1307;
  SM_ITEMUPDATE = 1500;                                     // 1308;
  SM_MONSTERSAY = 1501;                                     // 1309;
  SM_EXCHGTAKEON_OK = 65023;                                // 1310;
  SM_EXCHGTAKEON_FAIL = 65024;                              // 1311;
  SM_TEST = 65037;                                          // 1312;
  SM_TESTHERO = 1313;
  SM_THROW = 65069;                                         // 1314;
  SM_716 = 716;
  SM_PASSWORD = 1105;                                       // 3030; //1316;
  SM_PLAYDICE = 1200;                                       // 1317;
  SM_PASSWORDSTATUS = 8002;                                 // 20001; //1318;
  SM_GAMEGOLDNAME = 55;                                     // 向客户端发送游戏币名称,数量 1319;
  SM_GAMEPOINTNAME = 1320;                                  // 向客户端发送游戏币名称2 ,金刚石,灵符数量
  SM_GAMEGLORY = 1321;                                      // 游戏荣誉
  SM_SERVERCONFIG = 5007;                                   // 20002; //1322;
  SM_GETREGINFO = 8004;                                     // 20003; //1323;
  SM_MISSIONNPC = 1324;                                     // 发送任务NPC代码
  SM_ATTATCKMODE = 1325;                                    // 发送攻击模式
  SM_BUYSHOPITEM_SUCCESS = 9003;                            // 1326;
  SM_BUYSHOPITEM_FAIL = 9004;                               // 1327;
  SM_SENGSHOPITEMS = 9001;                                  // SERIES 7 每页的数量    wParam 总页数 1328;

  SM_AUTOGOTOXY = 20101;                                    // 1338; //自动寻路

  SM_REPAIRFIRDRAGON_OK = 5059;                             // 修补火龙之心 成功 1367;
  SM_REPAIRFIRDRAGON_FAIL = 5060;                           // 修补火龙之心 失败 1368;
  SM_MAGICMOVE = 5354;                                      // 新增加一个SM常量，配合十步一杀用 -- piaoyun 2013-06-25

  SM_SENGRANKING = 1330;
  SM_SENGMYRANKING_FAIL = 1331;
  SM_SHOWBOX = 1332;                                        // 显示宝箱
  SM_OPENBOX_SUCCESS = 1333;                                // 钥匙正确宝箱开启
  SM_OPENBOX_FAIL = 1334;
  SM_SENDGETBOXITEMINDEX = 1335;                            // 获取转动后选择的物品序号
  SM_TAKEONITEM = 1336;                                     // 自动穿装备
  SM_TAKEOFFITEM = 1337;                                    // 自动脱装备

  SM_CLICKNPCLABEL = 1339;                                  //
  SM_SERVERNAME = 1340;
  SM_HEROTAKEONITEM = 1341;                                 // 英雄自动穿装备
  SM_HEROTAKEOFFITEM = 1342;                                // 英雄自动脱装备
  SM_SENDGAMEGOLDDALITEM = 1343;                            // 元宝交易装备
  SM_SELLGAMEGOLDDALITEM_OK = 1344;
  SM_SELLGAMEGOLDDALITEM_FAIL = 1345;
  SM_BUYGAMEGOLDDALITEM_OK = 1346;
  SM_BUYGAMEGOLDDALITEM_FAIL = 1347;
  SM_CANCELGAMEGOLDDEALITEM_OK = 1348;                      // 取消元宝交易装备
  SM_CANCELGAMEGOLDDEALITEM_FAIL = 1349;                    // 取消元宝交易装备
  SM_CANCELGAMEGOLDSELLITEM_OK = 1350;                      // 取消元宝交易装备
  SM_CANCELGAMEGOLDSELLITEM_FAIL = 1351;                    // 取消元宝交易装备
  SM_UNBINDLIST = 1352;
  SM_EFFECTIMAGELIST = 1353;                                // WIL列表
  SM_PLAYEFFECT = 1354;                                     // 播放人物效果
  SM_SCREENEFFECT = 1355;
  SM_OVERLAPITEM_OK = 1356;                                 // 重叠物品 成功
  SM_OVERLAPITEM_FAIL = 1357;                               // 重叠物品 失败
  SM_HEROOVERLAPITEM_OK = 1358;                             // 英雄重叠物品 成功
  SM_HEROOVERLAPITEM_FAIL = 1359;                           // 英雄重叠物品 失败
  SM_PACKAGEITEM_OK = 1360;                                 // 分开重叠物品 成功
  SM_PACKAGEITEM_FAIL = 1361;                               // 分开重叠物品 失败
  SM_HEROPACKAGEITEM_OK = 1362;                             // 英雄分开重叠物品 成功
  SM_HEROPACKAGEITEM_FAIL = 1363;                           // 英雄分开重叠物品 失败
  SM_PLAYSOUND = 1364;
  SM_OPENBIGMERCHANTBIGDLG = 1365;
  SM_CLOSEBIGMERCHANTBIGDLG = 1366;
  SM_CHANGESPEED = 1369;                                    // 游戏速度
  SM_QUERYUSERSHOPS = 1370;                                 // 返回搜索传奇店铺结果
  SM_QUERYUSERSHOPITEMS = 1371;                             // 返回指定用户店铺物品
  SM_SEARCHSHOPITEMS = 1372;                                // 返回搜索传奇店铺物品结果
  SM_QUERYMYSHOPSELLINGITEMS = 1373;                        // 返回我的店铺正在物品
  SM_QUERYMYSHOPSELLEDITEMS = 1374;                         // 返回我的店铺已经出售物品
  SM_QUERYMYSHOPSTORAGEITEMS = 1375;                        // 返回我的店铺仓库物品
  SM_SENDADDTOMYSHOP_OK = 1376;
  SM_SENDADDTOMYSHOP_FAIL = 1377;
  SM_SENDCHANGEMYSHOPITEM_OK = 1378;
  SM_SENDCHANGEMYSHOPITEM_FAIL = 1379;
  SM_SENDMOVEMYSHOPITEM_OK = 1380;
  SM_SENDMOVEMYSHOPITEM_FAIL = 1381;
  SM_QUERYSELECTSHOPINFO = 1382;
  SM_QUERYSELECTSHOPINFO_FAIL = 1383;
  SM_SENDBUYUSERSHOPITEM_OK = 1384;
  SM_SENDBUYUSERSHOPITEM_FAIL = 1385;
  SM_UPGRADEDLGITEM_TAKE = 1386;                            // 升级成功
  SM_UPGRADEDLGITEM_GIVE = 1387;                            // 升级成功
  SM_OPENUPGRADEDLG = 1388;                                 // 显示OK对话框
  SM_SENDUSERICON = 1389;
  SM_SENDWEBBROWSER = 1390;
  SM_SENDUSEREFFECT = 1391;
  SM_SENDSUPERSHILEDEFFECT = 1392;
  SM_SENDBLASTHIT = 1393;                                   // 暴击
  SM_SPECIALCMD = 1396;                                     // 特殊命令
  SM_WEATHER = 1397;

  /////////////////挑战相关消息常量 piaoyun 2013-07-22//////////////////////////
  SM_CHALLENGETRY_FAIL = 1399;                              // 挑战失败
  SM_CHALLENGEMENU = 1398;                                  // 打开挑战抵押物品窗口;
  SM_CHALLENGEADDITEM_OK = 1400;                            // 玩家增加抵押物品成功;
  SM_CHALLENGEADDITEM_FAIL = 1401;                          // 玩家增加抵押物品失败;
  SM_CHALLENGEDELITEM_OK = 1402;                            // 玩家删除抵押物品成功;
  SM_CHALLENGEDELITEM_FAIL = 1403;                          // 玩家删除抵押物品失败;
  SM_CHALLENGECANCEL = 1404;                                // 玩家取消挑战;
  SM_CHALLENGEREMOTEADDITEM = 1405;                         // 发送增加抵押的物品后,给客户端显示;
  SM_CHALLENGEREMOTEDELITEM = 1406;                         // 发送删除抵押的物品后,给客户端显示;
  SM_CHALLENGECHGGOLD_OK = 1407;                            // 改变挑战金币成功
  SM_CHALLENGECHGGOLD_FAIL = 1408;                          // 改变挑战金币失败
  SM_CHALLENGECHGGAMEDIAMOND_OK = 1409;                     // 修改挑战金刚石成功
  SM_CHALLENGECHGGAMEDIAMOND_FAIL = 1410;                   // 修改挑战金刚石失败
  SM_CHALLENGEREMOTECHGGOLD = 1411;                         // 修改对方挑战金币
  SM_CHALLENGEREMOTECHGGAMEDIAMOND = 1412;                  // 修改对方挑战金刚石
  SM_CHALLENGESUCCESS = 1413;                               // 挑战成功
  //////////////////////////////////////////////////////////////////////////////

  SM_OPENUPGRADEDIALOG = 1414;                              // 打开包裹宝石装备升级对话框
  SM_SENDUPGRADEDIALOG_OK = 1415;                           // 包裹宝石装备升级成功
  SM_SENDUPGRADEDIALOG_FAIl = 1416;                         // 包裹宝石装备升级失败
  SM_HEARCOLOR = 1417;                                      // 人物喊话信息颜色
  SM_SOFTCLOSE = 1418;

  /////////////////////酒馆相关消息 piaoyun 2013-07-22//////////////////////////
  SM_PLAYDRINKSAY = 1419;                                   // 酒馆NPC对话框信息
  SM_USERPLAYDRINKITEM_OK = 1420;                           // 请酒物品成功
  SM_USERPLAYDRINKITEM_FAIl = 1421;                         // 请酒物品失败
  SM_USERPLAYDRINK_OK = 1422;                               // 给NPC的酒正确 可以斗酒
  SM_USERPLAYDRINK_FAIL = 1423;                             // 给NPC的酒错误
  SM_OPENPLAYDRINK = 1424;                                  // 打开窗口
  SM_CLOSEDRINK = 1425;                                     // 关闭酒馆NPC对话框
  SM_DRINKUPDATEVALUE = 1426;                               // 返回喝酒
  SM_PLAYDRINKTODRINK = 1427;                               // 发送到客户端谁赢谁输
  SM_SENDUSERPLAYDRINK = 1428;                              // 出现请酒对话框

  SM_SENDSTORAGEHEROINFO = 1429;                            // 英雄寄存信息   召回寄存的英雄
  SM_SENDSTORAGEHEROINFOEX = 1430;                          // 英雄寄存信息 评定英雄
  SM_ASSESSMENTHERO_OK = 1431;                              // 评定英雄车成功
  SM_ASSESSMENTHERO_FAIL = 1432;                            // 评定英雄车失败
  SM_SENDSHOWHEROAUTOPRACTICEDLG = 1433;                    // 显示英雄自动修炼对话框
  SM_SENDHEROAUTOPRACTICE_OK = 1434;                        // 英雄自动修炼成功
  SM_SENDHEROAUTOPRACTICE_FAIL = 1435;                      // 英雄自动修炼失败
  SM_REFABILNG = 1436;                                      // 刷新内力
  SM_ABILITYNG = 1437;                                      // 内功属性
  SM_ABILITYALCOHOL = 1438;                                 // 酒属性
  SM_ABILITYMERIDIANS = 1439;                               // 经脉
  SM_HEROABILITYNG = 1440;                                  // 英雄内功属性
  SM_HEROABILITYALCOHOL = 1441;                             // 英雄酒属性
  SM_HEROABILITYMERIDIANS = 1442;                           // 英雄经脉
  SM_OPENCOBWEBWINDING = 1443;                              // 蜘蛛网罩住  开启
  SM_CLOSECOBWEBWINDING = 1444;                             // 蜘蛛网罩住 打开
  SM_LIGHTINGEX = 1445;
  SM_CONTINUOUSMAGICORDER = 1446;                           // 连击顺序  series=0 人物 series=1 英雄
  SM_CONTINUOUSMAGIC_OK = 1447;                             // 请求开始开始连击成功
  SM_CONTINUOUSMAGIC_FAIL = 1448;                           // 请求开始开始连击失败
  SM_CANCONTINUOUSMAGIC = 1449;                             // 可以连击 界面连击图片闪烁显示
  SM_TRAININGNG = 1450;                                     // 是否修炼内功心法 界面相应显示内功心法界面  series=0 人物 series=1 英雄
  SM_LEVELUPNG = 1451;                                      // 内功升级
  SM_STOPCONTINUOUSMAGIC = 1452;                            // 停止连击
  SM_MAPCANRUN = 1453;                                      // 穿人穿怪状态
  SM_PLUGFILE = 1454;                                       // 客户端插件MD5 M2发送过来进行检测
  SM_MODULEMD5 = 1455;                                      // 白名单模块MD5
  SM_BLACKMODULEMD5 = 1456;                                 // 黑名单模块MD5
  SM_SENDSHOPNAME = 1457;                                   // 摆摊商铺名称
  SM_MASTERBAGTOHEROBAG_OK = 1458;                          // 主人包裹物品放到英雄包裹成功
  SM_MASTERBAGTOHEROBAG_FAIL = 1459;                        // 主人包裹物品放到英雄包裹失败
  SM_HEROBAGTOMASTERBAG_OK = 1460;                          // 英雄包裹物品放到主人包裹成功
  SM_HEROBAGTOMASTERBAG_FAIL = 1461;                        // 英雄包裹物品放到主人包裹失败

  //////////////////////英雄相关消息常量 piaoyun 2013-07-23/////////////////////
  SM_HEROBAGCOUNT = 1462;                                   // 英雄包裹数量
  SM_HEROLOGON = 1464;                                      // 获取英雄 TMessageBodyWL 产生英雄登陆效果
  SM_HEROLOYAL = 1465;                                      // 获取英雄忠诚  10001(忠00.00%)
  SM_SENDMYHEROMAGIC = 1470;                                // 获取英雄魔法
  SM_HEROANGERVALUE = 1481;                                 // 英雄怒值改变 Ident: 916 Recog: 5 Param: 2 Tag: 102 Series: 0
  SM_HEROLOGOUT_OK = 1482;                                  // 英雄退出OK
  SM_HEROCHANGEFACE = 1490;
  SM_HEROLOGON_OK = 1494;
  SM_HEROLOGOUT = 1463;                                     // 获取英雄 TMessageBodyWL 产生英雄退出效果
  SM_HEROABILITY = 1466;                                    // 获取英雄Abil
  SM_HEROSUBABILITY = 1467;                                 // 英雄SUBABILITY
  SM_HEROBAGITEMS = 1468;                                   // 获取英雄包裹     Tag:包裹物品数量 2 Series: 包裹总数量10
  SM_SENDHEROUSEITEMS = 1469;                               // 获取英雄身上装备
  SM_HEROADDITEM = 1471;                                    // 英雄 Ident: 905 Recog: 738569296 Param: 0 Tag: 0 Series: 1   AddItem
  SM_HERODELITEM = 1472;                                    // 英雄 Ident: 906 Recog: 738569296 Param: 0 Tag: 0 Series: 1   delItem
  SM_HEROTAKEON_OK = 1473;                                  // 英雄穿装备OK Ident: 907 Recog: 742933632 Param: 0 Tag: 0 Series: 0
  SM_HEROTAKEON_FAIL = 1474;                                // 英雄穿装备FAIL
  SM_HEROTAKEOFF_OK = 1475;                                 // 英雄脱装备OK
  SM_HEROTAKEOFF_FAIL = 1476;                               // 英雄脱装备FAIL
  SM_HEROEAT_OK = 1477;                                     // 英雄吃药OK
  SM_HEROEAT_FAIL = 1478;                                   // 英雄吃药FAIL
  SM_HEROADDMAGIC = 1479;                                   // 英雄增加魔法
  SM_HERODELMAGIC = 1480;                                   // 英雄删除魔法
  SM_HERODURACHANGE = 1483;                                 // 英雄物品持久改变
  SM_HERODROPITEM_SUCCESS = 1484;                           // 英雄扔物品OK
  SM_HERODROPITEM_FAIL = 1485;                              // 英雄扔物品FAIL
  SM_HEROLEVELUP = 1486;                                    // 英雄升级
  SM_HEROWINEXP = 1487;                                     // 英雄获取经验
  SM_HEROWEIGHTCHANGED = 1488;
  SM_HEROMAGIC_LVEXP = 1489;                                // 英雄魔法经验
  SM_HEROUPDATEITEM = 1491;                                 // 更新英雄物品
  SM_HERODELITEMS = 1492;                                   // 删除英雄物品 1492;
  SM_HEROCHANGEITEM = 1493;                                 // 改变英雄物品

  SM_OPENMISSIONDLG = 1495;                                 // 打开任务日志对话框
  SM_DELETEDELAYMESSAGE = 1496;                             // 删除延时消息

  /////////////////仿HeroM2摆摊相关常量值 piaoyun 2013-07-23////////////////////
  SM_HEROM2ADDUSERSHOPITEM_OK = 1497;                       // 增加摆摊物品成功
  SM_HEROM2ADDUSERSHOPITEM_FAIL = 1498;                     // 增加摆摊物品失败
  SM_HEROM2DELUSERSHOPITEM_OK = 1499;                       // 删除摆摊物品成功
  SM_HEROM2DELUSERSHOPITEM_FAIL = 1500;                     // 删除摆摊物品失败
  SM_HEROM2DELUSERSHOPITEM = 1501;                          // 删除摆摊物品
  SM_HEROM2DELREMOTEUSERSHOPITEM = 1502;                    // 删除摆摊物品
  SM_HEROM2SENDSHOPITEM = 1503;                             // 摆摊物品
  SM_HEROM2SENDCLOSESHOP = 1504;                            // 关闭购买摆摊物品窗口
  SM_HEROM2SENDDRESSEFFECT = 1505;                          // 摆摊物品衣服特效
  //////////////////////////////////////////////////////////////////////////////

  SM_SENDFILTERITEMLIST = 1506;                             // 过滤物品列表
  SM_SENDITEMDESCLIST = 1507;                               // 物品描述列表
  SM_SENDTZITEMDESCLIST = 1508;
  SM_SENDACTIONMSG = 1509;                                  // m_boCanHit m_boCanSpell m_boCanWalk  m_boCanRun
  SM_SENDOPENSKILLTIME = 1510;                              // 战士技能开启的剩余时间

  SM_AUTOEAT_OK = 1511;                                     // 自动吃药成功
  SM_AUTOEAT_FAIL = 1512;                                   // 自动吃药失败

  SM_HEROAUTOEAT_OK = 1513;                                 // 英雄自动吃药成功
  SM_HEROAUTOEAT_FAIL = 1514;                               // 英雄自动吃药失败
  SM_NATIONMESSAGE = 1515;


  SM_ADDBUTTON = 1516;                                                                              // 增加按钮
  SM_DELBUTTON = 1517;                                                                              // 删除按钮
  SM_SHOWPHANTOM = 1518;                                                                            // 显示放大的虚影
  SM_CLOSEPHANTOM = 1519;                                                                           // 关闭放大的虚影
  SM_STDITEMLIST = 1520;

  SM_SETCLIENTBUFF = 1521;
  SM_CLOSECLIENTBUFF = 1522;
  SM_SENDUSERMOVECMD = 1523;
//=============================================================================


type
  PPoint = ^TPoint;
  TPoint = packed record
    X: Longint;
    Y: Longint;
  end;

  PRect = ^TRect;
  TRect = packed record
    case Integer of
      0: (Left, Top, Right, Bottom: Longint);
      1: (TopLeft, BottomRight: TPoint);
  end;


  TMsgDlgBtn = (mbYes, mbNo, mbOK, mbCancel, mbAbort, mbRetry, mbIgnore,
    mbAll, mbNoToAll, mbYesToAll, mbHelp);
  TMsgDlgButtons = set of TMsgDlgBtn;
  TGridDrawState = set of (gdSelected, gdFocused, gdFixed);
  TGridState = (gsNormal, gsSelecting, gsRowSizing, gsColSizing, gsRowMoving, gsColMoving);

  TFontStyle = (fsBold, fsItalic, fsUnderline, fsStrikeOut);
  TFontStyles = set of TFontStyle;

const
  mbYesNoCancel = [mbYes, mbNo, mbCancel];
  mbYesAllNoAllCancel = [mbYes, mbYesToAll, mbNo, mbNoToAll, mbCancel];
  mbOKCancel = [mbOK, mbCancel];
  mbAbortRetryIgnore = [mbAbort, mbRetry, mbIgnore];
  mbAbortIgnore = [mbAbort, mbIgnore];


type
  TModalResult = Low(Integer)..High(Integer);

  TAlignment = (taLeftJustify, taRightJustify, taCenter);
  TShiftState = set of (ssShift, ssAlt, ssCtrl,
    ssLeft, ssRight, ssMiddle, ssDouble);
  TMouseButton = (mbLeft, mbRight, mbMiddle);

  PColor = ^TColor;
  TColor = -$7FFFFFFF - 1..$7FFFFFFF;

const
  IDOK = 1; ID_OK = IDOK;
  IDCANCEL = 2; ID_CANCEL = IDCANCEL;
  IDABORT = 3; ID_ABORT = IDABORT;
  IDRETRY = 4; ID_RETRY = IDRETRY;
  IDIGNORE = 5; ID_IGNORE = IDIGNORE;
  IDYES = 6; ID_YES = IDYES;
  IDNO = 7; ID_NO = IDNO;
  IDCLOSE = 8; ID_CLOSE = IDCLOSE;
  IDHELP = 9; ID_HELP = IDHELP;
  IDTRYAGAIN = 10;
  IDCONTINUE = 11;

  mrNone = 0;
  mrOk = idOk;
  mrCancel = idCancel;
  mrAbort = idAbort;
  mrRetry = idRetry;
  mrIgnore = idIgnore;
  mrYes = idYes;
  mrNo = idNo;
  mrAll = mrNo + 1;
  mrNoToAll = mrAll + 1;
  mrYesToAll = mrNoToAll + 1;

const
  clBlack = TColor($000000);
  clMaroon = TColor($000080);
  clGreen = TColor($008000);
  clOlive = TColor($008080);
  clNavy = TColor($800000);
  clPurple = TColor($800080);
  clTeal = TColor($808000);
  clGray = TColor($808080);
  clSilver = TColor($C0C0C0);
  clRed = TColor($0000FF);
  clLime = TColor($00FF00);
  clYellow = TColor($00FFFF);
  clBlue = TColor($FF0000);
  clFuchsia = TColor($FF00FF);
  clAqua = TColor($FFFF00);
  clLtGray = TColor($C0C0C0);
  clDkGray = TColor($808080);
  clWhite = TColor($FFFFFF);
  StandardColorsCount = 16;

  clMoneyGreen = TColor($C0DCC0);
  clSkyBlue = TColor($F0CAA6);
  clCream = TColor($F0FBFF);
  clMedGray = TColor($A4A0A0);

  clNone = TColor($1FFFFFFF);
  clDefault = TColor($20000000);
type
  TList = TObject;
  TStringList = TObject;
  TActor = TObject;
  TTexture = TObject;
  TDxControl = TObject;
  THGEFont = TObject;
  TPointDropItemList = TObject;
  TDropItemsMgr = TObject;

  pTActor = ^TActor;
  pTList = ^TList;
  pTStringList = ^TStringList;
  //176   185   英雄版  连击版   传奇续章     外传   归来
  TClientVersion = (cv176, cv185, cvHero, cvSerial, cvMirSequel, cvMirs, cvMirReturn);

  TGuiType = (t_None, t_Form, t_Button, t_Edit, t_Label, t_Grid,
    t_ScrollBox, t_ChatMemo, t_PopupMenu, t_ComboBox, t_PageControl, t_TabSheet,
    t_TreeView, t_ListView, t_Line, t_FormShape);
  TInValue = (vInteger, vString);
  TButtonStyle = (bsButton, bsRadio, bsCheckBox);
  TClickSound = (csNone, csStone, csGlass, csNorm);

  TOnClickEx = procedure(Sender: TObject; X, Y: Integer) of object; stdcall;
  TOnInRealArea = procedure(Sender: TObject; X, Y: Integer; var IsRealArea: Boolean) of object; stdcall;
  TOnGridMove = procedure(Sender: TObject; ACol, ARow: Integer; Shift: TShiftState) of object; stdcall;
  TOnGridSelect = procedure(Sender: TObject; ACol, ARow: Integer; Button: TMouseButton; Shift: TShiftState) of object; stdcall;
  TOnGridPaint = procedure(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState) of object; stdcall;
  
  // 2021-01-05 changed
  TDefaultMessage = record
    nRecog: Int64;
    wIdent: word;
    wParam: word;
    wTag: word;
    wSeries: word;
  end;
  pTDefaultMessage = ^TDefaultMessage;

  TAbility = packed record
    Level: LongInt;
    AC: Integer;
    MAC: Integer;
    DC: Integer;
    MC: Integer;
    SC: Integer;
    HP: LongInt;
    MP: LongInt;
    MaxHP: LongInt;
    MaxMP: LongInt;
    Exp: LongWord;
    MaxExp: LongWord;
    Weight: LongInt;
    MaxWeight: LongInt;
    WearWeight: LongInt;
    MaxWearWeight: LongInt;
    HandWeight: LongInt;
    MaxHandWeight: LongInt;
    CreditPoint: Integer;                                   //声望
    NewValue: array[0..20 - 1] of Byte;
//0暴击几率增加 1增加攻击伤害  2物理伤害减少 3魔法伤害减少  4忽视目标防御  5所有伤害反弹 6人物体力增加  7人物魔力增加 8怒气恢复增加 9合击攻击增加  10增加目标暴率
  end;
  pTAbility = ^TAbility;


  TStdItemEffect = packed record
    FileIndex: SmallInt; // 物品发光效果 文件编号 0
    ImageStart: Word; // 物品发光效果 读取位置
    ImageCount: Byte; // 物品发光效果 读取张数
    IsDrawCenter: Boolean; // 居中播放
    IsDrawNoBlend: Boolean; // 非透明绘制
    IsDrawBelow: Boolean; // 底层绘制
    OffsetX: SmallInt; // 物品发光效果 微调X
    OffsetY: SmallInt; // 物品发光效果 微调Y
    Time: Word; // 播放速度
  end;

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
    OverLap: Word; // 是否是重叠物品
    Color: Byte; // 物品名称颜色
    Stock: Integer;
    Light: Integer; // 数据库增加Light字段 piaoyun 2013-08-01

    Horse: Integer;
    Expand1: Integer;
    Expand2: Integer;
    Expand3: Integer;
    Expand4: Integer;
    Expand5: Integer;

    Elements: array[0..23] of Word;

    InsuranceCurrency: Integer;
    InsuranceGold: Integer;

    BagEffect: TStdItemEffect;  // 包裹中的物品发光效果
    BodyEffect: TStdItemEffect; // 内观中物品发光效果
    Effect: Int64;              // 指针改为64位 2021-01-05
  end;
  pTStdItem = ^TStdItem;


  // 自定义物品进度条
  TUserItemProgress = packed record
    boOpen: Boolean;
    btNameColor: Byte;
    btCount: Byte;
    btShowType: Byte; // 进度上的值显示方式(0:不显示; 1:百分比; 2:数值;)
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

  PUserItemProperty = ^TUserItemProperty;
  TUserItemProperty = packed record
    sText: string[128]; // NND,从64又要整到128 2019-03-18 17:18:22
    btTextColor: Byte;
    Properties: array[0..ITEM_PROP_COUNT - 1] of TCustomProperty;
  end;

  // 物品来源
  TItemFormType = (ifUnknow {未知}, ifGM {GM制造}, ifScript {脚本}, ifShopBuy {商店购买}, ifMonDrop {打怪掉落}, ifSysGive {系统给予}, ifMine {挖矿得到}, ifBoxGive {宝箱取得}, ifButchItem {挖肉得到}, ifCaptureMon {捕捉得到});

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

  TClientItem = packed record // OK
    s: TStdItem;
    MakeIndex: Integer;
    Dura: Word;
    DuraMax: Word;

    IsBind: Boolean; // 是否绑定
    btFluteCount: Byte;

    btUpgradeCount: Byte; // 升级次数
    btHeroM2Light: Byte; // HeroM2 SetItemsLight

    btValue: array[0..13] of Integer; // 附加属性
    NewValue: array[0..30 - 1] of Word;

    Flutes: array[0..MAX_FLUTE_COUNT - 1] of TFluteInfo; // 凹槽宝石信息         16

    Progress: array[0..1] of TUserItemProgress;

    CustomProperty: TUserItemProperty;

    ItemFrom: TUserItemFrom;
    wInsuranceCount: Word;
  end;
  PTClientItem = ^TClientItem;


  // 人物技能 英雄技能 连击技能 内功技能增加防御 内功技能增加攻击
  TMagicAttr = (mtHum, mtHero, mtContinuous, mtDefense, mtAttack);

   TMagic_C = packed record
    MagicAttr: TMagicAttr;
    wMagicId: Word;
    sMagicName: string[ITEM_NAME_LEN];
    btEffectType: Byte;
    btEffect: Byte;
    wSpell: Word;
    MaxTrain: array[0..15] of Integer;
    btTrainLv: Byte;                // 最高可升级等级
    dwMagicDelayTime: LongWord;
    wDefSpell: Word;
    CanUpgrade: Integer;            // 是否允许升级 chongchong 2013-12-06
    MaxUpgradeLevel: Integer;       // 最高
  end;
  pTMagic_C = ^TMagic_C;

  TClientMagic = packed record // 84
    Key: AnsiChar;
    Level: Byte;
    NewLevel: Byte; // 九重
    CurTrain: Integer;
    Def: TMagic_C;
    dwInterval: LongWord;
    dwRealInterval: LongWord;
    dwLastUseTick: LongWord;
  end;
  PTClientMagic = ^TClientMagic;

  TMovingItem = record
    Index: Integer;
    ItemType: Integer;
    Item: TClientItem;
  end;
  pTMovingItem = ^TMovingItem;

  THumFeature = packed record
    wRace: Word; // 脸型
    wWeapon: Word; // 武器
    wWeaponSound: Word;     // 武器声音 2020-11-24 23:40:49
    wDress: Word; // 衣服
    wShield: Word; // 盾牌 chongchong 2013-09-16
    btGender: Byte;
    btJob: Byte;
    btHair: Byte;
    btHorseType: Byte;
    btCaseltGuild: Byte;  // 1=沙行会成员 //2=沙行会掌门
    boShopStall: Boolean; // 摆摊
    btBodyColor: Byte;    // 人体颜色
    btShopStallDir: Byte;
    wDressEffType: Word;
    wDressEffType_30: Word;
    boDressEffNormalDraw: Boolean;
    boDressEffNoSex: Boolean;
    boDressEff_30NormalDraw: Boolean;
    boDressEff_30NoSex: Boolean;

    nChangeAppr: Integer;

    nWeaponEffectIndex: SmallInt; // 武器特效
    wWeaponEffectOffSet: Word;    // 武器特效偏移

    wDBWeaponEffectOffSet: Word;    // DB武器特效偏移

    nDressEffectIndex: SmallInt; // 衣服特效
    wDressEffectOffSet: Word; // 衣服特效偏移

    nShieldEffectIndex: SmallInt; // 盾牌特效
    wShieldEffectOffSet: Word; // 盾牌特效偏移

    boDressEffectNoBlend: Boolean; // 衣服普通绘制
    boDressEffectNoSex: Boolean; // 衣服不分男女
    //boDressEffect: Boolean;                                                                         // 衣服特效 (每个方向读8帧)

    boWeaponEffectNoBlend: Boolean; // 武器普通绘制
    boWeaponEffectNoSex: Boolean; // 武器不分男女

    boShieldEffectNoBlend: Boolean; // 盾牌普通绘制
    boShieldEffectNoSex: Boolean; // 盾牌不分男女

    nShieldAddEffectIndex: SmallInt; // 盾牌特效
    wShieldAddEffectOffSet: Word; // 盾牌特效偏移

    nDressAddEffectIndex: SmallInt; // 附加衣服特效
    bDressAddEffectOrder: Byte; // 附加衣服特效绘制顺序
    wDressAddEffectOffSet: Word; // 附加衣服特效偏移
    wDressAddEffectCount: Word; // 附加衣服特效数量
    wDressAddEffectTime: Word; // 附加衣服特效时间
    boDressAddEffectNoBlend: Boolean; // 附加衣服特效 - 普通绘制
    boDressAddEffectDrawCenter: Boolean;

    nMedalEffectIndex: SmallInt; // 勋章特效
    wMedalEffectOffSet: Word; // 勋章特效偏移
    boMedalEffectNoBlend: Boolean; // 勋章普通绘制
    boMedalEffectNoSex: Boolean; // 勋章不分男女

    btDoubleHumHorseType: Byte; // 骑马 - 双人骑类型 chongchong 2013-10-14
    boShowHorseWingsEffect: Boolean; // 是否显示马翅膀特效 chongchong 2013-10-16
    btHorseEffectType: Byte; // 马特效类型 chongchong 2015-10-24

    btHorseHum: Word; // 骑马 三方马上的人物造型 chongchong 2013-10-17
    btHorseHumExpand: Byte; // 骑马 三方马上的人物造型扩展 chongchong 2014-09-24

    btHorseHair: Byte; // 骑马 三方马上的人物头发 chongchong 2013-10-17

    boShowFashion: Boolean; // 显示时装 chongchong 2013-10-23
    boMagicShield: Boolean; // 使用护身装备 chongchong 2014-04-07

    btReLevel: Integer; // 转生等级 chongchong 2014-05-07

    sActiveFengHaoName: string[ITEM_NAME_LEN]; // 激活的封号名 chongchong 2014-05-25
    nActiveFengHaoID: Integer; // 激活的封号MakeIndex chongchong 2014-05-25
    dwActiveFengHaoLooks: Word; // 激活的封号Looks chongchong 2014-05-25
    btActiveFengHaoReserved: Byte;
    btActiveFengHaoColor: Byte; // 激活封号颜色 chongchong 2014-05-25

    boShowHair: Boolean;

    btCboDressUseDiyImage: Byte; // 连击时衣服使用自定义资源
    btCboWeaponUseDiyImage: Byte; // 连击时武器使用自定义资源

    btOldHair: Byte; // 原始发型，不算斗笠或面巾的
    boPlayMoster: Boolean; // 是否为人型怪 chongchong 2015-09-19
  end;
  pTHumFeature = ^THumFeature;


  // 人物宝宝类型
  THumBBType = (bbNo{不是宝宝}, bbSlave{普通宝宝}, bbGamePet{宠物宝宝});
  TMonFeature = packed record
    wRaceImg: Word;         // RaceImg字段
    wWeapon: Word;          // 武器
    wAppr: Word;            // 衣服
    btBodyColor: Byte;    // 人体颜色
    btRace: Byte;           // 非人物角色脸型 (Race字段) (基类是TActor的)
    MonLevel: LongWord;
    HumBBType: THumBBType;  // 人物宝宝类型 chongchong 2014-11-29
    IsExploreItem: Boolean; // 是否可探索怪
    IsDisableSimpleActor: Boolean;  // 禁止怪物简装
  end;
  pTMonFeature = ^TMonFeature;

  // 外观结构
  TFeature = packed record
    Feature: Integer;
    Buffer: array[0..255] of Byte;
  end;
  pTFeature = ^TFeature;

  TUseItems = array[0..MAX_USE_ITEM_COUNT - 1] of TClientItem;
  TClientBagItems = array[0..ALL_BAG_ITEM_COUNT - 1] of TClientItem;
  TClientHeroBagItems = array[0..MAX_HERO_BAG_ITEM - 1] of TClientItem;
  TJewelryBoxItems = array[0..5] of TClientItem;
  TItemBoxItems = array[0..7] of TClientItem;
  TGodBlessItems = array[0..11] of TClientItem;

  pTUseItems = ^TUseItems;
  pTClientBagItems = ^TClientBagItems;
  pTClientHeroBagItems = ^TClientHeroBagItems;
  pTJewelryBoxItems = ^TJewelryBoxItems;
  pTItemBoxItems = ^TItemBoxItems;
  PTGodBlessItems = ^TGodBlessItems;

  TJewelryBoxStatus = (jbsNoActive, jbsActive, jbsOpen);
  TGodBlessItemsState = array[Low(TGodBlessItems)..High(TGodBlessItems)] of Byte;

  TUserStateInfo = packed record
    RaceServer: Integer;
    Feature: TFeature;
    UserName: string[ACTOR_NAME_LEN];
    NAMECOLOR: Integer;
    GuildName: string[ACTOR_NAME_LEN];
    GuildRankName: string[ACTOR_NAME_LEN];
    UseItems: TUseItems;
    JewelryBoxStatus: TJewelryBoxStatus;
    JewelryItems: TJewelryBoxItems;

    ShowGodBless: Boolean;
    GodBlessItemsState: TGodBlessItemsState;
    GodBlessItems: TGodBlessItems;
  end;
  pTUserStateInfo = ^TUserStateInfo;

  TDrawItemEffect = record
    DrawCount: Integer;
    DrawTick: LongWord;
  end;
  pTDrawItemEffect = ^TDrawItemEffect;

  TClientGoods = record                                     // NPC当前出售物品列表
    Name: string[ITEM_NAME_LEN];
    RealName: string[ITEM_NAME_LEN];
    SubMenu: Integer;
    Price: Integer;
    Stock: Integer;
    Grade: Integer;
    Count: Integer;
    Looks: Integer;
  end;
  PTClientGoods = ^TClientGoods;

  TDropItem = record                                        // 地面物品
    x: Integer;
    y: Integer;
    id: Integer;
    Looks: Integer;
    Color: Integer;
    Name: string[30];
    DBName: string[30];
  end;
  pTDropItem = ^TDropItem;



implementation

end.

