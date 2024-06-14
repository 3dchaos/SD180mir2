unit PluginInterface;

{-------------------------------------------------------------------------------}
{
  M2Server����ӿ�

  �� �� ��: 1.5
  
  ��������: 2021-01-06

  ����ӿ�Լ������

    1: �����߼��ͱ������Գ�����BOOL�ͱ�ʾ

    2: ���д����ı��͵Ĳ�����Ϊ: Dest: PAnsiChar; var DestLen: DWORD ����ʽ

    3: ���нӿھ����ýṹ�壬�����ýṹ��ָ��

  ���¼�¼:

    1.1: 2018-03-23: ���η������������Ĳ���ӿ�

    1.2: 2018-03-27�����ӵ����ӿ�֧�� HookDecryptScriptFile

    1.3: 2018-04-02���޸Ľӿ��Լ�������������ԣ�ʹ�ӿڸ�Ϊ�淶
        a. �޸����нӿ��е�Boolean��ΪBOOL
        b. �޸����½ӿ�
           ���������޸ģ�Init, HookDecryptScriptFile, HookDecryptScriptLine(�޸�), HookGetVariableText(����)

    1.4: 2018-04-21 �޸Ļ�����غ���Integer ->  DWORD
          TPlayObject_IncGold
          TPlayObject_DecGold
          TPlayObject_IncGameGold
          TPlayObject_DecGameGold
          TPlayObject_IncGamePoint
          TPlayObject_DecGamePoint
          TPlayObject_IncGameDiamond
          TPlayObject_DecGameDiamond
          TPlayObject_IncGameGird
          TPlayObject_DecGameGird

    1.5 2021-01-06�������������͸�ΪNativeInt������֧��64λ
          TBaseObject_SendMsg
          TBaseObject_SendDelayMsg
          TBaseObject_SendRefMsg
          TBaseObject_SendUpdateMsg
          TPlayObject_SendDefMessage
          PluginTypeDef.TDefaultMessage
          ��ؽṹ���޸�

}
{-------------------------------------------------------------------------------}


interface

uses
  Windows, Classes, SysUtils, PluginTypeDef;

type
  TNotifyEventEx = procedure(Sender: _TObject); stdcall;

  //-------------------------------------------------------------------------------------------------------------------------------------------------------
  //---------------------------------------------- TMemory �ڴ���� ---------------------------------------------------------------------------------------
  //-------------------------------------------------------------------------------------------------------------------------------------------------------

  { �����ڴ� }
  TMemory_Alloc =
    function (Size: Integer): Pointer; stdcall;

  { �ͷ��ڴ� }
  TMemory_Free =
    procedure(P: Pointer); stdcall;

  { ���·����ڴ��С (�������ڴ�����ԭʼ�ڴ��ֵ) }
  TMemory_Realloc =
    procedure(P: Pointer; Size: Integer); stdcall;


  //-------------------------------------------------------------------------------------------------------------------------------------------------------
  //---------------------------------------------- TList �����б� -----------------------------------------------------------------------------------------
  //-------------------------------------------------------------------------------------------------------------------------------------------------------

  { �б��� }
  TList_Create =
    function (): _TList; stdcall;

  { �б��ͷ� }
  TList_Free =
    procedure(List: _TList); stdcall;

  { ȡ�б����� }
  TList_Count =
    function (List: _TList): Integer; stdcall;

  { ����б� }
  TList_Clear =
    procedure(List: _TList); stdcall;

  { ���Ԫ�� }
  TList_Add =
    procedure(List: _TList; Item: Pointer); stdcall;

  { ����Ԫ��}
  TList_Insert =
    procedure(List: _TList; Index: Integer; Item: Pointer); stdcall;

  { ����Ԫ��ɾ�� }
  TList_Remove =
     procedure(List: _TList; Item: Pointer); stdcall;

  { ��������ɾ�� }
  TList_Delete =
    procedure(List: _TList; Index: Integer); stdcall;

  { ȡ��Ԫ�� }
  TList_GetItem =
    function (List: _TList; Index: Integer): Pointer; stdcall;

  { ����Ԫ�� }
  TList_SetItem =
    procedure(List: _TList; Index: Integer; Item: Pointer); stdcall;

  { �õ�Ԫ�ص����� }
  TList_IndexOf =
    function (List: _TList; Item: Pointer): Integer; stdcall;

  { ����Ԫ�� }
  TList_Exchange =
    procedure(List: _TList; Index1, Index2: Integer); stdcall;

  { ���Ƶ���һ���б� }
  TList_CopyTo =
    procedure(Source, Dest: _TList); stdcall;

  //-------------------------------------------------------------------------------------------------------------------------------------------------------
  //---------------------------------------------- _TStringList �ı��б� --------------------------------------------------------------------------------------
  //-------------------------------------------------------------------------------------------------------------------------------------------------------

  { �����ı��б� }
  TStrList_Create =
    function (): _TStringList; stdcall;

  { �ͷ��ı��б�}
  TStrList_Free =
    procedure(Strings: _TStringList); stdcall;

  { �ж��Ƿ�ִ�Сд }
  TStrList_GetCaseSensitive =
    function (Strings: _TStringList): BOOL; stdcall;

  { �����Ƿ�ִ�Сд }
  TStrList_SetCaseSensitive =
    procedure(Strings: _TStringList; IsCaseSensitive: BOOL); stdcall;

  { �Ƿ����� }
  TStrList_GetSorted =
    function (Strings: _TStringList): BOOL; stdcall;

  { �����Ƿ��Զ����� }
  TStrList_SetSorted =
    procedure(Strings: _TStringList; Sorted: BOOL); stdcall;

  { �Ƿ��ظ�}
  TStrList_GetDuplicates =
    function (Strings: _TStringList): BOOL; stdcall;

  { �����Ƿ������ظ� }
  TStrList_SetDuplicates =
    procedure(Strings: _TStringList; Duplicates: BOOL); stdcall;

  { ȡ�ı����� }
  TStrList_Count =
    function (Strings: _TStringList): Integer; stdcall;

  { ȡ���������� }
  TStrList_GetText =
    function (Strings: _TStringList; Dest: PAnsiChar; var DestLen: DWORD): BOOL; stdcall;

  { �������� }
  TStrList_SetText =
    procedure(Strings: _TStringList; Src: PAnsiChar; SrcLen: DWORD); stdcall;

  { ���һ�� }
  TStrList_Add =
    procedure(Strings: _TStringList; S: PAnsiChar); stdcall;

  { ���һ�У��������а�һ������ }
  TStrList_AddObject =
    procedure(Strings: _TStringList; S: PAnsiChar; AObject: _TObject); stdcall;

  { ����һ�� }
  TStrList_Insert =
    procedure(Strings: _TStringList; Index: Integer; S: PAnsiChar); stdcall;

  { ����һ�У��������а�һ������ }
  TStrList_InsertObject =
    procedure(Strings: _TStringList; Index: Integer; S: PAnsiChar; AObject: _TObject); stdcall;

  { ����ָ���ı����� }
  TStrList_Remove =
    procedure(Strings: _TStringList; S: PAnsiChar); stdcall;

  { ɾ��ָ���ĵڼ���(������0��ʼ) }
  TStrList_Delete =
    procedure(Strings: _TStringList; Index: Integer); stdcall;

  { ȡһ�е����� }
  TStrList_GetItem =
    function (Strings: _TStringList; Index: Integer;
              Dest: PAnsiChar; var DestLen: DWORD): BOOL; stdcall;

  { ����ĳ�е����� }
  TStrList_SetItem =
    procedure(Strings: _TStringList; Index: Integer; S: PAnsiChar); stdcall;

  { ȡĳ�а󶨵Ķ��� }
  TStrList_GetObject =
    function (Strings: _TStringList; Index: Integer): _TObject; stdcall;

  { ����ĳ�еİ󶨶��� }
  TStrList_SetObject =
    procedure(Strings: _TStringList; Index: Integer; AObject: _TObject); stdcall;

  { �����ı��õ��е����� }
  TStrList_IndexOf =
    function (Strings: _TStringList; S: PAnsiChar): Integer; stdcall;

  { ���ݰ󶨶���õ������� }
  TStrList_IndexOfObject =
    function (Strings: _TStringList; AObject: _TObject): Integer; stdcall;

  { ���ֲ���ĳ�е����� (ÿ�е����ݱ����������) }
  TStrList_Find =
    function (Strings: _TStringList; S: PAnsiChar; var Index: Integer): BOOL; stdcall;

  { �������е����ݼ��󶨵Ķ��� }
  TStrList_Exchange =
    procedure(Strings: _TStringList; Index1, Index2: Integer); stdcall;

  { ���ļ����� }
  TStrLit_LoadFromFile =
    procedure(Strings: _TStringList; FileName: PAnsiChar); stdcall;

  { �浽�ļ� }
  TStrLit_SaveToFile =
    procedure(Strings: _TStringList; FileName: PAnsiChar); stdcall;

  { ���� }
  TStrList_CopyTo =
    procedure(Source, Dest: _TStringList); stdcall;

  //-------------------------------------------------------------------------------------------------------------------------------------------------------
  //---------------------------------------------- TMemStream �ڴ��� --------------------------------------------------------------------------------------
  //-------------------------------------------------------------------------------------------------------------------------------------------------------

  { �����ڴ��� }
  TMemStream_Create =
    function (): _TMemoryStream; stdcall;

  { �ͷ��ڴ��� }
  TMemStream_Free =
    procedure(Stream: _TMemoryStream); stdcall;

  { ȡ�ô�С }
  TMemStream_GetSize =
    function (Stream: _TMemoryStream): Int64; stdcall;

  { ���ô�С }
  TMemStream_SetSize =
    procedure(Stream: _TMemoryStream; NewSize: Integer); stdcall;

  { ��� }
  TMemStream_Clear =
    procedure(Stream: _TMemoryStream); stdcall;

  { ���ڴ��������ݶ�ȡ�� Buffer �� }
  TMemStream_Read =
    function (Stream: _TMemoryStream; Buffer: PAnsiChar; Count: Integer): Integer; stdcall;

  { ���ڴ���д������ }
  TMemStream_Write =
    function (Stream: _TMemoryStream; Buffer: PAnsiChar; Count: Integer): Integer; stdcall;

  { ָ�붨λ SeekOrigin: 0 (��ͷ��ʼ), 1 (��ǰλ�ÿ�ʼ), 2 (��β����ʼ) }
  TMemStream_Seek =
    function (Stream: _TMemoryStream; Offset: Integer; SeekOrigin: Word): Integer; stdcall;

  { ��ȡ�����ݵ��ڴ�ָ�� }
  TMemStream_Memory =
    function (Stream: _TMemoryStream): Pointer; stdcall;

  { ��ȡָ��λ�� }
  TMemStream_GetPosition =
    function (Stream: _TMemoryStream): Int64; stdcall;

  { ָ�붨λ (�����ڼ����ֽ�) }
  TMemStream_SetPosition =
    procedure(Stream: _TMemoryStream; Position: Int64); stdcall;

  { ���ļ����� }
  TMemStream_LoadFromFile =
    procedure(Stream: _TMemoryStream; FileName: PAnsiChar); stdcall;

  { ���浽�ļ� }
  TMemStream_SaveToFile =
    procedure(Stream: _TMemoryStream; FileName: PAnsiChar); stdcall;


  //-------------------------------------------------------------------------------------------------------------------------------------------------------
  //---------------------------------------------- TMenu �˵� ---------------------------------------------------------------------------------------------
  //-------------------------------------------------------------------------------------------------------------------------------------------------------

  { ��ȡ���˵� }
  TMenu_GetMainMenu =
    function (): _TMenuItem; stdcall;

  { ��ȡ���Ʋ˵� }
  TMenu_GetControlMenu =
    function (): _TMenuItem; stdcall;

  { ��ȡ�鿴�˵� }
  TMenu_GetViewMenu =
    function (): _TMenuItem; stdcall;

  { ��ȡѡ��˵� }
  TMenu_GetOptionMenu =
    function (): _TMenuItem; stdcall;

  { ��ȡ����˵� }
  TMenu_GetManagerMenu =
    function (): _TMenuItem; stdcall;

  { ��ȡ���߲˵� }
  TMenu_GetToolsMenu =
    function (): _TMenuItem; stdcall;

  { ��ȡ�����˵� }
  TMenu_GetHelpMenu =
    function (): _TMenuItem; stdcall;

  { ��ȡ����˵� }
  TMenu_GetPluginMenu =
    function (): _TMenuItem; stdcall;

  { ��ȡ�Ӳ˵����� }
  TMenu_Count =
    function (MenuItem: _TMenuItem): Integer; stdcall;

  { ��ȡĳ���Ӳ˵� }
  TMenu_GetItems =
    function (MenuItem: _TMenuItem; Index: Integer): _TMenuItem; stdcall;

  { ��Ӳ˵� }
  TMenu_Add =
    function (PlugID: NativeInt; MenuItem: _TMenuItem; Caption: PAnsiChar;
              Tag: Integer; OnClick: TNotifyEventEx): _TMenuItem; stdcall;

  { ����˵� }
  TMenu_Insert =
    function (PlugID: NativeInt; MenuItem: _TMenuItem; Index: Integer;
              Caption: PAnsiChar; Tag: Integer; OnClick: TNotifyEventEx): _TMenuItem; stdcall;

  { ��ȡ�˵����� }
  TMenu_GetCaption =
    function (MenuItem: _TMenuItem; Dest: PAnsiChar; var DestLen: DWORD): BOOL; stdcall;

  { ���ò˵�����}
  TMenu_SetCaption =
    procedure(MenuItem: _TMenuItem; Caption: PAnsiChar); stdcall;

  { ��ȡ�˵����� }
  TMenu_GetEnabled =
    function (MenuItem: _TMenuItem): BOOL; stdcall;

  { ���ò˵����� }
  TMenu_SetEnabled =
    procedure(MenuItem: _TMenuItem; Enabled: BOOL); stdcall;

  { ��ȡ�˵��ɼ� }
  TMenu_GetVisable =
    function (MenuItem: _TMenuItem): BOOL; stdcall;

  { ���ò˵��ɼ� }
  TMenu_SetVisable =
    procedure(MenuItem: _TMenuItem; Visible: BOOL); stdcall;

  { ��ȡ�˵�ѡ��״̬ }
  TMenu_GetChecked =
    function (MenuItem: _TMenuItem): BOOL; stdcall;

  { ���ò˵�ѡ��״̬ }
  TMenu_SetChecked =
    procedure(MenuItem: _TMenuItem; Checked: BOOL); stdcall;

  { ��ȡ�˵��Ƿ�Ϊ��ѡ }
  TMenu_GetRadioItem =
    function (MenuItem: _TMenuItem): BOOL; stdcall;

  { ���ò˵��Ƿ�Ϊ��ѡ }
  TMenu_SetRadioItem =
    procedure(MenuItem: _TMenuItem; IsRadioItem: BOOL); stdcall;

  { ��ȡ�˵���ѡ���� }
  TMenu_GetGroupIndex =
    function (MenuItem: _TMenuItem): Integer; stdcall;

  { ���ò˵���ѡ���� }
  TMenu_SetGroupIndex =
    procedure(MenuItem: _TMenuItem; Value: Integer); stdcall;

  { ��ȡ�������� }
  TMenu_GetTag =
    function (MenuItem: _TMenuItem): Integer; stdcall;

  { ���ø������� }
  TMenu_SetTag =
    procedure(MenuItem: _TMenuItem; Value: Integer); stdcall;

  //-------------------------------------------------------------------------------------------------------------------------------------------------------
  //---------------------------------------------- Ini����----------------------------------------------------------------------------------------
  //-------------------------------------------------------------------------------------------------------------------------------------------------------
  { ����Ini���� }
  TIniFile_Create =
    function (sFileName: PAnsiChar): _TIniFile; stdcall;

  { �ͷ�ini���� }
  TIniFile_Free =
    procedure(IniFile: _TIniFile); stdcall;

  { �ж������Ƿ���� }
  TIniFile_SectionExists =
    function (IniFile: _TIniFile; Section: PAnsiChar): BOOL; stdcall;

  { �жϼ��Ƿ���� }
  TIniFile_ValueExists =
    function (IniFile: _TIniFile; Section, Ident: PAnsiChar): BOOL; stdcall;

  { ��ȡ�ı� }
  TIniFile_ReadString =
    function (IniFile: _TIniFile; Section, Ident, Default: PAnsiChar;
              Dest: PAnsiChar; var DestLen: DWORD): BOOL; stdcall;
  { д���ı� }
  TIniFile_WriteString =
    procedure(IniFile: _TIniFile; Section, Ident, Value: PAnsiChar); stdcall;

  { ��ȡ���� }
  TIniFile_ReadInteger =
    function (IniFile: _TIniFile; Section, Ident: PAnsiChar; Default: Integer): Integer; stdcall;

  { д������ }
  TIniFile_WriteInteger =
    procedure(IniFile: _TIniFile; Section, Ident: PAnsiChar; Value: Integer); stdcall;

  { ��ȡ����ֵ }
  TIniFile_ReadBool =
    function (IniFile: _TIniFile; Section, Ident: PAnsiChar; Default: BOOL): BOOL; stdcall;

  { д�벼��ֵ }
  TIniFile_WriteBool =
    procedure(IniFile: _TIniFile; Section, Ident: PAnsiChar; Value: BOOL); stdcall;


  //-------------------------------------------------------------------------------------------------------------------------------------------------------
  //---------------------------------------------- _TMagicACList ���� --------------------------------------------------------------------------------------
  //-------------------------------------------------------------------------------------------------------------------------------------------------------

  { �����Ʒ��ٷֱ��б����� }
  TMagicACList_Count =
    function (List: _TMagicACList): Integer; stdcall;

  { ȡ����Ԫ�� }
  TMagicACList_GetItem =
    function (List: _TMagicACList; Index: Integer): PMagicACInfo; stdcall;

  { ���ݼ��ܵõ��Ʒ��ٷֱ���Ϣ }
  TMagicACList_FindByMagIdx =
    function (List: _TMagicACList; MagIdx: Integer): PMagicACInfo; stdcall;


  //-------------------------------------------------------------------------------------------------------------------------------------------------------
  //---------------------------------------------- TMapManager ��ͼ���� -----------------------------------------------------------------------------------
  //-------------------------------------------------------------------------------------------------------------------------------------------------------

  { ���ݵ�ͼ���õ���ͼ���� }
  TMapManager_FindMap =
    function (MapName: PAnsiChar): _TEnvirnoment; stdcall;

  { �õ���ͼ�б�; ����ֵ��ÿ��Ԫ��Ϊ��_TEnvirnoment }
  TMapManager_GetMapList =
    function (): _TList; stdcall;

  //-------------------------------------------------------------------------------------------------------------------------------------------------------
  //---------------------------------------------- TEnvir ��ͼ���� ----------------------------------------------------------------------------------------
  //-------------------------------------------------------------------------------------------------------------------------------------------------------

  { ��ͼ���� }
  TEnvir_GetMapName =
    function (Envir: _TEnvirnoment; Dest: PAnsiChar; var DestLen: DWORD): BOOL; stdcall;

  { ��ͼ���� }
  TEnvir_GetMapDesc =
    function (Envir: _TEnvirnoment; Dest: PAnsiChar; var DestLen: DWORD): BOOL; stdcall;

  { ��ͼ��� }
  TEnvir_GetWidth =
    function (Envir: _TEnvirnoment): Integer; stdcall;

  { ��ͼ�߶� }
  TEnvir_GetHeight =
    function (Envir: _TEnvirnoment): Integer; stdcall;

  { С��ͼ }
  TEnvir_GetMinMap =
    function (Envir: _TEnvirnoment): Integer; stdcall;

  { �Ƿ�����ͼ }
  TEnvir_IsMainMap =
    function (Envir: _TEnvirnoment): BOOL; stdcall;

  { ����ͼ�� }
  TEnvir_GetMainMapName =
    function (Envir: _TEnvirnoment; Dest: PAnsiChar; var DestLen: DWORD): BOOL; stdcall;

  { �Ƿ�̬�����ͼ }
  TEnvir_IsMirrMap =
    function (Envir: _TEnvirnoment): BOOL; stdcall;

  { ��̬�����ͼ����ʱ�� }
  TEnvir_GetMirrMapCreateTick =
    function (Envir: _TEnvirnoment): DWORD; stdcall;

  { ��̬�����ͼ���ʱ�� }
  TEnvir_GetMirrMapSurvivalTime =
    function (Envir: _TEnvirnoment): DWORD; stdcall;

  { ��̬��ͼ�˵��ĸ���ͼ }
  TEnvir_GetMirrMapExitToMap =
    function (Envir: _TEnvirnoment; Dest: PAnsiChar; var DestLen: DWORD): BOOL; stdcall;

  { ��̬�����ͼС��ͼ��� }
  TEnvir_GetMirrMapMinMap =
    function (Envir: _TEnvirnoment): Integer; stdcall;

  { ��̬�����ͼ�Ƿ�һֱ��ʾʱ�� }
  TEnvir_GetAlwaysShowTime =
    function (Envir: _TEnvirnoment): BOOL; stdcall;

  { �Ƿ񸱱���ͼ }
  TEnvir_IsFBMap =
    function (Envir: _TEnvirnoment): BOOL; stdcall;

  { ������ͼ�� }
  TEnvir_GetFBMapName =
    function (Envir: _TEnvirnoment; Dest: PAnsiChar; var DestLen: DWORD): BOOL; stdcall;

  { ������������ (0:���ѱ�������ְҵ; 1:������ְҵ�����Ѿ��ɽ�; 2:ֻ�����Լ�; 3:�����л����) }
  TEnvir_GetFBEnterLimit =
    function (Envir: _TEnvirnoment): Integer; stdcall;

  { ������ͼ�Ƿ񴴽� }
  TEnvir_GetFBCreated =
    function (Envir: _TEnvirnoment): BOOL; stdcall;

  { ������ͼ����ʱ�� }
  TEnvir_GetFBCreateTime =
    function (Envir: _TEnvirnoment): DWORD; stdcall;

  { ��ȡ��ͼ�Ƿ�����ĳ���� }
  { ���ͼ�в���: FIGHT4������ GetMapParam(Envir, 'FIGHT4')���򷵻�True }
  { ���ͼ�в�����INCGAMEGOLD(1/10)������ GetMapParam(Envir, 'INCGAMEGOLD')���򷵻�True }
  TEnvir_GetMapParam =
    function (Envir: _TEnvirnoment; Param: PAnsiChar): BOOL; stdcall;


  { ��ȡ��ͼ����ĳ����ֵ }
  { ���ͼ�в�����INCGAMEGOLD(1/10)������ GetMapParam(Envir, 'INCGAMEGOLD')���򷵻�1/10 }
  TEnvir_GetMapParamValue =
    function (Envir: _TEnvirnoment; Param: PAnsiChar; Dest: PAnsiChar; var DestLen: DWORD): BOOL; stdcall;

  { ��ͼ���Ƿ�ɴboFlag = Falseʱ�����жϸ�������Ƿ��н�ɫռ�� }
  TEnvir_CheckCanMove =
    function (Envir: _TEnvirnoment; nX, nY: Integer; boFlag: BOOL): BOOL; stdcall;

  { �жϵ�ͼ��������(nX, nY)Ϊ���У���nRangeΪ�뾶�ľ��η�Χ�ڣ��Ƿ���Obj���� }
  TEnvir_IsValidObject =
    function (Envir: _TEnvirnoment; nX, nY, nRange: Integer; AObject: _TObject): BOOL; stdcall;

  { ��ȡ��ͼ��ĳ�������Ʒ�б� }
  TEnvir_GetItemObjects =
    function (Envir: _TEnvirnoment; nX, nY: Integer; ObjectList: _TList): Integer; stdcall;

  { ��ȡ��ͼ��ĳ����Ľ�ɫ�б� }
  TEnvir_GetBaseObjects =
    function (Envir: _TEnvirnoment; nX, nY: Integer;
              IncDeathObject: BOOL; ObjectList: _TList): Integer; stdcall;

  { ��ȡ��ͼ��ĳ����������б� }
  TEnvir_GetPlayObjects =
    function (Envir: _TEnvirnoment; nX, nY: Integer;
              IncDeathObject: BOOL; ObjectList: _TList): Integer; stdcall;

  //-------------------------------------------------------------------------------------------------------------------------------------------------------
  //---------------------------------------------- M2������غ��� ----------------------------------------------------------------------------------------
  //-------------------------------------------------------------------------------------------------------------------------------------------------------

  { ȡM2�汾�� }
  TM2Engine_GetVersion =
    function (Dest: PAnsiChar; var DestLen: DWORD): BOOL; stdcall;

  { ȡ�汾�� }
  TM2Engine_GetVersionInt =
    function (): Integer; stdcall;

  { ȡ���������� }
  TM2Engine_GetMainFormHandle =
    function (): THandle; stdcall;

  { ������������� }
  TM2Engine_SetMainFormCaption =
    procedure(Caption: PAnsiChar); stdcall;

  { ����������Ŀ¼ }
  TM2Engine_GetAppDir =
    function (Dest: PAnsiChar; var DestLen: DWORD): BOOL; stdcall;
    
  { ��ȡ��������Ini���� (0:!Setup.txt; 1:String.ini }
  TM2Engine_GetGlobalIniFile =
    function (M2IniType: Integer): _TIniFile; stdcall;


  { ��������ļ���Ŀ¼ }
  {
    0: EnvirĿ¼;  1: ���Ŀ¼; 2: �л�Ŀ¼; 3: �л��ļ�; 4: �Ǳ�Ŀ¼; 5: �Ǳ��ļ�; 6: ��ͼĿ¼;
    7: ����Ŀ¼; 8: ����Ŀ¼; 9: �����ļ�; 10: �Զ������Ŀ¼; 11: �Զ��弼��Ŀ¼; 12: �Զ���NPCĿ¼
    13: ��Ʒ�������Ŀ¼; 14: ��Ʒ���������־Ŀ¼; 15: ��¼��־Ŀ¼
  }
  TM2Engine_GetOtherFileDir =
    function (M2FileType: Integer; Dest: PAnsiChar; var DestLen: DWORD): BOOL; stdcall;

  { M2�����Ϣ }
  TM2Engine_MainOutMessage =
    procedure(Msg: PAnsiChar; IsAddTime: BOOL); stdcall;

  { ��ȡȫ��I���� }
  TM2Engine_GetGlobalVarI =
    function (Index: Integer): Integer; stdcall;

  { ����ȫ��I���� }
  TM2Engine_SetGlobalVarI =
    function (Index: Integer; Value: Integer): BOOL; stdcall;

  { ��ȡȫ��G���� }
  TM2Engine_GetGlobalVarG =
    function (Index: Integer): Integer; stdcall;

  { ����ȫ��G���� }
  TM2Engine_SetGlobalVarG =
    function (Index: Integer; Value: Integer): BOOL; stdcall;

  { ��ȡȫ��A���� }
  TM2Engine_GetGlobalVarA =
    function (Index: Integer; Dest: PAnsiChar; var DestLen: DWORD): BOOL; stdcall;

  { ����ȫ��A���� }
  TM2Engine_SetGlobalVarA =
    function (Index: Integer; Value: PAnsiChar): BOOL; stdcall;

  { ���� }
  TM2Engine_EncodeBuffer =
    function (Src: PAnsiChar; SrcLen: DWORD; Dest: PAnsiChar; var DestLen: DWORD): BOOL; stdcall;

  { ���� }
  TM2Engine_DecodeBuffer =
    function (Src: PAnsiChar; SrcLen: DWORD; Dest: PAnsiChar; var DestLen: DWORD): BOOL; stdcall;

  { ѹ������ }
  TM2Engine_ZLibEncodeBuffer =
    function (Src: PAnsiChar; SrcLen: DWORD;  Dest: PAnsiChar; var DestLen: DWORD): BOOL; stdcall;

  { ѹ������ }
  TM2Engine_ZLibDecodeBuffer =
    function (Src: PAnsiChar; SrcLen: DWORD; Dest: PAnsiChar; var DestLen: DWORD): BOOL; stdcall;

  { ���� }
  TM2Engine_EncryptBuffer =
    function(Src: PAnsiChar; SrcLen: DWORD; Dest: PAnsiChar; var DestLen: DWORD): BOOL; stdcall;

  { ���� }
  TM2Engine_DecryptBuffer =
    function(Src: PAnsiChar; SrcLen: DWORD; Dest: PAnsiChar; var DestLen: DWORD): BOOL; stdcall;

  { ������ܣ���ͬ�ĵ��Եõ���ͬ�Ľ�� }
  TM2Engine_EncryptPassword =
    function (InData: PAnsiChar; OutData: PAnsiChar; var OutSize: DWORD): BOOL; stdcall;

  { ������� }
  TM2Engine_DecryptPassword =
    function (InData: PAnsiChar; OutData: PAnsiChar; var OutSize: DWORD): BOOL; stdcall;

  { ������ƷStdMode�õ���Ʒװ��λ�� }
  TM2Engine_GetTakeOnPosition =
    function (StdMode: Integer): Integer; stdcall;

  { �����Ʒ�Ƿ���ĳ�������� (TUserItem.btBindOption) }
  TM2Engine_CheckBindType =
    function (BindValue: Byte; BindType: Byte): BOOL; stdcall;

  { ������Ʒĳ�������� }
  TM2Engine_SetBindValue =
    procedure(var BindValue: Byte; BindType: Byte; Value: BOOL); stdcall;

  { ���ݵ��ֽ���ɫ�õ�RGB��ɫ }
  TM2Engine_GetRGB =
    function (Color: Byte): DWORD; stdcall;


  //-------------------------------------------------------------------------------------------------------------------------------------------------------
  //---------------------------------------------- TBaseObject���� ----------------------------------------------------------------------------------------
  //-------------------------------------------------------------------------------------------------------------------------------------------------------

  { ���� }
  TBaseObject_GetChrName =
    function (BaseObject: _TBaseObject; Dest: PAnsiChar; var DestLen: DWORD): BOOL; stdcall;

  { ��������(�����������Ӣ��) }
  TBaseObject_SetChrName =
    function (BaseObject: _TBaseObject; NewName: PAnsiChar): BOOL; stdcall;

  { ˢ�����Ƶ��ͻ��� }
  TBaseObject_RefShowName =
    procedure(BaseObject: _TBaseObject); stdcall;

  { ˢ��������ɫ PKPoint�ȸı�ʱ }
  TBaseObject_RefNameColor =
    procedure(BaseObject: _TBaseObject); stdcall;

  { ��ȡ�Ա� }
  TBaseObject_GetGender  =
    function (BaseObject: _TBaseObject): Byte; stdcall;

  { �����Ա� }
  TBaseObject_SetGender  =
    function (BaseObject: _TBaseObject; Gender: Byte): BOOL; stdcall;

  { ��ȡְҵ }
  TBaseObject_GetJob  =
    function (BaseObject: _TBaseObject): Byte; stdcall;

  { ����ְҵ }
  TBaseObject_SetJob  =
    function (BaseObject: _TBaseObject; Job: Byte): BOOL; stdcall;

  { ��ȡ���� }
  TBaseObject_GetHair  =
    function (BaseObject: _TBaseObject): Byte; stdcall;

  { ���÷��� }
  TBaseObject_SetHair  =
    procedure(BaseObject: _TBaseObject; Hair: Byte); stdcall;

  { ���ڵ�ͼ }
  TBaseObject_GetEnvir =
    function (BaseObject: _TBaseObject): _TEnvirnoment; stdcall;

  { ���ڵ�ͼ }
  TBaseObject_GetMapName =
    function (BaseObject: _TBaseObject; Dest: PAnsiChar; var DestLen: DWORD): BOOL; stdcall;

  { ����X }
  TBaseObject_GetCurrX =
    function (BaseObject: _TBaseObject): Integer; stdcall;

  { ����Y }
  TBaseObject_GetCurrY =
    function (BaseObject: _TBaseObject): Integer; stdcall;

  { ��ǰ���� }
  TBaseObject_GetDirection =
    function (BaseObject: _TBaseObject): Byte; stdcall;

  { �سǵ�ͼ }
  TBaseObject_GetHomeMap =
    function (BaseObject: _TBaseObject; Dest: PAnsiChar; var DestLen: DWORD): BOOL; stdcall;

  { �س�����X }
  TBaseObject_GetHomeX =
    function (BaseObject: _TBaseObject): Integer; stdcall;

  { �س�����Y }
  TBaseObject_GetHomeY =
    function (BaseObject: _TBaseObject): Integer; stdcall;

  { Ȩ�޵ȼ� }
  TBaseObject_GetPermission =
    function (BaseObject: _TBaseObject): Byte; stdcall;

  { ����Ȩ�޵ȼ� }
  TBaseObject_SetPermission =
    procedure(BaseObject: _TBaseObject; Value: Byte); stdcall;

  { �Ƿ����� }
  TBaseObject_GetDeath =
    function (BaseObject: _TBaseObject): BOOL; stdcall;

  { ����ʱ�� }
  TBaseObject_GetDeathTick =
    function (BaseObject: _TBaseObject): DWORD; stdcall;

  { �Ƿ����������� }
  TBaseObject_GetGhost =
    function (BaseObject: _TBaseObject): BOOL; stdcall;

  { ����ʱ�� }
  TBaseObject_GetGhostTick =
    function (BaseObject: _TBaseObject): DWORD; stdcall;

  { ɱ������� }
  TBaseObject_MakeGhost =
    procedure(BaseObject: _TBaseObject); stdcall;

  { ���� }
  TBaseObject_ReAlive =
    procedure (BaseObject: _TBaseObject); stdcall;

  { ���� }
  TBaseObject_GetRaceServer =
    function (BaseObject: _TBaseObject): Byte; stdcall;

  { Appr }
  TBaseObject_GetAppr =
    function (BaseObject: _TBaseObject): Word; stdcall;

  { RaceImg }
  TBaseObject_GetRaceImg =
    function (BaseObject: _TBaseObject): Byte; stdcall;

  { ״̬ }
  TBaseObject_GetCharStatus =
    function (BaseObject: _TBaseObject): Integer; stdcall;

  { ״̬�ı� }
  TBaseObject_SetCharStatus =
    procedure(BaseObject: _TBaseObject; Value: Integer); stdcall;

  { ����״̬�ı� }
  TBaseObject_StatusChanged =
    procedure(BaseObject: _TBaseObject); stdcall;

  { ��ȡ������ }
  TBaseObject_GetHungerPoint =
    function (BaseObject: _TBaseObject): Integer; stdcall;

  { ���ü����� }
  TBaseObject_SetHungerPoint =
    procedure(BaseObject: _TBaseObject; Value: Integer); stdcall;

  { �Ƿ�Ϊ�ڹ��� }
  TBaseobject_IsNGMonster =
    function (BaseObject: _TBaseObject): BOOL; stdcall;

  { �Ƿ���� }
  TBaseObject_IsDummyObject =
    function (BaseObject: _TBaseObject): BOOL; stdcall;

  { ��ȡ�Ӿ���Χ }
  TBaseObject_GetViewRange =
    function (BaseObject: _TBaseObject): Integer; stdcall;

  { �����Ӿ���Χ }
  TBaseObject_SetViewRange =
    procedure(BaseObject: _TBaseObject; Value: Integer); stdcall;

  { ԭʼ���� }
  TBaseObject_GetAbility =
    function (BaseObject: _TBaseObject; Dest: pTAbility): BOOL; stdcall;

  { �������� }
  TBaseObject_GetWAbility =
    function (BaseObject: _TBaseObject; Dest: pTAbility): BOOL; stdcall;

  { �������� }
  TBaseObject_SetWAbility =
    procedure(BaseObject: _TBaseObject; Value: pTAbility); stdcall;

  { �����б� }
  TBaseObject_GetSlaveList =
    function (BaseObject: _TBaseObject): _TList; stdcall;

  { ���� }
  TBaseObject_GetMaster =
    function (BaseObject: _TBaseObject): _TBaseObject; stdcall;

  { ���ϲ����� }
  TBaseObject_GetMasterEx =
    function (BaseObject: _TBaseObject): _TBaseObject; stdcall;

  { �Ƿ��޵�ģʽ }
  TBaseObject_GetSuperManMode =
    function (BaseObject: _TBaseObject): BOOL; stdcall;

  { �����޵�ģʽ }
  TBaseObject_SetSuperManMode =
    procedure(BaseObject: _TBaseObject; Value: BOOL); stdcall;

  { �Ƿ����ģʽ }
  TBaseObject_GetAdminMode =
    function (BaseObject: _TBaseObject): BOOL; stdcall;

  { ���ù���ģʽ }
  TBaseObject_SetAdminMode =
    procedure(BaseObject: _TBaseObject; Value: BOOL); stdcall;

  { ħ������ }
  TBaseObject_GetTransparent =
    function (BaseObject: _TBaseObject): BOOL; stdcall;

  { ����ħ������ }
  TBaseObject_SetTransparent =
    procedure(BaseObject: _TBaseObject; Value: BOOL); stdcall;

  { ����ģʽ }
  TBaseObject_GetObMode =
    function (BaseObject: _TBaseObject): BOOL; stdcall;

  { ��������ģʽ }
  TBaseObject_SetObMode =
    procedure(BaseObject: _TBaseObject; Value: BOOL); stdcall;

  { ʯ��ģʽ }
  TBaseObject_GetStoneMode =
    function (BaseObject: _TBaseObject): BOOL; stdcall;

  { ����ʯ��ģʽ }
  TBaseObject_SetStoneMode =
    procedure(BaseObject: _TBaseObject; Value: BOOL); stdcall;

  { �Ƿ����ƶ� }
  TBaseObject_GetStickMode =
    function (BaseObject: _TBaseObject): BOOL; stdcall;

  { ���ò����ƶ�ģʽ }
  TBaseObject_SetStickMode =
    procedure(BaseObject: _TBaseObject; Value: BOOL); stdcall;

  { �����Ƿ���� }
  TBaseObject_GetIsAnimal =
    function (BaseObject: _TBaseObject): BOOL; stdcall;

  { ���ù����Ƿ���� }
  TBaseObject_SetIsAnimal =
    procedure(BaseObject: _TBaseObject; Value: BOOL); stdcall;

  { �����Ƿ񲻵�װ�� }
  TBaseObject_GetIsNoItem =
    function (BaseObject: _TBaseObject): BOOL; stdcall;

  { ���������Ƿ񲻵�װ�� }
  TBaseObject_SetIsNoItem =
    procedure(BaseObject: _TBaseObject; Value: BOOL); stdcall;

  { �������� }
  TBaseObject_GetCoolEye =
    function (BaseObject: _TBaseObject): BOOL; stdcall;

  { ������������ }
  TBaseObject_SetCoolEye =
    procedure(BaseObject: _TBaseObject; Value: BOOL); stdcall;

  { ���� }
  TBaseObject_GetHitPoint =
    function (BaseObject: _TBaseObject): Word; stdcall;

  { �������� }
  TBaseObject_SetHitPoint =
    procedure(BaseObject: _TBaseObject; Value: Word); stdcall;

  { ���� }
  TBaseObject_GetSpeedPoint =
    function (BaseObject: _TBaseObject): Word; stdcall;

  { �������� }
  TBaseObject_SetSpeedPoint =
    procedure(BaseObject: _TBaseObject; Value: Word); stdcall;          

  { �����ٶ� }
  TBaseObject_GetHitSpeed =
    function (BaseObject: _TBaseObject): ShortInt; stdcall;

  { ���ù����ٶ� }
  TBaseObject_SetHitSpeed =
    procedure(BaseObject: _TBaseObject; Value: ShortInt); stdcall;

  { �ƶ��ٶ� }
  TBaseObject_GetWalkSpeed =
    function (BaseObject: _TBaseObject): Integer; stdcall;

  { �����ƶ��ٶ� }
  TBaseObject_SetWalkSpeed =
    procedure(BaseObject: _TBaseObject; Value: Integer); stdcall;

  { HP�ָ��ٶ� }
  TBaseObject_GetHPRecover =
    function (BaseObject: _TBaseObject): ShortInt; stdcall;

  { ����HP�ָ��ٶ� }
  TBaseObject_SetHPRecover =
    procedure(BaseObject: _TBaseObject; Value: ShortInt); stdcall;      

  { MP�ָ��ٶ� }
  TBaseObject_GetMPRecover =
    function (BaseObject: _TBaseObject): ShortInt; stdcall;

  { ����MP�ָ��ٶ� }
  TBaseObject_SetMPRecover =
    procedure(BaseObject: _TBaseObject; Value: ShortInt); stdcall;

  { �ж��ָ� }
  TBaseObject_GetPoisonRecover =
    function (BaseObject: _TBaseObject): ShortInt; stdcall;

  { �����ж��ָ� }
  TBaseObject_SetPoisonRecover =
    procedure(BaseObject: _TBaseObject; Value: ShortInt); stdcall;

  { ����� }
  TBaseObject_GetAntiPoison =
    function (BaseObject: _TBaseObject): Byte; stdcall;

  { ���ö���� }
  TBaseObject_SetAntiPoison =
    procedure(BaseObject: _TBaseObject; Value: Byte); stdcall;

  { ħ����� }
  TBaseObject_GetAntiMagic =
    function (BaseObject: _TBaseObject): ShortInt; stdcall;

  { ����ħ����� }
  TBaseObject_SetAntiMagic =
    procedure(BaseObject: _TBaseObject; Value: ShortInt); stdcall;

  { ���� }
  TBaseObject_GetLuck =
    function (BaseObject: _TBaseObject): Integer; stdcall;

  { �������� }
  TBaseObject_SetLuck =
    procedure(BaseObject: _TBaseObject; Value: Integer); stdcall;

  { ����ģʽ }
  TBaseObject_GetAttatckMode =
    function (BaseObject: _TBaseObject): Byte; stdcall;

  { ���ù���ģʽ }
  TBaseObject_SetAttatckMode =
    procedure(BaseObject: _TBaseObject; Value: Byte); stdcall;

  { ��ȡ�������� }
  TBaseObject_GetNation =
    function (BaseObject: _TBaseObject): Byte; stdcall;

  { ������������ }
  TBaseObject_SetNation =
    function (BaseObject: _TBaseObject; Nation: Byte): BOOL; stdcall;

   { ��ȡ�������� }
  TBaseObject_GetNationaName =
    function (BaseObject: _TBaseObject; Dest: PAnsiChar; var DestLen: DWORD): BOOL; stdcall;

  { �л� }
  TBaseObject_GetGuild =
    function (BaseObject: _TBaseObject): _TGuild; stdcall;

  { ���������л��еķ����� }
  TBaseobject_GetGuildRankNo =
    function (BaseObject: _TBaseObject): Integer; stdcall;

  { ���������л��еķ������� }
  TBaseobject_GetGuildRankName =
    function (BaseObject: _TBaseObject; Dest: PAnsiChar; var DestLen: DWORD): BOOL; stdcall;

  { �Ƿ�Ϊ�л��ϴ� }
  TBaseObject_IsGuildMaster =
    function (BaseObject: _TBaseObject): BOOL; stdcall;

  { �����ָ ������Ʒ:111 }
  TBaseObject_GetHideMode =
    function (BaseObject: _TBaseObject): BOOL; stdcall;

  TBaseObject_SetHideMode =
    procedure(BaseObject: _TBaseObject; Value: BOOL); stdcall;

  { ��Խ�ָ  ������Ʒ:113 }
  TBaseObject_GetIsParalysis =
    function (BaseObject: _TBaseObject): BOOL; stdcall;

  TBaseObject_SetIsParalysis =
    procedure(BaseObject: _TBaseObject; Value: BOOL); stdcall;

  { ��Լ��� }
  TBaseObject_GetParalysisRate =
    function (BaseObject: _TBaseObject): DWORD; stdcall;

  TBaseObject_SetParalysisRate =
    procedure(BaseObject: _TBaseObject; Value: DWORD); stdcall;

  { ħ����Խ�ָ  ������Ʒ:204 }
  TBaseObject_GetIsMDParalysis =
    function (BaseObject: _TBaseObject): BOOL; stdcall;

  TBaseObject_SetIsMDParalysis =
    procedure(BaseObject: _TBaseObject; Value: BOOL); stdcall;

  { ħ����Լ��� }
  TBaseObject_GetMDParalysisRate =
    function (BaseObject: _TBaseObject): DWORD; stdcall;

  TBaseObject_SetMDParalysisRate =
    procedure(BaseObject: _TBaseObject; Value: DWORD); stdcall;

  { ������ָ  ������Ʒ:205 }
  TBaseObject_GetIsFrozen =
    function (BaseObject: _TBaseObject): BOOL; stdcall;

  TBaseObject_SetIsFrozen =
    procedure(BaseObject: _TBaseObject; Value: BOOL); stdcall;

  { �������� }
  TBaseObject_GetFrozenRate =
    function (BaseObject: _TBaseObject): DWORD; stdcall;

  TBaseObject_SetFrozenRate =
    procedure(BaseObject: _TBaseObject; Value: DWORD); stdcall;

  { ������ָ  ������Ʒ:206 }
  TBaseObject_GetIsCobwebWinding =
    function (BaseObject: _TBaseObject): BOOL; stdcall;

  TBaseObject_SetIsCobwebWinding =
    procedure(BaseObject: _TBaseObject; Value: BOOL); stdcall;

  { �������� }
  TBaseObject_GetCobwebWindingRate =
    function (BaseObject: _TBaseObject): DWORD; stdcall;

  TBaseObject_SetCobwebWindingRate =
    procedure(BaseObject: _TBaseObject; Value: DWORD); stdcall;

  { ���鼸�� }
  TBaseObject_GetUnParalysisValue =
    function (Baseobject: _TBaseObject): DWORD; stdcall;

  TBaseObject_SetUnParalysisValue =
    procedure(Baseobject: _TBaseObject; Value: DWORD); stdcall;

  { ���ݼ���ȡ�����Ƿ���� }
  TBaseObject_GetIsUnParalysis =
    function (BaseObject: _TBaseObject): BOOL; stdcall;

  { �������� }
  TBaseObject_GetUnMagicShieldValue =
    function (BaseObject: _TBaseObject): DWORD; stdcall;

  TBaseObject_SetUnMagicShieldValue =
    procedure(BaseObject: _TBaseObject; Value: DWORD); stdcall;

  { ���ݼ���ȡ�����Ƿ������ }
  TBaseObject_GetIsUnMagicShield =
    function (BaseObject: _TBaseObject): BOOL; stdcall;

  { ������� }
  TBaseObject_GetUnRevivalValue =
    function (BaseObject: _TBaseObject): DWORD; stdcall;

  TBaseObject_SetUnRevivalValue =
    procedure(BaseObject: _TBaseObject; Value: DWORD); stdcall;

  { ���ݼ���ȡ�����Ƿ������ }
  TBaseObject_GetIsUnRevival =
    function (BaseObject: _TBaseObject): BOOL; stdcall;

  { �������� }
  TBaseObject_GetUnPosionValue =
    function (BaseObject: _TBaseObject): DWORD; stdcall;

  TBaseObject_SetUnPosionValue =
    procedure(BaseObject: _TBaseObject; Value: DWORD); stdcall;

  { ���ݼ���ȡ�����Ƿ���� }
  TBaseObject_GetIsUnPosion =
    function (BaseObject: _TBaseObject): BOOL; stdcall;

  { ���ջ��� }
  TBaseObject_GetUnTammingValue =
    function (BaseObject: _TBaseObject): DWORD; stdcall;

  TBaseObject_SetUnTammingValue =
    procedure(BaseObject: _TBaseObject; Value: DWORD); stdcall;

  { ���ݼ���ȡ�����Ƿ���ջ� }
  TBaseObject_GetIsUnTamming =
    function (BaseObject: _TBaseObject): BOOL; stdcall;

  { ����ǽ���� }
  TBaseObject_GetUnFireCrossValue =
    function (BaseObject: _TBaseObject): DWORD; stdcall;

  TBaseObject_SetUnFireCrossValue =
    procedure(BaseObject: _TBaseObject; Value: DWORD); stdcall;

  { ���ݼ���ȡ�����Ƿ����ǽ }
  TBaseObject_GetIsUnFireCross =
    function (BaseObject: _TBaseObject): BOOL; stdcall;

  { ���������� }
  TBaseObject_GetUnFrozenValue =
    function (BaseObject: _TBaseObject): DWORD; stdcall;

  TBaseObject_SetUnFrozenValue =
    procedure(BaseObject: _TBaseObject; Value: DWORD); stdcall;

  { ���ݼ���ȡ�����Ƿ������ }
  TBaseObject_GetIsUnFrozen =
    function (BaseObject: _TBaseObject): BOOL; stdcall;

  { ���������� }
  TBaseObject_GetUnCobwebWindingValue =
    function (BaseObject: _TBaseObject): DWORD; stdcall;

  TBaseObject_SetUnCobwebWindingValue =
    procedure(BaseObject: _TBaseObject; Value: DWORD); stdcall;

  { ���ݼ���ȡ�����Ƿ������ }
  TBaseObject_GetIsUnCobwebWinding =
    function (BaseObject: _TBaseObject): BOOL; stdcall;

  { ��ȡ��ǰ����Ŀ�� }
  TBaseObject_GetTargetCret =
    function (BaseObject: _TBaseObject): _TBaseObject; stdcall;

  { ���õ�ǰ����Ŀ�� }
  TBaseObject_SetTargetCret =
    procedure(BaseObject: _TBaseObject; TargetCret: _TBaseObject); stdcall;

  { ɾ����ǰ����Ŀ�� }
  TBaseObject_DelTargetCreat =
    procedure(BaseObject: _TBaseObject); stdcall;

  { ��˭���� }
  TBaseObject_GetLastHiter =
    function (BaseObject: _TBaseObject): _TBaseObject; stdcall;

  { ˭�þ��� }
  TBaseObject_GetExpHitter =
    function (BaseObject: _TBaseObject): _TBaseObject; stdcall;

  { ʩ���� }
  TBaseObject_GetPoisonHitter =
    function (BaseObject: _TBaseObject): _TBaseObject; stdcall;

  { ��ǰ�Ķ�����˭ }
  TBaseObject_GetPoseCreate =
    function (BaseObject: _TBaseObject): _TBaseObject; stdcall;

  { �Ƿ�Ϊ����Ŀ�� }
  TBaseObject_IsProperTarget =
    function (BaseObject, Target: _TBaseObject): BOOL; stdcall;

  { �Ƿ�Ϊ���� }
  TBaseObject_IsProperFriend =
    function (BaseObject, Target: _TBaseObject): BOOL; stdcall;

  { �ж϶�����ָ����Χ�� }
  TBaseObject_TargetInRange =
    function (BaseObject, Target: _TBaseObject; nX, nY, nRange: Integer): BOOL; stdcall;

  { ����Ϣ Int64 2021-01-06 }
  TBaseObject_SendMsg =
    procedure(BaseObject, Target: _TBaseObject; wIdent, wParam: Integer;
              nParam1, nParam2, nParam3: NativeInt; sMsg: PAnsiChar); stdcall;

  { ����ʱ��Ϣ  Int64 2021-01-06 }
  TBaseObject_SendDelayMsg =
    procedure(BaseObject, Target: _TBaseObject; wIdent, wParam: Integer;
              nParam1, nParam2, nParam3: NativeInt; sMsg: PAnsiChar; dwDelay: DWORD); stdcall;

  { ��ȫ����ҷ���Ϣ  Int64 2021-01-06 }
  TBaseObject_SendRefMsg =
    procedure(BaseObject: _TBaseObject; wIdent, wParam: Integer;
              nParam1, nParam2, nParam3: NativeInt; sMsg: PAnsiChar; dwDelay: DWORD); stdcall;

  { ���·���Ϣ  Int64 2021-01-06 }
  TBaseObject_SendUpdateMsg =
    procedure(BaseObject, Target: _TBaseObject; wIdent, wParam: Integer;
              nParam1, nParam2, nParam3: NativeInt; sMsg: PAnsiChar); stdcall;

  { ��������Ϣ }
  TBaseObject_SysMsg =
    function(BaseObject: _TBaseObject; sMsg: PAnsiChar;
              FColor, BColor: Byte; MsgType: Integer): BOOL; stdcall;

  { ������Ʒ }
  TBaseObject_GetBagItemList =
    function (BaseObject: _TBaseObject): _TList; stdcall;

  { ��ⱳ���Ƿ��� }
  TBaseObject_IsEnoughBag =
    function (BaseObject: _TBaseObject): BOOL; stdcall;

  { �����Ƿ����㹻�Ŀռ��ָ����������Ʒ }
  TBaseObject_IsEnoughBagEx =
    function (BaseObject: _TBaseObject; AddCount: Integer): BOOL; stdcall;

  { ����Ʒ������ }
  TBaseObject_AddItemToBag =
    function (BaseObject: _TBaseObject; UserItem: pTUserItem): BOOL; stdcall;

  { ɾ�������ڼ�����Ʒ }
  TBaseObject_DelBagItemByIndex =
    function (BaseObject: _TBaseObject; Index: Integer): BOOL; stdcall;

  { ����makeIndexɾ��������Ʒ }
  TBaseObject_DelBagItemByMakeIdx =
    function(BaseObject: _TBaseObject; MakeIndex: Integer; ItemName: PAnsiChar): BOOL; stdcall;

  { ����UserItemɾ��������Ʒ }
  TBaseObject_DelBagItemByUserItem =
    function(BaseObject: _TBaseObject; UserItem: pTUserItem): BOOL; stdcall;

  { ����ɫ�Ƿ��ڰ�ȫ�� }
  TBaseObject_IsInSafeZone =
    function (BaseObject: _TBaseObject): BOOL; stdcall;

  { ���������Ƿ��ڰ�ȫ���� }
  TBaseObject_IsPtInSafeZone =
    function (BaseObject: _TBaseObject; Envir: _TEnvirnoment; nX, nY: Integer): BOOL; stdcall;

  { ����ȼ�����(IsSysDef=True: ʹ��ϵͳĬ�ϵȼ�����; IsSysDef=False: ʹ���Զ���ȼ�����) }
  TBaseObject_RecalcLevelAbil =
    procedure(BaseObject: _TBaseObject; IsSysDef: BOOL); stdcall;

  { �������� }
  TBaseObject_RecalcAbil =
    procedure(BaseObject: _TBaseObject); stdcall;

  { ���㱳������ }
  TBaseObject_RecalcBagWeight =
    function (BaseObject: _TBaseObject): Integer; stdcall;

  { ָ���ȼ������¼���Ҫ����ֵ }
  TBaseObject_GetLevelExp =
    function (BaseObject: _TBaseObject; nLevel: Integer): DWORD; stdcall;

  { ���� }
  TBaseObject_HasLevelUp =
    procedure(BaseObject: _TBaseObject; nLevel: Integer); stdcall;


  { �Ӽ���������; IsDoChec = True,�жϼ��ܼӵ����� }
  { if TrainSkill(...) then
    begin
      if not CheckMagicLevelup(...) then
      begin
        MagicTranPointChanged(...);
      end;
    end;
  }
  TBaseObject_TrainSkill =
    function (BaseObject: _TBaseObject; UserMagic: pTUserMagic; nTranPoint: Integer; IsDoCheck: BOOL): BOOL; stdcall;

  { ��鼼���Ƿ����� }
  TBaseObject_CheckMagicLevelup =
    function (BaseObject: _TBaseObject; UserMagic: pTUserMagic): BOOL; stdcall;

  { ���ܵ�ĵ� }
  TBaseObject_MagicTranPointChanged =
    procedure(BaseObject: _TBaseObject; UserMagic: pTUserMagic); stdcall;

  { ��Ѫ }
  TBaseObject_DamageHealth =
    procedure(BaseObject: _TBaseObject; nDamage: Integer; StruckFrom: _TBaseObject); stdcall;

  { ����MP }
  TBaseObject_DamageSpell =
    procedure(BaseObject: _TBaseObject; nSpellPoint: Integer); stdcall;

  { ����HP/MP }
  TBaseObject_IncHealthSpell =
    procedure(BaseObject: _TBaseObject; nHP, nMP: Integer; SendChangedToClient: BOOL); stdcall;

  { ֪ͨ�ͻ���HP/MP�ı� }
  TBaseObject_HealthSpellChanged =
    procedure (BaseObject: _TBaseObject; dwDelay: DWORD); stdcall;

  { ֪ͨ�ͻ�����۸ı� }
  TBaseObject_FeatureChanged =
    procedure(BaseObject: _TBaseObject); stdcall;

  { ֪ͨ�ͻ��˸��ظı� }
  TBaseObject_WeightChanged =
    procedure(BaseObject: _TBaseObject); stdcall;

  { �����������˺�, nType = 1:�����������nType = 2:��ħ���ܷ��� }
   { MagicACInfo: ��������-->����ħ��-->�����Ʒ��ٷֱ��е���Ϣ }
  TBaseObject_GetHitStruckDamage =
    function (BaseObject: _TBaseObject; Target: _TBaseObject; nDamage: Integer;
              MagicACInfo:PMagicACInfo; nType: Integer): Integer; stdcall;

  { ������ħ���˺� }
  TBaseObject_GetMagStruckDamage =
    function(BaseObject: _TBaseObject; Target: _TBaseObject; nDamage: Integer): Integer; stdcall;

  { ���������� (Index: 0-9) }
  TBaseObject_GetActorIcon =
    function (BaseObject: _TBaseObject; Index: Integer; ActorIcon: pTActorIcon): BOOL; stdcall;

  { ���������� (Index: 0-9) }
  TBaseObject_SetActorIcon =
    function (BaseObject: _TBaseObject; Index: Integer; ActorIcon: pTActorIcon): BOOL; stdcall;

  { ˢ�¶��������� }
  TBaseObject_RefUseIcons =
    procedure(BaseObject: _TBaseObject); stdcall;

  { ˢ��Ч�� }
  TBaseObject_RefUseEffects =
    procedure(BaseObject: _TBaseObject); stdcall;

  { �ɵ�ָ����ͼ������ }
  TBaseObject_SpaceMove =
    procedure(BaseObject: _TBaseObject; sMapName: PAnsiChar; nX, nY: Integer; nInt: Integer); stdcall;

  { �ɵ�ָ����ͼ������� }
  TBaseObject_MapRandomMove =
    procedure(BaseObject: _TBaseObject; sMapName: PAnsiChar; nInt: Integer); stdcall;

  { �����Ƿ���ƶ� (����ԣ������״̬ʱ�������ƶ�) }
  TBaseObject_CanMove =
    function (BaseObject: _TBaseObject): BOOL; stdcall;

  { �Ƿ���Դ�һ����������һ���� }
  TBaseObject_CanRun =
    function (BaseObject: _TBaseObject; nCurrX, nCurrY, nX, nY: Integer): BOOL; stdcall;

  { ת�� }
  TBaseObject_TurnTo =
    procedure(BaseObject: _TBaseObject; btDir: Byte); stdcall;

  { ָ��������һ�� }
  TBaseObject_WalkTo =
    function (BaseObject: _TBaseObject; btDir: Byte; boFlag: BOOL): BOOL; stdcall;

  { ָ��������һ�� }
  TBaseObject_RunTo =
    function (BaseObject: _TBaseObject; btDir: Byte; boFlag: BOOL): BOOL; stdcall;

  { Ԥ��������ã������ط�δʹ�� }
  TBaseObject_PluginList =
    function (BaseObject: _TBaseObject): _TList; stdcall;

  //-------------------------------------------------------------------------------------------------------------------------------------------------------
  //---------------------------------------------- _TSmartObject ���󣬼̳�_TBaseObject ---------------------------------------------------------------------
  //-------------------------------------------------------------------------------------------------------------------------------------------------------

  { ��ȡ�����б� }
  TSmartObject_GetMagicList =
    function (SmartObject: _TSmartObject): _TList; stdcall;

  { ȡĳ��λ�õ�װ��; Index: 0-29 }
  TSmartObject_GetUseItem =
    function (SmartObject: _TSmartObject; Index: Integer; UserItem: pTUserItem): BOOL; stdcall;

  { ���κ�״̬ 0:δ����; 1:����; 2:���� }
  TSmartObject_GetJewelryBoxStatus  =
    function (SmartObject: _TSmartObject): Integer; stdcall;

  { �������κ�״̬ 0:δ����; 1:����; 2:���� }
  TSmartObject_SetJewelryBoxStatus  = procedure(SmartObject: _TSmartObject; Value: Integer); stdcall;

  { ȡ���κ���Ʒ; Index: 0-5 }
  TSmartObject_GetJewelryItem =
    function (SmartObject: _TSmartObject; Index: Integer; UserItem: pTUserItem): BOOL; stdcall;

  { �Ƿ���ʾ���Ӵ� }
  TSmartObject_GetIsShowGodBless =
    function (SmartObject: _TSmartObject): BOOL; stdcall;

  { ������ʾ���Ӵ� }
  TSmartObject_SetIsShowGodBless =
    procedure(SmartObject: _TSmartObject; Value: BOOL); stdcall;

  { ȡĳ�����Ӹ��ӵĿ���״̬ }
  TSmartObject_GetGodBlessItemsState =
    function (SmartObject: _TSmartObject; Index: Integer): BOOL; stdcall;

  { �������Ӹ��ӵĿ���״̬ }
  TSmartObject_SetGodBlessItemsState =
    procedure(SmartObject: _TSmartObject; Index: Integer; Value: BOOL); stdcall;

  { ȡ���Ӵ���Ʒ; Index: 0-11 }
  TSmartObject_GetGodBlessItem =
    function (SmartObject: _TSmartObject; Index: Integer; UserItem: pTUserItem): BOOL; stdcall;

  { ����б� }
  TSmartObject_GetFengHaoItems =
    function (SmartObject: _TSmartObject): _TList; stdcall;

  { ����ķ�� }
  TSmartObject_GetActiveFengHao =
    function (SmartObject: _TSmartObject): Integer; stdcall;
    
  { ���õ�ǰ������; -1���� }
  TSmartObject_SetActiveFengHao =
    procedure(SmartObject: _TSmartObject; FengHaoIndex: Integer); stdcall;

  { ˢ�»��ŵ��ͻ��� }
  TSmartObject_ActiveFengHaoChanged =
    procedure(SmartObject: _TSmartObject); stdcall;

  { ɾ����� }
  TSmartObject_DeleteFengHao =
    procedure(SmartObject: _TSmartObject; Index: Integer); stdcall;

  { ��շ�� }
  TSmartObject_ClearFengHao =
    procedure(SmartObject: _TSmartObject); stdcall;

  TSmartObject_GetMoveSpeed =
    function (SmartObject: _TSmartObject): SmallInt; stdcall;

  TSmartObject_SetMoveSpeed =
    procedure(SmartObject: _TSmartObject; Value: SmallInt); stdcall;

  TSmartObject_GetAttackSpeed =
    function (SmartObject: _TSmartObject): SmallInt; stdcall;

  TSmartObject_SetAttackSpeed =
    procedure(SmartObject: _TSmartObject; Value: SmallInt); stdcall;

  TSmartObject_GetSpellSpeed =
    function (SmartObject: _TSmartObject): SmallInt; stdcall;

  TSmartObject_SetSpellSpeed =
    procedure(SmartObject: _TSmartObject; Value: SmallInt); stdcall;

  { ˢ����Ϸ�ٶ� }
  TSmartObject_RefGameSpeed =
    procedure(SmartObject: _TSmartObject); stdcall;

  { �Ƿ���� }
  TSmartObject_GetIsButch =
    function (SmartObject: _TSmartObject): BOOL; stdcall;

  { �����Ƿ���� }
  TSmartObject_SetIsButch =
    procedure(SmartObject: _TSmartObject; Value: BOOL); stdcall;

  { �Ƿ�ѧ�ڹ� }
  TSmartObject_GetIsTrainingNG =
    function (SmartObject: _TSmartObject): BOOL; stdcall;

  TSmartObject_SetIsTrainingNG =
    procedure(SmartObject: _TSmartObject; Value: BOOL); stdcall;

   { �Ƿ�ѧ�ķ� }
  TSmartObject_GetIsTrainingXF  =
    function (SmartObject: _TSmartObject): BOOL; stdcall;

  TSmartObject_SetIsTrainingXF =
    procedure(SmartObject: _TSmartObject; Value: BOOL); stdcall;

  { ��4�������Ƿ��� }
  TSmartObject_GetIsOpenLastContinuous  =
    function (SmartObject: _TSmartObject): BOOL; stdcall;

  { ���ÿ�����4������ }
  TSmartObject_SetIsOpenLastContinuous  =
    procedure(SmartObject: _TSmartObject; Value: BOOL); stdcall;

  { ����˳�� Index:0-3 }
  TSmartObject_GetContinuousMagicOrder  =
    function (SmartObject: _TSmartObject; Index: Integer): Byte; stdcall;

  { ��������˳�� }
  TSmartObject_SetContinuousMagicOrder  =
    procedure(SmartObject: _TSmartObject; Index: Integer; Value: Byte); stdcall;

  { PK ���������飬��������͵��ȼ� }
  TSmartObject_GetPKDieLostExp  =
    function (SmartObject: _TSmartObject): DWORD; stdcall;

  TSmartObject_SetPKDieLostExp  =
    procedure(SmartObject: _TSmartObject; Value: DWORD); stdcall;

  { PK �������ȼ� }
  TSmartObject_GetPKDieLostLevel  =
    function (SmartObject: _TSmartObject): Integer; stdcall;
    
  TSmartObject_SetPKDieLostLevel  =
    procedure(SmartObject: _TSmartObject; Value: Integer); stdcall;

  { PK���� }
  TSmartObject_GetPKPoint =
    function (SmartObject: _TSmartObject): Integer; stdcall;

  TSmartObject_SetPKPoint =
    procedure(SmartObject: _TSmartObject; Value: Integer); stdcall;

  { ����PKֵ }
  TSmartObject_IncPKPoint =
    procedure(SmartObject: _TSmartObject; Value: Integer); stdcall;

  { ����PKֵ }
  TSmartObject_DecPKPoint =
    procedure(SmartObject: _TSmartObject; Value: Integer); stdcall;

  { PK�ȼ� }
  TSmartObject_GetPKLevel =
    function (SmartObject: _TSmartObject): Integer; stdcall;

  TSmartObject_SetPKLevel =
    procedure(SmartObject: _TSmartObject; Value: Integer); stdcall;          

  { ���ͽ�ָ ������Ʒ:112 }
  TSmartObject_GetIsTeleport =
    function (SmartObject: _TSmartObject): BOOL; stdcall;

  TSmartObject_SetIsTeleport =
    procedure(SmartObject: _TSmartObject; Value: BOOL); stdcall;

  { �����ָ ������Ʒ:114 }
  TSmartObject_GetIsRevival =
    function (SmartObject: _TSmartObject): BOOL; stdcall;

  TSmartObject_SetIsRevival =
    procedure(SmartObject: _TSmartObject; Value: BOOL); stdcall;

  { �����ָ: ������ }
  TSmartObject_GetRevivalTime =
    function (SmartObject: _TSmartObject): Integer; stdcall;

  TSmartObject_SetRevivalTime =
    procedure(SmartObject: _TSmartObject; Value: Integer); stdcall;

  { �����ָ ������Ʒ:115 }
  TSmartObject_GetIsFlameRing =
    function (SmartObject: _TSmartObject): BOOL; stdcall;

  TSmartObject_SetIsFlameRing =
    procedure(SmartObject: _TSmartObject; Value: BOOL); stdcall;

  { ������ָ ������Ʒ:116 }
  TSmartObject_GetIsRecoveryRing =
    function (SmartObject: _TSmartObject): BOOL; stdcall;

  TSmartObject_SetIsRecoveryRing =
    procedure(SmartObject: _TSmartObject; Value: BOOL); stdcall;

   { �����ָ ������Ʒ:118 }
  TSmartObject_GetIsMagicShield =
    function (SmartObject: _TSmartObject): BOOL; stdcall;

  TSmartObject_SetIsMagicShield =
    procedure(SmartObject: _TSmartObject; Value: BOOL); stdcall;

  { ������ָ(������) ������Ʒ:119 }
  TSmartObject_GetIsMuscleRing =
    function (SmartObject: _TSmartObject): BOOL; stdcall;

  TSmartObject_SetIsMuscleRing =
    procedure(SmartObject: _TSmartObject; Value: BOOL); stdcall;

  { �������� ������Ʒ:120 }
  TSmartObject_GetIsFastTrain =
    function (SmartObject: _TSmartObject): BOOL; stdcall;

  TSmartObject_SetIsFastTrain =
    procedure(SmartObject: _TSmartObject; Value: BOOL); stdcall;

  { ̽������ ������Ʒ:121 }
  TSmartObject_GetIsProbeNecklace =
    function (SmartObject: _TSmartObject): BOOL; stdcall;

  TSmartObject_SetIsProbeNecklace =
    procedure(SmartObject: _TSmartObject; Value: BOOL); stdcall;

  { ������Ʒ ������Ʒ:122, 124, 125 }
  TSmartObject_GetIsRecallSuite =
    function (SmartObject: _TSmartObject): BOOL; stdcall;

  TSmartObject_SetIsRecallSuite =
    procedure(SmartObject: _TSmartObject; Value: BOOL); stdcall;

  { ��װ�� ������Ʒ:126 - 129 }
  TSmartObject_GetIsPirit =
    function (SmartObject: _TSmartObject): BOOL; stdcall;

  TSmartObject_SetIsPirit =
    procedure(SmartObject: _TSmartObject; Value: BOOL); stdcall;

  { ������ָ ������Ʒ:140 }
  TSmartObject_GetIsSupermanItem =
    function (SmartObject: _TSmartObject): BOOL; stdcall;

  TSmartObject_SetIsSupermanItem =
    procedure(SmartObject: _TSmartObject; Value: BOOL); stdcall;

  { ������Ʒ ������Ʒ:141 }
  TSmartObject_GetIsExpItem =
    function (SmartObject: _TSmartObject): BOOL; stdcall;

  TSmartObject_SetIsExpItem =
    procedure(SmartObject: _TSmartObject; Value: BOOL); stdcall;

  { ������Ʒֵ ������Ʒ:141 }
  TSmartObject_GetExpItemValue =
    function (SmartObject: _TSmartObject): Real; stdcall;

  TSmartObject_SetExpItemValue =
    procedure(SmartObject: _TSmartObject; Value: Real); stdcall;

  { ������Ʒ���鱶�� (��Ʒװ��->��������->���鷭��->����) }
  TSmartObject_GetExpItemRate =
    function (SmartObject: _TSmartObject): Integer; stdcall;

  { ������Ʒ ������Ʒ:142 }
  TSmartObject_GetIsPowerItem =
    function (SmartObject: _TSmartObject): BOOL; stdcall;

  TSmartObject_SetIsPowerItem =
    procedure(SmartObject: _TSmartObject; Value: BOOL); stdcall;

  { ������Ʒֵ ������Ʒ:142 }
  TSmartObject_GetPowerItemValue =
    function (SmartObject: _TSmartObject): Real; stdcall;

  { ����������Ʒֵ ������Ʒ:142 }
  TSmartObject_SetPowerItemValue =
    procedure (SmartObject: _TSmartObject; Value: Real); stdcall;

  { ������Ʒ���鱶�� (��Ʒװ��->��������->��������->����) }
  TSmartObject_GetPowerItemRate =
    function (SmartObject: _TSmartObject): Integer; stdcall;

  { �лᴫ��װ�� ������Ʒ:145 }
  TSmartObject_GetIsGuildMove =
    function (SmartObject: _TSmartObject): BOOL; stdcall;

  TSmartObject_SetIsGuildMove =
    procedure(SmartObject: _TSmartObject; Value: BOOL); stdcall;

  { ���˽�ָ ������Ʒ 170 }
  TSmartObject_GetIsAngryRing =
    function (SmartObject: _TSmartObject): BOOL; stdcall;

  TSmartObject_SetIsAngryRing =
    procedure(SmartObject: _TSmartObject; Value: BOOL); stdcall;

  { ���ǽ�ָ }
  TSmartObject_GetIsStarRing =
    function (SmartObject: _TSmartObject): BOOL; stdcall;

  TSmartObject_SetIsStarRing =
    procedure(SmartObject: _TSmartObject; Value: BOOL); stdcall;

  { ������Ʒ }
  TSmartObject_GetIsACItem =
    function (SmartObject: _TSmartObject): BOOL; stdcall;

  TSmartObject_SetIsACItem =
    procedure(SmartObject: _TSmartObject; Value: BOOL); stdcall;

  { ����ֵ }
  TSmartObject_GetACItemValue =
    function (SmartObject: _TSmartObject): Real; stdcall;

  TSmartObject_SetACItemValue =
    procedure(SmartObject: _TSmartObject; Value: Real); stdcall;

  { ħ����Ʒ }
  TSmartObject_GetIsMACItem =
    function (SmartObject: _TSmartObject): BOOL; stdcall;

  TSmartObject_SetIsMACItem =
    procedure(SmartObject: _TSmartObject; Value: BOOL); stdcall;

  { ħ��ֵ }
  TSmartObject_GetMACItemValue =
    function (SmartObject: _TSmartObject): Real; stdcall;
    
  TSmartObject_SetMACItemValue =
    procedure(SmartObject: _TSmartObject; Value: Real); stdcall;

  { 171����������Ʒװ�� }
  TSmartObject_GetIsNoDropItem =
    function (SmartObject: _TSmartObject): BOOL; stdcall;

  TSmartObject_SetIsNoDropItem =
    procedure(SmartObject: _TSmartObject; Value: BOOL); stdcall;

  { 172����������Ʒװ�� }
  TSmartObject_GetIsNoDropUseItem =
    function (SmartObject: _TSmartObject): BOOL; stdcall;

  TSmartObject_SetIsNoDropUseItem =
    procedure(SmartObject: _TSmartObject; Value: BOOL); stdcall;

  { �ڹ����� }
  TSmartObject_GetNGAbility =
    function (SmartObject: _TSmartObject; AbilityNG: pTAbilityNG): BOOL; stdcall;

  TSmartObject_SetNGAbility =
    procedure(SmartObject: _TSmartObject; Value: pTAbilityNG); stdcall;

  { ������ }
  TSmartObject_GetAlcohol =
    function (SmartObject: _TSmartObject; AbilityAlcohol: pTAbilityAlcohol): BOOL; stdcall;

  TSmartObject_SetAlcohol =
    procedure(SmartObject: _TSmartObject; Value: PTAbilityAlcohol); stdcall;

  { �޸�����װ�� }
  TSmartObject_RepairAllItem =
    procedure(SmartObject: _TSmartObject); stdcall;

  { �Ƿ����㼼��ʹ������ }
  TSmartObject_IsAllowUseMagic =
    function (SmartObject: _TSmartObject; MagicID: Word): BOOL; stdcall;

  { ѡ���� }
  TSmartObject_SelectMagic  =
    function(SmartObject: _TSmartObject): Integer; stdcall;

  { ����Ŀ�� }
  TSmartObject_AttackTarget =
    function (SmartObject: _TSmartObject; MagicID: Word; AttackTime: DWORD): BOOL; stdcall;


  //-------------------------------------------------------------------------------------------------------------------------------------------------------
  //---------------------------------------------- TPlayObject ������󣬼̳�TSmartObject -----------------------------------------------------------------
  //-------------------------------------------------------------------------------------------------------------------------------------------------------
  { �ʻ��� }
  TPlayObject_GetUserID =
    function (Player: _TPlayObject; Dest: PAnsiChar; var DestLen: DWORD): BOOL; stdcall;

  { IP }
  TPlayObject_GetIPAddr =
    function (Player: _TPlayObject; Dest: PAnsiChar; var DestLen: DWORD): BOOL; stdcall;

  { IP������ }
  TPlayObject_GetIPLocal =
    function (Player: _TPlayObject; Dest: PAnsiChar; var DestLen: DWORD): BOOL; stdcall;

  { MAC }
  TPlayObject_GetMachineID =
    function (Player: _TPlayObject; Dest: PAnsiChar; var DestLen: DWORD): BOOL; stdcall;

  { �Ƿ������Ϸ��� }
  TPlayObject_GetIsReadyRun =
    function (Player: _TPlayObject): BOOL; stdcall;

  { ��¼ʱ�� }
  TPlayObject_GetLogonTime =
    function (Player: _TPlayObject; LogonTime: PSystemTime): BOOL; stdcall;

  { �ͻ��˰汾�� }
  TPlayObject_GetSoftVerDate  =
    function (Player: _TPlayObject): Integer; stdcall;

  { �ͻ������� (0:176; 1:185; 2:Ӣ�۰�; 3:������; 4:��������; 5:�⴫; 6:����) }
  TPlayObject_GetClientType =
    function (Player: _TPlayObject): Integer; stdcall;

  { �Ƿ�Ϊ�Ͽͻ��� (185���ݿͻ���) }
  TPlayObject_IsOldClient =
    function (Player: _TPlayObject): BOOL; stdcall;

  { �ͻ��˷ֱ��� �� }
  TPlayObject_GetScreenWidth =
    function (Player: _TPlayObject): Word; stdcall;

  { �ͻ��˷ֱ��� �� }
  TPlayObject_GetScreenHeight =
    function (Player: _TPlayObject): Word; stdcall;

  { �ͻ����Ӿ���Χ��С }
  TPlayObject_GetClientViewRange =
    function (Player: _TPlayObject): Word; stdcall;

  { ת���ȼ� }
  TPlayObject_GetRelevel =
    function (Player: _TPlayObject): Byte; stdcall;
  
  TPlayObject_SetRelevel =
    procedure(Player: _TPlayObject; Value: Byte); stdcall;

  { δ�������Ե� }
  TPlayObject_GetBonusPoint =
    function (Player: _TPlayObject): Integer; stdcall;
    
  TPlayObject_SetBonusPoint =
    procedure(Player: _TPlayObject; Value: Integer); stdcall;

  { �������Ե� }
  TPlayObject_SendAdjustBonus =
    procedure(Player: _TPlayObject); stdcall;

  { ����Ӣ���� }
  TPlayObject_GetHeroName =
    function (Player: _TPlayObject; Dest: PAnsiChar; var DestLen: DWORD): BOOL; stdcall;

  { ����Ӣ���� }
  TPlayObject_GetDeputyHeroName =
    function (Player: _TPlayObject; Dest: PAnsiChar; var DestLen: DWORD): BOOL; stdcall;

  { ����Ӣ��ְҵ }
  TPlayObject_GetDeputyHeroJob =
    function (Player: _TPlayObject): Byte; stdcall;

  { Ӣ�۶��� }
  TPlayObject_GetMyHero =
    function (Player: _TPlayObject): _THeroObject; stdcall;

  { �Ƿ���������Ӣ�� }
  TPlayObject_GetFixedHero =
    function (Player: _TPlayObject): BOOL; stdcall;

  { �ٻ�Ӣ�� }
  TPlayObject_ClientHeroLogOn =
    procedure(Player: _TPlayObject; IsDeputyHero: BOOL); stdcall;

  { Ӣ���Ƿ�Ĵ� }
  TPlayObject_GetStorageHero =
    function (Player: _TPlayObject): BOOL; stdcall;

  { ����Ӣ���Ƿ�Ĵ� }
  TPlayObject_GetStorageDeputyHero =
    function (Player: _TPlayObject): BOOL; stdcall;

  { �ֿ��Ƿ��� Index:�ֿ����(0-3); }
  TPlayObject_GetIsStorageOpen =
    function (Player: _TPlayObject; Index: Integer): BOOL; stdcall;

  TPlayObject_SetIsStorageOpen =
    procedure(Player: _TPlayObject; Index: Integer; Value: BOOL); stdcall;

  { ������� }
  TPlayObject_GetGold =
    function (Player: _TPlayObject): DWORD; stdcall;

  TPlayObject_SetGold =
    procedure(Player: _TPlayObject; Value: DWORD); stdcall;

  { �����������ɴ���� }
  TPlayObject_GetGoldMax =
    function (Player: _TPlayObject): DWORD; stdcall;

  { �ӽ�� }
  TPlayObject_IncGold =
    function (Player: _TPlayObject; Value: DWORD): BOOL; stdcall;

  { ����� }
  TPlayObject_DecGold =
    function (Player: _TPlayObject; Value: DWORD): BOOL; stdcall;

  { ֪ͨ�ͻ���ˢ�� (��ң�Ԫ��) }
  TPlayObject_GoldChanged =
    procedure(Player: _TPlayObject); stdcall;

  { Ԫ������ }
  TPlayObject_GetGameGold =
    function (Player: _TPlayObject): DWORD; stdcall;

  TPlayObject_SetGameGold =
    procedure(Player: _TPlayObject; Value: DWORD); stdcall;

  { ��Ԫ�� }
  TPlayObject_IncGameGold =
    procedure(Player: _TPlayObject; Value: DWORD); stdcall;

  { ��Ԫ�� }
  TPlayObject_DecGameGold =
    procedure(Player: _TPlayObject; Value: DWORD); stdcall;

  { ֪ͨ�ͻ���ˢ�� (Ԫ������Ϸ��) }
  TPlayObject_GameGoldChanged =
    procedure(Player: _TPlayObject); stdcall;

  { ��Ϸ�� }
  TPlayObject_GetGamePoint =
    function (Player: _TPlayObject): DWORD; stdcall;

  { ������Ϸ�� }
  TPlayObject_SetGamePoint =
    procedure(Player: _TPlayObject; Value: DWORD); stdcall;

  { ����Ϸ�� }
  TPlayObject_IncGamePoint =
    procedure(Player: _TPlayObject; Value: DWORD); stdcall;

  { ����Ϸ�� }
  TPlayObject_DecGamePoint =
    procedure(Player: _TPlayObject; Value: DWORD); stdcall;

  { ���ʯ }
  TPlayObject_GetGameDiamond =
    function (Player: _TPlayObject): DWORD; stdcall;
    
  TPlayObject_SetGameDiamond =
    procedure(Player: _TPlayObject; Value: DWORD); stdcall;

  { �ӽ��ʯ }
  TPlayObject_IncGameDiamond =
    procedure(Player: _TPlayObject; Value: DWORD); stdcall;

  { �����ʯ }
  TPlayObject_DecGameDiamond =
    procedure(Player: _TPlayObject; Value: DWORD); stdcall;

  { ֪ͨ�ͻ���ˢ�� (���ʯ�����) }
  TPlayObject_NewGamePointChanged =
    procedure(Player: _TPlayObject); stdcall;

  { ��� }
  TPlayObject_GetGameGird =
    function (Player: _TPlayObject): DWORD; stdcall;

  TPlayObject_SetGameGird =
    procedure(Player: _TPlayObject; Value: DWORD); stdcall;

  { ����� }
  TPlayObject_IncGameGird =
    procedure(Player: _TPlayObject; Value: DWORD); stdcall;

  { ����� }
  TPlayObject_DecGameGird =
    procedure(Player: _TPlayObject; Value: DWORD); stdcall;

  { ����Ϸ�� }
  TPlayObject_GetGameGoldEx =
    function (Player: _TPlayObject): Integer; stdcall;

  TPlayObject_SetGameGoldEx =
    procedure(Player: _TPlayObject; Value: Integer); stdcall;

  { ���� }
  TPlayObject_GetGameGlory =
    function (Player: _TPlayObject): Integer; stdcall;
    
  TPlayObject_SetGameGlory =
    procedure(Player: _TPlayObject; Value: Integer); stdcall;

  { ������ }
  TPlayObject_IncGameGlory =
    procedure(Player: _TPlayObject; Value: Integer); stdcall;

  { ������ }
  TPlayObject_DecGameGlory =
    procedure(Player: _TPlayObject; Value: Integer); stdcall;

  { ֪ͨ�ͻ���ˢ������ }
  TPlayObject_GameGloryChanged =
    procedure(Player: _TPlayObject); stdcall;

  { ��ֵ�� }
  TPlayObject_GetPayMentPoint =
    function (Player: _TPlayObject): Integer; stdcall;

  TPlayObject_SetPayMentPoint =
    procedure(Player: _TPlayObject; Value: Integer); stdcall;

  { ��Ա���� }
  TPlayObject_GetMemberType =
    function (Player: _TPlayObject): Integer; stdcall;

  TPlayObject_SetMemberType =
    procedure(Player: _TPlayObject; Value: Integer); stdcall;

  { ��Ա�ȼ� }
  TPlayObject_GetMemberLevel =
    function (Player: _TPlayObject): Integer; stdcall;

  TPlayObject_SetMemberLevel =
    procedure(Player: _TPlayObject; Value: Integer); stdcall;

  { ���׶� }
  TPlayObject_GetContribution =
    function (Player: _TPlayObject): Word; stdcall;

  TPlayObject_SetContribution =
    procedure(Player: _TPlayObject; Value: Word); stdcall;

  { �Ӿ��飬����Щ�������Զ�ˢ�¿ͻ��� }
  TPlayObejct_IncExp =
    procedure(Player: _TPlayObject; Value: DWORD); stdcall;

  { ����ı� }
  TPlayObject_SendExpChanged =
    procedure(Player: _TPlayObject); stdcall;

  { ���ڹ����飬���ô˺������Զ�ˢ�¿ͻ��� }
  TPlayObject_IncExpNG =
    procedure(Player: _TPlayObject; Value: DWORD); stdcall;

  { �ڹ�����ı� }
  TPlayObject_SendExpNGChanged =
    procedure(Player: _TPlayObject); stdcall;

  { ���Ӿ����龭�� }
  TPlayObject_IncBeadExp =
    procedure(Player: _TPlayObject; Value: DWORD; IsFromNPC: BOOL); stdcall;

  { P���� m_nVal  [0..999] }
  TPlayObject_GetVarP =
    function (Player: _TPlayObject; Index: Integer): Integer; stdcall;
  
  TPlayObject_SetVarP =
    procedure(Player: _TPlayObject; Index: Integer; Value: Integer); stdcall;

  { M���� m_nMval [0..999] }
  TPlayObject_GetVarM =
    function (Player: _TPlayObject; Index: Integer): Integer; stdcall;

  TPlayObject_SetVarM =
    procedure(Player: _TPlayObject; Index: Integer; Value: Integer); stdcall;

  { D���� m_DyVal [0..999] }
  TPlayObject_GetVarD =
    function (Player: _TPlayObject; Index: Integer): Integer; stdcall;

  TPlayObject_SetVarD =
    procedure(Player: _TPlayObject; Index: Integer; Value: Integer); stdcall;

  { U���� m_UVal [0..254] }
  TPlayObject_GetVarU =
    function (Player: _TPlayObject; Index: Integer): Integer; stdcall;

  TPlayObject_SetVarU =
    procedure(Player: _TPlayObject; Index: Integer; Value: Integer); stdcall;

  { T���� m_UVal [0..254] }
  TPlayObject_GetVarT =
    function (Player: _TPlayObject; Index: Integer;
              Dest: PAnsiChar; var DestLen: DWORD): BOOL; stdcall;

  TPlayObject_SetVarT =
    procedure(Player: _TPlayObject; Index: Integer; Value: PAnsiChar); stdcall;

  { N���� m_nInteger [0..999] }
  TPlayObject_GetVarN =
    function (Player: _TPlayObject; Index: Integer): Integer; stdcall;

  TPlayObject_SetVarN =
    procedure(Player: _TPlayObject; Index: Integer; Value: Integer); stdcall;

  { S���� m_sString [0..999] }
  TPlayObject_GetVarS =
    function (Player: _TPlayObject; Index: Integer;
              Dest: PAnsiChar; var DestLen: DWORD): BOOL; stdcall;

  TPlayObject_SetVarS =
    procedure(Player: _TPlayObject; Index: Integer; Value: PAnsiChar); stdcall;

  { �Զ��嶯̬�����б� (�����Ԫ��Ϊ pTDynamicVar) }
  TPlayObject_GetDynamicVarList = function (Player: _TPlayObject): _TList; stdcall;

  //m_IntegerList: TQuickList; { N }
  //m_StringList: TValueList; { S }

  TPlayObject_GetQuestFlagStatus =
    function (Player: _TPlayObject; nFlag: Integer): Integer; stdcall;

  TPlayObject_SetQuestFlagStatus =
    procedure(Player: _TPlayObject; nFlag: Integer; Value: Integer); stdcall;

  { �Ƿ����߹һ� }
  TPlayObject_IsOffLine =
    function (Player: _TPlayObject): BOOL; stdcall;

  { �Ƿ���ʦ�� }
  TPlayObject_IsMaster =
    function (Player: _TPlayObject): BOOL; stdcall;

  { ȡ��ʦ������ }
  TPlayObject_GetMasterName =
    function (Player: _TPlayObject; Dest: PAnsiChar; var DestLen: DWORD): BOOL; stdcall;

  { ʦ�� }
  TPlayObject_GetMasterHuman =
    function (Player: _TPlayObject): _TPlayObject; stdcall;

  { ����ɫΪͽ��ʱ��ͽ������ }
  TPlayObject_GetApprenticeNO =
    function (Player: _TPlayObject): Integer; stdcall;

  { ����ͽ���б� }
  TPlayObject_GetOnlineApprenticeList =
    function (Player: _TPlayObject): _TList; stdcall;

  { ����ͽ���б� (�����Ԫ��Ϊ pTMasterRankInfo) }
  TPlayObject_GetAllApprenticeList =
    function (Player: _TPlayObject): _TList; stdcall;

  { ȡ�ð������� }
  TPlayObject_GetDearName =
    function (Player: _TPlayObject; Dest: PAnsiChar; var DestLen: DWORD): BOOL; stdcall;

  { ���� }
  TPlayObject_GetDearHuman =
    function (Player: _TPlayObject): _TPlayObject; stdcall;

  { ������ }
  TPlayObject_GetMarryCount =
    function (Player: _TPlayObject): Byte; stdcall;

  { �ӳ� }
  TPlayObject_GetGroupOwner =
    function (Player: _TPlayObject): _TPlayObject; stdcall;

  { ��Ա�б� Item: ��Ա�� Objects: _TBaseObject}
  TPlayObject_GetGroupMembers =
    function (Player: _TPlayObject): _TStringList; stdcall;

  { ������¼ }
  TPlayObject_GetIsLockLogin =
    function (Player: _TPlayObject): BOOL; stdcall;

  TPlayObject_SetIsLockLogin =
    procedure(Player: _TPlayObject; Value: BOOL); stdcall;

  { �Ƿ�������� }
  TPlayObject_GetIsAllowGroup =
    function (Player: _TPlayObject): BOOL; stdcall;

  TPlayObject_SetIsAllowGroup =
    procedure(Player: _TPlayObject; Value: BOOL); stdcall;

  { �Ƿ�������غ�һ }
  TPlayObject_GetIsAllowGroupReCall =
    function (Player: _TPlayObject): BOOL; stdcall;

  TPlayObject_SetIsAllowGroupReCall =
    procedure(Player: _TPlayObject; Value: BOOL); stdcall;

  { �Ƿ������л��һ }
  TPlayObject_GetIsAllowGuildReCall =
    function (Player: _TPlayObject): BOOL; stdcall;

  TPlayObject_SetIsAllowGuildReCall =
    procedure(Player: _TPlayObject; Value: BOOL); stdcall;

  { ������ }
  TPlayObject_GetIsAllowTrading =
    function (Player: _TPlayObject): BOOL; stdcall;

  TPlayObject_SetIsAllowTrading =
    procedure(Player: _TPlayObject; Value: BOOL); stdcall;

  { ��ֹ�������� }
  TPlayObject_GetIsDisableInviteHorseRiding =
    function (Player: _TPlayObject): BOOL; stdcall;

  TPlayObject_SetIsDisableInviteHorseRiding =
    procedure(Player: _TPlayObject; Value: BOOL); stdcall;

  { �Ƿ���Ԫ������ }
  TPlayObject_GetIsGameGoldTrading =
    function (Player: _TPlayObject): BOOL; stdcall;

  TPlayObject_SetIsGameGoldTrading =
    procedure(Player: _TPlayObject; Value: BOOL); stdcall;

  { �Ϲ���û�е�¼���� }
  TPlayObject_GetIsNewServer =
    function (Player: _TPlayObject): BOOL; stdcall;

  { ���˵�����ʾ��Ϣ }
  TPlayObject_GetIsFilterGlobalDropItemMsg =
    function (Player: _TPlayObject): BOOL; stdcall;

  TPlayObject_SetIsFilterGlobalDropItemMsg =
    procedure(Player: _TPlayObject; Value: BOOL); stdcall;

  { ����SendCenterMsg }
  TPlayObject_GetIsFilterGlobalCenterMsg =
    function (Player: _TPlayObject): BOOL; stdcall;

  TPlayObject_SetIsFilterGlobalCenterMsg =
    procedure(Player: _TPlayObject; Value: BOOL); stdcall;

  { ����SendMsgȫ����Ϣ }
  TPlayObject_GetIsFilterGolbalSendMsg =
    function (Player: _TPlayObject): BOOL; stdcall;

  TPlayObject_SetIsFilterGolbalSendMsg =
    procedure(Player: _TPlayObject; Value: BOOL); stdcall;

  { �Ƿ������ }
  TPlayObject_GetIsPleaseDrink =
    function (Player: _TPlayObject): BOOL; stdcall;

  { ����ʱ�Ƶ�Ʒ�� }
  TPlayObject_GetIsDrinkWineQuality =
    function (Player: _TPlayObject): Integer; stdcall;

  TPlayObject_SetIsDrinkWineQuality =
    procedure(Player: _TPlayObject; Value: Integer); stdcall;

  { ����ʱ�ƵĶ��� }
  TPlayObject_GetIsDrinkWineAlcohol =
    function (Player: _TPlayObject): Integer; stdcall;

  TPlayObject_SetIsDrinkWineAlcohol =
    procedure(Player: _TPlayObject; Value: Integer); stdcall;

  { ���Ƿ�Ⱦ����� }
  TPlayObject_GetIsDrinkWineDrunk =
    function (Player: _TPlayObject): BOOL; stdcall;

  TPlayObject_SetIsDrinkWineDrunk =
    procedure(Player: _TPlayObject; Value: BOOL); stdcall;

  { �س� }
  TPlayObject_MoveToHome =
    procedure(Player: _TPlayObject); stdcall;

  { ������͵��سǵ�ͼ }
  TPlayObject_MoveRandomToHome =
    procedure(Player: _TPlayObject); stdcall;

  { �������� }
  TPlayObject_SendSocket =
    procedure(Player: _TPlayObject; DefMsg: pTDefaultMessage; sMsg: PAnsiChar); stdcall;

  { ������Ϣ  Int64 2021-01-06 }
  TPlayObject_SendDefMessage =
    procedure(Player: _TPlayObject; wIdent: Word; nRecog: Int64;
              nParam, nTag, nSeries: Word; sMsg: PAnsiChar); stdcall;

  TPlayObject_SendMoveMsg =
    procedure(Player: _TPlayObject; sMsg: PAnsiChar;
              btFColor, btBColor: Byte; nY: Word; nMoveCount: Integer;
              nFontSize: Integer; nMarqueeTime: Integer); stdcall;

  TPlayObject_SendCenterMsg =
    procedure(Player: _TPlayObject; sMsg: PAnsiChar;
              btFColor, btBColor: Byte; nTime: Integer); stdcall;

  TPlayObject_SendTopBroadCastMsg =
    function(Player: _TPlayObject; sMsg: PAnsiChar; btFColor, btBColor: Byte;
              nTime: Integer; MsgType: Integer): BOOL; stdcall;

  { ���װ���Ƿ�ɴ��� }
  TPlayObject_CheckTakeOnItems =
    function (Player: _TPlayObject; Where: Integer; StdItem: pTStdItem): BOOL; stdcall;

  { ����װ������ʱ��Ӧ�ļ��� }
  TPlayObject_ProcessUseItemSkill =
    procedure(Player: _TPlayObject; Where: Integer; StdItem: pTStdItem; IsTakeOn: BOOL); stdcall;

  { ��������װ���б� }
  TPlayObject_SendUseItems =
    procedure(Player: _TPlayObject); stdcall;

  { ����������Ʒ }
  TPlayObject_SendAddItem =
    procedure(Player: _TPlayObject; UserItem: pTUserItem); stdcall;

  { �ͻ���ɾ�������Ʒ 2020-01-20�޸� ��Ʒ����/MakeIndex/��Ʒ����/MakeIndex.... }
  TPlayObject_SendDelItemList =
    procedure(Player: _TPlayObject; Items: PAnsiChar; ItemsCount: Integer); stdcall;

  { �ͻ���ɾ����Ʒ }
  TPlayObject_SendDelItem =
    procedure(Player: _TPlayObject; UserItem: pTUserItem); stdcall;

  { �ͻ���ˢ����Ʒ }
  TPlayObject_SendUpdateItem =
    procedure(Player: _TPlayObject; UserItem: pTUserItem); stdcall;

  { �ͻ���ˢ��װ���־øı� }
  TPlayObject_SendItemDuraChange =
    procedure(Player: _TPlayObject; ItemWhere: Integer; UserItem: pTUserItem); stdcall;

  { ˢ�¿ͻ��˰��� }
  TPlayObject_SendBagItems =
    procedure(Plyaer: _TPlayObject); stdcall;

  { �������κ���Ʒ }
  TPlayObject_SendJewelryBoxItems =
    procedure(Player: _TPlayObject); stdcall;

  { �������Ӵ���Ʒ }
  TPlayObject_SendGodBlessItems =
    procedure(Player: _TPlayObject); stdcall;

  { ���Ӹ��� }
  TPlayObject_SendOpenGodBlessItem =
    procedure(Player: _TPlayObject; Index: Integer); stdcall;

  { ���Ӹ�ر� }
  TPlayObject_SendCloseGodBlessItem =
    procedure(Player: _TPlayObject; Index: Integer); stdcall;

  { ���ͼ����б� }
  TPlayObject_SendUseMagics =
    procedure(Player: _TPlayObject); stdcall;

  { ���ͼ������ }
  TPlayObject_SendAddMagic =
    procedure(Player: _TPlayObject; UserMagic: pTUserMagic); stdcall;

  { ���ͼ���ɾ�� }
  TPlayObject_SendDelMagic =
    procedure(Player: _TPlayObject; UserMagic: pTUserMagic); stdcall;

  { ���ͷ����Ʒ }
  TPlayObject_SendFengHaoItems =
    procedure(Player: _TPlayObject); stdcall;

  { ���ͷ������ }
  TPlayObject_SendAddFengHaoItem =
    procedure(Player: _TPlayObject; UserItem: PTUserItem); stdcall;

  { ���ͷ��ɾ�� }
  TPlayObject_SendDelFengHaoItem =
    procedure(Player: _TPlayObject; Index: Integer); stdcall;

  { ������·/�ܲ�ʧ�� }
  TPlayObject_SendSocketStatusFail =
    procedure(Player: _TPlayObject); stdcall;

  TPlayObject_PlayEffect =
    procedure(Player: _TPlayObject; nFileIndex, nImageOffset,
              nImageCount, nLoopCount, nSpeedTime: Integer;
              btDrawOrder: Byte; nOffsetX: Integer; nOffsetY: Integer); stdcall;

  { �Ƿ������ڹҹһ� }
  TPlayObject_IsAutoPlayGame =
    function (Player: _TPlayObject): BOOL; stdcall;

  { ��ʼ�ڹҹһ� }
  TPlayObject_StartAutoPlayGame =
    function (Player: _TPlayObject): BOOL; stdcall;

  { ֹͣ�ڹҹһ� }
  TPlayObject_StopAutoPlayGame =
    function (Player: _TPlayObject): BOOL; stdcall;

  //-------------------------------------------------------------------------------------------------------------------------------------------------------
  //---------------------------------------------- TDummyObject ���˶��󣬼̳�TPlayObject -----------------------------------------------------------------
  //-------------------------------------------------------------------------------------------------------------------------------------------------------

  { �����Ƿ�ʼ�һ� }
  TDummyObject_IsStart =
    function (Dummyer: _TDummyObject): BOOL; stdcall;

  { ���˿�ʼ�һ� }
  TDummyObject_Start =
    procedure(Dummyer: _TDummyObject); stdcall;

  { ����ֹͣ�һ� }
  TDummyObject_Stop =
    procedure(Dummyer: _TDummyObject); stdcall;


  //-------------------------------------------------------------------------------------------------------------------------------------------------------
  //---------------------------------------------- THeroObject Ӣ�۶��󣬼̳�TSmartObject -----------------------------------------------------------------
  //-------------------------------------------------------------------------------------------------------------------------------------------------------

  { ����ģʽ }
  THeroObject_GetAttackMode =
    function (Hero: _THeroObject): Byte; stdcall;

  THeroObject_SetAttackMode =
    function (Hero: _THeroObject; Value: Byte; ShowSysMsg: BOOL): BOOL; stdcall;

  { �л���һ������ģʽ }
  THeroObject_SetNextAttackMode =
    procedure(Hero: _THeroObject); stdcall;

  { ��ȡ�������� }
  THeroObject_GetBagCount =
    function (Hero: _THeroObject): Integer; stdcall;

  { ��ǰŭ��ֵ }
  THeroObject_GetAngryValue =
    function (Hero: _THeroObject): Integer; stdcall;

  { �ҳ϶� }
  THeroObject_GetLoyalPoint =
    function (Hero: _THeroObject): Real; stdcall;

  THeroObject_SetLoyalPoint =
    procedure(Hero: _THeroObject; Value: Real); stdcall;

  THeroObject_SendLoyalPointChanged =
    procedure(Hero: _THeroObject); stdcall;

  { �Ƿ񸱽�Ӣ�� }
  THeroObject_IsDeputy =
    function (Hero: _THeroObject): BOOL; stdcall;

  { �������� }
  THeroObject_GetMasterName =
    function (Hero: _THeroObject; Dest: PAnsiChar; var DestLen: DWORD): BOOL; stdcall;

  THeroObject_GetQuestFlagStatus =
    function (Hero: _THeroObject; nFlag: Integer): Integer; stdcall;

  THeroObject_SetQuestFlagStatus =
    procedure(Hero: _THeroObject; nFlag: Integer; Value: Integer); stdcall;

  { ��������װ�� }
  THeroObject_SendUseItems =
    procedure(Hero: _THeroObject); stdcall;

  { ˢ��Ӣ�۱��� }
  THeroObject_SendBagItems =
    procedure(Hero: _THeroObject); stdcall;

  { �������κ���Ʒ }
  THeroObject_SendJewelryBoxItems =
    procedure(Hero: _THeroObject); stdcall;

  { �������Ӵ���Ʒ }
  THeroObject_SendGodBlessItems =
    procedure(Hero: _THeroObject); stdcall;

  { ���Ӹ��� }
  THeroObject_SendOpenGodBlessItem =
    procedure(Hero: _THeroObject; Index: Integer); stdcall;

  { ���Ӹ�ر� }
  THeroObject_SendCloseGodBlessItem =
    procedure(Hero: _THeroObject; Index: Integer); stdcall;

  { ����������Ʒ }
  THeroObject_SendAddItem =
    procedure(Hero: _THeroObject; UserItem: pTUserItem); stdcall;

  { �ͻ���ɾ����Ʒ }
  THeroObject_SendDelItem =
    procedure(Hero: _THeroObject; UserItem: pTUserItem); stdcall;

  { �ͻ���ˢ����Ʒ }
  THeroObject_SendUpdateItem =
    procedure(Hero: _THeroObject; UserItem: pTUserItem); stdcall;

  { �ͻ���ˢ��װ���־øı� }
  THeroObject_SendItemDuraChange =
    procedure(Hero: _THeroObject; ItemWhere: Integer; UserItem: pTUserItem); stdcall;

  { ���ͼ����б� }
  THeroObject_SendUseMagics =
    procedure(Hero: _THeroObject); stdcall;

  { ���ͼ������ }
  THeroObject_SendAddMagic =
    procedure(Hero: _THeroObject; UserMagic: pTUserMagic); stdcall;

  { ���ͼ���ɾ�� }
  THeroObject_SendDelMagic =
    procedure(Hero: _THeroObject; UserMagic: pTUserMagic); stdcall;

  { ȡ�úϻ����� }
  THeroObject_FindGroupMagic =
    function (Hero: _THeroObject; UserMagic: pTUserMagic): BOOL; stdcall;

  { ȡ�úϻ�����ID }
  THeroObject_GetGroupMagicId =
    function (Hero: _THeroObject): Integer; stdcall;

  { ���ͷ����Ʒ }
  THeroObject_SendFengHaoItems =
    procedure(Hero: _THeroObject); stdcall;

  { ���ͷ������ }
  THeroObject_SendAddFengHaoItem =
    procedure(Hero: _THeroObject; UserItem: pTUserItem);  stdcall;

  { ���ͷ��ɾ�� }
  THeroObject_SendDelFengHaoItem =
    procedure(Hero: _THeroObject; Index: Integer); stdcall;

  THeroObject_IncExp =
    procedure(Hero: _THeroObject; dwExp: DWORD); stdcall;
    
  THeroObject_IncExpNG =
    procedure(Hero: _THeroObject; dwExp: DWORD); stdcall;

  THeroObject_IsOldClient =
    function (Hero: _THeroObject): BOOL; stdcall;


  //-------------------------------------------------------------------------------------------------------------------------------------------------------
  //---------------------------------------------- TNormNpc NPC���󣬼̳�TBaseObject ---------------------------------------------------------------------
  //-------------------------------------------------------------------------------------------------------------------------------------------------------
  { ����NPC����NPC�������Զ��ͷ� }
  TNormNpc_Create =
    function (CharName, sMapName, sScript: PAnsiChar; X, Y: Integer;
              wAppr: Word; boIsHide: BOOL): _TNormNpc; stdcall;

  { ����ű� }
  TNormNpc_LoadNpcScript =
    procedure(NormNpc: _TNormNpc); stdcall;

  { ��ű� }
  TNormNpc_ClearScript =
    procedure(NormNpc: _TNormNpc); stdcall;

  TNormNpc_GetFilePath =
    function (NormNpc: _TNormNpc; Dest: PAnsiChar; var DestLen: DWORD): BOOL; stdcall;

  TNormNpc_SetFilePath =
    procedure(NormNpc: _TNormNpc; Value: PAnsiChar); stdcall;

  TNormNpc_GetPath =
    function (NormNpc: _TNormNpc; Dest: PAnsiChar; var DestLen: DWORD): BOOL; stdcall;

  TNormNpc_SetPath =
    procedure(NormNpc: _TNormNpc; Value: PAnsiChar); stdcall;

  TNormNpc_GetIsHide =
    function (NormNpc: _TNormNpc): BOOL; stdcall;

  TNormNpc_SetIsHide =
    procedure(NormNpc: _TNormNpc; Value: BOOL); stdcall;

  TNormNpc_GetIsQuest =
    function (NormNpc: _TNormNpc): BOOL; stdcall;

  TNormNpc_GetLineVariableText =
    function (NormNpc: _TNormNpc; Player: _TPlayObject; sMsg: PAnsiChar;
              Dest: PAnsiChar; var DestLen: DWORD): BOOL; stdcall;

  TNormNpc_GotoLable =
    procedure(NormNpc: _TNormNpc; Player: _TPlayObject; sLabel: PAnsiChar; boExtJmp: BOOL); stdcall;

  TNormNpc_SendMsgToUser =
    procedure(NormNpc: _TNormNpc; Player: _TPlayObject; sMsg: PAnsiChar); stdcall;

  TNormNpc_MessageBox =
    procedure(NormNpc: _TNormNpc; Player: _TPlayObject; sMsg: PAnsiChar); stdcall;

  TNormNpc_GetVarValue =
    function (NormNpc: _TNormNpc; Player: _TPlayObject; sVarName: PAnsiChar;
              sValue: PAnsiChar; var sValueSize: DWORD; var nValue: Integer): BOOL; stdcall;

  TNormNpc_SetVarValue =
    function (NormNpc: _TNormNpc; Player: _TPlayObject; sVarName: PAnsiChar;
              sValue: PAnsiChar; nValue: Integer): BOOL; stdcall;

  TNormNpc_GetDynamicVarValue =
    function (NormNpc: _TNormNpc; Player: _TPlayObject; sVarName: PAnsiChar;
              sValue: PAnsiChar; var sValueSize: DWORD; var nValue: Integer): BOOL; stdcall;

  TNormNpc_SetDynamicVarValue =
    function (NormNpc: _TNormNpc; Player: _TPlayObject; sVarName: PAnsiChar;
              sValue: PAnsiChar; nValue: Integer): BOOL; stdcall;


  //-------------------------------------------------------------------------------------------------------------------------------------------------------
  //---------------------------------------------- TUserEngine ���� --------------------------------------------------------------------------------------
  //-------------------------------------------------------------------------------------------------------------------------------------------------------

  { ��ȡ�������������б�(������) }
  TUserEngine_GetPlayerList =
    function (): _TStringList; stdcall;

  { ���������������ƻ�ȡ���� }
  TUserEngine_GetPlayerByName =
    function (ChrName: PAnsiChar): _TPlayObject; stdcall;

  { ���������ʻ���ȡ���� }
  TUserEngine_GetPlayerByUserID =
    function (UserID: PAnsiChar): _TPlayObject; stdcall;

  { �ж϶����Ƿ���һ���Ϸ����������� }
  TUserEngine_GetPlayerByObject =
    function (AObject: _TObject): _TPlayObject; stdcall;

  { �����ʻ���ȡһ�����߹һ����� }
  TUserEngine_GetOfflinePlayer =
    function (UserID: PAnsiChar): _TPlayObject; stdcall;

  { ���� }
  TUserEngine_KickPlayer  =
    procedure(ChrName: PAnsiChar); stdcall;

  { ��ȡӢ���б� }
  TUserEngine_GetHeroList =
    function (): _TStringList; stdcall;

  { �������ƻ�ȡӢ�۶��� }
  TUserEngine_GetHeroByName =
    function (ChrName: PAnsiChar): _THeroObject; stdcall;

  { ��Ӣ�� }
  TUserEngine_KickHero =
    function (ChrName: PAnsiChar): BOOL; stdcall;

  { ��ȡ����NPC�б� }
  TUserEngine_GetMerchantList =
    function (): _TList; stdcall;

  { ��ȡ�Զ���NPC�����б� }
  TUserEngine_GetCustomNpcConfigList =
    function (): _TList; stdcall;

  { ��ȡMapQuest.txt�ж����NPC�б� }
  TUserEngine_GetQuestNPCList =
    function (): _TList; stdcall;

  TUserEngine_GetManageNPC =
    function (): _TNormNpc; stdcall;

  TUserEngine_GetFunctionNPC =
    function (): _TNormNpc; stdcall;
    
  TUserEngine_GetRobotNPC =
    function (): _TNormNpc; stdcall;
    
  TUserEngine_MissionNPC =
    function (): _TNormNpc; stdcall;

  { �ж�NPC�����Ƿ�Ϸ� }
  TUserEngine_FindMerchant =
    function (AObject: _TObject): _TNormNpc; stdcall;

  { ���ݵ�ͼ����õ�NPC }
  TUserEngine_FindMerchantByPos =
    function (MapName: PAnsiChar; nX, nY: Integer): _TNormNpc; stdcall;

  { �ж�NPC�����Ƿ�Ϸ� }
  TUserEngine_FindQuestNPC =
    function (AObject: _TObject): _TNormNpc; stdcall;

  { Magic.DB }
  TUserEngine_GetMagicList =
    function (): _TList; stdcall;

  { �Զ��弼�������б� }
  TUserEngine_GetCustomMagicConfigList =
    function (): _TList; stdcall;

  { M2 -> �������� ->����ħ�� -> �����Ʒ��ٷֱ� }
  TUserEngine_GetMagicACList =
    function (): _TMagicACList; stdcall;

  { ���ݼ��������Ҽ��� }
  TUserEngine_FindMagicByName =
    function (MagName: PAnsiChar; Magic: pTMagic): BOOL; stdcall;

  { ���ݼ��ܱ�Ų��Ҽ��� }
  TUserEngine_FindMagicByIndex =
    function (MagIdx: Integer; Magic: pTMagic): BOOL; stdcall;

  { ���ݼ����������Բ��Ҽ��� }
  TUserEngine_FindMagicByNameEx =
    function (MagName: PAnsiChar; MagAttr: Integer; Magic: pTMagic): BOOL; stdcall;

  { ���ݼ��ܱ�ż����Բ��Ҽ��� }
  TUserEngine_FindMagicByIndexEx =
    function (MagIdx: Integer; MagAttr: Integer; Magic: pTMagic): BOOL; stdcall;

  { ���ݼ���������Ӣ�ۼ��� }
  TUserEngine_FindHeroMagicByName =
    function (MagName: PAnsiChar; Magic: pTMagic): BOOL; stdcall;

  { ���ݼ��ܱ�Ų���Ӣ�ۼ��� }
  TUserEngine_FindHeroMagicByIndex =
    function (MagIdx: Integer; Magic: pTMagic): BOOL; stdcall;

  { ���ݼ����������Բ���Ӣ�ۼ��� }
  TUserEngine_FindHeroMagicByNameEx =
    function (MagName: PAnsiChar; MagAttr: Integer; Magic: pTMagic): BOOL; stdcall;

  { ���ݼ��ܱ�ż����Բ���Ӣ�ۼ��� }
  TUserEngine_FindHeroMagicByIndexEx =
    function (MagIdx: Integer; MagAttr: Integer; Magic: pTMagic): BOOL; stdcall;

  { StdItem.DB }
  TUserEngine_GetStdItemList =
    function (): _TList; stdcall;

  { ������Ʒ���õ����ݿ����Ʒ��Ϣ }
  TUserEngine_GetStdItemByName =
    function (ItemName: PAnsiChar; StdItem: pTStdItem): BOOL; stdcall;

  { ������Ʒ��ŵõ����ݿ����Ʒ��Ϣ }
  TUserEngine_GetStdItemByIndex =
    function (ItemIdx: Integer; StdItem: pTStdItem): BOOL; stdcall;

  { ������Ʒ��ŵõ���Ʒ�� }
  TUserEngine_GetStdItemName =
    function (ItemIdx: Integer; Dest: PAnsiChar; var DestLen: DWORD): BOOL; stdcall;

  { ������Ʒ���õ���Ʒ��� }
  TUserEngine_GetStdItemIndex =
    function (ItemName: PAnsiChar): Integer; stdcall;

  { Monster.DB }
  TUserEngine_MonsterList =
    function (): _TList; stdcall;

  TUserEngine_SendBroadCastMsg =
    function(sMsg: PAnsiChar; FColor, BColor: Integer; MsgType: Integer): BOOL; stdcall;

  TUserEngine_SendBroadCastMsgExt =
    function(sMsg: PAnsiChar; MsgType: Integer): BOOL; stdcall;

  TUserEngine_SendTopBroadCastMsg =
    function(sMsg: PAnsiChar; FColor, BColor: Integer; nTime: Integer; MsgType: Integer): BOOL; stdcall;

  TUserEngine_SendMoveMsg =
    procedure(sMsg: PAnsiChar; btFColor, btBColor: Byte; nY, nMoveCount: Integer;
              nFontSize: Integer; nMarqueeTime: Integer); stdcall;

  TUserEngine_SendCenterMsg =
    procedure(sMsg: PAnsiChar; btFColor, btBColor: Byte; nTime: Integer); stdcall;

   { ������Ϣ }
  TUserEngine_SendNewLineMsg =
    procedure(sMsg: PAnsiChar; btFColor, btBColor, btFontSize: Byte;
              nY, nShowMsgTime, nDrawType: Integer); stdcall;

  { ��ʢ�󶥲�������Ϣ }
  TUserEngine_SendSuperMoveMsg =
    procedure(sMsg: PAnsiChar; btFColor, btBColor, btFontSize: Byte; nY, nMoveCount: Integer); stdcall;

  { ������Ļ����Ϣ }
  TUserEngine_SendSceneShake =
    procedure(Count: Integer); stdcall;

  TUserEngine_CopyToUserItemFromName =
    function (ItemName: PAnsiChar; UserItem: pTUserItem): BOOL; stdcall;

  TUserEngine_CopyToUserItemFromItem =
    function (StdItem: pTStdItem; ItemIndex: Integer; UserItem: pTUserItem): BOOL; stdcall;

  TUserEngine_RandomUpgradeItem =
    procedure(UserItem: pTUserItem); stdcall;

  { �������Ԫ������ }
  TUserEngine_RandomItemNewAbil =
    procedure(UserItem: pTUserItem); stdcall;

  TUserEngine_GetUnknowItemValue =
    procedure(UserItem: pTUserItem); stdcall;

  { ���м������� }
  TUserEngine_GetAllDummyCount =
    function (): Integer; stdcall;

  { ָ����ͼ�������� }
  TUserEngine_GetMapDummyCount =
    function (Envir: _TEnvirnoment): Integer; stdcall;

  { ���߹һ��������� }
  TUserEngine_GetOfflineCount =
    function (): Integer; stdcall;

  { ������������(�������߹һ�) }
  TUserEngine_GetRealPlayerCount =
    function (): Integer; stdcall;

  //-------------------------------------------------------------------------------------------------------------------------------------------------------
  //---------------------------------------------- _TGuild �л���� --------------------------------------------------------------------------------------
  //-------------------------------------------------------------------------------------------------------------------------------------------------------

  { �л����� }
  TGuild_GetGuildName =
    function (Guild: _TGuild; Dest: PAnsiChar; var DestLen: DWORD): BOOL; stdcall;

  { �����л�ְҵ (1:սʿ; 2:��ʦ; 3:��ʿ�������) }
  TGuild_GetJoinJob =
    function (Guild: _TGuild): Integer; stdcall;

  { �����л���͵ȼ� }
  TGuild_GetJoinLevel =
    function (Guild: _TGuild): DWORD; stdcall;

  { ������Ϣ }
  TGuild_GetJoinMsg =
    function (Guild: _TGuild; Dest: PAnsiChar; var DestLen: DWORD): BOOL; stdcall;

  { ������ }
  TGuild_GetBuildPoint =
    function (Guild: _TGuild): Integer; stdcall;

  { ����ֵ/��ע�� }
  TGuild_GetAurae =
    function (Guild: _TGuild): Integer; stdcall;

  { ������ }
  TGuild_GetStability =
    function (Guild: _TGuild): Integer; stdcall;

  { ���ٶ� }
  TGuild_GetFlourishing =
    function (Guild: _TGuild): Integer; stdcall;

  { ��ȡװ������ }
  TGuild_GetChiefItemCount =
    function (Guild: _TGuild): Integer; stdcall;

  { �л��Ա���� }
  TGuild_GetMemberCount =
    function (Guild: _TGuild): Integer; stdcall;

  { �����л��Ա���� }
  TGuild_GetOnlineMemeberCount =
    function (Guild: _TGuild): Integer; stdcall;

  { �������� }
  TGuild_GetMasterCount =
    function (Guild: _TGuild): Integer; stdcall;

  { �õ��л��������� }
  TGuild_GetMaster =
    procedure(Guild: _TGuild; var Master1, Master2: _TPlayObject); stdcall;

  { �õ��л������������� }
  TGuild_GetMasterName =
    function (Guild: _TGuild; Master1: PAnsiChar; var Master1Size: DWORD;
              Master2: PAnsiChar; var Master2Size: DWORD): BOOL; stdcall;

  { ����л��Ƿ���Ա }
  TGuild_CheckMemberIsFull =
    function (Guild: _TGuild): BOOL; stdcall;

  { �����Ա�Ƿ�Ϊ�л��Ա }
  TGuild_IsMemeber =
    function (Guild: _TGuild; CharName: PAnsiChar): BOOL; stdcall;

  { ��Ա�����л� }
  TGuild_AddMember =
    function (Guild: _TGuild; Player: _TPlayObject): BOOL; stdcall;

  TGuild_AddMemberEx =
    function (Guild: _TGuild; CharName: PAnsiChar): BOOL; stdcall;

  { �л�ɾ����Ա }
  TGuild_DelMemeber =
    function (Guild: _TGuild; Player: _TPlayObject): BOOL; stdcall;

  TGuild_DelMemeberEx =
    function (Guild: _TGuild; CharName: PAnsiChar): BOOL; stdcall;

  { �ж� CheckGuild�Ƿ���Guild�������л� }
  TGuild_IsAllianceGuild =
    function (Guild: _TGuild; CheckGuild: _TGuild): BOOL; stdcall;

  { �ж��Ƿ�Ϊս���л� }
  TGuild_IsWarGuild =
    function (Guild: _TGuild; CheckGuild: _TGuild): BOOL; stdcall;

  { �ж��Ƿ�Ϊ��ע�л� }
  TGuild_IsAttentionGuild =
    function (Guild: _TGuild; CheckGuild: _TGuild): BOOL; stdcall;

  { ��������л� }
  TGuild_AddAlliance =
    function (Guild: _TGuild; AddGuild: _TGuild): BOOL; stdcall;

  { ���ս���л� }
  TGuild_AddWarGuild =
    function (Guild: _TGuild; AddGuild: _TGuild): BOOL; stdcall;

  { ��ӹ�ע�л� }
  TGuild_AddAttentionGuild =
    function (Guild: _TGuild; AddGuild: _TGuild): BOOL; stdcall;

  { ɾ�������л� }
  TGuild_DelAllianceGuild =
    function(Guild: _TGuild; DelGuild: _TGuild): BOOL; stdcall;

  { ɾ����ע�л� }
  TGuild_DelAttentionGuild =
    function(Guild: _TGuild; DelGuild: _TGuild): BOOL; stdcall;

  TGuild_GetRandNameByName =
    function (Guild: _TGuild; CharName: PAnsiChar; var nRankNo: Integer;
              Dest: PAnsiChar; var DestLen: DWORD): BOOL; stdcall;

  TGuild_GetRandNameByPlayer =
    function (Guild: _TGuild; Player: _TPlayObject; var nRankNo: Integer;
              Dest: PAnsiChar; var DestLen: DWORD): BOOL; stdcall;

  { �����л���Ϣ }
  TGuild_SendGuildMsg =
    procedure(Guild: _TGuild; Msg: PAnsiChar); stdcall;

  //-------------------------------------------------------------------------------------------------------------------------------------------------------
  //---------------------------------------------- TGuildManager �л���� ---------------------------------------------------------------------------------
  //-------------------------------------------------------------------------------------------------------------------------------------------------------

  { �����л����õ��л���� }
  TGuildManager_FindGuild =
    function (GuildName: PAnsiChar): _TGuild; stdcall;

  { �����û����õ��л���� }
  TGuildManager_GetPlayerGuild =
    function (CharName: PAnsiChar): _TGuild; stdcall;

  { �������л� }
  TGuildManager_AddGuild =
    function (GuildName, GuildMaster: PAnsiChar): BOOL; stdcall;

  { ɾ���лᣬ�г�Աʱ����ɾ }
  TGuildManager_DelGuild =
    function (GuildName: PAnsiChar; var IsFoundGuild: BOOL): BOOL; stdcall;

type
  TMemoryFunc = record
    Allow: TMemory_Alloc;                                   // �����ڴ�
    Free: TMemory_Free;                                     // �ͷ��ڴ�
    Realloc: TMemory_Realloc;                               // ���·����ڴ��С (�������ڴ�����ԭʼ�ڴ��ֵ)
    Reserved: array[0..3] of Pointer;
  end;

  TListFunc = record
    Create: TList_Create;                                   // �б���
    Free: TList_Free;                                       // �б��ͷ�
    Count: TList_Count;                                     // ȡ�б�����
    Clear: TList_Clear;                                     // ����б�
    Add: TList_Add;                                         // ���Ԫ��
    Insert: TList_Insert;                                   // ����Ԫ��}
    Remove: TList_Remove;                                   // ����Ԫ��ɾ��
    Delete: TList_Delete;                                   // ��������ɾ��
    GetItem: TList_GetItem;                                 // ȡ��Ԫ��
    SetItem: TList_SetItem;                                 // ����Ԫ��
    IndexOf: TList_IndexOf;                                 // �õ�Ԫ�ص�����
    Exchange: TList_Exchange;                               // ����Ԫ��
    CopyTo: TList_CopyTo;                                   // ���Ƶ���һ���б�

    Reserved: array[0..19] of Pointer;
  end;


  TStringListFunc = record
    Create: TStrList_Create;                                // �����ı��б�
    Free: TStrList_Free;                                    // �ͷ��ı��б�
    GetCaseSensitive: TStrList_GetCaseSensitive;            // �ж��Ƿ�ִ�Сд
    SetCaseSensitive: TStrList_SetCaseSensitive;            // �����Ƿ�ִ�Сд
    GetSorted: TStrList_GetSorted;                          // �Ƿ�����
    SetSorted: TStrList_SetSorted;                          // �����Ƿ��Զ�����
    GetDuplicates: TStrList_GetDuplicates;                  // �Ƿ��ظ�
    SetDuplicates: TStrList_SetDuplicates;                  // �����Ƿ������ظ�
    Count: TStrList_Count;                                  // ȡ�ı�����
    GetText: TStrList_GetText;                              // ȡ����������
    SetText: TStrList_SetText;                              // ��������
    Add: TStrList_Add;                                      // ���һ��
    AddObject: TStrList_AddObject;                          // ���һ�У��������а�һ������
    Insert: TStrList_Insert;                                // ����һ��
    InsertObject: TStrList_InsertObject;                    // ����һ�У��������а�һ������
    Remove: TStrList_Remove;                                // ����ָ���ı�����
    Delete: TStrList_Delete;                                // ɾ��ָ���ĵڼ���(������0��ʼ)
    GetItem: TStrList_GetItem;                              // ȡһ�е�����
    SetItem: TStrList_SetItem;                              // ����ĳ�е�����
    GetObject: TStrList_GetObject;                          // ȡĳ�а󶨵Ķ���
    SetObject: TStrList_SetObject;                          // ����ĳ�еİ󶨶���
    IndexOf: TStrList_IndexOf;                              // �����ı��õ��е�����
    IndexOfObject: TStrList_IndexOfObject;                  // ���ݰ󶨶���õ�������
    Find: TStrList_Find;                                    // ���ֲ���ĳ�е����� (ÿ�е����ݱ����������)
    Exchange: TStrList_Exchange;                            // �������е����ݼ��󶨵Ķ���
    LoadFromFile: TStrLit_LoadFromFile;                     // ���ļ�����
    SaveToFile: TStrLit_SaveToFile;                         // �浽�ļ�
    CopyTo: TStrList_CopyTo;                                // ����

    Reserved: array[0..19] of Pointer;
  end;

  TMemoryStreamFunc = record
    Create: TMemStream_Create;                              // �����ڴ���
    Free: TMemStream_Free;                                  // �ͷ��ڴ���
    GetSize: TMemStream_GetSize;                            // ȡ�ô�С
    SetSize: TMemStream_SetSize;                            // ���ô�С
    Clear: TMemStream_Clear;                                // ���
    Read: TMemStream_Read;                                  // ���ڴ��������ݶ�ȡ�� Buffer ��
    Write: TMemStream_Write;                                // ���ڴ���д������
    Seek: TMemStream_Seek;                                  // ָ�붨λ SeekOrigin: 0 (��ͷ��ʼ), 1 (��ǰλ�ÿ�ʼ), 2 (��β����ʼ)
    Memory: TMemStream_Memory;                              // ��ȡ�����ݵ��ڴ�ָ��
    GetPosition: TMemStream_GetPosition;                    // ��ȡָ��λ��
    SetPosition: TMemStream_SetPosition;                    // ָ�붨λ (�����ڼ����ֽ�)
    LoadFromFile: TMemStream_LoadFromFile;                  // ���ļ�����
    SaveToFile: TMemStream_SaveToFile;                      // ���浽�ļ�
                                                         
    Reserved: array[0..19] of Pointer;                   
  end;                                                   
                                                         
  TMemuFunc = record                                     
    GetMainMenu: TMenu_GetMainMenu;                         // ��ȡ���˵�
    GetControlMenu: TMenu_GetControlMenu;                   // ��ȡ���Ʋ˵�
    GetViewMenu: TMenu_GetViewMenu;                         // ��ȡ�鿴�˵�
    GetOptionMenu: TMenu_GetOptionMenu;                     // ��ȡѡ��˵�
    GetManagerMenu: TMenu_GetManagerMenu;                   // ��ȡ����˵�
    GetToolsMenu: TMenu_GetToolsMenu;                       // ��ȡ���߲˵�
    GetHelpMenu: TMenu_GetHelpMenu;                         // ��ȡ�����˵�
    GetPluginMenu: TMenu_GetPluginMenu;                     // ��ȡ����˵�
    Count: TMenu_Count;                                     // ��ȡ�Ӳ˵�����
    GetItems: TMenu_GetItems;                               // ��ȡĳ���Ӳ˵�
    Add: TMenu_Add;                                         // ��Ӳ˵�
    Insert: TMenu_Insert;                                   // ����˵�
    GetCaption: TMenu_GetCaption;                           // ��ȡ�˵�����
    SetCaption: TMenu_SetCaption;                           // ���ò˵�����
    GetEnabled: TMenu_GetEnabled;                           // ��ȡ�˵�����
    SetEnabled: TMenu_SetEnabled;                           // ���ò˵�����
    GetVisable: TMenu_GetVisable;                           // ��ȡ�˵��ɼ�
    SetVisable: TMenu_SetVisable;                           // ���ò˵��ɼ�
    GetChecked: TMenu_GetChecked;                           // ��ȡ�˵�ѡ��״̬
    SetChecked: TMenu_SetChecked;                           // ���ò˵�ѡ��״̬
    GetRadioItem: TMenu_GetRadioItem;                       // ��ȡ�˵��Ƿ�Ϊ��ѡ
    SetRadioItem: TMenu_SetRadioItem;                       // ���ò˵��Ƿ�Ϊ��ѡ
    GetGroupIndex: TMenu_GetGroupIndex;                     // ��ȡ�˵���ѡ����
    SetGroupIndex: TMenu_SetGroupIndex;                     // ���ò˵���ѡ����
    GetTag: TMenu_GetTag;                                   // ��ȡ��������
    SetTag: TMenu_SetTag;                                   // ���ø�������

    Reserved: array[0..19] of Pointer;
  end;

  TIniFileFunc = record
    Create: TIniFile_Create;                                // ����Ini����
    Free: TIniFile_Free;                                    // �ͷ�ini����
    SectionExists: TIniFile_SectionExists;                  // �ж������Ƿ����
    ValueExists: TIniFile_ValueExists;                      // �жϼ��Ƿ����
    ReadString: TIniFile_ReadString;                        // ��ȡ�ı�
    WriteString: TIniFile_WriteString;                      // д���ı�
    ReadInteger: TIniFile_ReadInteger;                      // ��ȡ����
    WriteInteger: TIniFile_WriteInteger;                    // д������
    ReadBool: TIniFile_ReadBool;                            // ��ȡ����ֵ
    WriteBool: TIniFile_WriteBool;                          // д�벼��ֵ

    Reserved: array[0..29] of Pointer;
  end;

  TMagicACListFunc = record
    Count: TMagicACList_Count;                              // �����Ʒ��ٷֱ��б�����
    GetItem: TMagicACList_GetItem;                          // ȡ����Ԫ��
    FindByMagIdx: TMagicACList_FindByMagIdx;                // ���ݼ��ܵõ��Ʒ��ٷֱ���Ϣ

    Reserved: array[0..9] of Pointer;
  end;

  TMapManagerFunc = record
    FindMap: TMapManager_FindMap;                           // ���ݵ�ͼ���õ���ͼ����
    GetMapList: TMapManager_GetMapList;                     // �õ���ͼ�б�; ����ֵ��ÿ��Ԫ��Ϊ��_TEnvirnoment

    Reserved: array[0..39] of Pointer;
  end;

  TEnvirnomentFunc = record
    GetMapName: TEnvir_GetMapName;                          // ��ͼ����
    GetMapDesc: TEnvir_GetMapDesc;                          // ��ͼ����
    GetWidth: TEnvir_GetWidth;                              // ��ͼ���
    GetHeight: TEnvir_GetHeight;                            // ��ͼ�߶�
    GetMinMap: TEnvir_GetMinMap;                            // С��ͼ
    IsMainMap: TEnvir_IsMainMap;                            // �Ƿ�����ͼ
    GetMainMapName: TEnvir_GetMainMapName;                  // ����ͼ��
    IsMirrMap: TEnvir_IsMirrMap;                            // �Ƿ�̬�����ͼ
    GetMirrMapCreateTick: TEnvir_GetMirrMapCreateTick;      // ��̬�����ͼ����ʱ��
    GetMirrMapSurvivalTime: TEnvir_GetMirrMapSurvivalTime;  // ��̬�����ͼ���ʱ��
    GetMirrMapExitToMap: TEnvir_GetMirrMapExitToMap;        // ��̬��ͼ�˵��ĸ���ͼ
    GetMirrMapMinMap: TEnvir_GetMirrMapMinMap;              // ��̬�����ͼС��ͼ���
    GetAlwaysShowTime: TEnvir_GetAlwaysShowTime;            // ��̬�����ͼ�Ƿ�һֱ��ʾʱ��
    IsFBMap: TEnvir_IsFBMap;                                // �Ƿ񸱱���ͼ
    GetFBMapName: TEnvir_GetFBMapName;                      // ������ͼ��
    GetFBEnterLimit: TEnvir_GetFBEnterLimit;                // ������������ (0:���ѱ�������ְҵ; 1:������ְҵ�����Ѿ��ɽ�; 2:ֻ�����Լ�; 3:�����л����)
    GetFBCreated: TEnvir_GetFBCreated;                      // ������ͼ�Ƿ񴴽�
    GetFBCreateTime: TEnvir_GetFBCreateTime;                // ������ͼ����ʱ��
    GetMapParam: TEnvir_GetMapParam;                        // ��ȡ��ͼ�Ƿ�����ĳ����
    GetMapParamValue: TEnvir_GetMapParamValue;              // ��ȡ��ͼ����ĳ����ֵ
    CheckCanMove: TEnvir_CheckCanMove;                      // ��ͼ���Ƿ�ɴboFlag = Falseʱ�����жϸ�������Ƿ��н�ɫռ��
    IsValidObject: TEnvir_IsValidObject;                    // �жϵ�ͼ��������(nX, nY)Ϊ���У���nRangeΪ�뾶�ľ��η�Χ�ڣ��Ƿ���Obj����
    GetItemObjects: TEnvir_GetItemObjects;                  // ��ȡ��ͼ��ĳ�������Ʒ�б�
    GetBaseObjects: TEnvir_GetBaseObjects;                  // ��ȡ��ͼ��ĳ����Ľ�ɫ�б�
    GetPlayObjects: TEnvir_GetPlayObjects;                  // ��ȡ��ͼ��ĳ����������б�

    Reserved: array[0..99] of Pointer;
  end;

  TM2EngineFunc = record
    GetVersion: TM2Engine_GetVersion;                       // ȡM2�汾��
    GetVersionInt: TM2Engine_GetVersionInt;                 // ȡ�汾��
    GetMainFormHandle: TM2Engine_GetMainFormHandle;         // ȡ����������
    SetMainFormCaption: TM2Engine_SetMainFormCaption;       // �������������
    GetAppDir: TM2Engine_GetAppDir;                         // ����������Ŀ¼
    GetGlobalIniFile: TM2Engine_GetGlobalIniFile;           // ��ȡ������ȫ��ini����
    GetOtherFileDir: TM2Engine_GetOtherFileDir;             // ��ȡ�������ļ���Ŀ¼
    MainOutMessage: TM2Engine_MainOutMessage;               // M2�����Ϣ
    GetGlobalVarI: TM2Engine_GetGlobalVarI;                 // ��ȡȫ��I����
    SetGlobalVarI: TM2Engine_SetGlobalVarI;                 // ����ȫ��I����
    GetGlobalVarG: TM2Engine_GetGlobalVarG;                 // ��ȡȫ��G����
    SetGlobalVarG: TM2Engine_SetGlobalVarG;                 // ����ȫ��G����
    GetGlobalVarA: TM2Engine_GetGlobalVarA;                 // ��ȡȫ��A����
    SetGlobalVarA: TM2Engine_SetGlobalVarA;                 // ����ȫ��A����
    EncodeBuffer: TM2Engine_EncodeBuffer;                   // ����
    DecodeBuffer: TM2Engine_DecodeBuffer;                   // ����
    ZLibEncodeBuffer: TM2Engine_ZLibEncodeBuffer;           // ѹ������
    ZLibDecodeBuffer: TM2Engine_ZLibDecodeBuffer;           // ѹ������
    EncryptBuffer: TM2Engine_EncryptBuffer;                 // ����
    DecryptBuffer: TM2Engine_DecryptBuffer;                 // ����
    EncryptPassword: TM2Engine_EncryptPassword;             // �������(��ͬ�ĵ��Եõ���ͬ�Ľ��)
    DecryptPassword: TM2Engine_DecryptPassword;             // �������
    GetTakeOnPosition: TM2Engine_GetTakeOnPosition;         // ������ƷStdMode�õ���Ʒװ��λ��
    CheckBindType: TM2Engine_CheckBindType;                 // �����Ʒ�Ƿ���ĳ��������
    SetBindValue: TM2Engine_SetBindValue;                   // ������Ʒĳ��������
    GetRGB: TM2Engine_GetRGB;                               // ���ݵ��ֽ���ɫ�õ�RGB��ɫ

    Reserved: array[0..99] of Pointer;
  end;

  TBaseObjectFunc = record
    GetChrName: TBaseObject_GetChrName;                     // ����
    SetChrName: TBaseObject_SetChrName;                     // ��������(�����������Ӣ��)
    RefShowName: TBaseObject_RefShowName;                   // ˢ�����Ƶ��ͻ���
    RefNameColor: TBaseObject_RefNameColor;                 // ˢ��������ɫ PKPoint�ȸı�ʱ

    GetGender: TBaseObject_GetGender;                       // ��ȡ�Ա�
    SetGender: TBaseObject_SetGender;                       // �����Ա�

    GetJob: TBaseObject_GetJob;                             // ��ȡְҵ
    SetJob: TBaseObject_SetJob;                             // ����ְҵ

    GetHair: TBaseObject_GetHair;                           // ��ȡ����
    SetHair: TBaseObject_SetHair;                           // ���÷���

    GetEnvir: TBaseObject_GetEnvir;                         // ���ڵ�ͼ
    GetMapName: TBaseObject_GetMapName;                     // ���ڵ�ͼ
    GetCurrX: TBaseObject_GetCurrX;                         // ����X
    GetCurrY: TBaseObject_GetCurrY;                         // ����Y
    GetDirection: TBaseObject_GetDirection;                 // ��ǰ����

    GetHomeMap: TBaseObject_GetHomeMap;                     // �سǵ�ͼ
    GetHomeX: TBaseObject_GetHomeX;                         // �س�����X
    GetHomeY: TBaseObject_GetHomeY;                         // �س�����Y
    GetPermission: TBaseObject_GetPermission;               // Ȩ�޵ȼ�
    SetPermission: TBaseObject_SetPermission;               // ����Ȩ�޵ȼ�
    GetDeath: TBaseObject_GetDeath;                         // �Ƿ�����
    GetDeathTick: TBaseObject_GetDeathTick;                 // ����ʱ��
    GetGhost: TBaseObject_GetGhost;                         // �Ƿ�����������
    GetGhostTick: TBaseObject_GetGhostTick;                 // ����ʱ��
    MakeGhost: TBaseObject_MakeGhost;                       // ɱ�������
    ReAlive: TBaseObject_ReAlive;                           // ����

    GetRaceServer: TBaseObject_GetRaceServer;               // ����
    GetAppr: TBaseObject_GetAppr;                           // Appr
    GetRaceImg: TBaseObject_GetRaceImg;                     // RaceImg

    GetCharStatus: TBaseObject_GetCharStatus;               // ״̬
    SetCharStatus: TBaseObject_SetCharStatus;               // ״̬�ı�
    StatusChanged: TBaseObject_StatusChanged;               // ����״̬�ı�

    GetHungerPoint: TBaseObject_GetHungerPoint;             // ��ȡ������
    SetHungerPoint: TBaseObject_SetHungerPoint;             // ���ü�����

    IsNGMonster: TBaseobject_IsNGMonster;                   // �Ƿ�Ϊ�ڹ���
    IsDummyObject: TBaseObject_IsDummyObject;               // �Ƿ����

    GetViewRange: TBaseObject_GetViewRange;                 // ��ȡ�Ӿ���Χ
    SetViewRange: TBaseObject_SetViewRange;                 // �����Ӿ���Χ
    GetAbility: TBaseObject_GetAbility;                     // ԭʼ����

    GetWAbility: TBaseObject_GetWAbility;                   // ��������
    SetWAbility: TBaseObject_SetWAbility;                   // ��������

    GetSlaveList: TBaseObject_GetSlaveList;                 // �����б�
    GetMaster: TBaseObject_GetMaster;                       // ����
    GetMasterEx: TBaseObject_GetMasterEx;                   // ���ϲ�����

    GetSuperManMode: TBaseObject_GetSuperManMode;           // �Ƿ��޵�ģʽ
    SetSuperManMode: TBaseObject_SetSuperManMode;           // �����޵�ģʽ

    GetAdminMode: TBaseObject_GetAdminMode;                 // �Ƿ����ģʽ
    SetAdminMode: TBaseObject_SetAdminMode;                 // ���ù���ģʽ

    GetTransparent: TBaseObject_GetTransparent;             // ħ������
    SetTransparent: TBaseObject_SetTransparent;             // ����ħ������

    GetObMode: TBaseObject_GetObMode;                       // ����ģʽ
    SetObMode: TBaseObject_SetObMode;                       // ��������ģʽ

    GetStoneMode: TBaseObject_GetStoneMode;                 // ʯ��ģʽ
    SetStoneMode: TBaseObject_SetStoneMode;                 // ����ʯ��ģʽ

    GetStickMode: TBaseObject_GetStickMode;                 // �Ƿ����ƶ�
    SetStickMode: TBaseObject_SetStickMode;                 // ���ò����ƶ�ģʽ

    GetIsAnimal: TBaseObject_GetIsAnimal;                   // �����Ƿ����
    SetIsAnimal: TBaseObject_SetIsAnimal;                   // ���ù����Ƿ����

    GetIsNoItem: TBaseObject_GetIsNoItem;                   // �����Ƿ񲻵�װ��
    SetIsNoItem: TBaseObject_SetIsNoItem;                   // ���������Ƿ񲻵�װ��

    GetCoolEye: TBaseObject_GetCoolEye;                     // ��������
    SetCoolEye: TBaseObject_SetCoolEye;                     // ������������

    GetHitPoint: TBaseObject_GetHitPoint;                   // ����
    SetHitPoint: TBaseObject_SetHitPoint;                   // ��������

    GetSpeedPoint: TBaseObject_GetSpeedPoint;               // ����
    SetSpeedPoint: TBaseObject_SetSpeedPoint;               // ��������

    GetHitSpeed: TBaseObject_GetHitSpeed;                   // �����ٶ�
    SetHitSpeed: TBaseObject_SetHitSpeed;                   // ���ù����ٶ�

    GetWalkSpeed: TBaseObject_GetWalkSpeed;                 // �ƶ��ٶ�
    SetWalkSpeed: TBaseObject_SetWalkSpeed;                 // �����ƶ��ٶ�

    GetHPRecover: TBaseObject_GetHPRecover;                 // HP�ָ��ٶ�
    SetHPRecover: TBaseObject_SetHPRecover;                 // ����HP�ָ��ٶ�

    GetMPRecover: TBaseObject_GetMPRecover;                 // MP�ָ��ٶ�
    SetMPRecover: TBaseObject_SetMPRecover;                 // ����MP�ָ��ٶ�

    GetPoisonRecover: TBaseObject_GetPoisonRecover;         // �ж��ָ�
    SetPoisonRecover: TBaseObject_SetPoisonRecover;         // �����ж��ָ�

    GetAntiPoison: TBaseObject_GetAntiPoison;               // �����
    SetAntiPoison: TBaseObject_SetAntiPoison;               // ���ö����

    GetAntiMagic: TBaseObject_GetAntiMagic;                 // ħ�����
    SetAntiMagic: TBaseObject_SetAntiMagic;                 // ����ħ�����

    GetLuck: TBaseObject_GetLuck;                           // ����
    SetLuck: TBaseObject_SetLuck;                           // ��������

    GetAttatckMode: TBaseObject_GetAttatckMode;             // ����ģʽ
    SetAttatckMode: TBaseObject_SetAttatckMode;             // ���ù���ģʽ

    GetNation: TBaseObject_GetNation;                       // ��ȡ��������
    SetNation: TBaseObject_SetNation;                       // ������������

    GetNationaName: TBaseObject_GetNationaName;             // ��ȡ��������

    GetGuild: TBaseObject_GetGuild;                         // �л�
    GetGuildRankNo: TBaseobject_GetGuildRankNo;             // ���������л��еķ�����
    GetGuildRankName: TBaseobject_GetGuildRankName;         // ���������л��еķ�������
    IsGuildMaster: TBaseObject_IsGuildMaster;               // �Ƿ�Ϊ�л��ϴ�

    GetHideMode: TBaseObject_GetHideMode;                   // �����ָ ������Ʒ:111
    SetHideMode: TBaseObject_SetHideMode;

    GetIsParalysis: TBaseObject_GetIsParalysis;                     // ��Խ�ָ  ������Ʒ:113
    SetIsParalysis: TBaseObject_SetIsParalysis;
    GetParalysisRate: TBaseObject_GetParalysisRate;                 // ��Լ���
    SetParalysisRate: TBaseObject_SetParalysisRate;

    GetIsMDParalysis: TBaseObject_GetIsMDParalysis;                 // ħ����Խ�ָ  ������Ʒ:204
    SetIsMDParalysis: TBaseObject_SetIsMDParalysis;
    GetMDParalysisRate: TBaseObject_GetMDParalysisRate;             // ħ����Լ���
    SetMDParalysisRate: TBaseObject_SetMDParalysisRate;

    GetIsFrozen: TBaseObject_GetIsFrozen;                           // ������ָ  ������Ʒ:205
    SetIsFrozen: TBaseObject_SetIsFrozen;
    GetFrozenRate: TBaseObject_GetFrozenRate;                       // ��������
    SetFrozenRate: TBaseObject_SetFrozenRate;

    GetIsCobwebWinding: TBaseObject_GetIsCobwebWinding;             // ������ָ  ������Ʒ:206
    SetIsCobwebWinding: TBaseObject_SetIsCobwebWinding;
    GetCobwebWindingRate: TBaseObject_GetCobwebWindingRate;         // ��������
    SetCobwebWindingRate: TBaseObject_SetCobwebWindingRate;

    GetUnParalysisValue: TBaseObject_GetUnParalysisValue;           // ���鼸��
    SetUnParalysisValue: TBaseObject_SetUnParalysisValue;
    GetIsUnParalysis: TBaseObject_GetIsUnParalysis;                 // ���ݼ���ȡ�����Ƿ����

    GetUnMagicShieldValue: TBaseObject_GetUnMagicShieldValue;       // ��������
    SetUnMagicShieldValue: TBaseObject_SetUnMagicShieldValue;
    GetIsUnMagicShield: TBaseObject_GetIsUnMagicShield;             // ���ݼ���ȡ�����Ƿ������

    GetUnRevivalValue: TBaseObject_GetUnRevivalValue;               // �������
    SetUnRevivalValue: TBaseObject_SetUnRevivalValue;
    GetIsUnRevival: TBaseObject_GetIsUnRevival;                     // ���ݼ���ȡ�����Ƿ������

    GetUnPosionValue: TBaseObject_GetUnPosionValue;                 // ��������
    SetUnPosionValue: TBaseObject_SetUnPosionValue;
    GetIsUnPosion: TBaseObject_GetIsUnPosion;                       // ���ݼ���ȡ�����Ƿ����

    GetUnTammingValue: TBaseObject_GetUnTammingValue;               // ���ջ���
    SetUnTammingValue: TBaseObject_SetUnTammingValue;
    GetIsUnTamming: TBaseObject_GetIsUnTamming;                     // ���ݼ���ȡ�����Ƿ���ջ�

    GetUnFireCrossValue: TBaseObject_GetUnFireCrossValue;           // ����ǽ����
    SetUnFireCrossValue: TBaseObject_SetUnFireCrossValue;
    GetIsUnFireCross: TBaseObject_GetIsUnFireCross;                 // ���ݼ���ȡ�����Ƿ����ǽ

    GetUnFrozenValue: TBaseObject_GetUnFrozenValue;                 // ����������
    SetUnFrozenValue: TBaseObject_SetUnFrozenValue;
    GetIsUnFrozen: TBaseObject_GetIsUnFrozen;                       // ���ݼ���ȡ�����Ƿ������

    GetUnCobwebWindingValue: TBaseObject_GetUnCobwebWindingValue;   // ����������
    SetUnCobwebWindingValue: TBaseObject_SetUnCobwebWindingValue;
    GetIsUnCobwebWinding: TBaseObject_GetIsUnCobwebWinding;         // ���ݼ���ȡ�����Ƿ������


    GetTargetCret: TBaseObject_GetTargetCret;                       // ��ȡ��ǰ����Ŀ��
    SetTargetCret: TBaseObject_SetTargetCret;                       // ���õ�ǰ����Ŀ��
    DelTargetCreat: TBaseObject_DelTargetCreat;                     // ɾ����ǰ����Ŀ��
    GetLastHiter: TBaseObject_GetLastHiter;                         // ��˭����
    GetExpHitter: TBaseObject_GetExpHitter;                         // ˭�þ���
    GetPoisonHitter: TBaseObject_GetPoisonHitter;                   // ʩ����
    GetPoseCreate: TBaseObject_GetPoseCreate;                       // ��ǰ�Ķ�����˭

    IsProperTarget: TBaseObject_IsProperTarget;                     // �Ƿ�Ϊ����Ŀ��
    IsProperFriend: TBaseObject_IsProperFriend;                     // �Ƿ�Ϊ����

    TargetInRange: TBaseObject_TargetInRange;                       // �ж϶�����ָ����Χ��

    SendMsg: TBaseObject_SendMsg;                                   // ����Ϣ
    SendDelayMsg: TBaseObject_SendDelayMsg;                         // ����ʱ��Ϣ
    SendRefMsg: TBaseObject_SendRefMsg;                             // ��ȫ����ҷ���Ϣ
    SendUpdateMsg: TBaseObject_SendUpdateMsg;                       // ���·���Ϣ
    SysMsg: TBaseObject_SysMsg;                                     // ��������Ϣ

    GetBagItemList: TBaseObject_GetBagItemList;                     // ������Ʒ
    IsEnoughBag: TBaseObject_IsEnoughBag;                           // ��ⱳ���Ƿ���
    IsEnoughBagEx: TBaseObject_IsEnoughBagEx;                       // �����Ƿ����㹻�Ŀռ��ָ����������Ʒ
    AddItemToBag: TBaseObject_AddItemToBag;                         // ����Ʒ������
    DelBagItemByIndex: TBaseObject_DelBagItemByIndex;               // ɾ�������ڼ�����Ʒ
    DelBagItemByMakeIdx: TBaseObject_DelBagItemByMakeIdx;           // ����MakeIndexɾ��������Ʒ
    DelBagItemByUserItem: TBaseObject_DelBagItemByUserItem;         // ����UserItemɾ��������Ʒ

    IsInSafeZone: TBaseObject_IsInSafeZone;                         // ����ɫ�Ƿ��ڰ�ȫ��
    IsPtInSafeZone: TBaseObject_IsPtInSafeZone;                     // ���������Ƿ��ڰ�ȫ����

    RecalcLevelAbil: TBaseObject_RecalcLevelAbil;                   // ����ȼ�����(IsSysDef=True: ʹ��ϵͳĬ�ϵȼ�����; IsSysDef=False: ʹ���Զ���ȼ�����)
    RecalcAbil: TBaseObject_RecalcAbil;                             // ��������
    RecalcBagWeight: TBaseObject_RecalcBagWeight;                   // ���㱳������

    GetLevelExp: TBaseObject_GetLevelExp;                           // ָ���ȼ������¼���Ҫ����ֵ

    HasLevelUp: TBaseObject_HasLevelUp;                             // ����
    TrainSkill: TBaseObject_TrainSkill;                             // �Ӽ���������; IsDoChec = True,�жϼ��ܼӵ�����

    CheckMagicLevelup: TBaseObject_CheckMagicLevelup;               // ��鼼���Ƿ�����
    MagicTranPointChanged: TBaseObject_MagicTranPointChanged;       // ���ܵ�ĵ�

    DamageHealth: TBaseObject_DamageHealth;                         // ��Ѫ
    DamageSpell: TBaseObject_DamageSpell;                           // ����MP
    IncHealthSpell: TBaseObject_IncHealthSpell;                     // ����HP/MP
    HealthSpellChanged: TBaseObject_HealthSpellChanged;             // ֪ͨ�ͻ���HP/MP�ı�

    FeatureChanged: TBaseObject_FeatureChanged;                     // ֪ͨ�ͻ�����۸ı�
    WeightChanged: TBaseObject_WeightChanged;                       // ֪ͨ�ͻ��˸��ظı�

    GetHitStruckDamage: TBaseObject_GetHitStruckDamage;             // �����������˺�, nType = 1:�����������nType = 2:��ħ���ܷ���
    GetMagStruckDamage: TBaseObject_GetMagStruckDamage;             // ������ħ���˺�

    GetActorIcon: TBaseObject_GetActorIcon;                         // ���������� (Index: 0-9)
    SetActorIcon: TBaseObject_SetActorIcon;                         // ���������� (Index: 0-9)

    RefUseIcons: TBaseObject_RefUseIcons;                           // ˢ�¶���������
    RefUseEffects: TBaseObject_RefUseEffects;                       // ˢ��Ч��

    SpaceMove: TBaseObject_SpaceMove;                               // �ɵ�ָ����ͼ������
    MapRandomMove: TBaseObject_MapRandomMove;                       // �ɵ�ָ����ͼ�������

    CanMove: TBaseObject_CanMove;                                   // �����Ƿ���ƶ� (����ԣ������״̬ʱ�������ƶ�)
    CanRun: TBaseObject_CanRun;                                     // �Ƿ���Դ�һ����������һ����
    TurnTo: TBaseObject_TurnTo;                                     // ת��
    WalkTo: TBaseObject_WalkTo;                                     // ָ��������һ��
    RunTo: TBaseObject_RunTo;                                       // ָ��������һ��

    PluginList: TBaseObject_PluginList;                             // Ԥ��������ã������ط�δʹ��

    Reserved: array[0..99] of Pointer;
  end;

  TSmartObjectFunc = record
    GetMagicList: TSmartObject_GetMagicList;                        // ��ȡ�����б�

    GetUseItem: TSmartObject_GetUseItem;                            // ȡĳ��λ�õ�װ��; Index: 0-29

    GetJewelryBoxStatus: TSmartObject_GetJewelryBoxStatus;          // ���κ�״̬ 0:δ����; 1:����; 2:����
    SetJewelryBoxStatus: TSmartObject_SetJewelryBoxStatus;          // �������κ�״̬ 0:δ����; 1:����; 2:����
    GetJewelryItem: TSmartObject_GetJewelryItem;                    // ȡ���κ���Ʒ; Index: 0-5

    GetIsShowGodBless: TSmartObject_GetIsShowGodBless;              // �Ƿ���ʾ���Ӵ�
    SetIsShowGodBless: TSmartObject_SetIsShowGodBless;              // ������ʾ���Ӵ�

    GetGodBlessItemsState: TSmartObject_GetGodBlessItemsState;      // ȡĳ�����Ӹ��ӵĿ���״̬
    SetGodBlessItemsState: TSmartObject_SetGodBlessItemsState;      // �������Ӹ��ӵĿ���״̬

    GetGodBlessItem: TSmartObject_GetGodBlessItem;                  // ȡ���Ӵ���Ʒ; Index: 0-11

    GetFengHaoItems: TSmartObject_GetFengHaoItems;                  // ����б�
    GetActiveFengHao: TSmartObject_GetActiveFengHao;                // ����ķ��
    SetActiveFengHao: TSmartObject_SetActiveFengHao;                // ���õ�ǰ������; -1����
    ActiveFengHaoChanged: TSmartObject_ActiveFengHaoChanged;        // ˢ�»��ŵ��ͻ���
    DeleteFengHao: TSmartObject_DeleteFengHao;                      // ɾ�����
    ClearFengHao: TSmartObject_ClearFengHao;                        // ��շ��

    GetMoveSpeed: TSmartObject_GetMoveSpeed;
    SetMoveSpeed: TSmartObject_SetMoveSpeed;
    GetAttackSpeed: TSmartObject_GetAttackSpeed;
    SetAttackSpeed: TSmartObject_SetAttackSpeed;
    GetSpellSpeed: TSmartObject_GetSpellSpeed;
    SetSpellSpeed: TSmartObject_SetSpellSpeed;
    RefGameSpeed: TSmartObject_RefGameSpeed;                        // ˢ����Ϸ�ٶ�
    GetIsButch: TSmartObject_GetIsButch;                            // �Ƿ����
    SetIsButch: TSmartObject_SetIsButch;                            // �����Ƿ����

    GetIsTrainingNG: TSmartObject_GetIsTrainingNG;                  // �Ƿ�ѧ�ڹ�
    SetIsTrainingNG: TSmartObject_SetIsTrainingNG;

    GetIsTrainingXF: TSmartObject_GetIsTrainingXF;                  // �Ƿ�ѧ�ķ�
    SetIsTrainingXF: TSmartObject_SetIsTrainingXF;

    GetIsOpenLastContinuous: TSmartObject_GetIsOpenLastContinuous;  // ��4�������Ƿ���
    SetIsOpenLastContinuous: TSmartObject_SetIsOpenLastContinuous;  // ���ÿ�����4������

    GetContinuousMagicOrder: TSmartObject_GetContinuousMagicOrder;  // ����˳�� Index:0-3
    SetContinuousMagicOrder: TSmartObject_SetContinuousMagicOrder;  // ��������˳��

    GetPKDieLostExp: TSmartObject_GetPKDieLostExp;                  // PK ���������飬��������͵��ȼ�
    SetPKDieLostExp: TSmartObject_SetPKDieLostExp;

    GetPKDieLostLevel: TSmartObject_GetPKDieLostLevel;              // PK �������ȼ�
    SetPKDieLostLevel: TSmartObject_SetPKDieLostLevel;

    GetPKPoint: TSmartObject_GetPKPoint;                            // PK����
    SetPKPoint: TSmartObject_SetPKPoint;
    IncPKPoint: TSmartObject_IncPKPoint;                            // ����PKֵ
    DecPKPoint: TSmartObject_DecPKPoint;                            // ����PKֵ

    GetPKLevel: TSmartObject_GetPKLevel;                            // PK�ȼ�
    SetPKLevel: TSmartObject_SetPKLevel;

    GetIsTeleport: TSmartObject_GetIsTeleport;                      // ���ͽ�ָ ������Ʒ:112
    SetIsTeleport: TSmartObject_SetIsTeleport;

    GetIsRevival: TSmartObject_GetIsRevival;                        // �����ָ ������Ʒ:114
    SetIsRevival: TSmartObject_SetIsRevival;

    GetRevivalTime: TSmartObject_GetRevivalTime;                    // �����ָ: ������
    SetRevivalTime: TSmartObject_SetRevivalTime;

    GetIsFlameRing: TSmartObject_GetIsFlameRing;                    // �����ָ ������Ʒ:115
    SetIsFlameRing: TSmartObject_SetIsFlameRing;

    GetIsRecoveryRing: TSmartObject_GetIsRecoveryRing;              // ������ָ ������Ʒ:116
    SetIsRecoveryRing: TSmartObject_SetIsRecoveryRing;

    GetIsMagicShield: TSmartObject_GetIsMagicShield;                // �����ָ ������Ʒ:118
    SetIsMagicShield: TSmartObject_SetIsMagicShield;

    GetIsMuscleRing: TSmartObject_GetIsMuscleRing;                  // ������ָ(������) ������Ʒ:119
    SetIsMuscleRing: TSmartObject_SetIsMuscleRing;

    GetIsFastTrain: TSmartObject_GetIsFastTrain;                    // �������� ������Ʒ:120
    SetIsFastTrain: TSmartObject_SetIsFastTrain;

    GetIsProbeNecklace: TSmartObject_GetIsProbeNecklace;            // ̽������ ������Ʒ:121
    SetIsProbeNecklace: TSmartObject_SetIsProbeNecklace;

    GetIsRecallSuite: TSmartObject_GetIsRecallSuite;                // ������Ʒ ������Ʒ:122, 124, 125
    SetIsRecallSuite: TSmartObject_SetIsRecallSuite;

    GetIsPirit: TSmartObject_GetIsPirit;                            // ��װ�� ������Ʒ:126 - 129
    SetIsPirit: TSmartObject_SetIsPirit;

    GetIsSupermanItem: TSmartObject_GetIsSupermanItem;              // ������ָ ������Ʒ:140
    SetIsSupermanItem: TSmartObject_SetIsSupermanItem;

    GetIsExpItem: TSmartObject_GetIsExpItem;                        // ������Ʒ ������Ʒ:141
    SetIsExpItem: TSmartObject_SetIsExpItem;

    GetExpItemValue: TSmartObject_GetExpItemValue;                  // ������Ʒֵ ������Ʒ:141
    SetExpItemValue: TSmartObject_SetExpItemValue;

    GetExpItemRate: TSmartObject_GetExpItemRate;                    // ������Ʒ���鱶�� (��Ʒװ��->��������->���鷭��->����)

    GetIsPowerItem: TSmartObject_GetIsPowerItem;                    // ������Ʒ ������Ʒ:142
    SetIsPowerItem: TSmartObject_SetIsPowerItem;

    GetPowerItemValue: TSmartObject_GetPowerItemValue;              // ������Ʒֵ ������Ʒ:142
    SetPowerItemValue: TSmartObject_SetPowerItemValue;              // ����������Ʒֵ ������Ʒ:142
    
    GetPowerItemRate: TSmartObject_GetPowerItemRate;                // ������Ʒ���鱶�� (��Ʒװ��->��������->��������->����)

    GetIsGuildMove: TSmartObject_GetIsGuildMove;                    // �лᴫ��װ�� ������Ʒ:145
    SetIsGuildMove: TSmartObject_SetIsGuildMove;

    GetIsAngryRing: TSmartObject_GetIsAngryRing;                    // ���˽�ָ ������Ʒ 170
    SetIsAngryRing: TSmartObject_SetIsAngryRing;

    GetIsStarRing: TSmartObject_GetIsStarRing;                      // ���ǽ�ָ
    SetIsStarRing: TSmartObject_SetIsStarRing;

    GetIsACItem: TSmartObject_GetIsACItem;                          // ������Ʒ
    SetIsACItem: TSmartObject_SetIsACItem;

    GetACItemValue: TSmartObject_GetACItemValue;                    // ����ֵ
    SetACItemValue: TSmartObject_SetACItemValue;

    GetIsMACItem: TSmartObject_GetIsMACItem;                        // ħ����Ʒ
    SetIsMACItem: TSmartObject_SetIsMACItem;

    GetMACItemValue: TSmartObject_GetMACItemValue;                  // ħ��ֵ
    SetMACItemValue: TSmartObject_SetMACItemValue;

    GetIsNoDropItem: TSmartObject_GetIsNoDropItem;                  // 171����������Ʒװ��
    SetIsNoDropItem: TSmartObject_SetIsNoDropItem;

    GetIsNoDropUseItem: TSmartObject_GetIsNoDropUseItem;            // 172����������Ʒװ��
    SetIsNoDropUseItem: TSmartObject_SetIsNoDropUseItem;            // �ڹ�����

    GetNGAbility: TSmartObject_GetNGAbility;
    SetNGAbility: TSmartObject_SetNGAbility;

    GetAlcohol: TSmartObject_GetAlcohol;                            // ������
    SetAlcohol: TSmartObject_SetAlcohol;

    RepairAllItem: TSmartObject_RepairAllItem;                      // �޸�����װ��
    IsAllowUseMagic: TSmartObject_IsAllowUseMagic;                  // �Ƿ����㼼��ʹ������

    SelectMagic: TSmartObject_SelectMagic;                          // ѡ����

    AttackTarget: TSmartObject_AttackTarget;                        // ����Ŀ��

    Reserved: array[0..99] of Pointer;
  end;

  TPlayObjectFunc = record
    GetUserID: TPlayObject_GetUserID;                               // �ʻ���
    GetIPAddr: TPlayObject_GetIPAddr;                               // IP
    GetIPLocal: TPlayObject_GetIPLocal;                             // IP������
    GetMachineID: TPlayObject_GetMachineID;                         // MAC
    GetIsReadyRun: TPlayObject_GetIsReadyRun;                       // �Ƿ������Ϸ���
    GetLogonTime: TPlayObject_GetLogonTime;                         // ��¼ʱ��

    GetSoftVerDate: TPlayObject_GetSoftVerDate;                     // �ͻ��˰汾��
    GetClientType: TPlayObject_GetClientType;                       // �ͻ������� (0:176; 1:185; 2:Ӣ�۰�; 3:������; 4:��������; 5:�⴫; 6:����)

    IsOldClient: TPlayObject_IsOldClient;                           // �Ƿ�Ϊ�Ͽͻ��� (185���ݿͻ���)

    GetScreenWidth: TPlayObject_GetScreenWidth;                     // �ͻ��˷ֱ��� ��
    GetScreenHeight: TPlayObject_GetScreenHeight;                   // �ͻ��˷ֱ��� ��

    GetClientViewRange: TPlayObject_GetClientViewRange;             // �ͻ����Ӿ���Χ��С

    GetRelevel: TPlayObject_GetRelevel;                             // ת���ȼ�
    SetRelevel: TPlayObject_SetRelevel;

    GetBonusPoint: TPlayObject_GetBonusPoint;                       // δ�������Ե�
    SetBonusPoint: TPlayObject_SetBonusPoint;
    SendAdjustBonus: TPlayObject_SendAdjustBonus;                   // �������Ե�

    GetHeroName: TPlayObject_GetHeroName;                           // ����Ӣ����
    GetDeputyHeroName: TPlayObject_GetDeputyHeroName;               // ����Ӣ����
    GetDeputyHeroJob: TPlayObject_GetDeputyHeroJob;                 // ����Ӣ��ְҵ
    GetMyHero: TPlayObject_GetMyHero;                               // Ӣ�۶���

    GetFixedHero: TPlayObject_GetFixedHero;                         // �Ƿ���������Ӣ��

    ClientHeroLogOn: TPlayObject_ClientHeroLogOn;                   // �ٻ�Ӣ��

    GetStorageHero: TPlayObject_GetStorageHero;                     // Ӣ���Ƿ�Ĵ�
    GetStorageDeputyHero: TPlayObject_GetStorageDeputyHero;         // ����Ӣ���Ƿ�Ĵ�

    GetIsStorageOpen: TPlayObject_GetIsStorageOpen;                 // �ֿ��Ƿ��� Index:�ֿ����(0-3);
    SetIsStorageOpen: TPlayObject_SetIsStorageOpen;

    GetGold: TPlayObject_GetGold;                                   // �������
    SetGold: TPlayObject_SetGold;
    GetGoldMax: TPlayObject_GetGoldMax;                             // �����������ɴ����

    IncGold: TPlayObject_IncGold;                                   // �ӽ��
    DecGold: TPlayObject_DecGold;                                   // �����                  
    GoldChanged: TPlayObject_GoldChanged;                           // ֪ͨ�ͻ���ˢ�� (��ң�Ԫ��)

    GetGameGold: TPlayObject_GetGameGold;                           // Ԫ������
    SetGameGold: TPlayObject_SetGameGold;                         
    IncGameGold: TPlayObject_IncGameGold;                           // ��Ԫ��
    DecGameGold: TPlayObject_DecGameGold;                           // ��Ԫ��
    GameGoldChanged: TPlayObject_GameGoldChanged;                   // ֪ͨ�ͻ���ˢ�� (Ԫ������Ϸ��)

    GetGamePoint: TPlayObject_GetGamePoint;                         // ��Ϸ��
    SetGamePoint: TPlayObject_SetGamePoint;                         // ������Ϸ��                  
    IncGamePoint: TPlayObject_IncGamePoint;                         // ����Ϸ��
    DecGamePoint: TPlayObject_DecGamePoint;                         // ����Ϸ��                  

    GetGameDiamond: TPlayObject_GetGameDiamond;                     // ���ʯ                  
    SetGameDiamond: TPlayObject_SetGameDiamond;                     
    IncGameDiamond: TPlayObject_IncGameDiamond;                     // �ӽ��ʯ
    DecGameDiamond: TPlayObject_DecGameDiamond;                     // �����ʯ
    NewGamePointChanged: TPlayObject_NewGamePointChanged;           // ֪ͨ�ͻ���ˢ�� (���ʯ�����)

    GetGameGird: TPlayObject_GetGameGird;                           // ���
    SetGameGird: TPlayObject_SetGameGird;                         
    IncGameGird: TPlayObject_IncGameGird;                           // �����
    DecGameGird: TPlayObject_DecGameGird;                           // �����

    GetGameGoldEx: TPlayObject_GetGameGoldEx;                       // ����Ϸ��
    SetGameGoldEx: TPlayObject_SetGameGoldEx;

    GetGameGlory: TPlayObject_GetGameGlory;                         // ����
    SetGameGlory: TPlayObject_SetGameGlory;
    IncGameGlory: TPlayObject_IncGameGlory;                         // ������
    DecGameGlory: TPlayObject_DecGameGlory;                         // ������
    GameGloryChanged: TPlayObject_GameGloryChanged;                 // ֪ͨ�ͻ���ˢ������

    GetPayMentPoint: TPlayObject_GetPayMentPoint;                   // ��ֵ��
    SetPayMentPoint: TPlayObject_SetPayMentPoint;

    GetMemberType: TPlayObject_GetMemberType;                       // ��Ա����
    SetMemberType: TPlayObject_SetMemberType;
    GetMemberLevel: TPlayObject_GetMemberLevel;                     // ��Ա�ȼ�
    SetMemberLevel: TPlayObject_SetMemberLevel;

    GetContribution: TPlayObject_GetContribution;                   // ���׶�
    SetContribution: TPlayObject_SetContribution;

    IncExp: TPlayObejct_IncExp;                                     // �Ӿ��飬����Щ�������Զ�ˢ�¿ͻ���
    SendExpChanged: TPlayObject_SendExpChanged;                     // ����ı�

    IncExpNG: TPlayObject_IncExpNG;                                 // ���ڹ����飬����Щ�������Զ�ˢ�¿ͻ���
    SendExpNGChanged: TPlayObject_SendExpNGChanged;                 // �ڹ�����ı�

    IncBeadExp: TPlayObject_IncBeadExp;                             // ���Ӿ����龭��
                                                                                      
    GetVarP: TPlayObject_GetVarP;                                   // P���� m_nVal  [0..999]
    SetVarP: TPlayObject_SetVarP;
                                                                                      
    GetVarM: TPlayObject_GetVarM;                                   // M���� m_nMval [0..999]
    SetVarM: TPlayObject_SetVarM;                                                           

    GetVarD: TPlayObject_GetVarD;                                   // D���� m_DyVal [0..999]
    SetVarD: TPlayObject_SetVarD;
                                                                                            
    GetVarU: TPlayObject_GetVarU;                                   // U���� m_UVal [0..254]
    SetVarU: TPlayObject_SetVarU;

    GetVarT: TPlayObject_GetVarT;                                   // T���� m_UVal [0..254]
    SetVarT: TPlayObject_SetVarT;

    GetVarN: TPlayObject_GetVarN;                                   // N���� m_nInteger [0..999]
    SetVarN: TPlayObject_SetVarN;

    GetVarS: TPlayObject_GetVarS;                                   // S���� m_sString [0..999]
    SetVarS: TPlayObject_SetVarS;

    GetDynamicVarList: TPlayObject_GetDynamicVarList;               // �Զ��嶯̬�����б� (�����Ԫ��Ϊ pTDynamicVar)

    GetQuestFlagStatus: TPlayObject_GetQuestFlagStatus;
    SetQuestFlagStatus: TPlayObject_SetQuestFlagStatus;

    IsOffLine: TPlayObject_IsOffLine;                               // �Ƿ����߹һ�

    IsMaster: TPlayObject_IsMaster;                                 // �Ƿ���ʦ��
    GetMasterName: TPlayObject_GetMasterName;                       // ȡ��ʦ������
    GetMasterHuman: TPlayObject_GetMasterHuman;                     // ʦ��

    GetApprenticeNO: TPlayObject_GetApprenticeNO;                   // ����ɫΪͽ��ʱ��ͽ������
    GetOnlineApprenticeList: TPlayObject_GetOnlineApprenticeList;   // ����ͽ���б�
    GetAllApprenticeList: TPlayObject_GetAllApprenticeList;         // ����ͽ���б� (�����Ԫ��Ϊ pTMasterRankInfo)

    GetDearName: TPlayObject_GetDearName;                           // ȡ�ð�������
    GetDearHuman: TPlayObject_GetDearHuman;                         // ����
    GetMarryCount: TPlayObject_GetMarryCount;                       // ������                     

    GetGroupOwner: TPlayObject_GetGroupOwner;                       // �ӳ�
    GetGroupMembers: TPlayObject_GetGroupMembers;                   // ��Ա�б� Item: ��Ա�� Objects: _TBaseObject

    GetIsLockLogin: TPlayObject_GetIsLockLogin;                     // ������¼
    SetIsLockLogin: TPlayObject_SetIsLockLogin;

    GetIsAllowGroup: TPlayObject_GetIsAllowGroup;                   // �Ƿ��������
    SetIsAllowGroup: TPlayObject_SetIsAllowGroup;

    GetIsAllowGroupReCall: TPlayObject_GetIsAllowGroupReCall;       // �Ƿ�������غ�һ
    SetIsAllowGroupReCall: TPlayObject_SetIsAllowGroupReCall;

    GetIsAllowGuildReCall: TPlayObject_GetIsAllowGuildReCall;       // �Ƿ������л��һ
    SetIsAllowGuildReCall: TPlayObject_SetIsAllowGuildReCall;

    GetIsAllowTrading: TPlayObject_GetIsAllowTrading;               // ������
    SetIsAllowTrading: TPlayObject_SetIsAllowTrading;

    GetIsDisableInviteHorseRiding: TPlayObject_GetIsDisableInviteHorseRiding;     // ��ֹ��������
    SetIsDisableInviteHorseRiding: TPlayObject_SetIsDisableInviteHorseRiding;

    GetIsGameGoldTrading: TPlayObject_GetIsGameGoldTrading;                       // �Ƿ���Ԫ������
    SetIsGameGoldTrading: TPlayObject_SetIsGameGoldTrading;

    GetIsNewServer: TPlayObject_GetIsNewServer;                                   // �Ϲ���û�е�¼����

    GetIsFilterGlobalDropItemMsg: TPlayObject_GetIsFilterGlobalDropItemMsg;       // ���˵�����ʾ��Ϣ
    SetIsFilterGlobalDropItemMsg: TPlayObject_SetIsFilterGlobalDropItemMsg;

    GetIsFilterGlobalCenterMsg: TPlayObject_GetIsFilterGlobalCenterMsg;           // ����SendCenterMsg
    SetIsFilterGlobalCenterMsg: TPlayObject_SetIsFilterGlobalCenterMsg;

    GetIsFilterGolbalSendMsg: TPlayObject_GetIsFilterGolbalSendMsg;               // ����SendMsgȫ����Ϣ
    SetIsFilterGolbalSendMsg: TPlayObject_SetIsFilterGolbalSendMsg;

    GetIsPleaseDrink: TPlayObject_GetIsPleaseDrink;                 // �Ƿ������

    GetIsDrinkWineQuality: TPlayObject_GetIsDrinkWineQuality;       // ����ʱ�Ƶ�Ʒ��
    SetIsDrinkWineQuality: TPlayObject_SetIsDrinkWineQuality;

    GetIsDrinkWineAlcohol: TPlayObject_GetIsDrinkWineAlcohol;       // ����ʱ�ƵĶ���
    SetIsDrinkWineAlcohol: TPlayObject_SetIsDrinkWineAlcohol;

    GetIsDrinkWineDrunk: TPlayObject_GetIsDrinkWineDrunk;           // ���Ƿ�Ⱦ�����
    SetIsDrinkWineDrunk: TPlayObject_SetIsDrinkWineDrunk;

    MoveToHome: TPlayObject_MoveToHome;                             // �س�
    MoveRandomToHome: TPlayObject_MoveRandomToHome;                 // ������͵��سǵ�ͼ

    SendSocket: TPlayObject_SendSocket;                             // ��������
    SendDefMessage: TPlayObject_SendDefMessage;                     // ������Ϣ
    SendMoveMsg: TPlayObject_SendMoveMsg;
    SendCenterMsg: TPlayObject_SendCenterMsg;
    SendTopBroadCastMsg: TPlayObject_SendTopBroadCastMsg;

    CheckTakeOnItems: TPlayObject_CheckTakeOnItems;                 // ���װ���Ƿ�ɴ���
    ProcessUseItemSkill: TPlayObject_ProcessUseItemSkill;           // ����װ������ʱ��Ӧ�ļ���

    SendUseItems: TPlayObject_SendUseItems;                         // ��������װ���б�
    SendAddItem: TPlayObject_SendAddItem;                           // ����������Ʒ
    SendDelItemList: TPlayObject_SendDelItemList;                   // �ͻ���ɾ�������Ʒ ItemList.AddObject(��Ʒ����, MakeIndex)
    SendDelItem: TPlayObject_SendDelItem;                           // �ͻ���ɾ����Ʒ
    SendUpdateItem: TPlayObject_SendUpdateItem;                     // �ͻ���ˢ����Ʒ
    SendItemDuraChange: TPlayObject_SendItemDuraChange;             // �ͻ���ˢ��װ���־øı�

    SendBagItems: TPlayObject_SendBagItems;                         // ˢ�¿ͻ��˰���

    SendJewelryBoxItems: TPlayObject_SendJewelryBoxItems;           // �������κ���Ʒ

    SendGodBlessItems: TPlayObject_SendGodBlessItems;               // �������Ӵ���Ʒ
    SendOpenGodBlessItem: TPlayObject_SendOpenGodBlessItem;         // ���Ӹ���
    SendCloseGodBlessItem: TPlayObject_SendCloseGodBlessItem;       // ���Ӹ�ر�

    SendUseMagics: TPlayObject_SendUseMagics;                       // ���ͼ����б�
    SendAddMagic: TPlayObject_SendAddMagic;                         // ���ͼ������
    SendDelMagic: TPlayObject_SendDelMagic;                         // ���ͼ���ɾ��

    SendFengHaoItems: TPlayObject_SendFengHaoItems;                 // ���ͷ����Ʒ
    SendAddFengHaoItem: TPlayObject_SendAddFengHaoItem;             // ���ͷ������
    SendDelFengHaoItem: TPlayObject_SendDelFengHaoItem;             // ���ͷ��ɾ��

    SendSocketStatusFail: TPlayObject_SendSocketStatusFail;         // ������·/�ܲ�ʧ��

    PlayEffect: TPlayObject_PlayEffect;
    IsAutoPlayGame: TPlayObject_IsAutoPlayGame;                     // �Ƿ������ڹҹһ�
    StartAutoPlayGame: TPlayObject_StartAutoPlayGame;               // ��ʼ�ڹҹһ�
    StopAutoPlayGame: TPlayObject_StopAutoPlayGame;                 // ֹͣ�ڹҹһ�

    Reserved: array[0..99] of Pointer;
  end;

  TDummyObjectFunc = record
    IsStart: TDummyObject_IsStart;                                  // �����Ƿ�ʼ�һ�
    Start: TDummyObject_Start;                                      // ���˿�ʼ�һ�
    Stop: TDummyObject_Stop;                                        // ����ֹͣ�һ�

    Reserved: array[0..99] of Pointer;
  end;

  THeroObjectFunc = record
    GetAttackMode: THeroObject_GetAttackMode;                       // ����ģʽ
    SetAttackMode: THeroObject_SetAttackMode;
    SetNextAttackMode: THeroObject_SetNextAttackMode;               // �л���һ������ģʽ

    GetBagCount: THeroObject_GetBagCount;                           // ��ȡ��������
    GetAngryValue: THeroObject_GetAngryValue;                       // ��ǰŭ��ֵ

    GetLoyalPoint: THeroObject_GetLoyalPoint;                       // �ҳ϶�
    SetLoyalPoint: THeroObject_SetLoyalPoint;
    SendLoyalPointChanged: THeroObject_SendLoyalPointChanged;       // �ҳ϶ȸı�

    IsDeputy: THeroObject_IsDeputy;                                 // �Ƿ񸱽�Ӣ��
    GetMasterName: THeroObject_GetMasterName;                       // ��������

    GetQuestFlagStatus: THeroObject_GetQuestFlagStatus;
    SetQuestFlagStatus: THeroObject_SetQuestFlagStatus;

    SendUseItems: THeroObject_SendUseItems;                         // ��������װ��
    SendBagItems: THeroObject_SendBagItems;                         // ˢ��Ӣ�۱���

    SendJewelryBoxItems: THeroObject_SendJewelryBoxItems;           // �������κ���Ʒ

    SendGodBlessItems: THeroObject_SendGodBlessItems;               // �������Ӵ���Ʒ
    SendOpenGodBlessItem: THeroObject_SendOpenGodBlessItem;         // ���Ӹ���
    SendCloseGodBlessItem: THeroObject_SendCloseGodBlessItem;       // ���Ӹ�ر�

    SendAddItem: THeroObject_SendAddItem;                           // ����������Ʒ
    SendDelItem: THeroObject_SendDelItem;                           // �ͻ���ɾ����Ʒ
    SendUpdateItem: THeroObject_SendUpdateItem;                     // �ͻ���ˢ����Ʒ                
    SendItemDuraChange: THeroObject_SendItemDuraChange;             // �ͻ���ˢ��װ���־øı�                

    SendUseMagics: THeroObject_SendUseMagics;                       // ���ͼ����б�                
    SendAddMagic: THeroObject_SendAddMagic;                         // ���ͼ������                
    SendDelMagic: THeroObject_SendDelMagic;                         // ���ͼ���ɾ��

    FindGroupMagic: THeroObject_FindGroupMagic;                     // ȡ�úϻ�����                
    GetGroupMagicId: THeroObject_GetGroupMagicId;                   // ȡ�úϻ�����ID

    SendFengHaoItems: THeroObject_SendFengHaoItems;                 // ���ͷ����Ʒ
    SendAddFengHaoItem: THeroObject_SendAddFengHaoItem;             // ���ͷ������                
    SendDelFengHaoItem: THeroObject_SendDelFengHaoItem;             // ���ͷ��ɾ��

    IncExp: THeroObject_IncExp;                                     // �Ӿ���
    IncExpNG: THeroObject_IncExpNG;                                 // ���ڹ�����

    IsOldClient: THeroObject_IsOldClient;

    Reserved: array[0..99] of Pointer;
  end;

  TNormNpcFunc = record                                             // ����NPC
    Create: TNormNpc_Create;

    LoadNpcScript: TNormNpc_LoadNpcScript;                          // ����ű�
    ClearScript: TNormNpc_ClearScript;                              // ����ű�

    GetFilePath: TNormNpc_GetFilePath;
    SetFilePath: TNormNpc_SetFilePath;

    GetPath: TNormNpc_GetPath;
    SetPath: TNormNpc_SetPath;

    GetIsHide: TNormNpc_GetIsHide;
    SetIsHide: TNormNpc_SetIsHide;

    GetIsQuest: TNormNpc_GetIsQuest;

    GetLineVariableText: TNormNpc_GetLineVariableText;

    GotoLable: TNormNpc_GotoLable;
    SendMsgToUser: TNormNpc_SendMsgToUser;
    MessageBox: TNormNpc_MessageBox;

    GetVarValue: TNormNpc_GetVarValue;
    SetVarValue: TNormNpc_SetVarValue;
    GetDynamicVarValue: TNormNpc_GetDynamicVarValue;
    SetDynamicVarValue: TNormNpc_SetDynamicVarValue;

    Reserved: array[0..99] of Pointer;
  end;

  TUserEngineFunc = record
    GetPlayerList: TUserEngine_GetPlayerList;                       // ��ȡ�������������б�(������)
    GetPlayerByName: TUserEngine_GetPlayerByName;                   // ���������������ƻ�ȡ����
    GetPlayerByUserID: TUserEngine_GetPlayerByUserID;               // ���������ʻ���ȡ����
    GetPlayerByObject: TUserEngine_GetPlayerByObject;               // �ж϶����Ƿ���һ���Ϸ�����������

    GetOfflinePlayer: TUserEngine_GetOfflinePlayer;                 // �����ʻ���ȡһ�����߹һ�����
    KickPlayer: TUserEngine_KickPlayer;                             // ����

    GetHeroList: TUserEngine_GetHeroList;                           // ��ȡӢ���б�
    GetHeroByName: TUserEngine_GetHeroByName;                       // �������ƻ�ȡӢ�۶���
    KickHero: TUserEngine_KickHero;                                 // ��Ӣ��

    GetMerchantList: TUserEngine_GetMerchantList;                   // ��ȡ����NPC�б�
    GetCustomNpcConfigList: TUserEngine_GetCustomNpcConfigList;     // ��ȡ�Զ���NPC�����б�

    GetQuestNPCList: TUserEngine_GetQuestNPCList;                   // ��ȡMapQuest.txt�ж����NPC�б�
    GetManageNPC: TUserEngine_GetManageNPC;
    GetFunctionNPC: TUserEngine_GetFunctionNPC;
    GetRobotNPC: TUserEngine_GetRobotNPC;
    MissionNPC: TUserEngine_MissionNPC;

    FindMerchant: TUserEngine_FindMerchant;                         // �ж�NPC�����Ƿ�Ϸ�
    FindMerchantByPos: TUserEngine_FindMerchantByPos;               // ���ݵ�ͼ����õ�NPC

    FindQuestNPC: TUserEngine_FindQuestNPC;                         // �ж�NPC�����Ƿ�Ϸ�                 

    GetMagicList: TUserEngine_GetMagicList;                         // Magic.DB
    GetCustomMagicConfigList: TUserEngine_GetCustomMagicConfigList; // �Զ��弼�������б�
    GetMagicACList: TUserEngine_GetMagicACList;                     // M2 -> �������� ->����ħ�� -> �����Ʒ��ٷֱ�

    FindMagicByName: TUserEngine_FindMagicByName;                   // ���ݼ��������Ҽ���                 
    FindMagicByIndex: TUserEngine_FindMagicByIndex;                 // ���ݼ��ܱ�Ų��Ҽ���
    FindMagicByNameEx: TUserEngine_FindMagicByNameEx;               // ���ݼ����������Բ��Ҽ���                 
    FindMagicByIndexEx: TUserEngine_FindMagicByIndexEx;             // ���ݼ��ܱ�ż����Բ��Ҽ���

    FindHeroMagicByName: TUserEngine_FindHeroMagicByName;           // ���ݼ���������Ӣ�ۼ���
    FindHeroMagicByIndex: TUserEngine_FindHeroMagicByIndex;         // ���ݼ��ܱ�Ų���Ӣ�ۼ���
    FindHeroMagicByNameEx: TUserEngine_FindHeroMagicByNameEx;       // ���ݼ����������Բ���Ӣ�ۼ���
    FindHeroMagicByIndexEx: TUserEngine_FindHeroMagicByIndexEx;     // ���ݼ��ܱ�ż����Բ���Ӣ�ۼ���


    GetStdItemList: TUserEngine_GetStdItemList;                     // StdItem.DB
    GetStdItemByName: TUserEngine_GetStdItemByName;                 // ������Ʒ���õ����ݿ����Ʒ��Ϣ
    GetStdItemByIndex: TUserEngine_GetStdItemByIndex;               // ������Ʒ��ŵõ����ݿ����Ʒ��Ϣ                 
    GetStdItemName: TUserEngine_GetStdItemName;                     // ������Ʒ��ŵõ���Ʒ��
    GetStdItemIndex: TUserEngine_GetStdItemIndex;                   // ������Ʒ���õ���Ʒ���

    MonsterList: TUserEngine_MonsterList;                           // Monster.DB

    SendBroadCastMsg: TUserEngine_SendBroadCastMsg;
    SendBroadCastMsgExt: TUserEngine_SendBroadCastMsgExt;
    SendTopBroadCastMsg: TUserEngine_SendTopBroadCastMsg;
    SendMoveMsg: TUserEngine_SendMoveMsg;
    SendCenterMsg: TUserEngine_SendCenterMsg;
    SendNewLineMsg: TUserEngine_SendNewLineMsg;                     // ������Ϣ
    SendSuperMoveMsg: TUserEngine_SendSuperMoveMsg;                 // ��ʢ�󶥲�������Ϣ
    SendSceneShake: TUserEngine_SendSceneShake;                     // ������Ļ����Ϣ

    CopyToUserItemFromName: TUserEngine_CopyToUserItemFromName;     // �������Ԫ������
    CopyToUserItemFromItem: TUserEngine_CopyToUserItemFromItem;

    RandomUpgradeItem: TUserEngine_RandomUpgradeItem;
    RandomItemNewAbil: TUserEngine_RandomItemNewAbil;
    GetUnknowItemValue: TUserEngine_GetUnknowItemValue;

    GetAllDummyCount: TUserEngine_GetAllDummyCount;                 // ���м�������
    GetMapDummyCount: TUserEngine_GetMapDummyCount;                 // ָ����ͼ��������
    GetOfflineCount: TUserEngine_GetOfflineCount;                   // ���߹һ���������
    GetRealPlayerCount: TUserEngine_GetRealPlayerCount;             // ������������(�������߹һ�)

    Reserved: array[0..99] of Pointer;
  end;

  TGuildManagerFunc = record
    FindGuild: TGuildManager_FindGuild;                             // �����л����õ��л����
    GetPlayerGuild: TGuildManager_GetPlayerGuild;                   // �����û����õ��л����
    AddGuild: TGuildManager_AddGuild;                               // �������л�
    DelGuild: TGuildManager_DelGuild;                               // ɾ���лᣬ�г�Աʱ����ɾ

    Reserved: array[0..99] of Pointer;
  end;

  TGuildFunc = record
    GetGuildName: TGuild_GetGuildName;                              // �л�����

    GetJoinJob: TGuild_GetJoinJob;                                  // �����л�ְҵ (1:սʿ; 2:��ʦ; 3:��ʿ�������)
    GetJoinLevel: TGuild_GetJoinLevel;                              // �����л���͵ȼ�
    GetJoinMsg: TGuild_GetJoinMsg;                                  // ������Ϣ

    GetBuildPoint: TGuild_GetBuildPoint;                            // ������
    GetAurae: TGuild_GetAurae;                                      // ����ֵ/��ע��
    GetStability: TGuild_GetStability;                              // ������
    GetFlourishing: TGuild_GetFlourishing;                          // ���ٶ�
    GetChiefItemCount: TGuild_GetChiefItemCount;                    // ��ȡװ������

    GetMemberCount: TGuild_GetMemberCount;                          // �л��Ա����
    GetOnlineMemeberCount: TGuild_GetOnlineMemeberCount;            // �����л��Ա����
    GetMasterCount: TGuild_GetMasterCount;                          // ��������

    GetMaster: TGuild_GetMaster;                                    // �õ��л���������
    GetMasterName: TGuild_GetMasterName;                            // �õ��л�������������

    CheckMemberIsFull: TGuild_CheckMemberIsFull;                    // ����л��Ƿ���Ա
    IsMemeber: TGuild_IsMemeber;                                    // �����Ա�Ƿ�Ϊ�л��Ա

    AddMember: TGuild_AddMember;                                    // ��Ա�����л�
    AddMemberEx: TGuild_AddMemberEx;

    DelMemeber: TGuild_DelMemeber;                                  // �л�ɾ����Ա
    DelMemeberEx: TGuild_DelMemeberEx;

    IsAllianceGuild: TGuild_IsAllianceGuild;                        // �ж� CheckGuild�Ƿ���Guild�������л�
    IsWarGuild: TGuild_IsWarGuild;                                  // �ж��Ƿ�Ϊս���л�
    IsAttentionGuild: TGuild_IsAttentionGuild;                      // �ж��Ƿ�Ϊ��ע�л�

    AddAlliance: TGuild_AddAlliance;                                // ��������л�
    AddWarGuild: TGuild_AddWarGuild;                                // ���ս���л�
    AddAttentionGuild: TGuild_AddAttentionGuild;                    // ��ӹ�ע�л�

    DelAllianceGuild: TGuild_DelAllianceGuild;                      // ɾ�������л�
    DelAttentionGuild: TGuild_DelAttentionGuild;                    // ɾ����ע�л�

    GetRandNameByName: TGuild_GetRandNameByName;
    GetRandNameByPlayer: TGuild_GetRandNameByPlayer;

    SendGuildMsg: TGuild_SendGuildMsg;                              // �����л���Ϣ

    Reserved: array[0..99] of Pointer;
  end;

type
  PAppFuncDef = ^TAppFuncDef;
  TAppFuncDef = record
    PluginID: NativeInt;                                            // ���ID

    Memory: TMemoryFunc;                                            // �ڴ����
    List: TListFunc;                                                // �б�
    StringList: TStringListFunc;                                    // �ַ����б�
    MemStream: TMemoryStreamFunc;                                   // �ڴ���
    Menu: TMemuFunc;                                                // �˵�
    IniFile: TIniFileFunc;                                          // Ini�ļ�
    MagicACList: TMagicACListFunc;                                  // �����Ʒ�
    MapManager: TMapManagerFunc;                                    // ��ͼ����
    Envir: TEnvirnomentFunc;                                        // ��ͼ
    M2Engine: TM2EngineFunc;                                        // M2����
    BaseObject: TBaseObjectFunc;                                    // ��������
    Smarter: TSmartObjectFunc;                                      // ���ܶ���
    Player: TPlayObjectFunc;                                        // ����
    Dummy: TDummyObjectFunc;                                        // ����
    Hero: THeroObjectFunc;                                          // Ӣ��
    Npc: TNormNpcFunc;                                              // NPC
    UserEngine: TUserEngineFunc;
    GuildManager: TGuildManagerFunc;                                // �л����
    Guild: TGuildFunc;                                              // �л�


    Reserved: array[0..999] of Pointer;
  end;


  //---------------------------------------------------------------------------
  //----------------------�����ǲ��֧�ֵĵ�������-----------------------------
  //---------------------------------------------------------------------------

  {

  // �����ʼ��
  function Init(AppFunc: PAppFuncDef; AppFuncCrc: DWORD;
    ExtParam: DWORD; Desc: PAnsiChar; var DescLen: DWORD): BOOL; stdcall;

  // �������ʼ��
  procedure UnInit(); stdcall;

  // Hook IP�����ز�ѯ
  function HookGetIPLocal(sIPaddr: PAnsiChar;
    Dest: PAnsiChar; var DestLen: DWORD): BOOL; stdcall;

  // ����׼������
  procedure HookEngineReadyToStart(); stdcall;

  // �����������
  procedure HookEngineStartComplete(); stdcall;

  // HOOK M2���¼�����Ϣ��� (����-> ���¼��� ->... �������)
  procedure HookEngineReloadComplete(ReloadType: Integer); stdcall;

  // Hook ���ؽű��ļ�
  function HookLoadScriptFile(FileName: PAnsiChar;
    MemStream: _TMemoryStream): BOOL; stdcall;

  // Hook �ű��ļ����� (����г��⣬ʣ�µĲ���һ�ν���)
  // �ű���1�н��ܱ��Ϊ ;-------****-------
  function HookDecryptScriptFile(Src: PAnsiChar; SrcLen: DWORD;
    Dest: PAnsiChar; var DestLen: DWORD): BOOL; stdcall;

  // Hook ���н��ܽű� (һ���н���)
  // �ű���1�н��ܱ��Ϊ ;+++++++****+++++++
  function HookDecryptScriptLine(Src: PAnsiChar; SrcLen: DWORD;
    Dest: PAnsiChar; var DestLen: DWORD): BOOL; stdcall;

  // Hook NPC�����ж������������ֵ:1 - 500��ʾ��������������
  function HookNpcLoadConditionCmd(pCmd: PAnsiChar): Integer; stdcall;

  // Hook NPC�����ж�ִ������
  function HookNpcConditionProcess(ScriptParam: PScriptCmdParam): BOOL; stdcall;

  // Hook NPCִ�������������ֵ:1 - 500��ʾ��������������
  function HookNpcLoadActionCmd(pCmd: PAnsiChar): Integer; stdcall;

  // Hook NPCִ������
  procedure HookNpcActionProcess(ScriptParam: PScriptCmdParam;
    var boSendMerChantSay, boBreak: BOOL); stdcall;

  // Hook �û����NPC����
  function HookUserSelect(Merchant: TMerchant; PlayObject: _TPlayObject;
    sLabel, sMsg: PAnsiChar): BOOL; stdcall;

  // Hook �Զ������������
  function HookUserCommand(PlayObject: _TPlayObject; pCmd, pParam1, pParam2,
    pParam3, pParam4, pParam5, pParam6, pParam7: PAnsiChar): BOOL; stdcall;

  // Hook ��ȡ�Զ������ֵ
  function HookGetVariableText(NPC: _TNormNpc; PlayObject: _TPlayObject;
    sVariable: PAnsiChar; sValue: PAnsiChar; var nValueLen: DWORD): BOOL; stdcall;

  // Hook BaseObject����
  procedure HookBaseObjectCreate(BaseObject: _TBaseObject); stdcall;

  // Hook BaseObject�������Կ�ʼ
  procedure HookBaseObjectRecalAbilBegin(BaseObject: _TBaseObject); stdcall;

  // Hook BaseObject�������Խ���
  procedure HookBaseObjectRecalAbilEnd(BaseObject: _TBaseObject); stdcall;

  // Hook BaseObject��������
  procedure HookBaseObjectRun(BaseObject: _TBaseObject); stdcall;

  // Hook BaseObject�Զ�����Ϣ���� 2021-01-05 changed
  procedure HookBaseObjectProcessMsg(BaseObject: _TBaseObject;
    wIdent: Word; wParam: Integer; nParam1, nParam2, nParam3: NativeInt; 
    MsgObject: _TObject; dwDeliveryTime: LongWord;
    pMsg: PAnsiChar; var boReturn: BOOL); stdcall;

  // Hook BaseObject�ܵ�������
  procedure HookBaseObjectStruck(BaseObject: _TBaseObject;
    AttackObject: _TBaseObject); stdcall;

  // Hook BaseObject�ܵ�ħ������
  procedure HookBaseObjectMagicStruck(BaseObject: _TBaseObject;
    AttackObject: _TBaseObject; MagicIdx: Integer); stdcall;

  // Hook BaseObject������Ŀ��
  procedure HookBaseObjectAttack(BaseObject: _TBaseObject;
    Target: _TBaseObject; MagicIdx: Integer; var nPower: Integer); stdcall;

  // Hook BaseObjectħ������Ŀ��
  procedure HookBaseObjectMagicAttack(BaseObject: _TBaseObject;
    Target: _TBaseObject; MagicIdx: Integer; var nPower: Integer); stdcall;

  // Hook BaseObject����
  procedure HookBaseObjectDie(BaseObject: _TBaseObject); stdcall;

  // Hook BaseObject����ʬ��
  procedure HookBaseObjectMakeGhost(BaseObject: _TBaseObject); stdcall;

  // Hook BaseObject�����ͷ�
  procedure HookBaseObjectFree(BaseObject: _TBaseObject); stdcall;

  // Hook PlayObject���󴴽�
  procedure HookPlayerCreate(PlayObject: _TPlayObject); stdcall;

  // Hook PlayObject�����¼1
  procedure HookPlayerLogin1(PlayObject: _TPlayObject); stdcall;

  // Hook PlayObject�����¼2
  procedure HookPlayerLogin2(PlayObject: _TPlayObject); stdcall;

  // Hook PlayObject�����¼3
  procedure HookPlayerLogin3(PlayObject: _TPlayObject); stdcall;

  // Hook PlayObject�����¼4
  procedure HookPlayerLogin4(PlayObject: _TPlayObject); stdcall;

  // Hook PlayObject��������
  procedure HookPlayerRun(PlayObject: _TPlayObject); stdcall;

  // Hook PlayObject������Ұ��Χ�ڷ����¶���
  procedure HookPlayerViewRangeNewObject(PlayeObject: _TPlayObject;
    AObject: _TObject; AObjectX, AObjectY: Integer); stdcall;

  // Hook PlayObject��Ϣ����ʼ���� boReturn = Trueʱ��������ϵͳ�����������Ĵ���  2021-01-05 changed
  procedure HookPlayerProcessMsgBegin(PlayObject: _TPlayObject;
      wIdent: Word; wParam: Integer; nParam1, nParam2, nParam3: NativeInt;
      MsgObject: _TObject; dwDeliveryTime: LongWord;
      pMsg: PAnsiChar; var boReturn: BOOL); stdcall;

  // Hook PlayObject��Ϣ����ʼ���� boReturn = Trueʱ�������غ������Ĵ���  2021-01-05 changed
  procedure HookPlayerProcessMsgEnd(PlayObject: _TPlayObject;
      wIdent: Word; wParam: Integer; nParam1, nParam2, nParam3: NativeInt;
      MsgObject: _TObject; dwDeliveryTime: LongWord;
      pMsg: PAnsiChar; var boReturn: BOOL); stdcall;

  // Hook PlayObject�����ͷ�
  procedure HookPlayerFree(PlayObject: _TPlayObject); stdcall;

  // Hook �������п�ʼ���� boReturn = Trueʱ��������ϵͳ�����������Ĵ���
  procedure HookDummyObjectRunBegin(DummyObject: _TDummyObject;
    var boReturn: BOOL); stdcall;

  // Hook �������н���
  procedure HookDummyObjectRunEnd(DummyObject: _TDummyObject); stdcall;

  // Hook Ӣ�۴���
  procedure HookHeroObjectCreate(Hero: _THeroObject); stdcall;

  // Hook Ӣ���ͷ�
  procedure HookHeroObjectFree(Hero: _THeroObject); stdcall;

  }

implementation

end.

