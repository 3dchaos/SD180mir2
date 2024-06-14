unit ClientType;

interface

const
  MAP_NAME_LEN = 30;
  ITEM_NAME_LEN = 60;
  ACTOR_NAME_LEN = 14;    // ��ɫ����
  ACCOUNT_LEN = 10;       // �˺ų���
  DEF_BLOCK_SIZE = 22;    // 16 - 64λ�޸� 2021-01-04

  MAX_FLUTE_COUNT = 8;    // ��󰼲�����

  ITEM_PROP_COUNT = 20;
  ITEM_PROP_VALUES_COUNT = 3;

  MAX_USE_ITEM_COUNT = 30; // ����װ������

  DEF_MAX_BAG_ITEM = 46; // ���ﱳ����Ʒ����
  MAX_EXT_BAG_PAGE_COUNT = 4; // ����չ����ҳ��
  MAX_EXT_ONE_PAGE_ITEM_COUNT = 40; // ��չ����ÿҳ������

  ALL_BAG_ITEM_COUNT = DEF_MAX_BAG_ITEM + MAX_EXT_BAG_PAGE_COUNT * MAX_EXT_ONE_PAGE_ITEM_COUNT;

  MAX_HERO_BAG_ITEM = 40; // Ӣ�۰���


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

//----------------------------------����ģʽ------------------------------------
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
///////////////////////////////8������//////////////////////////////////////////
  DR_UP = 0;
  DR_UPRIGHT = 1;
  DR_RIGHT = 2;
  DR_DOWNRIGHT = 3;
  DR_DOWN = 4;
  DR_DOWNLEFT = 5;
  DR_LEFT = 6;
  DR_UPLEFT = 7;
////////////////////////////////////////////////////////////////////////////////


  U_DRESS = 0;                                              // �·�
  U_WEAPON = 1;                                             // ����
  U_RIGHTHAND = 2;                                          // ������Ʒ
  U_NECKLACE = 3;                                           // ����
  U_HELMET = 4;                                             // ͷ��
  U_ARMRINGL = 5;                                           // ������
  U_ARMRINGR = 6;                                           // ������
  U_RINGL = 7;                                              // ���ָ
  U_RINGR = 8;                                              // �ҽ�ָ
  U_BUJUK = 9;                                              // ��
  U_BELT = 10;                                              // ����
  U_BOOTS = 11;                                             // Ь
  U_CHARM = 12;                                             // ��ʯ
  U_HAT = 13;                                               // ����
  U_DRUM = 14;                                              // ��
  U_HORSE = 15;                                             // ��

///////////////////////���ý�ɫ���ͳ���ֵ piaoyun 2013-07-23////////////////////
  RC_PLAYOBJECT = 0;                                        // ���
  RC_HEROOBJECT = 1;                                        // Ӣ��
  RC_PLAYMOSTER = 150;                                      // ���ι��� JS-->60;
  RC_MOONOBJECT = 99;                                       // ����
  RC_GUARD = 11;                                            // ������
  RC_PEACENPC = 15;                                         // ��ƽNPC
  RC_ANIMAL = 50;                                           // ����NPC
  RC_MONSTER = 80;                                          // ����
  RC_NPC = 10;                                              // ��ͨNPC
  RC_ARCHERGUARD = 112;                                     // ������
  RC_TRUCKOBJECT = 128;                                     // Ѻ�ڳ�


//==============================================================================
// ------------------------------------------------------------------------------
// ------------------------------------------------------------------------------
// ------------------------------------------------------------------------------
// ------------------------------------------------------------------------------
  CM_QUERYUSERNAME = 80;                                    // ������Ϸ,���������ؽ�ɫ�����ͻ��� 47;
  CM_QUERYCHR = 100;                                        // ��¼�ɹ�,�ͻ����Գ����ҽ�ɫ����һ˲ 3000;
  CM_NEWCHR = 101;                                          // ������ɫ 3001;
  CM_DELCHR = 102;                                          // ɾ����ɫ 3002;
  CM_SELCHR = 103;                                          // ѡ���ɫ 3003;
  CM_SELECTSERVER = 104;                                    // ������,ע�ⲻ��ѡ��,ʢ��һ��������(����8��??group.dat������ôд��)��ֹһ���ķ����� 3004;
  CM_QUERYDELCHR = 105;                                     // ��ѯɾ�����Ľ�ɫ��Ϣ 3005;
  CM_GETBACKDELCHR = 3006;
  CM_GETBACKPASSWORD = 2010;                                // �����һ� 3007;
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
  CM_SPELL = 3017;                                          // ʩħ��
  CM_HORSERUN = 3009;                                       // ����
  CM_TURN = 3010;                                           // ת��(����ı�)
  CM_WALK = 3011;                                           // ��
  CM_SITDOWN = 3012;                                        // ��(����)
  CM_RUN = 3013;                                            // ��
  CM_HIT = 3014;                                            // ��ͨ���������
  CM_HEAVYHIT = 3015;                                       // ��������Ķ���
  CM_BIGHIT = 3016;                                         // ǿ��
  CM_POWERHIT = 3018;                                       // ��ɱ
  CM_LONGHIT = 3019;                                        // ��ɱ
  CM_WIDEHIT = 3024;                                        // ����
  CM_FIREHIT = 3025;                                        // �һ�
  CM_CRSHIT = 3036;                                         // ���µ� ˫��ն ID=40
  CM_TWNHIT = 3037;                                         // ��Ӱ����      ID=42

  // ���濪ʼ���¼���
  CM_43HIT = 3043;                                          // ��������     ID=43
  CM_SWORDHIT = 3056;                                       // ���ս���     ID=56
  // CM_114HIT = 3114;  // ��������  ID = 3114

  // ����������Ҫ���ԡ���֪����û������ 2013-07-13
  CM_60HIT = 3060;                                          // 18;                                //�ƻ�ն
  CM_61HIT = 3061;                                          // 19;                                //����ն
  CM_62HIT = 3062;                                          // 20;                                //����һ��

  CM_66HIT = 3066;                                          // ����ն


  CM_100HIT = 3100;                                         // ׷�Ĵ�
  CM_101HIT = 3101;                                         // ����ɱ
  CM_102HIT = 3102;                                         // ����ն
  CM_103HIT = 3103;                                         // ��ɨǧ��


  CM_DROPITEM = 1000;                                       // �Ӱ������ӳ���Ʒ����ͼ,��ʱ��������ڰ�ȫ�����ܻ���ʾ��ȫ���������Ӷ��� 48;
  CM_PICKUP = 1001;                                         // ���� 49;
  CM_TAKEONITEM = 1003;                                     // װ��װ�������ϵ�װ��λ�� 50;
  CM_TAKEOFFITEM = 1004;                                    // ������ĳ��װ��λ��ȡ��ĳ��װ�� 51;
  CM_EAT = 1006;                                            // ��ҩ 52;
  CM_BUTCH = 1007;                                          // �� 53;
  CM_MAGICKEYCHANGE = 1008;                                 // ħ����ݼ��ı� 54;

  // ���̵�NPC�������
  CM_CLICKNPC = 1010;                                       // �û������ĳ��NPC���н��� 55;
  CM_MERCHANTDLGSELECT = 1011;                              // ��Ʒѡ��,���� 56;
  CM_MERCHANTQUERYSELLPRICE = 1012;                         // ���ؼ۸�,��׼�۸�,����֪���̵��û��������Щ�������־û������� 57;
  CM_USERSELLITEM = 1013;                                   // �û������� 58;
  CM_USERBUYITEM = 1014;                                    // �û����붫�� 59;
  CM_USERGETDETAILITEM = 1015;                              // ȡ����Ʒ�嵥,������"���۽�ָ"����,�����һ�����۽�ָ����ѡ�� 60;
  CM_DROPGOLD = 1016;                                       // �û����½�Ǯ������ 61;
  CM_LOGINNOTICEOK = 1018;                                  // ������Ϸ�Ҹ����ȷʵ,������Ϸ 62;
  CM_GROUPMODE = 1019;                                      // ���黹�ǿ��� 63;
  CM_CREATEGROUP = 1020;                                    // �½���� 64;
  CM_ADDGROUPMEMBER = 1021;                                 // �������� 65;
  CM_DELGROUPMEMBER = 1022;                                 // ����ɾ�� 66;
  CM_USERREPAIRITEM = 1023;                                 // �û������� 67;
  CM_MERCHANTQUERYREPAIRCOST = 1024;                        // �ͻ�����NPCȡ��������� 68;
  CM_DEALTRY = 1025;                                        // ��ʼ����,���׿�ʼ 69;
  CM_DEALADDITEM = 1026;                                    // �Ӷ�����������Ʒ���� 70;
  CM_DEALDELITEM = 1027;                                    // �ӽ�����Ʒ���ϳ��ض���???��������Ŷ 71;
  CM_DEALCANCEL = 1028;                                     // ȡ������ 72;
  CM_DEALCHGGOLD = 1029;                                    // �����������Ͻ�ǮΪ0,,���н�Ǯ����,����˫�������������Ϣ 73;
  CM_DEALEND = 1030;                                        // ���׳ɹ�,��ɽ��� 74;
  CM_USERSTORAGEITEM = 1031;                                // �û��Ĵ涫�� 75;
  CM_USERTAKEBACKSTORAGEITEM = 1032;                        // �û��򱣹�Աȡ�ض��� 76;
  CM_WANTMINMAP = 1033;                                     // �û������"С��ͼ"��ť 77;
  CM_USERMAKEDRUGITEM = 1034;                               // �û����춾ҩ(������Ʒ) 78;
  CM_OPENGUILDDLG = 1035;                                   // �û������"�л�"��ť 79;
  CM_GUILDHOME = 1036;                                      // ���"�л���ҳ" 80;
  CM_GUILDMEMBERLIST = 1037;                                // ���"��Ա�б�" 81;
  CM_GUILDADDMEMBER = 1038;                                 // ���ӳ�Ա 82;
  CM_GUILDDELMEMBER = 1039;                                 // ���˳��л� 83;
  CM_GUILDUPDATENOTICE = 1040;                              // �޸��лṫ�� 84;
  CM_GUILDUPDATERANKINFO = 1041;                            // ����������Ϣ(ȡ����������) 85;
  CM_ADJUST_BONUS = 1043;                                   // �û��õ�����??˽���бȽ�����,С������ʱ��ó���Ǯ������,���Ǻ�ȷ��,//�󾭹����Եĸ��ֵ���֤ 86;
  CM_PASSWORD = 1105;                                       // 87;
  CM_SAY = 3030;                                            // ��ɫ���� 88;
  CM_QUERYUSERSTATE = 82;                                   // 89;
  CM_QUERYBAGITEMS = 81;                                    // ��ѯ������Ʒ 90;
  CM_OPENDOOR = 1002;                                       // ����,�����ߵ���ͼ��ĳ�����ŵ�ʱ 91;
  CM_SOFTCLOSE = 1009;                                      // �˳�����(��Ϸ����,��������Ϸ�д���,Ҳ����ʱѡ��ʱ�˳�) 92;
  CM_GUILDALLY = 1044;                                      // 93;
  CM_GUILDBREAKALLY = 1045;                                 // 94;
  // �������
  CM_GETSHOPITEMS = 95;
  CM_BUYSHOPITEM = 9002;                                    // 96;
  // ���а�
  CM_GETRANKING = 97;
  CM_GETMYRANKING = 98;
  // ������
  CM_OPENBOX = 99;                                          // Կ�׷���Կ�׿״�����
  CM_ROTATIONBOX = 100;                                     // ת������
  CM_SENDGETSELBOXITEM = 101;                               // ��ȡ�����Լ�ѡ�����Ʒ
  CM_SENDSELLGAMEGOLDDALITEM = 102;                         // Ԫ������װ��
  CM_SENDBUYGAMEGOLDDALITEM = 103;                          // ����Ԫ������װ��
  CM_SENDCANCELGAMEGOLDDALITEM = 104;                       // ȡ��Ԫ������װ��
  CM_OVERLAPITEM = 105;                                     // �ص���Ʒ
  CM_HEROOVERLAPITEM = 106;                                 // Ӣ�۰����ص���Ʒ
  CM_PACKAGEITEM = 107;                                     // �ֿ��ص���Ʒ
  CM_HEROPACKAGEITEM = 108;                                 // �ֿ�Ӣ�۰����ص���Ʒ
  CM_QUERYUSERSHOPS = 109;                                  // �����������
  CM_GETUSERSHOPS = 110;                                    // �������
  CM_QUERYUSERSHOPITEMS = 111;                              // ����ָ���û�������Ʒ
  CM_GETUSERSHOPITEMS = 112;                                // ����ָ���û�������Ʒ
  CM_SEARCHSHOPITEMS = 113;                                 // �����û�������Ʒ
  CM_SEARCHGETSHOPITEMS = 114;                              //
  CM_QUERYMYSHOPSELLINGITEMS = 115;                         // �����ҵĵ���������Ʒ
  CM_QUERYMYSHOPSELLEDITEMS = 116;                          // �����ҵĵ����Ѿ���Ʒ
  CM_QUERYMYSHOPSTORAGEITEMS = 117;                         // �����ҵĵ��ֿ̲���Ʒ
  CM_GETMYSHOPITEMS = 118;                                  // �����ҵĵ�����Ʒ
  CM_SENDADDTOMYSHOP = 119;
  CM_SENDCHANGEMYSHOPITEM = 120;
  CM_SENDMOVEMYSHOPITEM = 121;
  CM_QUERYSELECTSHOPINFO = 122;
  CM_SENDSHOPSTALLSTATUS = 123;
  CM_SENDBUYUSERSHOPITEM = 124;
  CM_SENDDELETESELLEDITEM = 125;
  CM_SENDUSERSPEEDING = 126;                                // �û�����
  CM_UPGRADEDLGITEM = 127;                                  // OK�Ի�����Ʒ
  CM_CANCELUPGRADEDLGITEM = 128;                            // ȡ���Ի�����Ʒ
  CM_CHALLENGETRY = 129;                                    // ��ս
  CM_CHALLENGEADDITEM = 130;                                // ������ս��Ʒ
  CM_CHALLENGEDELITEM = 131;                                // ɾ����ս��Ʒ
  CM_CHALLENGECANCEL = 132;                                 // ȡ����ս
  CM_CHALLENGECHGGOLD = 133;                                // �޸���ս���
  CM_CHALLENGECHGGAMEDIAMOND = 134;                         // �޸���ս���ʯ
  CM_CHALLENGEEND = 135;                                    // ��ʼ��ս
  CM_SENDUPGRADEDIALOG = 136;                               // ������ʯװ������
  CM_HELPBUTTONCLICK = 137;                                 // ���������ť
  CM_SENDPLEASEDRINK = 138;                                 // �������
  CM_SENDGIVENPCWINE = 139;                                 // ���Ͷ���
  CM_SENDSELECTFINGER = 140;                                // ����ѡ��ļ���ʯͷ��
  CM_SENDDRINK = 141;                                       // �Ⱦ�
  CM_SENDGETBACKHERO = 142;                                 // �û�ȡ�ؼĴ��Ӣ��                                  //
  CM_ASSESSMENTHERO = 143;                                  // ����Ӣ��
  CM_SENDHEROAUTOPRACTICE = 144;                            // ��ȷ��Ӣ���Զ�����
  CM_SENDACUPOINTCLICK = 145;                               // ���Ѩλ series=0 ���� series=1 Ӣ��
  CM_SENDTRAININGMERIDIANCLICK = 146;                       // �������� series=0 ���� series=1 Ӣ��
  CM_CONTINUOUSMAGIC = 147;                                 // ��ʼ��������
  CM_CHANGECONTINUOUSMAGICORDER = 148;                      // �ı�����ħ��˳��  ����˳��  series=0 ���� series=1 Ӣ��
  CM_SENDMODULEMD5 = 149;                                   // ��¼���ϴ���ģ��MD5
  CM_SENDSHOPNAME = 150;                                    // ��̯��������
  CM_HEROLOGON = 151;                                       // �ٻ�Ӣ��
  CM_HEROLOGOUT = 152;                                      // Ӣ���˳�
  CM_MASTERBAGTOHEROBAG = 153;                              // ���˰�����Ʒ�ŵ�Ӣ�۰���
  CM_HEROBAGTOMASTERBAG = 154;                              // Ӣ�۰�����Ʒ�ŵ����˰���
  CM_HEROTAKEONITEM = 155;                                  // Ӣ�۴�װ��
  CM_HEROTAKEOFFITEM = 156;                                 // Ӣ����װ��
  CM_HEROEAT = 157;                                         // Ӣ�۳�ҩ
  CM_HEROTARGET = 158;                                      // ����//Ident: 1105 Recog: 260806992 Param: 0 Tag: 32 Series: 0   Recog= ��������   Param=X  Tag=Y
  CM_HERODROPITEM = 159;                                    // Ӣ������Ʒ
  CM_HEROGROUPATTACK = 160;                                 // �ϻ�
  CM_HEROMAGICKEYCHANGE = 161;
  CM_HEROPROTECT = 162;
  CM_HEROM2STARTSHOPSTALL = 163;                            // ��ʼ��̯
  CM_HEROM2STOPSHOPSTALL = 164;                             // ֹͣ��̯
  CM_HEROM2BUYUSERSHOPITEM = 165;                           // �����̯��Ʒ
  CM_HEROM2ADDUSERSHOPITEM = 166;                           // ���Ӱ�̯��Ʒ
  CM_HEROM2DELUSERSHOPITEM = 167;                           // ɾ����̯��Ʒ
  CM_HEROM2SENDCLOSESHOP = 168;                             // �رչ����̯��Ʒ����

// ------------------------------------------------------------------------------
// ------------------------------------------------------------------------------
// ------------------------------------------------------------------------------
// ------------------------------------------------------------------------------
  SM_PASSWD_FAIL = 503;                                     // ��֤ʧ��,"��������֤ʧ��,��Ҫ���µ�¼"?? 1000;
  SM_NEWID_SUCCESS = 504;                                   // �������˺ųɹ� 1001;
  SM_NEWID_FAIL = 505;                                      // �������˺�ʧ�� 1002;
  SM_CHGPASSWD_SUCCESS = 506;                               // �޸�����ɹ� 1003;
  SM_CHGPASSWD_FAIL = 507;                                  // �޸�����ʧ�� 1004;
  SM_GETBACKPASSWD_SUCCESS = 508;                           // �����һسɹ� 1005;
  SM_GETBACKPASSWD_FAIL = 509;                              // �����һ�ʧ�� 1006;
  SM_QUERYCHR = 520;                                        // ���ؽ�ɫ��Ϣ���ͻ��� 1007;
  SM_NEWCHR_SUCCESS = 521;                                  // �½���ɫ�ɹ� 1008;
  SM_NEWCHR_FAIL = 522;                                     // �½���ɫʧ�� 1009;
  SM_DELCHR_SUCCESS = 523;                                  // ɾ����ɫ�ɹ� 1010;
  SM_DELCHR_FAIL = 524;                                     // ɾ����ɫʧ�� 1011;
  SM_STARTPLAY = 525;                                       // ��ʼ������Ϸ����(���˽�����Ϸ�Ҹ�������Ϸ����) 1012;
  SM_STARTFAIL = 526;                                       // ��ʼʧ��,�洫���������,��ʱѡ���ɫ,�㽡����Ϸ�Ҹ����� 1013; //SM_USERFULL
  SM_QUERYCHR_FAIL = 527;                                   // ���ؽ�ɫ��Ϣ���ͻ���ʧ��1014;
  SM_OUTOFCONNECTION = 528;                                 // �������������,ǿ���û����� 1027;
  SM_PASSOK_SELECTSERVER = 529;                             // ������֤�����������ȷ,��ʼѡ�� 1015;
  SM_SELECTSERVER_OK = 530;                                 // ѡ���ɹ� 1016;
  SM_NEEDUPDATE_ACCOUNT = 531;                              // 1017;
  SM_UPDATEID_SUCCESS = 532;                                // ���³ɹ� 1018;
  SM_UPDATEID_FAIL = 533;                                   // ����ʧ�� 1019;
  SM_QUERYDELCHR = 534;                                     // ����ɾ�����Ľ�ɫ 1020;
  SM_GETBAKCHAR_SUCCESS = 1021;                             // �һ�����ɹ�
  SM_GETBAKCHAR_FAIL = 1022;                                // �һ�����ʧ��
  SM_RANDOMCODE = 2007;                                     // 1023;
  SM_NEEDPASSWORD = 8004;                                   // 1024;
  SM_CERTIFICATION_SUCCESS = 500;                           // 1025;
  SM_CERTIFICATION_FAIL = 501;                              // 1026;
  SM_CHECKISMYSELFSERVER = 8889;

  SM_HORSERUN = 5;                                          // 1106;
  SM_TURN = 10;                                             // 1102; //ת��
  SM_WALK = 11;                                             // 1103; //��
  SM_SITDOWN = 12;                                          // 1104;
  SM_RUN = 13;                                              // 1105; //��
  SM_HIT = 14;                                              // 1107; //��
  SM_HEAVYHIT = 15;                                         // 1108; //
  SM_BIGHIT = 16;                                           // 1109; //
  SM_SPELL = 17;                                            // 1101; //ʹ��ħ��
  SM_POWERHIT = 18;                                         // 1110;
  SM_LONGHIT = 19;                                          // 1111; //��ɱ
  SM_WIDEHIT = 24;                                          // 1112; //����
  SM_FIREHIT = 8;                                           // 1113; //�һ�
  SM_CRSHIT = 25;                                           // 1114; //���µ� ˫��ն   ID=40
  SM_TWNHIT = 26;                                           // 1115; //��Ӱ����     ID=42

  /////սʿ////
  SM_43HIT = 43;                                            // ��������    ID=43
  SM_SWORDHIT = 56;                                         // ���ս���  ID=56
  /////////////

  // //// �ϻ�//////
  SM_60HIT = 1118;                                          // �ƻ�ն
  SM_61HIT = 1119;                                          // ����ն
  SM_62HIT = 1120;                                          // ����һ��
  // ////////////////
  SM_66HIT = 66;                                            // ����ն
  SM_100HIT = 1122;                                         // ׷�Ĵ�
  SM_101HIT = 9101;                                         // ����ɱ
  SM_102HIT = 9102;                                         // ����ն
  SM_103HIT = 9103;                                         // ��ɨǧ��

  SM_RUSH = 6;                                              // 1147;
  SM_RUSHKUNG = 7;                                          // 1148; //
  SM_BACKSTEP = 9;                                          // 1149;
  SM_DIGUP = 20;                                            // ����һ"��"һ"��",�������ڶ�����"��" 1150;
  SM_DIGDOWN = 21;                                          // �ڶ�����"��" 1151;
  SM_FLYAXE = 22;                                           // �ɸ�,����ͳ��Ĺ�����ʽ? 1152;
  SM_LIGHTING = 23;                                         // �������� 1153;
  SM_ALIVE = 27;                                            // ����??�����ָ 1154; //
  SM_MOVEFAIL = 28;                                         // �ƶ�ʧ��,�߶����ܶ� 1155; //
  SM_HIDE = 29;                                             // ����? 1156; //
  SM_DISAPPEAR = 30;                                        // ������Ʒ��ʧ 1157;
  SM_STRUCK = 31;                                           // �ܹ��� 1158; //����
  SM_DEATH = 32;                                            // �������� 1159;
  SM_SKELETON = 33;                                         // ʬ�� 1160;
  SM_NOWDEATH = 34;                                         // ��ɱ? 1161;
  SM_SPELL2 = 117;                                          // 1162;
  SM_HEAR = 40;                                             // ���˻���Ļ� 1163;
  SM_FEATURECHANGED = 41;                                   // 1164;
  SM_USERNAME = 42;                                         // 1165;
  SM_WINEXP = 44;                                           // ��þ��� 1166;
  SM_LEVELUP = 45;                                          // ����,���Ͻǳ���ī�̵��������� 1167;
  SM_DAYCHANGING = 46;                                      // ����������½ǵ�̫���������� 1168;
  SM_LOGON = 50;                                            // logon 1169;
  SM_NEWMAP = 51;                                           // �µ�ͼ?? 1170;
  SM_ABILITY = 52;                                          // �����ԶԻ���,F11 1171;
  SM_HEALTHSPELLCHANGED = 53;                               // ������ʹ����������� 1172;
  SM_MAPDESCRIPTION = 54;                                   // ��ͼ����,�л�ս��ͼ?��������?��ȫ����? 1173;
  SM_SYSMESSAGE = 100;                                      // ϵͳ��Ϣ,ʢ��һ�����,˽������ 1174;
  SM_GROUPMESSAGE = 101;                                    // ��������!! 1175;
  SM_CRY = 102;                                             // ���� 1176;
  SM_WHISPER = 103;                                         // ˽�� 1177;
  SM_GUILDMESSAGE = 104;                                    // �л�����!~ 1178;
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
  SM_OPENDOOR_OK = 612;                                     // ͨ�����ŵ�ɹ� //1195;
  SM_OPENDOOR_LOCK = 613;                                   // ���ֹ��ſ��Ƿ�����,��ǰʢ������ͨ��ȥ���µ���Ҫ5���ӿ�һ�� 1196;
  SM_CLOSEDOOR = 614;                                       // �û�����,�����йر� 1197;
  SM_TAKEON_OK = 615;                                       // 1198;
  SM_TAKEON_FAIL = 616;                                     // 1199;
  SM_TAKEOFF_OK = 619;                                      // 1200;
  SM_TAKEOFF_FAIL = 620;                                    // 1201;
  SM_SENDUSEITEMS = 621;                                    // 1202;
  SM_WEIGHTCHANGED = 622;                                   // 1203;
  SM_CLEAROBJECTS = 633;                                    // 1204;
  SM_CHANGEMAP = 634;                                       // ��ͼ�ı�,�����µ�ͼ 1205;
  SM_EAT_OK = 635;                                          // 1206;
  SM_EAT_FAIL = 636;                                        // 1207;
  SM_BUTCH = 637;                                           // Ұ��? 1208;
  SM_MAGICFIRE = 638;                                       // ������,��ǽ?? 1209;
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
  SM_CHANGELIGHT = 654;                                     // ���ظı� 1224;
  SM_LAMPCHANGEDURA = 655;                                  // ����־øı� 1225;
  SM_CHANGENAMECOLOR = 656;                                 // ������ɫ�ı�,����,����,����,���� 1226;
  SM_CHARSTATUSCHANGED = 657;                               // 1227;
  SM_SENDNOTICE = 658;                                      // ���ͽ�����Ϸ�Ҹ�(����) 1228;
  SM_GROUPMODECHANGED = 659;                                // ���ģʽ�ı� 1229;
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
  SM_STORAGE_FULL = 702;                                    // 1257;   // �ֿ�����
  SM_STORAGE_FAIL = 703;                                    // 1258;
  SM_SAVEITEMLIST = 704;                                    // 1259;
  SM_TAKEBACKSTORAGEITEM_OK = 705;                          // 1260;
  SM_TAKEBACKSTORAGEITEM_FAIL = 706;                        // 1261;
  SM_TAKEBACKSTORAGEITEM_FULLBAG = 707;                     // 1262;
  SM_AREASTATE = 708;                                       // ��Χ״̬ 1263;
  SM_MYSTATUS = 766;                                        // �ҵ�״̬,���һ������״̬,���Ƿ񱻶�,���˾�ǿ�ƻس� 1264;
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
  SM_SUBABILITY = 752;                                      // ���������ԶԻ��� 1273;
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
  SM_SPACEMOVE_HIDE = 800;                                  // ��ʿ��һ������ 1292;
  SM_SPACEMOVE_SHOW = 801;                                  // ��ʿ��һ���������Ϊ���� 1293;
  SM_RECONNECT = 802;                                       // ����������� 1294;
  SM_GHOST = 803;                                           // ʬ�����,��ħ��������Ч��? 1295;
  SM_SHOWEVENT = 804;                                       // ��ʾ�¼� 1296;
  SM_HIDEEVENT = 805;                                       // �����¼� 1297;
  SM_SPACEMOVE_HIDE2 = 806;                                 // 1298;
  SM_SPACEMOVE_SHOW2 = 807;                                 // 1299;
  SM_TIMECHECK_MSG = 810;                                   // ʱ�Ӽ��,����ͻ������� 1300;
  SM_ADJUST_BONUS = 811;                                    // 1301; //?
  SM_OPENHEALTH = 1100;                                     // 1302;
  SM_CLOSEHEALTH = 1101;                                    // 1303;
  SM_BREAKWEAPON = 1102;                                    // �������� 1304;
  SM_INSTANCEHEALGUAGE = 1103;                              // ʵʱ���� 1305;
  SM_CHANGEFACE = 1104;                                     // ����,���͸ı�? 1306;
  SM_VERSION_FAIL = 1106;                                   // �ͻ��˰汾��֤ʧ�� 1307;
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
  SM_GAMEGOLDNAME = 55;                                     // ��ͻ��˷�����Ϸ������,���� 1319;
  SM_GAMEPOINTNAME = 1320;                                  // ��ͻ��˷�����Ϸ������2 ,���ʯ,�������
  SM_GAMEGLORY = 1321;                                      // ��Ϸ����
  SM_SERVERCONFIG = 5007;                                   // 20002; //1322;
  SM_GETREGINFO = 8004;                                     // 20003; //1323;
  SM_MISSIONNPC = 1324;                                     // ��������NPC����
  SM_ATTATCKMODE = 1325;                                    // ���͹���ģʽ
  SM_BUYSHOPITEM_SUCCESS = 9003;                            // 1326;
  SM_BUYSHOPITEM_FAIL = 9004;                               // 1327;
  SM_SENGSHOPITEMS = 9001;                                  // SERIES 7 ÿҳ������    wParam ��ҳ�� 1328;

  SM_AUTOGOTOXY = 20101;                                    // 1338; //�Զ�Ѱ·

  SM_REPAIRFIRDRAGON_OK = 5059;                             // �޲�����֮�� �ɹ� 1367;
  SM_REPAIRFIRDRAGON_FAIL = 5060;                           // �޲�����֮�� ʧ�� 1368;
  SM_MAGICMOVE = 5354;                                      // ������һ��SM���������ʮ��һɱ�� -- piaoyun 2013-06-25

  SM_SENGRANKING = 1330;
  SM_SENGMYRANKING_FAIL = 1331;
  SM_SHOWBOX = 1332;                                        // ��ʾ����
  SM_OPENBOX_SUCCESS = 1333;                                // Կ����ȷ���俪��
  SM_OPENBOX_FAIL = 1334;
  SM_SENDGETBOXITEMINDEX = 1335;                            // ��ȡת����ѡ�����Ʒ���
  SM_TAKEONITEM = 1336;                                     // �Զ���װ��
  SM_TAKEOFFITEM = 1337;                                    // �Զ���װ��

  SM_CLICKNPCLABEL = 1339;                                  //
  SM_SERVERNAME = 1340;
  SM_HEROTAKEONITEM = 1341;                                 // Ӣ���Զ���װ��
  SM_HEROTAKEOFFITEM = 1342;                                // Ӣ���Զ���װ��
  SM_SENDGAMEGOLDDALITEM = 1343;                            // Ԫ������װ��
  SM_SELLGAMEGOLDDALITEM_OK = 1344;
  SM_SELLGAMEGOLDDALITEM_FAIL = 1345;
  SM_BUYGAMEGOLDDALITEM_OK = 1346;
  SM_BUYGAMEGOLDDALITEM_FAIL = 1347;
  SM_CANCELGAMEGOLDDEALITEM_OK = 1348;                      // ȡ��Ԫ������װ��
  SM_CANCELGAMEGOLDDEALITEM_FAIL = 1349;                    // ȡ��Ԫ������װ��
  SM_CANCELGAMEGOLDSELLITEM_OK = 1350;                      // ȡ��Ԫ������װ��
  SM_CANCELGAMEGOLDSELLITEM_FAIL = 1351;                    // ȡ��Ԫ������װ��
  SM_UNBINDLIST = 1352;
  SM_EFFECTIMAGELIST = 1353;                                // WIL�б�
  SM_PLAYEFFECT = 1354;                                     // ��������Ч��
  SM_SCREENEFFECT = 1355;
  SM_OVERLAPITEM_OK = 1356;                                 // �ص���Ʒ �ɹ�
  SM_OVERLAPITEM_FAIL = 1357;                               // �ص���Ʒ ʧ��
  SM_HEROOVERLAPITEM_OK = 1358;                             // Ӣ���ص���Ʒ �ɹ�
  SM_HEROOVERLAPITEM_FAIL = 1359;                           // Ӣ���ص���Ʒ ʧ��
  SM_PACKAGEITEM_OK = 1360;                                 // �ֿ��ص���Ʒ �ɹ�
  SM_PACKAGEITEM_FAIL = 1361;                               // �ֿ��ص���Ʒ ʧ��
  SM_HEROPACKAGEITEM_OK = 1362;                             // Ӣ�۷ֿ��ص���Ʒ �ɹ�
  SM_HEROPACKAGEITEM_FAIL = 1363;                           // Ӣ�۷ֿ��ص���Ʒ ʧ��
  SM_PLAYSOUND = 1364;
  SM_OPENBIGMERCHANTBIGDLG = 1365;
  SM_CLOSEBIGMERCHANTBIGDLG = 1366;
  SM_CHANGESPEED = 1369;                                    // ��Ϸ�ٶ�
  SM_QUERYUSERSHOPS = 1370;                                 // ��������������̽��
  SM_QUERYUSERSHOPITEMS = 1371;                             // ����ָ���û�������Ʒ
  SM_SEARCHSHOPITEMS = 1372;                                // �����������������Ʒ���
  SM_QUERYMYSHOPSELLINGITEMS = 1373;                        // �����ҵĵ���������Ʒ
  SM_QUERYMYSHOPSELLEDITEMS = 1374;                         // �����ҵĵ����Ѿ�������Ʒ
  SM_QUERYMYSHOPSTORAGEITEMS = 1375;                        // �����ҵĵ��ֿ̲���Ʒ
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
  SM_UPGRADEDLGITEM_TAKE = 1386;                            // �����ɹ�
  SM_UPGRADEDLGITEM_GIVE = 1387;                            // �����ɹ�
  SM_OPENUPGRADEDLG = 1388;                                 // ��ʾOK�Ի���
  SM_SENDUSERICON = 1389;
  SM_SENDWEBBROWSER = 1390;
  SM_SENDUSEREFFECT = 1391;
  SM_SENDSUPERSHILEDEFFECT = 1392;
  SM_SENDBLASTHIT = 1393;                                   // ����
  SM_SPECIALCMD = 1396;                                     // ��������
  SM_WEATHER = 1397;

  /////////////////��ս�����Ϣ���� piaoyun 2013-07-22//////////////////////////
  SM_CHALLENGETRY_FAIL = 1399;                              // ��սʧ��
  SM_CHALLENGEMENU = 1398;                                  // ����ս��Ѻ��Ʒ����;
  SM_CHALLENGEADDITEM_OK = 1400;                            // ������ӵ�Ѻ��Ʒ�ɹ�;
  SM_CHALLENGEADDITEM_FAIL = 1401;                          // ������ӵ�Ѻ��Ʒʧ��;
  SM_CHALLENGEDELITEM_OK = 1402;                            // ���ɾ����Ѻ��Ʒ�ɹ�;
  SM_CHALLENGEDELITEM_FAIL = 1403;                          // ���ɾ����Ѻ��Ʒʧ��;
  SM_CHALLENGECANCEL = 1404;                                // ���ȡ����ս;
  SM_CHALLENGEREMOTEADDITEM = 1405;                         // �������ӵ�Ѻ����Ʒ��,���ͻ�����ʾ;
  SM_CHALLENGEREMOTEDELITEM = 1406;                         // ����ɾ����Ѻ����Ʒ��,���ͻ�����ʾ;
  SM_CHALLENGECHGGOLD_OK = 1407;                            // �ı���ս��ҳɹ�
  SM_CHALLENGECHGGOLD_FAIL = 1408;                          // �ı���ս���ʧ��
  SM_CHALLENGECHGGAMEDIAMOND_OK = 1409;                     // �޸���ս���ʯ�ɹ�
  SM_CHALLENGECHGGAMEDIAMOND_FAIL = 1410;                   // �޸���ս���ʯʧ��
  SM_CHALLENGEREMOTECHGGOLD = 1411;                         // �޸ĶԷ���ս���
  SM_CHALLENGEREMOTECHGGAMEDIAMOND = 1412;                  // �޸ĶԷ���ս���ʯ
  SM_CHALLENGESUCCESS = 1413;                               // ��ս�ɹ�
  //////////////////////////////////////////////////////////////////////////////

  SM_OPENUPGRADEDIALOG = 1414;                              // �򿪰�����ʯװ�������Ի���
  SM_SENDUPGRADEDIALOG_OK = 1415;                           // ������ʯװ�������ɹ�
  SM_SENDUPGRADEDIALOG_FAIl = 1416;                         // ������ʯװ������ʧ��
  SM_HEARCOLOR = 1417;                                      // ���ﺰ����Ϣ��ɫ
  SM_SOFTCLOSE = 1418;

  /////////////////////�ƹ������Ϣ piaoyun 2013-07-22//////////////////////////
  SM_PLAYDRINKSAY = 1419;                                   // �ƹ�NPC�Ի�����Ϣ
  SM_USERPLAYDRINKITEM_OK = 1420;                           // �����Ʒ�ɹ�
  SM_USERPLAYDRINKITEM_FAIl = 1421;                         // �����Ʒʧ��
  SM_USERPLAYDRINK_OK = 1422;                               // ��NPC�ľ���ȷ ���Զ���
  SM_USERPLAYDRINK_FAIL = 1423;                             // ��NPC�ľƴ���
  SM_OPENPLAYDRINK = 1424;                                  // �򿪴���
  SM_CLOSEDRINK = 1425;                                     // �رվƹ�NPC�Ի���
  SM_DRINKUPDATEVALUE = 1426;                               // ���غȾ�
  SM_PLAYDRINKTODRINK = 1427;                               // ���͵��ͻ���˭Ӯ˭��
  SM_SENDUSERPLAYDRINK = 1428;                              // ������ƶԻ���

  SM_SENDSTORAGEHEROINFO = 1429;                            // Ӣ�ۼĴ���Ϣ   �ٻؼĴ��Ӣ��
  SM_SENDSTORAGEHEROINFOEX = 1430;                          // Ӣ�ۼĴ���Ϣ ����Ӣ��
  SM_ASSESSMENTHERO_OK = 1431;                              // ����Ӣ�۳��ɹ�
  SM_ASSESSMENTHERO_FAIL = 1432;                            // ����Ӣ�۳�ʧ��
  SM_SENDSHOWHEROAUTOPRACTICEDLG = 1433;                    // ��ʾӢ���Զ������Ի���
  SM_SENDHEROAUTOPRACTICE_OK = 1434;                        // Ӣ���Զ������ɹ�
  SM_SENDHEROAUTOPRACTICE_FAIL = 1435;                      // Ӣ���Զ�����ʧ��
  SM_REFABILNG = 1436;                                      // ˢ������
  SM_ABILITYNG = 1437;                                      // �ڹ�����
  SM_ABILITYALCOHOL = 1438;                                 // ������
  SM_ABILITYMERIDIANS = 1439;                               // ����
  SM_HEROABILITYNG = 1440;                                  // Ӣ���ڹ�����
  SM_HEROABILITYALCOHOL = 1441;                             // Ӣ�۾�����
  SM_HEROABILITYMERIDIANS = 1442;                           // Ӣ�۾���
  SM_OPENCOBWEBWINDING = 1443;                              // ֩������ס  ����
  SM_CLOSECOBWEBWINDING = 1444;                             // ֩������ס ��
  SM_LIGHTINGEX = 1445;
  SM_CONTINUOUSMAGICORDER = 1446;                           // ����˳��  series=0 ���� series=1 Ӣ��
  SM_CONTINUOUSMAGIC_OK = 1447;                             // ����ʼ��ʼ�����ɹ�
  SM_CONTINUOUSMAGIC_FAIL = 1448;                           // ����ʼ��ʼ����ʧ��
  SM_CANCONTINUOUSMAGIC = 1449;                             // �������� ��������ͼƬ��˸��ʾ
  SM_TRAININGNG = 1450;                                     // �Ƿ������ڹ��ķ� ������Ӧ��ʾ�ڹ��ķ�����  series=0 ���� series=1 Ӣ��
  SM_LEVELUPNG = 1451;                                      // �ڹ�����
  SM_STOPCONTINUOUSMAGIC = 1452;                            // ֹͣ����
  SM_MAPCANRUN = 1453;                                      // ���˴���״̬
  SM_PLUGFILE = 1454;                                       // �ͻ��˲��MD5 M2���͹������м��
  SM_MODULEMD5 = 1455;                                      // ������ģ��MD5
  SM_BLACKMODULEMD5 = 1456;                                 // ������ģ��MD5
  SM_SENDSHOPNAME = 1457;                                   // ��̯��������
  SM_MASTERBAGTOHEROBAG_OK = 1458;                          // ���˰�����Ʒ�ŵ�Ӣ�۰����ɹ�
  SM_MASTERBAGTOHEROBAG_FAIL = 1459;                        // ���˰�����Ʒ�ŵ�Ӣ�۰���ʧ��
  SM_HEROBAGTOMASTERBAG_OK = 1460;                          // Ӣ�۰�����Ʒ�ŵ����˰����ɹ�
  SM_HEROBAGTOMASTERBAG_FAIL = 1461;                        // Ӣ�۰�����Ʒ�ŵ����˰���ʧ��

  //////////////////////Ӣ�������Ϣ���� piaoyun 2013-07-23/////////////////////
  SM_HEROBAGCOUNT = 1462;                                   // Ӣ�۰�������
  SM_HEROLOGON = 1464;                                      // ��ȡӢ�� TMessageBodyWL ����Ӣ�۵�½Ч��
  SM_HEROLOYAL = 1465;                                      // ��ȡӢ���ҳ�  10001(��00.00%)
  SM_SENDMYHEROMAGIC = 1470;                                // ��ȡӢ��ħ��
  SM_HEROANGERVALUE = 1481;                                 // Ӣ��ŭֵ�ı� Ident: 916 Recog: 5 Param: 2 Tag: 102 Series: 0
  SM_HEROLOGOUT_OK = 1482;                                  // Ӣ���˳�OK
  SM_HEROCHANGEFACE = 1490;
  SM_HEROLOGON_OK = 1494;
  SM_HEROLOGOUT = 1463;                                     // ��ȡӢ�� TMessageBodyWL ����Ӣ���˳�Ч��
  SM_HEROABILITY = 1466;                                    // ��ȡӢ��Abil
  SM_HEROSUBABILITY = 1467;                                 // Ӣ��SUBABILITY
  SM_HEROBAGITEMS = 1468;                                   // ��ȡӢ�۰���     Tag:������Ʒ���� 2 Series: ����������10
  SM_SENDHEROUSEITEMS = 1469;                               // ��ȡӢ������װ��
  SM_HEROADDITEM = 1471;                                    // Ӣ�� Ident: 905 Recog: 738569296 Param: 0 Tag: 0 Series: 1   AddItem
  SM_HERODELITEM = 1472;                                    // Ӣ�� Ident: 906 Recog: 738569296 Param: 0 Tag: 0 Series: 1   delItem
  SM_HEROTAKEON_OK = 1473;                                  // Ӣ�۴�װ��OK Ident: 907 Recog: 742933632 Param: 0 Tag: 0 Series: 0
  SM_HEROTAKEON_FAIL = 1474;                                // Ӣ�۴�װ��FAIL
  SM_HEROTAKEOFF_OK = 1475;                                 // Ӣ����װ��OK
  SM_HEROTAKEOFF_FAIL = 1476;                               // Ӣ����װ��FAIL
  SM_HEROEAT_OK = 1477;                                     // Ӣ�۳�ҩOK
  SM_HEROEAT_FAIL = 1478;                                   // Ӣ�۳�ҩFAIL
  SM_HEROADDMAGIC = 1479;                                   // Ӣ������ħ��
  SM_HERODELMAGIC = 1480;                                   // Ӣ��ɾ��ħ��
  SM_HERODURACHANGE = 1483;                                 // Ӣ����Ʒ�־øı�
  SM_HERODROPITEM_SUCCESS = 1484;                           // Ӣ������ƷOK
  SM_HERODROPITEM_FAIL = 1485;                              // Ӣ������ƷFAIL
  SM_HEROLEVELUP = 1486;                                    // Ӣ������
  SM_HEROWINEXP = 1487;                                     // Ӣ�ۻ�ȡ����
  SM_HEROWEIGHTCHANGED = 1488;
  SM_HEROMAGIC_LVEXP = 1489;                                // Ӣ��ħ������
  SM_HEROUPDATEITEM = 1491;                                 // ����Ӣ����Ʒ
  SM_HERODELITEMS = 1492;                                   // ɾ��Ӣ����Ʒ 1492;
  SM_HEROCHANGEITEM = 1493;                                 // �ı�Ӣ����Ʒ

  SM_OPENMISSIONDLG = 1495;                                 // ��������־�Ի���
  SM_DELETEDELAYMESSAGE = 1496;                             // ɾ����ʱ��Ϣ

  /////////////////��HeroM2��̯��س���ֵ piaoyun 2013-07-23////////////////////
  SM_HEROM2ADDUSERSHOPITEM_OK = 1497;                       // ���Ӱ�̯��Ʒ�ɹ�
  SM_HEROM2ADDUSERSHOPITEM_FAIL = 1498;                     // ���Ӱ�̯��Ʒʧ��
  SM_HEROM2DELUSERSHOPITEM_OK = 1499;                       // ɾ����̯��Ʒ�ɹ�
  SM_HEROM2DELUSERSHOPITEM_FAIL = 1500;                     // ɾ����̯��Ʒʧ��
  SM_HEROM2DELUSERSHOPITEM = 1501;                          // ɾ����̯��Ʒ
  SM_HEROM2DELREMOTEUSERSHOPITEM = 1502;                    // ɾ����̯��Ʒ
  SM_HEROM2SENDSHOPITEM = 1503;                             // ��̯��Ʒ
  SM_HEROM2SENDCLOSESHOP = 1504;                            // �رչ����̯��Ʒ����
  SM_HEROM2SENDDRESSEFFECT = 1505;                          // ��̯��Ʒ�·���Ч
  //////////////////////////////////////////////////////////////////////////////

  SM_SENDFILTERITEMLIST = 1506;                             // ������Ʒ�б�
  SM_SENDITEMDESCLIST = 1507;                               // ��Ʒ�����б�
  SM_SENDTZITEMDESCLIST = 1508;
  SM_SENDACTIONMSG = 1509;                                  // m_boCanHit m_boCanSpell m_boCanWalk  m_boCanRun
  SM_SENDOPENSKILLTIME = 1510;                              // սʿ���ܿ�����ʣ��ʱ��

  SM_AUTOEAT_OK = 1511;                                     // �Զ���ҩ�ɹ�
  SM_AUTOEAT_FAIL = 1512;                                   // �Զ���ҩʧ��

  SM_HEROAUTOEAT_OK = 1513;                                 // Ӣ���Զ���ҩ�ɹ�
  SM_HEROAUTOEAT_FAIL = 1514;                               // Ӣ���Զ���ҩʧ��
  SM_NATIONMESSAGE = 1515;


  SM_ADDBUTTON = 1516;                                                                              // ���Ӱ�ť
  SM_DELBUTTON = 1517;                                                                              // ɾ����ť
  SM_SHOWPHANTOM = 1518;                                                                            // ��ʾ�Ŵ����Ӱ
  SM_CLOSEPHANTOM = 1519;                                                                           // �رշŴ����Ӱ
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
  //176   185   Ӣ�۰�  ������   ��������     �⴫   ����
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
    CreditPoint: Integer;                                   //����
    NewValue: array[0..20 - 1] of Byte;
//0������������ 1���ӹ����˺�  2�����˺����� 3ħ���˺�����  4����Ŀ�����  5�����˺����� 6������������  7����ħ������ 8ŭ���ָ����� 9�ϻ���������  10����Ŀ�걩��
  end;
  pTAbility = ^TAbility;


  TStdItemEffect = packed record
    FileIndex: SmallInt; // ��Ʒ����Ч�� �ļ���� 0
    ImageStart: Word; // ��Ʒ����Ч�� ��ȡλ��
    ImageCount: Byte; // ��Ʒ����Ч�� ��ȡ����
    IsDrawCenter: Boolean; // ���в���
    IsDrawNoBlend: Boolean; // ��͸������
    IsDrawBelow: Boolean; // �ײ����
    OffsetX: SmallInt; // ��Ʒ����Ч�� ΢��X
    OffsetY: SmallInt; // ��Ʒ����Ч�� ΢��Y
    Time: Word; // �����ٶ�
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
    OverLap: Word; // �Ƿ����ص���Ʒ
    Color: Byte; // ��Ʒ������ɫ
    Stock: Integer;
    Light: Integer; // ���ݿ�����Light�ֶ� piaoyun 2013-08-01

    Horse: Integer;
    Expand1: Integer;
    Expand2: Integer;
    Expand3: Integer;
    Expand4: Integer;
    Expand5: Integer;

    Elements: array[0..23] of Word;

    InsuranceCurrency: Integer;
    InsuranceGold: Integer;

    BagEffect: TStdItemEffect;  // �����е���Ʒ����Ч��
    BodyEffect: TStdItemEffect; // �ڹ�����Ʒ����Ч��
    Effect: Int64;              // ָ���Ϊ64λ 2021-01-05
  end;
  pTStdItem = ^TStdItem;


  // �Զ�����Ʒ������
  TUserItemProgress = packed record
    boOpen: Boolean;
    btNameColor: Byte;
    btCount: Byte;
    btShowType: Byte; // �����ϵ�ֵ��ʾ��ʽ(0:����ʾ; 1:�ٷֱ�; 2:��ֵ;)
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

  PUserItemProperty = ^TUserItemProperty;
  TUserItemProperty = packed record
    sText: string[128]; // NND,��64��Ҫ����128 2019-03-18 17:18:22
    btTextColor: Byte;
    Properties: array[0..ITEM_PROP_COUNT - 1] of TCustomProperty;
  end;

  // ��Ʒ��Դ
  TItemFormType = (ifUnknow {δ֪}, ifGM {GM����}, ifScript {�ű�}, ifShopBuy {�̵깺��}, ifMonDrop {��ֵ���}, ifSysGive {ϵͳ����}, ifMine {�ڿ�õ�}, ifBoxGive {����ȡ��}, ifButchItem {����õ�}, ifCaptureMon {��׽�õ�});

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

  TClientItem = packed record // OK
    s: TStdItem;
    MakeIndex: Integer;
    Dura: Word;
    DuraMax: Word;

    IsBind: Boolean; // �Ƿ��
    btFluteCount: Byte;

    btUpgradeCount: Byte; // ��������
    btHeroM2Light: Byte; // HeroM2 SetItemsLight

    btValue: array[0..13] of Integer; // ��������
    NewValue: array[0..30 - 1] of Word;

    Flutes: array[0..MAX_FLUTE_COUNT - 1] of TFluteInfo; // ���۱�ʯ��Ϣ         16

    Progress: array[0..1] of TUserItemProgress;

    CustomProperty: TUserItemProperty;

    ItemFrom: TUserItemFrom;
    wInsuranceCount: Word;
  end;
  PTClientItem = ^TClientItem;


  // ���＼�� Ӣ�ۼ��� �������� �ڹ��������ӷ��� �ڹ��������ӹ���
  TMagicAttr = (mtHum, mtHero, mtContinuous, mtDefense, mtAttack);

   TMagic_C = packed record
    MagicAttr: TMagicAttr;
    wMagicId: Word;
    sMagicName: string[ITEM_NAME_LEN];
    btEffectType: Byte;
    btEffect: Byte;
    wSpell: Word;
    MaxTrain: array[0..15] of Integer;
    btTrainLv: Byte;                // ��߿������ȼ�
    dwMagicDelayTime: LongWord;
    wDefSpell: Word;
    CanUpgrade: Integer;            // �Ƿ��������� chongchong 2013-12-06
    MaxUpgradeLevel: Integer;       // ���
  end;
  pTMagic_C = ^TMagic_C;

  TClientMagic = packed record // 84
    Key: AnsiChar;
    Level: Byte;
    NewLevel: Byte; // ����
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
    wRace: Word; // ����
    wWeapon: Word; // ����
    wWeaponSound: Word;     // �������� 2020-11-24 23:40:49
    wDress: Word; // �·�
    wShield: Word; // ���� chongchong 2013-09-16
    btGender: Byte;
    btJob: Byte;
    btHair: Byte;
    btHorseType: Byte;
    btCaseltGuild: Byte;  // 1=ɳ�л��Ա //2=ɳ�л�����
    boShopStall: Boolean; // ��̯
    btBodyColor: Byte;    // ������ɫ
    btShopStallDir: Byte;
    wDressEffType: Word;
    wDressEffType_30: Word;
    boDressEffNormalDraw: Boolean;
    boDressEffNoSex: Boolean;
    boDressEff_30NormalDraw: Boolean;
    boDressEff_30NoSex: Boolean;

    nChangeAppr: Integer;

    nWeaponEffectIndex: SmallInt; // ������Ч
    wWeaponEffectOffSet: Word;    // ������Чƫ��

    wDBWeaponEffectOffSet: Word;    // DB������Чƫ��

    nDressEffectIndex: SmallInt; // �·���Ч
    wDressEffectOffSet: Word; // �·���Чƫ��

    nShieldEffectIndex: SmallInt; // ������Ч
    wShieldEffectOffSet: Word; // ������Чƫ��

    boDressEffectNoBlend: Boolean; // �·���ͨ����
    boDressEffectNoSex: Boolean; // �·�������Ů
    //boDressEffect: Boolean;                                                                         // �·���Ч (ÿ�������8֡)

    boWeaponEffectNoBlend: Boolean; // ������ͨ����
    boWeaponEffectNoSex: Boolean; // ����������Ů

    boShieldEffectNoBlend: Boolean; // ������ͨ����
    boShieldEffectNoSex: Boolean; // ���Ʋ�����Ů

    nShieldAddEffectIndex: SmallInt; // ������Ч
    wShieldAddEffectOffSet: Word; // ������Чƫ��

    nDressAddEffectIndex: SmallInt; // �����·���Ч
    bDressAddEffectOrder: Byte; // �����·���Ч����˳��
    wDressAddEffectOffSet: Word; // �����·���Чƫ��
    wDressAddEffectCount: Word; // �����·���Ч����
    wDressAddEffectTime: Word; // �����·���Чʱ��
    boDressAddEffectNoBlend: Boolean; // �����·���Ч - ��ͨ����
    boDressAddEffectDrawCenter: Boolean;

    nMedalEffectIndex: SmallInt; // ѫ����Ч
    wMedalEffectOffSet: Word; // ѫ����Чƫ��
    boMedalEffectNoBlend: Boolean; // ѫ����ͨ����
    boMedalEffectNoSex: Boolean; // ѫ�²�����Ů

    btDoubleHumHorseType: Byte; // ���� - ˫�������� chongchong 2013-10-14
    boShowHorseWingsEffect: Boolean; // �Ƿ���ʾ������Ч chongchong 2013-10-16
    btHorseEffectType: Byte; // ����Ч���� chongchong 2015-10-24

    btHorseHum: Word; // ���� �������ϵ��������� chongchong 2013-10-17
    btHorseHumExpand: Byte; // ���� �������ϵ�����������չ chongchong 2014-09-24

    btHorseHair: Byte; // ���� �������ϵ�����ͷ�� chongchong 2013-10-17

    boShowFashion: Boolean; // ��ʾʱװ chongchong 2013-10-23
    boMagicShield: Boolean; // ʹ�û���װ�� chongchong 2014-04-07

    btReLevel: Integer; // ת���ȼ� chongchong 2014-05-07

    sActiveFengHaoName: string[ITEM_NAME_LEN]; // ����ķ���� chongchong 2014-05-25
    nActiveFengHaoID: Integer; // ����ķ��MakeIndex chongchong 2014-05-25
    dwActiveFengHaoLooks: Word; // ����ķ��Looks chongchong 2014-05-25
    btActiveFengHaoReserved: Byte;
    btActiveFengHaoColor: Byte; // ��������ɫ chongchong 2014-05-25

    boShowHair: Boolean;

    btCboDressUseDiyImage: Byte; // ����ʱ�·�ʹ���Զ�����Դ
    btCboWeaponUseDiyImage: Byte; // ����ʱ����ʹ���Զ�����Դ

    btOldHair: Byte; // ԭʼ���ͣ����㶷�һ�����
    boPlayMoster: Boolean; // �Ƿ�Ϊ���͹� chongchong 2015-09-19
  end;
  pTHumFeature = ^THumFeature;


  // ���ﱦ������
  THumBBType = (bbNo{���Ǳ���}, bbSlave{��ͨ����}, bbGamePet{���ﱦ��});
  TMonFeature = packed record
    wRaceImg: Word;         // RaceImg�ֶ�
    wWeapon: Word;          // ����
    wAppr: Word;            // �·�
    btBodyColor: Byte;    // ������ɫ
    btRace: Byte;           // �������ɫ���� (Race�ֶ�) (������TActor��)
    MonLevel: LongWord;
    HumBBType: THumBBType;  // ���ﱦ������ chongchong 2014-11-29
    IsExploreItem: Boolean; // �Ƿ��̽����
    IsDisableSimpleActor: Boolean;  // ��ֹ�����װ
  end;
  pTMonFeature = ^TMonFeature;

  // ��۽ṹ
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

  TClientGoods = record                                     // NPC��ǰ������Ʒ�б�
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

  TDropItem = record                                        // ������Ʒ
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

