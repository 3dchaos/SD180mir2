unit PluginInterface;

{-------------------------------------------------------------------------------}
{
  M2Server插件接口

  版 本 号: 1.5
  
  发布日期: 2021-01-06

  插件接口约定规则：

    1: 所有逻辑型变量均以长整型BOOL型表示

    2: 所有传出文本型的参数均为: Dest: PAnsiChar; var DestLen: DWORD 的形式

    3: 所有接口均不用结构体，可以用结构体指针

  更新记录:

    1.1: 2018-03-23: 初次发布重新整理后的插件接口

    1.2: 2018-03-27：增加导出接口支持 HookDecryptScriptFile

    1.3: 2018-04-02：修改接口以兼容其它编程语言，使接口更为规范
        a. 修改所有接口中的Boolean型为BOOL
        b. 修改以下接口
           导出函数修改：Init, HookDecryptScriptFile, HookDecryptScriptLine(修改), HookGetVariableText(增加)

    1.4: 2018-04-21 修改货币相关函数Integer ->  DWORD
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

    1.5 2021-01-06，部分数据类型改为NativeInt，用于支持64位
          TBaseObject_SendMsg
          TBaseObject_SendDelayMsg
          TBaseObject_SendRefMsg
          TBaseObject_SendUpdateMsg
          TPlayObject_SendDefMessage
          PluginTypeDef.TDefaultMessage
          相关结构体修改

}
{-------------------------------------------------------------------------------}


interface

uses
  Windows, Classes, SysUtils, PluginTypeDef;

type
  TNotifyEventEx = procedure(Sender: _TObject); stdcall;

  //-------------------------------------------------------------------------------------------------------------------------------------------------------
  //---------------------------------------------- TMemory 内存管理 ---------------------------------------------------------------------------------------
  //-------------------------------------------------------------------------------------------------------------------------------------------------------

  { 申请内存 }
  TMemory_Alloc =
    function (Size: Integer): Pointer; stdcall;

  { 释放内存 }
  TMemory_Free =
    procedure(P: Pointer); stdcall;

  { 重新分配内存大小 (若扩大内存则保留原始内存的值) }
  TMemory_Realloc =
    procedure(P: Pointer; Size: Integer); stdcall;


  //-------------------------------------------------------------------------------------------------------------------------------------------------------
  //---------------------------------------------- TList 对象列表 -----------------------------------------------------------------------------------------
  //-------------------------------------------------------------------------------------------------------------------------------------------------------

  { 列表创建 }
  TList_Create =
    function (): _TList; stdcall;

  { 列表释放 }
  TList_Free =
    procedure(List: _TList); stdcall;

  { 取列表数量 }
  TList_Count =
    function (List: _TList): Integer; stdcall;

  { 清空列表 }
  TList_Clear =
    procedure(List: _TList); stdcall;

  { 添加元素 }
  TList_Add =
    procedure(List: _TList; Item: Pointer); stdcall;

  { 插入元素}
  TList_Insert =
    procedure(List: _TList; Index: Integer; Item: Pointer); stdcall;

  { 根据元素删除 }
  TList_Remove =
     procedure(List: _TList; Item: Pointer); stdcall;

  { 根据索引删除 }
  TList_Delete =
    procedure(List: _TList; Index: Integer); stdcall;

  { 取得元素 }
  TList_GetItem =
    function (List: _TList; Index: Integer): Pointer; stdcall;

  { 设置元素 }
  TList_SetItem =
    procedure(List: _TList; Index: Integer; Item: Pointer); stdcall;

  { 得到元素的索引 }
  TList_IndexOf =
    function (List: _TList; Item: Pointer): Integer; stdcall;

  { 交换元素 }
  TList_Exchange =
    procedure(List: _TList; Index1, Index2: Integer); stdcall;

  { 复制到另一个列表 }
  TList_CopyTo =
    procedure(Source, Dest: _TList); stdcall;

  //-------------------------------------------------------------------------------------------------------------------------------------------------------
  //---------------------------------------------- _TStringList 文本列表 --------------------------------------------------------------------------------------
  //-------------------------------------------------------------------------------------------------------------------------------------------------------

  { 创建文本列表 }
  TStrList_Create =
    function (): _TStringList; stdcall;

  { 释放文本列表}
  TStrList_Free =
    procedure(Strings: _TStringList); stdcall;

  { 判断是否分大小写 }
  TStrList_GetCaseSensitive =
    function (Strings: _TStringList): BOOL; stdcall;

  { 设置是否分大小写 }
  TStrList_SetCaseSensitive =
    procedure(Strings: _TStringList; IsCaseSensitive: BOOL); stdcall;

  { 是否排序 }
  TStrList_GetSorted =
    function (Strings: _TStringList): BOOL; stdcall;

  { 设置是否自动排序 }
  TStrList_SetSorted =
    procedure(Strings: _TStringList; Sorted: BOOL); stdcall;

  { 是否重复}
  TStrList_GetDuplicates =
    function (Strings: _TStringList): BOOL; stdcall;

  { 设置是否允许重复 }
  TStrList_SetDuplicates =
    procedure(Strings: _TStringList; Duplicates: BOOL); stdcall;

  { 取文本行数 }
  TStrList_Count =
    function (Strings: _TStringList): Integer; stdcall;

  { 取得所有内容 }
  TStrList_GetText =
    function (Strings: _TStringList; Dest: PAnsiChar; var DestLen: DWORD): BOOL; stdcall;

  { 设置内容 }
  TStrList_SetText =
    procedure(Strings: _TStringList; Src: PAnsiChar; SrcLen: DWORD); stdcall;

  { 添加一行 }
  TStrList_Add =
    procedure(Strings: _TStringList; S: PAnsiChar); stdcall;

  { 添加一行，并将该行绑定一个对象 }
  TStrList_AddObject =
    procedure(Strings: _TStringList; S: PAnsiChar; AObject: _TObject); stdcall;

  { 插入一行 }
  TStrList_Insert =
    procedure(Strings: _TStringList; Index: Integer; S: PAnsiChar); stdcall;

  { 插入一行，并将该行绑定一个对象 }
  TStrList_InsertObject =
    procedure(Strings: _TStringList; Index: Integer; S: PAnsiChar; AObject: _TObject); stdcall;

  { 根据指定文本的行 }
  TStrList_Remove =
    procedure(Strings: _TStringList; S: PAnsiChar); stdcall;

  { 删除指定的第几行(行数从0开始) }
  TStrList_Delete =
    procedure(Strings: _TStringList; Index: Integer); stdcall;

  { 取一行的内容 }
  TStrList_GetItem =
    function (Strings: _TStringList; Index: Integer;
              Dest: PAnsiChar; var DestLen: DWORD): BOOL; stdcall;

  { 设置某行的内容 }
  TStrList_SetItem =
    procedure(Strings: _TStringList; Index: Integer; S: PAnsiChar); stdcall;

  { 取某行绑定的对象 }
  TStrList_GetObject =
    function (Strings: _TStringList; Index: Integer): _TObject; stdcall;

  { 设置某行的绑定对象 }
  TStrList_SetObject =
    procedure(Strings: _TStringList; Index: Integer; AObject: _TObject); stdcall;

  { 根据文本得到行的索引 }
  TStrList_IndexOf =
    function (Strings: _TStringList; S: PAnsiChar): Integer; stdcall;

  { 根据绑定对象得到行索引 }
  TStrList_IndexOfObject =
    function (Strings: _TStringList; AObject: _TObject): Integer; stdcall;

  { 二分查找某行的内容 (每行的内容必须是排序的) }
  TStrList_Find =
    function (Strings: _TStringList; S: PAnsiChar; var Index: Integer): BOOL; stdcall;

  { 交换两行的内容及绑定的对象 }
  TStrList_Exchange =
    procedure(Strings: _TStringList; Index1, Index2: Integer); stdcall;

  { 从文件载入 }
  TStrLit_LoadFromFile =
    procedure(Strings: _TStringList; FileName: PAnsiChar); stdcall;

  { 存到文件 }
  TStrLit_SaveToFile =
    procedure(Strings: _TStringList; FileName: PAnsiChar); stdcall;

  { 复制 }
  TStrList_CopyTo =
    procedure(Source, Dest: _TStringList); stdcall;

  //-------------------------------------------------------------------------------------------------------------------------------------------------------
  //---------------------------------------------- TMemStream 内存流 --------------------------------------------------------------------------------------
  //-------------------------------------------------------------------------------------------------------------------------------------------------------

  { 创建内存流 }
  TMemStream_Create =
    function (): _TMemoryStream; stdcall;

  { 释放内存流 }
  TMemStream_Free =
    procedure(Stream: _TMemoryStream); stdcall;

  { 取得大小 }
  TMemStream_GetSize =
    function (Stream: _TMemoryStream): Int64; stdcall;

  { 设置大小 }
  TMemStream_SetSize =
    procedure(Stream: _TMemoryStream; NewSize: Integer); stdcall;

  { 清空 }
  TMemStream_Clear =
    procedure(Stream: _TMemoryStream); stdcall;

  { 把内存流的数据读取到 Buffer 中 }
  TMemStream_Read =
    function (Stream: _TMemoryStream; Buffer: PAnsiChar; Count: Integer): Integer; stdcall;

  { 向内存流写入数据 }
  TMemStream_Write =
    function (Stream: _TMemoryStream; Buffer: PAnsiChar; Count: Integer): Integer; stdcall;

  { 指针定位 SeekOrigin: 0 (从头开始), 1 (当前位置开始), 2 (从尾部开始) }
  TMemStream_Seek =
    function (Stream: _TMemoryStream; Offset: Integer; SeekOrigin: Word): Integer; stdcall;

  { 获取流数据的内存指针 }
  TMemStream_Memory =
    function (Stream: _TMemoryStream): Pointer; stdcall;

  { 获取指针位置 }
  TMemStream_GetPosition =
    function (Stream: _TMemoryStream): Int64; stdcall;

  { 指针定位 (定到第几个字节) }
  TMemStream_SetPosition =
    procedure(Stream: _TMemoryStream; Position: Int64); stdcall;

  { 从文件载入 }
  TMemStream_LoadFromFile =
    procedure(Stream: _TMemoryStream; FileName: PAnsiChar); stdcall;

  { 保存到文件 }
  TMemStream_SaveToFile =
    procedure(Stream: _TMemoryStream; FileName: PAnsiChar); stdcall;


  //-------------------------------------------------------------------------------------------------------------------------------------------------------
  //---------------------------------------------- TMenu 菜单 ---------------------------------------------------------------------------------------------
  //-------------------------------------------------------------------------------------------------------------------------------------------------------

  { 获取主菜单 }
  TMenu_GetMainMenu =
    function (): _TMenuItem; stdcall;

  { 获取控制菜单 }
  TMenu_GetControlMenu =
    function (): _TMenuItem; stdcall;

  { 获取查看菜单 }
  TMenu_GetViewMenu =
    function (): _TMenuItem; stdcall;

  { 获取选项菜单 }
  TMenu_GetOptionMenu =
    function (): _TMenuItem; stdcall;

  { 获取管理菜单 }
  TMenu_GetManagerMenu =
    function (): _TMenuItem; stdcall;

  { 获取工具菜单 }
  TMenu_GetToolsMenu =
    function (): _TMenuItem; stdcall;

  { 获取帮助菜单 }
  TMenu_GetHelpMenu =
    function (): _TMenuItem; stdcall;

  { 获取插件菜单 }
  TMenu_GetPluginMenu =
    function (): _TMenuItem; stdcall;

  { 获取子菜单数量 }
  TMenu_Count =
    function (MenuItem: _TMenuItem): Integer; stdcall;

  { 获取某个子菜单 }
  TMenu_GetItems =
    function (MenuItem: _TMenuItem; Index: Integer): _TMenuItem; stdcall;

  { 添加菜单 }
  TMenu_Add =
    function (PlugID: NativeInt; MenuItem: _TMenuItem; Caption: PAnsiChar;
              Tag: Integer; OnClick: TNotifyEventEx): _TMenuItem; stdcall;

  { 插入菜单 }
  TMenu_Insert =
    function (PlugID: NativeInt; MenuItem: _TMenuItem; Index: Integer;
              Caption: PAnsiChar; Tag: Integer; OnClick: TNotifyEventEx): _TMenuItem; stdcall;

  { 获取菜单标题 }
  TMenu_GetCaption =
    function (MenuItem: _TMenuItem; Dest: PAnsiChar; var DestLen: DWORD): BOOL; stdcall;

  { 设置菜单标题}
  TMenu_SetCaption =
    procedure(MenuItem: _TMenuItem; Caption: PAnsiChar); stdcall;

  { 获取菜单可用 }
  TMenu_GetEnabled =
    function (MenuItem: _TMenuItem): BOOL; stdcall;

  { 设置菜单可用 }
  TMenu_SetEnabled =
    procedure(MenuItem: _TMenuItem; Enabled: BOOL); stdcall;

  { 获取菜单可见 }
  TMenu_GetVisable =
    function (MenuItem: _TMenuItem): BOOL; stdcall;

  { 设置菜单可见 }
  TMenu_SetVisable =
    procedure(MenuItem: _TMenuItem; Visible: BOOL); stdcall;

  { 获取菜单选中状态 }
  TMenu_GetChecked =
    function (MenuItem: _TMenuItem): BOOL; stdcall;

  { 设置菜单选中状态 }
  TMenu_SetChecked =
    procedure(MenuItem: _TMenuItem; Checked: BOOL); stdcall;

  { 获取菜单是否为单选 }
  TMenu_GetRadioItem =
    function (MenuItem: _TMenuItem): BOOL; stdcall;

  { 设置菜单是否为单选 }
  TMenu_SetRadioItem =
    procedure(MenuItem: _TMenuItem; IsRadioItem: BOOL); stdcall;

  { 获取菜单单选分组 }
  TMenu_GetGroupIndex =
    function (MenuItem: _TMenuItem): Integer; stdcall;

  { 设置菜单单选分组 }
  TMenu_SetGroupIndex =
    procedure(MenuItem: _TMenuItem; Value: Integer); stdcall;

  { 获取附加数据 }
  TMenu_GetTag =
    function (MenuItem: _TMenuItem): Integer; stdcall;

  { 设置附加数据 }
  TMenu_SetTag =
    procedure(MenuItem: _TMenuItem; Value: Integer); stdcall;

  //-------------------------------------------------------------------------------------------------------------------------------------------------------
  //---------------------------------------------- Ini操作----------------------------------------------------------------------------------------
  //-------------------------------------------------------------------------------------------------------------------------------------------------------
  { 创建Ini对象 }
  TIniFile_Create =
    function (sFileName: PAnsiChar): _TIniFile; stdcall;

  { 释放ini对象 }
  TIniFile_Free =
    procedure(IniFile: _TIniFile); stdcall;

  { 判断区段是否存在 }
  TIniFile_SectionExists =
    function (IniFile: _TIniFile; Section: PAnsiChar): BOOL; stdcall;

  { 判断键是否存在 }
  TIniFile_ValueExists =
    function (IniFile: _TIniFile; Section, Ident: PAnsiChar): BOOL; stdcall;

  { 读取文本 }
  TIniFile_ReadString =
    function (IniFile: _TIniFile; Section, Ident, Default: PAnsiChar;
              Dest: PAnsiChar; var DestLen: DWORD): BOOL; stdcall;
  { 写入文本 }
  TIniFile_WriteString =
    procedure(IniFile: _TIniFile; Section, Ident, Value: PAnsiChar); stdcall;

  { 读取整数 }
  TIniFile_ReadInteger =
    function (IniFile: _TIniFile; Section, Ident: PAnsiChar; Default: Integer): Integer; stdcall;

  { 写入整数 }
  TIniFile_WriteInteger =
    procedure(IniFile: _TIniFile; Section, Ident: PAnsiChar; Value: Integer); stdcall;

  { 读取布尔值 }
  TIniFile_ReadBool =
    function (IniFile: _TIniFile; Section, Ident: PAnsiChar; Default: BOOL): BOOL; stdcall;

  { 写入布尔值 }
  TIniFile_WriteBool =
    procedure(IniFile: _TIniFile; Section, Ident: PAnsiChar; Value: BOOL); stdcall;


  //-------------------------------------------------------------------------------------------------------------------------------------------------------
  //---------------------------------------------- _TMagicACList 对象 --------------------------------------------------------------------------------------
  //-------------------------------------------------------------------------------------------------------------------------------------------------------

  { 技能破防百分比列表数量 }
  TMagicACList_Count =
    function (List: _TMagicACList): Integer; stdcall;

  { 取单个元素 }
  TMagicACList_GetItem =
    function (List: _TMagicACList; Index: Integer): PMagicACInfo; stdcall;

  { 根据技能得到破防百分比信息 }
  TMagicACList_FindByMagIdx =
    function (List: _TMagicACList; MagIdx: Integer): PMagicACInfo; stdcall;


  //-------------------------------------------------------------------------------------------------------------------------------------------------------
  //---------------------------------------------- TMapManager 地图管理 -----------------------------------------------------------------------------------
  //-------------------------------------------------------------------------------------------------------------------------------------------------------

  { 根据地图名得到地图对象 }
  TMapManager_FindMap =
    function (MapName: PAnsiChar): _TEnvirnoment; stdcall;

  { 得到地图列表; 返回值中每个元素为：_TEnvirnoment }
  TMapManager_GetMapList =
    function (): _TList; stdcall;

  //-------------------------------------------------------------------------------------------------------------------------------------------------------
  //---------------------------------------------- TEnvir 地图对象 ----------------------------------------------------------------------------------------
  //-------------------------------------------------------------------------------------------------------------------------------------------------------

  { 地图名称 }
  TEnvir_GetMapName =
    function (Envir: _TEnvirnoment; Dest: PAnsiChar; var DestLen: DWORD): BOOL; stdcall;

  { 地图描述 }
  TEnvir_GetMapDesc =
    function (Envir: _TEnvirnoment; Dest: PAnsiChar; var DestLen: DWORD): BOOL; stdcall;

  { 地图宽度 }
  TEnvir_GetWidth =
    function (Envir: _TEnvirnoment): Integer; stdcall;

  { 地图高度 }
  TEnvir_GetHeight =
    function (Envir: _TEnvirnoment): Integer; stdcall;

  { 小地图 }
  TEnvir_GetMinMap =
    function (Envir: _TEnvirnoment): Integer; stdcall;

  { 是否主地图 }
  TEnvir_IsMainMap =
    function (Envir: _TEnvirnoment): BOOL; stdcall;

  { 主地图名 }
  TEnvir_GetMainMapName =
    function (Envir: _TEnvirnoment; Dest: PAnsiChar; var DestLen: DWORD): BOOL; stdcall;

  { 是否动态镜像地图 }
  TEnvir_IsMirrMap =
    function (Envir: _TEnvirnoment): BOOL; stdcall;

  { 动态镜像地图创建时间 }
  TEnvir_GetMirrMapCreateTick =
    function (Envir: _TEnvirnoment): DWORD; stdcall;

  { 动态镜像地图存活时间 }
  TEnvir_GetMirrMapSurvivalTime =
    function (Envir: _TEnvirnoment): DWORD; stdcall;

  { 动态地图退到哪个地图 }
  TEnvir_GetMirrMapExitToMap =
    function (Envir: _TEnvirnoment; Dest: PAnsiChar; var DestLen: DWORD): BOOL; stdcall;

  { 动态镜像地图小地图编号 }
  TEnvir_GetMirrMapMinMap =
    function (Envir: _TEnvirnoment): Integer; stdcall;

  { 动态镜像地图是否一直显示时间 }
  TEnvir_GetAlwaysShowTime =
    function (Envir: _TEnvirnoment): BOOL; stdcall;

  { 是否副本地图 }
  TEnvir_IsFBMap =
    function (Envir: _TEnvirnoment): BOOL; stdcall;

  { 副本地图名 }
  TEnvir_GetFBMapName =
    function (Envir: _TEnvirnoment; Dest: PAnsiChar; var DestLen: DWORD): BOOL; stdcall;

  { 副本进入限制 (0:队友必须有三职业; 1:不限制职业，队友均可进; 2:只允许自己; 3:允许行会进入) }
  TEnvir_GetFBEnterLimit =
    function (Envir: _TEnvirnoment): Integer; stdcall;

  { 副本地图是否创建 }
  TEnvir_GetFBCreated =
    function (Envir: _TEnvirnoment): BOOL; stdcall;

  { 副本地图创建时间 }
  TEnvir_GetFBCreateTime =
    function (Envir: _TEnvirnoment): DWORD; stdcall;

  { 获取地图是否设置某参数 }
  { 如地图有参数: FIGHT4，调用 GetMapParam(Envir, 'FIGHT4')，则返回True }
  { 如地图有参数：INCGAMEGOLD(1/10)，调用 GetMapParam(Envir, 'INCGAMEGOLD')，则返回True }
  TEnvir_GetMapParam =
    function (Envir: _TEnvirnoment; Param: PAnsiChar): BOOL; stdcall;


  { 获取地图设置某参数值 }
  { 如地图有参数：INCGAMEGOLD(1/10)，调用 GetMapParam(Envir, 'INCGAMEGOLD')，则返回1/10 }
  TEnvir_GetMapParamValue =
    function (Envir: _TEnvirnoment; Param: PAnsiChar; Dest: PAnsiChar; var DestLen: DWORD): BOOL; stdcall;

  { 地图点是否可达，boFlag = False时，会判断该坐标点是否有角色占据 }
  TEnvir_CheckCanMove =
    function (Envir: _TEnvirnoment; nX, nY: Integer; boFlag: BOOL): BOOL; stdcall;

  { 判断地图上以坐标(nX, nY)为空中，以nRange为半径的矩形范围内，是否有Obj对象 }
  TEnvir_IsValidObject =
    function (Envir: _TEnvirnoment; nX, nY, nRange: Integer; AObject: _TObject): BOOL; stdcall;

  { 获取地图上某坐标的物品列表 }
  TEnvir_GetItemObjects =
    function (Envir: _TEnvirnoment; nX, nY: Integer; ObjectList: _TList): Integer; stdcall;

  { 获取地图上某坐标的角色列表 }
  TEnvir_GetBaseObjects =
    function (Envir: _TEnvirnoment; nX, nY: Integer;
              IncDeathObject: BOOL; ObjectList: _TList): Integer; stdcall;

  { 获取地图上某坐标的人物列表 }
  TEnvir_GetPlayObjects =
    function (Envir: _TEnvirnoment; nX, nY: Integer;
              IncDeathObject: BOOL; ObjectList: _TList): Integer; stdcall;

  //-------------------------------------------------------------------------------------------------------------------------------------------------------
  //---------------------------------------------- M2引擎相关函数 ----------------------------------------------------------------------------------------
  //-------------------------------------------------------------------------------------------------------------------------------------------------------

  { 取M2版本号 }
  TM2Engine_GetVersion =
    function (Dest: PAnsiChar; var DestLen: DWORD): BOOL; stdcall;

  { 取版本号 }
  TM2Engine_GetVersionInt =
    function (): Integer; stdcall;

  { 取主窗体主柄 }
  TM2Engine_GetMainFormHandle =
    function (): THandle; stdcall;

  { 设置主窗体标题 }
  TM2Engine_SetMainFormCaption =
    procedure(Caption: PAnsiChar); stdcall;

  { 主程序所在目录 }
  TM2Engine_GetAppDir =
    function (Dest: PAnsiChar; var DestLen: DWORD): BOOL; stdcall;
    
  { 获取服务器的Ini对象 (0:!Setup.txt; 1:String.ini }
  TM2Engine_GetGlobalIniFile =
    function (M2IniType: Integer): _TIniFile; stdcall;


  { 获得其他文件或目录 }
  {
    0: Envir目录;  1: 插件目录; 2: 行会目录; 3: 行会文件; 4: 城堡目录; 5: 城堡文件; 6: 地图目录;
    7: 公告目录; 8: 宝箱目录; 9: 宝箱文件; 10: 自定义怪物目录; 11: 自定义技能目录; 12: 自定义NPC目录
    13: 物品掉落规则目录; 14: 物品掉落规则日志目录; 15: 登录日志目录
  }
  TM2Engine_GetOtherFileDir =
    function (M2FileType: Integer; Dest: PAnsiChar; var DestLen: DWORD): BOOL; stdcall;

  { M2输出信息 }
  TM2Engine_MainOutMessage =
    procedure(Msg: PAnsiChar; IsAddTime: BOOL); stdcall;

  { 读取全局I变量 }
  TM2Engine_GetGlobalVarI =
    function (Index: Integer): Integer; stdcall;

  { 设置全局I变量 }
  TM2Engine_SetGlobalVarI =
    function (Index: Integer; Value: Integer): BOOL; stdcall;

  { 读取全局G变量 }
  TM2Engine_GetGlobalVarG =
    function (Index: Integer): Integer; stdcall;

  { 设置全局G变量 }
  TM2Engine_SetGlobalVarG =
    function (Index: Integer; Value: Integer): BOOL; stdcall;

  { 读取全局A变量 }
  TM2Engine_GetGlobalVarA =
    function (Index: Integer; Dest: PAnsiChar; var DestLen: DWORD): BOOL; stdcall;

  { 设置全局A变量 }
  TM2Engine_SetGlobalVarA =
    function (Index: Integer; Value: PAnsiChar): BOOL; stdcall;

  { 编码 }
  TM2Engine_EncodeBuffer =
    function (Src: PAnsiChar; SrcLen: DWORD; Dest: PAnsiChar; var DestLen: DWORD): BOOL; stdcall;

  { 解码 }
  TM2Engine_DecodeBuffer =
    function (Src: PAnsiChar; SrcLen: DWORD; Dest: PAnsiChar; var DestLen: DWORD): BOOL; stdcall;

  { 压缩编码 }
  TM2Engine_ZLibEncodeBuffer =
    function (Src: PAnsiChar; SrcLen: DWORD;  Dest: PAnsiChar; var DestLen: DWORD): BOOL; stdcall;

  { 压缩解码 }
  TM2Engine_ZLibDecodeBuffer =
    function (Src: PAnsiChar; SrcLen: DWORD; Dest: PAnsiChar; var DestLen: DWORD): BOOL; stdcall;

  { 加密 }
  TM2Engine_EncryptBuffer =
    function(Src: PAnsiChar; SrcLen: DWORD; Dest: PAnsiChar; var DestLen: DWORD): BOOL; stdcall;

  { 解密 }
  TM2Engine_DecryptBuffer =
    function(Src: PAnsiChar; SrcLen: DWORD; Dest: PAnsiChar; var DestLen: DWORD): BOOL; stdcall;

  { 密码加密，不同的电脑得到不同的结果 }
  TM2Engine_EncryptPassword =
    function (InData: PAnsiChar; OutData: PAnsiChar; var OutSize: DWORD): BOOL; stdcall;

  { 密码解密 }
  TM2Engine_DecryptPassword =
    function (InData: PAnsiChar; OutData: PAnsiChar; var OutSize: DWORD): BOOL; stdcall;

  { 根据物品StdMode得到物品装备位置 }
  TM2Engine_GetTakeOnPosition =
    function (StdMode: Integer): Integer; stdcall;

  { 检查物品是否有某个绑定类型 (TUserItem.btBindOption) }
  TM2Engine_CheckBindType =
    function (BindValue: Byte; BindType: Byte): BOOL; stdcall;

  { 设置物品某个绑定类型 }
  TM2Engine_SetBindValue =
    procedure(var BindValue: Byte; BindType: Byte; Value: BOOL); stdcall;

  { 根据单字节颜色得到RGB颜色 }
  TM2Engine_GetRGB =
    function (Color: Byte): DWORD; stdcall;


  //-------------------------------------------------------------------------------------------------------------------------------------------------------
  //---------------------------------------------- TBaseObject对象 ----------------------------------------------------------------------------------------
  //-------------------------------------------------------------------------------------------------------------------------------------------------------

  { 名称 }
  TBaseObject_GetChrName =
    function (BaseObject: _TBaseObject; Dest: PAnsiChar; var DestLen: DWORD): BOOL; stdcall;

  { 设置名称(不能设置人物、英雄) }
  TBaseObject_SetChrName =
    function (BaseObject: _TBaseObject; NewName: PAnsiChar): BOOL; stdcall;

  { 刷新名称到客户端 }
  TBaseObject_RefShowName =
    procedure(BaseObject: _TBaseObject); stdcall;

  { 刷新名称颜色 PKPoint等改变时 }
  TBaseObject_RefNameColor =
    procedure(BaseObject: _TBaseObject); stdcall;

  { 获取性别 }
  TBaseObject_GetGender  =
    function (BaseObject: _TBaseObject): Byte; stdcall;

  { 设置性别 }
  TBaseObject_SetGender  =
    function (BaseObject: _TBaseObject; Gender: Byte): BOOL; stdcall;

  { 获取职业 }
  TBaseObject_GetJob  =
    function (BaseObject: _TBaseObject): Byte; stdcall;

  { 设置职业 }
  TBaseObject_SetJob  =
    function (BaseObject: _TBaseObject; Job: Byte): BOOL; stdcall;

  { 获取发型 }
  TBaseObject_GetHair  =
    function (BaseObject: _TBaseObject): Byte; stdcall;

  { 设置发型 }
  TBaseObject_SetHair  =
    procedure(BaseObject: _TBaseObject; Hair: Byte); stdcall;

  { 所在地图 }
  TBaseObject_GetEnvir =
    function (BaseObject: _TBaseObject): _TEnvirnoment; stdcall;

  { 所在地图 }
  TBaseObject_GetMapName =
    function (BaseObject: _TBaseObject; Dest: PAnsiChar; var DestLen: DWORD): BOOL; stdcall;

  { 坐标X }
  TBaseObject_GetCurrX =
    function (BaseObject: _TBaseObject): Integer; stdcall;

  { 坐标Y }
  TBaseObject_GetCurrY =
    function (BaseObject: _TBaseObject): Integer; stdcall;

  { 当前方向 }
  TBaseObject_GetDirection =
    function (BaseObject: _TBaseObject): Byte; stdcall;

  { 回城地图 }
  TBaseObject_GetHomeMap =
    function (BaseObject: _TBaseObject; Dest: PAnsiChar; var DestLen: DWORD): BOOL; stdcall;

  { 回城坐标X }
  TBaseObject_GetHomeX =
    function (BaseObject: _TBaseObject): Integer; stdcall;

  { 回城坐标Y }
  TBaseObject_GetHomeY =
    function (BaseObject: _TBaseObject): Integer; stdcall;

  { 权限等级 }
  TBaseObject_GetPermission =
    function (BaseObject: _TBaseObject): Byte; stdcall;

  { 设置权限等级 }
  TBaseObject_SetPermission =
    procedure(BaseObject: _TBaseObject; Value: Byte); stdcall;

  { 是否死亡 }
  TBaseObject_GetDeath =
    function (BaseObject: _TBaseObject): BOOL; stdcall;

  { 死亡时间 }
  TBaseObject_GetDeathTick =
    function (BaseObject: _TBaseObject): DWORD; stdcall;

  { 是否死亡并清理 }
  TBaseObject_GetGhost =
    function (BaseObject: _TBaseObject): BOOL; stdcall;

  { 清理时间 }
  TBaseObject_GetGhostTick =
    function (BaseObject: _TBaseObject): DWORD; stdcall;

  { 杀死并清掉 }
  TBaseObject_MakeGhost =
    procedure(BaseObject: _TBaseObject); stdcall;

  { 复活 }
  TBaseObject_ReAlive =
    procedure (BaseObject: _TBaseObject); stdcall;

  { 类型 }
  TBaseObject_GetRaceServer =
    function (BaseObject: _TBaseObject): Byte; stdcall;

  { Appr }
  TBaseObject_GetAppr =
    function (BaseObject: _TBaseObject): Word; stdcall;

  { RaceImg }
  TBaseObject_GetRaceImg =
    function (BaseObject: _TBaseObject): Byte; stdcall;

  { 状态 }
  TBaseObject_GetCharStatus =
    function (BaseObject: _TBaseObject): Integer; stdcall;

  { 状态改变 }
  TBaseObject_SetCharStatus =
    procedure(BaseObject: _TBaseObject; Value: Integer); stdcall;

  { 发送状态改变 }
  TBaseObject_StatusChanged =
    procedure(BaseObject: _TBaseObject); stdcall;

  { 获取饥饿点 }
  TBaseObject_GetHungerPoint =
    function (BaseObject: _TBaseObject): Integer; stdcall;

  { 设置饥饿点 }
  TBaseObject_SetHungerPoint =
    procedure(BaseObject: _TBaseObject; Value: Integer); stdcall;

  { 是否为内功怪 }
  TBaseobject_IsNGMonster =
    function (BaseObject: _TBaseObject): BOOL; stdcall;

  { 是否假人 }
  TBaseObject_IsDummyObject =
    function (BaseObject: _TBaseObject): BOOL; stdcall;

  { 获取视觉范围 }
  TBaseObject_GetViewRange =
    function (BaseObject: _TBaseObject): Integer; stdcall;

  { 设置视觉范围 }
  TBaseObject_SetViewRange =
    procedure(BaseObject: _TBaseObject; Value: Integer); stdcall;

  { 原始属性 }
  TBaseObject_GetAbility =
    function (BaseObject: _TBaseObject; Dest: pTAbility): BOOL; stdcall;

  { 最终属性 }
  TBaseObject_GetWAbility =
    function (BaseObject: _TBaseObject; Dest: pTAbility): BOOL; stdcall;

  { 设置属性 }
  TBaseObject_SetWAbility =
    procedure(BaseObject: _TBaseObject; Value: pTAbility); stdcall;

  { 宝宝列表 }
  TBaseObject_GetSlaveList =
    function (BaseObject: _TBaseObject): _TList; stdcall;

  { 主人 }
  TBaseObject_GetMaster =
    function (BaseObject: _TBaseObject): _TBaseObject; stdcall;

  { 最上层主人 }
  TBaseObject_GetMasterEx =
    function (BaseObject: _TBaseObject): _TBaseObject; stdcall;

  { 是否无敌模式 }
  TBaseObject_GetSuperManMode =
    function (BaseObject: _TBaseObject): BOOL; stdcall;

  { 设置无敌模式 }
  TBaseObject_SetSuperManMode =
    procedure(BaseObject: _TBaseObject; Value: BOOL); stdcall;

  { 是否管理模式 }
  TBaseObject_GetAdminMode =
    function (BaseObject: _TBaseObject): BOOL; stdcall;

  { 设置管理模式 }
  TBaseObject_SetAdminMode =
    procedure(BaseObject: _TBaseObject; Value: BOOL); stdcall;

  { 魔法隐身 }
  TBaseObject_GetTransparent =
    function (BaseObject: _TBaseObject): BOOL; stdcall;

  { 设置魔法隐身 }
  TBaseObject_SetTransparent =
    procedure(BaseObject: _TBaseObject; Value: BOOL); stdcall;

  { 隐身模式 }
  TBaseObject_GetObMode =
    function (BaseObject: _TBaseObject): BOOL; stdcall;

  { 设置隐身模式 }
  TBaseObject_SetObMode =
    procedure(BaseObject: _TBaseObject; Value: BOOL); stdcall;

  { 石像化模式 }
  TBaseObject_GetStoneMode =
    function (BaseObject: _TBaseObject): BOOL; stdcall;

  { 设置石像化模式 }
  TBaseObject_SetStoneMode =
    procedure(BaseObject: _TBaseObject; Value: BOOL); stdcall;

  { 是否能推动 }
  TBaseObject_GetStickMode =
    function (BaseObject: _TBaseObject): BOOL; stdcall;

  { 设置不可推动模式 }
  TBaseObject_SetStickMode =
    procedure(BaseObject: _TBaseObject; Value: BOOL); stdcall;

  { 怪物是否可挖 }
  TBaseObject_GetIsAnimal =
    function (BaseObject: _TBaseObject): BOOL; stdcall;

  { 设置怪物是否可挖 }
  TBaseObject_SetIsAnimal =
    procedure(BaseObject: _TBaseObject; Value: BOOL); stdcall;

  { 死亡是否不掉装备 }
  TBaseObject_GetIsNoItem =
    function (BaseObject: _TBaseObject): BOOL; stdcall;

  { 设置死亡是否不掉装备 }
  TBaseObject_SetIsNoItem =
    procedure(BaseObject: _TBaseObject; Value: BOOL); stdcall;

  { 隐身免疫 }
  TBaseObject_GetCoolEye =
    function (BaseObject: _TBaseObject): BOOL; stdcall;

  { 设置隐身免疫 }
  TBaseObject_SetCoolEye =
    procedure(BaseObject: _TBaseObject; Value: BOOL); stdcall;

  { 命中 }
  TBaseObject_GetHitPoint =
    function (BaseObject: _TBaseObject): Word; stdcall;

  { 设置命中 }
  TBaseObject_SetHitPoint =
    procedure(BaseObject: _TBaseObject; Value: Word); stdcall;

  { 敏捷 }
  TBaseObject_GetSpeedPoint =
    function (BaseObject: _TBaseObject): Word; stdcall;

  { 设置敏捷 }
  TBaseObject_SetSpeedPoint =
    procedure(BaseObject: _TBaseObject; Value: Word); stdcall;          

  { 攻击速度 }
  TBaseObject_GetHitSpeed =
    function (BaseObject: _TBaseObject): ShortInt; stdcall;

  { 设置攻击速度 }
  TBaseObject_SetHitSpeed =
    procedure(BaseObject: _TBaseObject; Value: ShortInt); stdcall;

  { 移动速度 }
  TBaseObject_GetWalkSpeed =
    function (BaseObject: _TBaseObject): Integer; stdcall;

  { 设置移动速度 }
  TBaseObject_SetWalkSpeed =
    procedure(BaseObject: _TBaseObject; Value: Integer); stdcall;

  { HP恢复速度 }
  TBaseObject_GetHPRecover =
    function (BaseObject: _TBaseObject): ShortInt; stdcall;

  { 设置HP恢复速度 }
  TBaseObject_SetHPRecover =
    procedure(BaseObject: _TBaseObject; Value: ShortInt); stdcall;      

  { MP恢复速度 }
  TBaseObject_GetMPRecover =
    function (BaseObject: _TBaseObject): ShortInt; stdcall;

  { 设置MP恢复速度 }
  TBaseObject_SetMPRecover =
    procedure(BaseObject: _TBaseObject; Value: ShortInt); stdcall;

  { 中毒恢复 }
  TBaseObject_GetPoisonRecover =
    function (BaseObject: _TBaseObject): ShortInt; stdcall;

  { 设置中毒恢复 }
  TBaseObject_SetPoisonRecover =
    procedure(BaseObject: _TBaseObject; Value: ShortInt); stdcall;

  { 毒躲避 }
  TBaseObject_GetAntiPoison =
    function (BaseObject: _TBaseObject): Byte; stdcall;

  { 设置毒躲避 }
  TBaseObject_SetAntiPoison =
    procedure(BaseObject: _TBaseObject; Value: Byte); stdcall;

  { 魔法躲避 }
  TBaseObject_GetAntiMagic =
    function (BaseObject: _TBaseObject): ShortInt; stdcall;

  { 设置魔法躲避 }
  TBaseObject_SetAntiMagic =
    procedure(BaseObject: _TBaseObject; Value: ShortInt); stdcall;

  { 幸运 }
  TBaseObject_GetLuck =
    function (BaseObject: _TBaseObject): Integer; stdcall;

  { 设置幸运 }
  TBaseObject_SetLuck =
    procedure(BaseObject: _TBaseObject; Value: Integer); stdcall;

  { 攻击模式 }
  TBaseObject_GetAttatckMode =
    function (BaseObject: _TBaseObject): Byte; stdcall;

  { 设置攻击模式 }
  TBaseObject_SetAttatckMode =
    procedure(BaseObject: _TBaseObject; Value: Byte); stdcall;

  { 获取所属国家 }
  TBaseObject_GetNation =
    function (BaseObject: _TBaseObject): Byte; stdcall;

  { 设置所属国家 }
  TBaseObject_SetNation =
    function (BaseObject: _TBaseObject; Nation: Byte): BOOL; stdcall;

   { 获取国家名字 }
  TBaseObject_GetNationaName =
    function (BaseObject: _TBaseObject; Dest: PAnsiChar; var DestLen: DWORD): BOOL; stdcall;

  { 行会 }
  TBaseObject_GetGuild =
    function (BaseObject: _TBaseObject): _TGuild; stdcall;

  { 人物所在行会中的分组编号 }
  TBaseobject_GetGuildRankNo =
    function (BaseObject: _TBaseObject): Integer; stdcall;

  { 人物所在行会中的分组名称 }
  TBaseobject_GetGuildRankName =
    function (BaseObject: _TBaseObject; Dest: PAnsiChar; var DestLen: DWORD): BOOL; stdcall;

  { 是否为行会老大 }
  TBaseObject_IsGuildMaster =
    function (BaseObject: _TBaseObject): BOOL; stdcall;

  { 隐身戒指 特殊物品:111 }
  TBaseObject_GetHideMode =
    function (BaseObject: _TBaseObject): BOOL; stdcall;

  TBaseObject_SetHideMode =
    procedure(BaseObject: _TBaseObject; Value: BOOL); stdcall;

  { 麻痹戒指  特殊物品:113 }
  TBaseObject_GetIsParalysis =
    function (BaseObject: _TBaseObject): BOOL; stdcall;

  TBaseObject_SetIsParalysis =
    procedure(BaseObject: _TBaseObject; Value: BOOL); stdcall;

  { 麻痹几率 }
  TBaseObject_GetParalysisRate =
    function (BaseObject: _TBaseObject): DWORD; stdcall;

  TBaseObject_SetParalysisRate =
    procedure(BaseObject: _TBaseObject; Value: DWORD); stdcall;

  { 魔道麻痹戒指  特殊物品:204 }
  TBaseObject_GetIsMDParalysis =
    function (BaseObject: _TBaseObject): BOOL; stdcall;

  TBaseObject_SetIsMDParalysis =
    procedure(BaseObject: _TBaseObject; Value: BOOL); stdcall;

  { 魔道麻痹几率 }
  TBaseObject_GetMDParalysisRate =
    function (BaseObject: _TBaseObject): DWORD; stdcall;

  TBaseObject_SetMDParalysisRate =
    procedure(BaseObject: _TBaseObject; Value: DWORD); stdcall;

  { 冰冻戒指  特殊物品:205 }
  TBaseObject_GetIsFrozen =
    function (BaseObject: _TBaseObject): BOOL; stdcall;

  TBaseObject_SetIsFrozen =
    procedure(BaseObject: _TBaseObject; Value: BOOL); stdcall;

  { 冰冻几率 }
  TBaseObject_GetFrozenRate =
    function (BaseObject: _TBaseObject): DWORD; stdcall;

  TBaseObject_SetFrozenRate =
    procedure(BaseObject: _TBaseObject; Value: DWORD); stdcall;

  { 蛛网戒指  特殊物品:206 }
  TBaseObject_GetIsCobwebWinding =
    function (BaseObject: _TBaseObject): BOOL; stdcall;

  TBaseObject_SetIsCobwebWinding =
    procedure(BaseObject: _TBaseObject; Value: BOOL); stdcall;

  { 蛛网几率 }
  TBaseObject_GetCobwebWindingRate =
    function (BaseObject: _TBaseObject): DWORD; stdcall;

  TBaseObject_SetCobwebWindingRate =
    procedure(BaseObject: _TBaseObject; Value: DWORD); stdcall;

  { 防麻几率 }
  TBaseObject_GetUnParalysisValue =
    function (Baseobject: _TBaseObject): DWORD; stdcall;

  TBaseObject_SetUnParalysisValue =
    procedure(Baseobject: _TBaseObject; Value: DWORD); stdcall;

  { 根据几率取当次是否防麻 }
  TBaseObject_GetIsUnParalysis =
    function (BaseObject: _TBaseObject): BOOL; stdcall;

  { 防护身几率 }
  TBaseObject_GetUnMagicShieldValue =
    function (BaseObject: _TBaseObject): DWORD; stdcall;

  TBaseObject_SetUnMagicShieldValue =
    procedure(BaseObject: _TBaseObject; Value: DWORD); stdcall;

  { 根据几率取当次是否防护身 }
  TBaseObject_GetIsUnMagicShield =
    function (BaseObject: _TBaseObject): BOOL; stdcall;

  { 防复活几率 }
  TBaseObject_GetUnRevivalValue =
    function (BaseObject: _TBaseObject): DWORD; stdcall;

  TBaseObject_SetUnRevivalValue =
    procedure(BaseObject: _TBaseObject; Value: DWORD); stdcall;

  { 根据几率取当次是否防复活 }
  TBaseObject_GetIsUnRevival =
    function (BaseObject: _TBaseObject): BOOL; stdcall;

  { 防毒几率 }
  TBaseObject_GetUnPosionValue =
    function (BaseObject: _TBaseObject): DWORD; stdcall;

  TBaseObject_SetUnPosionValue =
    procedure(BaseObject: _TBaseObject; Value: DWORD); stdcall;

  { 根据几率取当次是否防毒 }
  TBaseObject_GetIsUnPosion =
    function (BaseObject: _TBaseObject): BOOL; stdcall;

  { 防诱惑几率 }
  TBaseObject_GetUnTammingValue =
    function (BaseObject: _TBaseObject): DWORD; stdcall;

  TBaseObject_SetUnTammingValue =
    procedure(BaseObject: _TBaseObject; Value: DWORD); stdcall;

  { 根据几率取当次是否防诱惑 }
  TBaseObject_GetIsUnTamming =
    function (BaseObject: _TBaseObject): BOOL; stdcall;

  { 防火墙几率 }
  TBaseObject_GetUnFireCrossValue =
    function (BaseObject: _TBaseObject): DWORD; stdcall;

  TBaseObject_SetUnFireCrossValue =
    procedure(BaseObject: _TBaseObject; Value: DWORD); stdcall;

  { 根据几率取当次是否防火墙 }
  TBaseObject_GetIsUnFireCross =
    function (BaseObject: _TBaseObject): BOOL; stdcall;

  { 防冰冻几率 }
  TBaseObject_GetUnFrozenValue =
    function (BaseObject: _TBaseObject): DWORD; stdcall;

  TBaseObject_SetUnFrozenValue =
    procedure(BaseObject: _TBaseObject; Value: DWORD); stdcall;

  { 根据几率取当次是否防冰冻 }
  TBaseObject_GetIsUnFrozen =
    function (BaseObject: _TBaseObject): BOOL; stdcall;

  { 防蛛网几率 }
  TBaseObject_GetUnCobwebWindingValue =
    function (BaseObject: _TBaseObject): DWORD; stdcall;

  TBaseObject_SetUnCobwebWindingValue =
    procedure(BaseObject: _TBaseObject; Value: DWORD); stdcall;

  { 根据几率取当次是否防蛛网 }
  TBaseObject_GetIsUnCobwebWinding =
    function (BaseObject: _TBaseObject): BOOL; stdcall;

  { 获取当前攻击目标 }
  TBaseObject_GetTargetCret =
    function (BaseObject: _TBaseObject): _TBaseObject; stdcall;

  { 设置当前攻击目标 }
  TBaseObject_SetTargetCret =
    procedure(BaseObject: _TBaseObject; TargetCret: _TBaseObject); stdcall;

  { 删除当前攻击目标 }
  TBaseObject_DelTargetCreat =
    procedure(BaseObject: _TBaseObject); stdcall;

  { 被谁攻击 }
  TBaseObject_GetLastHiter =
    function (BaseObject: _TBaseObject): _TBaseObject; stdcall;

  { 谁得经验 }
  TBaseObject_GetExpHitter =
    function (BaseObject: _TBaseObject): _TBaseObject; stdcall;

  { 施毒者 }
  TBaseObject_GetPoisonHitter =
    function (BaseObject: _TBaseObject): _TBaseObject; stdcall;

  { 面前的对象是谁 }
  TBaseObject_GetPoseCreate =
    function (BaseObject: _TBaseObject): _TBaseObject; stdcall;

  { 是否为攻击目标 }
  TBaseObject_IsProperTarget =
    function (BaseObject, Target: _TBaseObject): BOOL; stdcall;

  { 是否为朋友 }
  TBaseObject_IsProperFriend =
    function (BaseObject, Target: _TBaseObject): BOOL; stdcall;

  { 判断对象在指定范围内 }
  TBaseObject_TargetInRange =
    function (BaseObject, Target: _TBaseObject; nX, nY, nRange: Integer): BOOL; stdcall;

  { 发消息 Int64 2021-01-06 }
  TBaseObject_SendMsg =
    procedure(BaseObject, Target: _TBaseObject; wIdent, wParam: Integer;
              nParam1, nParam2, nParam3: NativeInt; sMsg: PAnsiChar); stdcall;

  { 发延时消息  Int64 2021-01-06 }
  TBaseObject_SendDelayMsg =
    procedure(BaseObject, Target: _TBaseObject; wIdent, wParam: Integer;
              nParam1, nParam2, nParam3: NativeInt; sMsg: PAnsiChar; dwDelay: DWORD); stdcall;

  { 向全屏玩家发消息  Int64 2021-01-06 }
  TBaseObject_SendRefMsg =
    procedure(BaseObject: _TBaseObject; wIdent, wParam: Integer;
              nParam1, nParam2, nParam3: NativeInt; sMsg: PAnsiChar; dwDelay: DWORD); stdcall;

  { 更新发消息  Int64 2021-01-06 }
  TBaseObject_SendUpdateMsg =
    procedure(BaseObject, Target: _TBaseObject; wIdent, wParam: Integer;
              nParam1, nParam2, nParam3: NativeInt; sMsg: PAnsiChar); stdcall;

  { 发聊天信息 }
  TBaseObject_SysMsg =
    function(BaseObject: _TBaseObject; sMsg: PAnsiChar;
              FColor, BColor: Byte; MsgType: Integer): BOOL; stdcall;

  { 背包物品 }
  TBaseObject_GetBagItemList =
    function (BaseObject: _TBaseObject): _TList; stdcall;

  { 检测背包是否满 }
  TBaseObject_IsEnoughBag =
    function (BaseObject: _TBaseObject): BOOL; stdcall;

  { 背包是否还有足够的空间放指定数量的物品 }
  TBaseObject_IsEnoughBagEx =
    function (BaseObject: _TBaseObject; AddCount: Integer): BOOL; stdcall;

  { 加物品到背包 }
  TBaseObject_AddItemToBag =
    function (BaseObject: _TBaseObject; UserItem: pTUserItem): BOOL; stdcall;

  { 删除背包第几个物品 }
  TBaseObject_DelBagItemByIndex =
    function (BaseObject: _TBaseObject; Index: Integer): BOOL; stdcall;

  { 根据makeIndex删除背包物品 }
  TBaseObject_DelBagItemByMakeIdx =
    function(BaseObject: _TBaseObject; MakeIndex: Integer; ItemName: PAnsiChar): BOOL; stdcall;

  { 根据UserItem删除背包物品 }
  TBaseObject_DelBagItemByUserItem =
    function(BaseObject: _TBaseObject; UserItem: pTUserItem): BOOL; stdcall;

  { 检查角色是否在安全区 }
  TBaseObject_IsInSafeZone =
    function (BaseObject: _TBaseObject): BOOL; stdcall;

  { 检查坐标点是否在安全区内 }
  TBaseObject_IsPtInSafeZone =
    function (BaseObject: _TBaseObject; Envir: _TEnvirnoment; nX, nY: Integer): BOOL; stdcall;

  { 重算等级属性(IsSysDef=True: 使用系统默认等级属性; IsSysDef=False: 使用自定义等级属性) }
  TBaseObject_RecalcLevelAbil =
    procedure(BaseObject: _TBaseObject; IsSysDef: BOOL); stdcall;

  { 重算属性 }
  TBaseObject_RecalcAbil =
    procedure(BaseObject: _TBaseObject); stdcall;

  { 重算背包重量 }
  TBaseObject_RecalcBagWeight =
    function (BaseObject: _TBaseObject): Integer; stdcall;

  { 指定等级升到下级所要经验值 }
  TBaseObject_GetLevelExp =
    function (BaseObject: _TBaseObject; nLevel: Integer): DWORD; stdcall;

  { 升级 }
  TBaseObject_HasLevelUp =
    procedure(BaseObject: _TBaseObject; nLevel: Integer); stdcall;


  { 加技能熟练点; IsDoChec = True,判断技能加点条件 }
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

  { 检查技能是否升级 }
  TBaseObject_CheckMagicLevelup =
    function (BaseObject: _TBaseObject; UserMagic: pTUserMagic): BOOL; stdcall;

  { 技能点改点 }
  TBaseObject_MagicTranPointChanged =
    procedure(BaseObject: _TBaseObject; UserMagic: pTUserMagic); stdcall;

  { 掉血 }
  TBaseObject_DamageHealth =
    procedure(BaseObject: _TBaseObject; nDamage: Integer; StruckFrom: _TBaseObject); stdcall;

  { 消耗MP }
  TBaseObject_DamageSpell =
    procedure(BaseObject: _TBaseObject; nSpellPoint: Integer); stdcall;

  { 增加HP/MP }
  TBaseObject_IncHealthSpell =
    procedure(BaseObject: _TBaseObject; nHP, nMP: Integer; SendChangedToClient: BOOL); stdcall;

  { 通知客户端HP/MP改变 }
  TBaseObject_HealthSpellChanged =
    procedure (BaseObject: _TBaseObject; dwDelay: DWORD); stdcall;

  { 通知客户端外观改变 }
  TBaseObject_FeatureChanged =
    procedure(BaseObject: _TBaseObject); stdcall;

  { 通知客户端负重改变 }
  TBaseObject_WeightChanged =
    procedure(BaseObject: _TBaseObject); stdcall;

  { 减防后物理伤害, nType = 1:减物理防御；nType = 2:减魔法盾防御 }
   { MagicACInfo: 功能设置-->技能魔法-->技能破防百分比中的信息 }
  TBaseObject_GetHitStruckDamage =
    function (BaseObject: _TBaseObject; Target: _TBaseObject; nDamage: Integer;
              MagicACInfo:PMagicACInfo; nType: Integer): Integer; stdcall;

  { 减防后魔法伤害 }
  TBaseObject_GetMagStruckDamage =
    function(BaseObject: _TBaseObject; Target: _TBaseObject; nDamage: Integer): Integer; stdcall;

  { 顶戴花花翎 (Index: 0-9) }
  TBaseObject_GetActorIcon =
    function (BaseObject: _TBaseObject; Index: Integer; ActorIcon: pTActorIcon): BOOL; stdcall;

  { 顶戴花花翎 (Index: 0-9) }
  TBaseObject_SetActorIcon =
    function (BaseObject: _TBaseObject; Index: Integer; ActorIcon: pTActorIcon): BOOL; stdcall;

  { 刷新顶戴花花翎 }
  TBaseObject_RefUseIcons =
    procedure(BaseObject: _TBaseObject); stdcall;

  { 刷新效果 }
  TBaseObject_RefUseEffects =
    procedure(BaseObject: _TBaseObject); stdcall;

  { 飞到指定地图及坐标 }
  TBaseObject_SpaceMove =
    procedure(BaseObject: _TBaseObject; sMapName: PAnsiChar; nX, nY: Integer; nInt: Integer); stdcall;

  { 飞到指定地图随机坐标 }
  TBaseObject_MapRandomMove =
    procedure(BaseObject: _TBaseObject; sMapName: PAnsiChar; nInt: Integer); stdcall;

  { 对象是否可移动 (当麻痹，冰结等状态时，不能移动) }
  TBaseObject_CanMove =
    function (BaseObject: _TBaseObject): BOOL; stdcall;

  { 是否可以从一个点跑往另一个点 }
  TBaseObject_CanRun =
    function (BaseObject: _TBaseObject; nCurrX, nCurrY, nX, nY: Integer): BOOL; stdcall;

  { 转向 }
  TBaseObject_TurnTo =
    procedure(BaseObject: _TBaseObject; btDir: Byte); stdcall;

  { 指定方向走一步 }
  TBaseObject_WalkTo =
    function (BaseObject: _TBaseObject; btDir: Byte; boFlag: BOOL): BOOL; stdcall;

  { 指定方向跑一步 }
  TBaseObject_RunTo =
    function (BaseObject: _TBaseObject; btDir: Byte; boFlag: BOOL): BOOL; stdcall;

  { 预留给插件用，其他地方未使用 }
  TBaseObject_PluginList =
    function (BaseObject: _TBaseObject): _TList; stdcall;

  //-------------------------------------------------------------------------------------------------------------------------------------------------------
  //---------------------------------------------- _TSmartObject 对象，继承_TBaseObject ---------------------------------------------------------------------
  //-------------------------------------------------------------------------------------------------------------------------------------------------------

  { 获取技能列表 }
  TSmartObject_GetMagicList =
    function (SmartObject: _TSmartObject): _TList; stdcall;

  { 取某个位置的装备; Index: 0-29 }
  TSmartObject_GetUseItem =
    function (SmartObject: _TSmartObject; Index: Integer; UserItem: pTUserItem): BOOL; stdcall;

  { 首饰盒状态 0:未激活; 1:激活; 2:开启 }
  TSmartObject_GetJewelryBoxStatus  =
    function (SmartObject: _TSmartObject): Integer; stdcall;

  { 设置首饰盒状态 0:未激活; 1:激活; 2:开启 }
  TSmartObject_SetJewelryBoxStatus  = procedure(SmartObject: _TSmartObject; Value: Integer); stdcall;

  { 取首饰盒物品; Index: 0-5 }
  TSmartObject_GetJewelryItem =
    function (SmartObject: _TSmartObject; Index: Integer; UserItem: pTUserItem): BOOL; stdcall;

  { 是否显示神佑袋 }
  TSmartObject_GetIsShowGodBless =
    function (SmartObject: _TSmartObject): BOOL; stdcall;

  { 设置显示神佑袋 }
  TSmartObject_SetIsShowGodBless =
    procedure(SmartObject: _TSmartObject; Value: BOOL); stdcall;

  { 取某个神佑格子的开关状态 }
  TSmartObject_GetGodBlessItemsState =
    function (SmartObject: _TSmartObject; Index: Integer): BOOL; stdcall;

  { 设置神佑格子的开关状态 }
  TSmartObject_SetGodBlessItemsState =
    procedure(SmartObject: _TSmartObject; Index: Integer; Value: BOOL); stdcall;

  { 取神佑袋物品; Index: 0-11 }
  TSmartObject_GetGodBlessItem =
    function (SmartObject: _TSmartObject; Index: Integer; UserItem: pTUserItem): BOOL; stdcall;

  { 封号列表 }
  TSmartObject_GetFengHaoItems =
    function (SmartObject: _TSmartObject): _TList; stdcall;

  { 激活的封号 }
  TSmartObject_GetActiveFengHao =
    function (SmartObject: _TSmartObject): Integer; stdcall;
    
  { 设置当前激活封号; -1清封号 }
  TSmartObject_SetActiveFengHao =
    procedure(SmartObject: _TSmartObject; FengHaoIndex: Integer); stdcall;

  { 刷新活动封号到客户端 }
  TSmartObject_ActiveFengHaoChanged =
    procedure(SmartObject: _TSmartObject); stdcall;

  { 删除封号 }
  TSmartObject_DeleteFengHao =
    procedure(SmartObject: _TSmartObject; Index: Integer); stdcall;

  { 清空封号 }
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

  { 刷新游戏速度 }
  TSmartObject_RefGameSpeed =
    procedure(SmartObject: _TSmartObject); stdcall;

  { 是否可挖 }
  TSmartObject_GetIsButch =
    function (SmartObject: _TSmartObject): BOOL; stdcall;

  { 设置是否可挖 }
  TSmartObject_SetIsButch =
    procedure(SmartObject: _TSmartObject; Value: BOOL); stdcall;

  { 是否学内功 }
  TSmartObject_GetIsTrainingNG =
    function (SmartObject: _TSmartObject): BOOL; stdcall;

  TSmartObject_SetIsTrainingNG =
    procedure(SmartObject: _TSmartObject; Value: BOOL); stdcall;

   { 是否学心法 }
  TSmartObject_GetIsTrainingXF  =
    function (SmartObject: _TSmartObject): BOOL; stdcall;

  TSmartObject_SetIsTrainingXF =
    procedure(SmartObject: _TSmartObject; Value: BOOL); stdcall;

  { 第4个连击是否开启 }
  TSmartObject_GetIsOpenLastContinuous  =
    function (SmartObject: _TSmartObject): BOOL; stdcall;

  { 设置开启第4个连击 }
  TSmartObject_SetIsOpenLastContinuous  =
    procedure(SmartObject: _TSmartObject; Value: BOOL); stdcall;

  { 连击顺序 Index:0-3 }
  TSmartObject_GetContinuousMagicOrder  =
    function (SmartObject: _TSmartObject; Index: Integer): Byte; stdcall;

  { 设置连击顺序 }
  TSmartObject_SetContinuousMagicOrder  =
    procedure(SmartObject: _TSmartObject; Index: Integer; Value: Byte); stdcall;

  { PK 死亡掉经验，不够经验就掉等级 }
  TSmartObject_GetPKDieLostExp  =
    function (SmartObject: _TSmartObject): DWORD; stdcall;

  TSmartObject_SetPKDieLostExp  =
    procedure(SmartObject: _TSmartObject; Value: DWORD); stdcall;

  { PK 死亡掉等级 }
  TSmartObject_GetPKDieLostLevel  =
    function (SmartObject: _TSmartObject): Integer; stdcall;
    
  TSmartObject_SetPKDieLostLevel  =
    procedure(SmartObject: _TSmartObject; Value: Integer); stdcall;

  { PK点数 }
  TSmartObject_GetPKPoint =
    function (SmartObject: _TSmartObject): Integer; stdcall;

  TSmartObject_SetPKPoint =
    procedure(SmartObject: _TSmartObject; Value: Integer); stdcall;

  { 增加PK值 }
  TSmartObject_IncPKPoint =
    procedure(SmartObject: _TSmartObject; Value: Integer); stdcall;

  { 减少PK值 }
  TSmartObject_DecPKPoint =
    procedure(SmartObject: _TSmartObject; Value: Integer); stdcall;

  { PK等级 }
  TSmartObject_GetPKLevel =
    function (SmartObject: _TSmartObject): Integer; stdcall;

  TSmartObject_SetPKLevel =
    procedure(SmartObject: _TSmartObject; Value: Integer); stdcall;          

  { 传送戒指 特殊物品:112 }
  TSmartObject_GetIsTeleport =
    function (SmartObject: _TSmartObject): BOOL; stdcall;

  TSmartObject_SetIsTeleport =
    procedure(SmartObject: _TSmartObject; Value: BOOL); stdcall;

  { 复活戒指 特殊物品:114 }
  TSmartObject_GetIsRevival =
    function (SmartObject: _TSmartObject): BOOL; stdcall;

  TSmartObject_SetIsRevival =
    procedure(SmartObject: _TSmartObject; Value: BOOL); stdcall;

  { 复活戒指: 复活间隔 }
  TSmartObject_GetRevivalTime =
    function (SmartObject: _TSmartObject): Integer; stdcall;

  TSmartObject_SetRevivalTime =
    procedure(SmartObject: _TSmartObject; Value: Integer); stdcall;

  { 火焰戒指 特殊物品:115 }
  TSmartObject_GetIsFlameRing =
    function (SmartObject: _TSmartObject): BOOL; stdcall;

  TSmartObject_SetIsFlameRing =
    procedure(SmartObject: _TSmartObject; Value: BOOL); stdcall;

  { 治愈戒指 特殊物品:116 }
  TSmartObject_GetIsRecoveryRing =
    function (SmartObject: _TSmartObject): BOOL; stdcall;

  TSmartObject_SetIsRecoveryRing =
    procedure(SmartObject: _TSmartObject; Value: BOOL); stdcall;

   { 护身戒指 特殊物品:118 }
  TSmartObject_GetIsMagicShield =
    function (SmartObject: _TSmartObject): BOOL; stdcall;

  TSmartObject_SetIsMagicShield =
    procedure(SmartObject: _TSmartObject; Value: BOOL); stdcall;

  { 活力戒指(超负载) 特殊物品:119 }
  TSmartObject_GetIsMuscleRing =
    function (SmartObject: _TSmartObject): BOOL; stdcall;

  TSmartObject_SetIsMuscleRing =
    procedure(SmartObject: _TSmartObject; Value: BOOL); stdcall;

  { 技巧项链 特殊物品:120 }
  TSmartObject_GetIsFastTrain =
    function (SmartObject: _TSmartObject): BOOL; stdcall;

  TSmartObject_SetIsFastTrain =
    procedure(SmartObject: _TSmartObject; Value: BOOL); stdcall;

  { 探测项链 特殊物品:121 }
  TSmartObject_GetIsProbeNecklace =
    function (SmartObject: _TSmartObject): BOOL; stdcall;

  TSmartObject_SetIsProbeNecklace =
    procedure(SmartObject: _TSmartObject; Value: BOOL); stdcall;

  { 记忆物品 特殊物品:122, 124, 125 }
  TSmartObject_GetIsRecallSuite =
    function (SmartObject: _TSmartObject): BOOL; stdcall;

  TSmartObject_SetIsRecallSuite =
    procedure(SmartObject: _TSmartObject; Value: BOOL); stdcall;

  { 祈祷装备 特殊物品:126 - 129 }
  TSmartObject_GetIsPirit =
    function (SmartObject: _TSmartObject): BOOL; stdcall;

  TSmartObject_SetIsPirit =
    procedure(SmartObject: _TSmartObject; Value: BOOL); stdcall;

  { 不死戒指 特殊物品:140 }
  TSmartObject_GetIsSupermanItem =
    function (SmartObject: _TSmartObject): BOOL; stdcall;

  TSmartObject_SetIsSupermanItem =
    procedure(SmartObject: _TSmartObject; Value: BOOL); stdcall;

  { 经验物品 特殊物品:141 }
  TSmartObject_GetIsExpItem =
    function (SmartObject: _TSmartObject): BOOL; stdcall;

  TSmartObject_SetIsExpItem =
    procedure(SmartObject: _TSmartObject; Value: BOOL); stdcall;

  { 经验物品值 特殊物品:141 }
  TSmartObject_GetExpItemValue =
    function (SmartObject: _TSmartObject): Real; stdcall;

  TSmartObject_SetExpItemValue =
    procedure(SmartObject: _TSmartObject; Value: Real); stdcall;

  { 经验物品经验倍率 (物品装备->特殊属性->经验翻倍->倍率) }
  TSmartObject_GetExpItemRate =
    function (SmartObject: _TSmartObject): Integer; stdcall;

  { 力量物品 特殊物品:142 }
  TSmartObject_GetIsPowerItem =
    function (SmartObject: _TSmartObject): BOOL; stdcall;

  TSmartObject_SetIsPowerItem =
    procedure(SmartObject: _TSmartObject; Value: BOOL); stdcall;

  { 力量物品值 特殊物品:142 }
  TSmartObject_GetPowerItemValue =
    function (SmartObject: _TSmartObject): Real; stdcall;

  { 设置力量物品值 特殊物品:142 }
  TSmartObject_SetPowerItemValue =
    procedure (SmartObject: _TSmartObject; Value: Real); stdcall;

  { 力量物品经验倍率 (物品装备->特殊属性->攻击翻倍->倍率) }
  TSmartObject_GetPowerItemRate =
    function (SmartObject: _TSmartObject): Integer; stdcall;

  { 行会传送装备 特殊物品:145 }
  TSmartObject_GetIsGuildMove =
    function (SmartObject: _TSmartObject): BOOL; stdcall;

  TSmartObject_SetIsGuildMove =
    procedure(SmartObject: _TSmartObject; Value: BOOL); stdcall;

  { 幸运戒指 特殊物品 170 }
  TSmartObject_GetIsAngryRing =
    function (SmartObject: _TSmartObject): BOOL; stdcall;

  TSmartObject_SetIsAngryRing =
    procedure(SmartObject: _TSmartObject; Value: BOOL); stdcall;

  { 流星戒指 }
  TSmartObject_GetIsStarRing =
    function (SmartObject: _TSmartObject): BOOL; stdcall;

  TSmartObject_SetIsStarRing =
    procedure(SmartObject: _TSmartObject; Value: BOOL); stdcall;

  { 防御物品 }
  TSmartObject_GetIsACItem =
    function (SmartObject: _TSmartObject): BOOL; stdcall;

  TSmartObject_SetIsACItem =
    procedure(SmartObject: _TSmartObject; Value: BOOL); stdcall;

  { 防御值 }
  TSmartObject_GetACItemValue =
    function (SmartObject: _TSmartObject): Real; stdcall;

  TSmartObject_SetACItemValue =
    procedure(SmartObject: _TSmartObject; Value: Real); stdcall;

  { 魔御物品 }
  TSmartObject_GetIsMACItem =
    function (SmartObject: _TSmartObject): BOOL; stdcall;

  TSmartObject_SetIsMACItem =
    procedure(SmartObject: _TSmartObject; Value: BOOL); stdcall;

  { 魔御值 }
  TSmartObject_GetMACItemValue =
    function (SmartObject: _TSmartObject): Real; stdcall;
    
  TSmartObject_SetMACItemValue =
    procedure(SmartObject: _TSmartObject; Value: Real); stdcall;

  { 171不掉背包物品装备 }
  TSmartObject_GetIsNoDropItem =
    function (SmartObject: _TSmartObject): BOOL; stdcall;

  TSmartObject_SetIsNoDropItem =
    procedure(SmartObject: _TSmartObject; Value: BOOL); stdcall;

  { 172不掉身上物品装备 }
  TSmartObject_GetIsNoDropUseItem =
    function (SmartObject: _TSmartObject): BOOL; stdcall;

  TSmartObject_SetIsNoDropUseItem =
    procedure(SmartObject: _TSmartObject; Value: BOOL); stdcall;

  { 内功属性 }
  TSmartObject_GetNGAbility =
    function (SmartObject: _TSmartObject; AbilityNG: pTAbilityNG): BOOL; stdcall;

  TSmartObject_SetNGAbility =
    procedure(SmartObject: _TSmartObject; Value: pTAbilityNG); stdcall;

  { 酒属性 }
  TSmartObject_GetAlcohol =
    function (SmartObject: _TSmartObject; AbilityAlcohol: pTAbilityAlcohol): BOOL; stdcall;

  TSmartObject_SetAlcohol =
    procedure(SmartObject: _TSmartObject; Value: PTAbilityAlcohol); stdcall;

  { 修复所有装备 }
  TSmartObject_RepairAllItem =
    procedure(SmartObject: _TSmartObject); stdcall;

  { 是否满足技能使用条件 }
  TSmartObject_IsAllowUseMagic =
    function (SmartObject: _TSmartObject; MagicID: Word): BOOL; stdcall;

  { 选择技能 }
  TSmartObject_SelectMagic  =
    function(SmartObject: _TSmartObject): Integer; stdcall;

  { 攻击目标 }
  TSmartObject_AttackTarget =
    function (SmartObject: _TSmartObject; MagicID: Word; AttackTime: DWORD): BOOL; stdcall;


  //-------------------------------------------------------------------------------------------------------------------------------------------------------
  //---------------------------------------------- TPlayObject 人物对象，继承TSmartObject -----------------------------------------------------------------
  //-------------------------------------------------------------------------------------------------------------------------------------------------------
  { 帐户名 }
  TPlayObject_GetUserID =
    function (Player: _TPlayObject; Dest: PAnsiChar; var DestLen: DWORD): BOOL; stdcall;

  { IP }
  TPlayObject_GetIPAddr =
    function (Player: _TPlayObject; Dest: PAnsiChar; var DestLen: DWORD): BOOL; stdcall;

  { IP归属地 }
  TPlayObject_GetIPLocal =
    function (Player: _TPlayObject; Dest: PAnsiChar; var DestLen: DWORD): BOOL; stdcall;

  { MAC }
  TPlayObject_GetMachineID =
    function (Player: _TPlayObject; Dest: PAnsiChar; var DestLen: DWORD): BOOL; stdcall;

  { 是否进入游戏完成 }
  TPlayObject_GetIsReadyRun =
    function (Player: _TPlayObject): BOOL; stdcall;

  { 登录时间 }
  TPlayObject_GetLogonTime =
    function (Player: _TPlayObject; LogonTime: PSystemTime): BOOL; stdcall;

  { 客户端版本号 }
  TPlayObject_GetSoftVerDate  =
    function (Player: _TPlayObject): Integer; stdcall;

  { 客户端类型 (0:176; 1:185; 2:英雄版; 3:连击版; 4:传奇续章; 5:外传; 6:归来) }
  TPlayObject_GetClientType =
    function (Player: _TPlayObject): Integer; stdcall;

  { 是否为老客户端 (185兼容客户端) }
  TPlayObject_IsOldClient =
    function (Player: _TPlayObject): BOOL; stdcall;

  { 客户端分辨率 宽 }
  TPlayObject_GetScreenWidth =
    function (Player: _TPlayObject): Word; stdcall;

  { 客户端分辨率 高 }
  TPlayObject_GetScreenHeight =
    function (Player: _TPlayObject): Word; stdcall;

  { 客户端视觉范围大小 }
  TPlayObject_GetClientViewRange =
    function (Player: _TPlayObject): Word; stdcall;

  { 转生等级 }
  TPlayObject_GetRelevel =
    function (Player: _TPlayObject): Byte; stdcall;
  
  TPlayObject_SetRelevel =
    procedure(Player: _TPlayObject; Value: Byte); stdcall;

  { 未分配属性点 }
  TPlayObject_GetBonusPoint =
    function (Player: _TPlayObject): Integer; stdcall;
    
  TPlayObject_SetBonusPoint =
    procedure(Player: _TPlayObject; Value: Integer); stdcall;

  { 发送属性点 }
  TPlayObject_SendAdjustBonus =
    procedure(Player: _TPlayObject); stdcall;

  { 主将英雄名 }
  TPlayObject_GetHeroName =
    function (Player: _TPlayObject; Dest: PAnsiChar; var DestLen: DWORD): BOOL; stdcall;

  { 副将英雄名 }
  TPlayObject_GetDeputyHeroName =
    function (Player: _TPlayObject; Dest: PAnsiChar; var DestLen: DWORD): BOOL; stdcall;

  { 副将英雄职业 }
  TPlayObject_GetDeputyHeroJob =
    function (Player: _TPlayObject): Byte; stdcall;

  { 英雄对象 }
  TPlayObject_GetMyHero =
    function (Player: _TPlayObject): _THeroObject; stdcall;

  { 是否评定主副英雄 }
  TPlayObject_GetFixedHero =
    function (Player: _TPlayObject): BOOL; stdcall;

  { 召唤英雄 }
  TPlayObject_ClientHeroLogOn =
    procedure(Player: _TPlayObject; IsDeputyHero: BOOL); stdcall;

  { 英雄是否寄存 }
  TPlayObject_GetStorageHero =
    function (Player: _TPlayObject): BOOL; stdcall;

  { 副将英雄是否寄存 }
  TPlayObject_GetStorageDeputyHero =
    function (Player: _TPlayObject): BOOL; stdcall;

  { 仓库是否开启 Index:仓库序号(0-3); }
  TPlayObject_GetIsStorageOpen =
    function (Player: _TPlayObject; Index: Integer): BOOL; stdcall;

  TPlayObject_SetIsStorageOpen =
    procedure(Player: _TPlayObject; Index: Integer; Value: BOOL); stdcall;

  { 金币数量 }
  TPlayObject_GetGold =
    function (Player: _TPlayObject): DWORD; stdcall;

  TPlayObject_SetGold =
    procedure(Player: _TPlayObject; Value: DWORD); stdcall;

  { 人物身上最多可带金币 }
  TPlayObject_GetGoldMax =
    function (Player: _TPlayObject): DWORD; stdcall;

  { 加金币 }
  TPlayObject_IncGold =
    function (Player: _TPlayObject; Value: DWORD): BOOL; stdcall;

  { 减金币 }
  TPlayObject_DecGold =
    function (Player: _TPlayObject; Value: DWORD): BOOL; stdcall;

  { 通知客户端刷新 (金币，元宝) }
  TPlayObject_GoldChanged =
    procedure(Player: _TPlayObject); stdcall;

  { 元宝数量 }
  TPlayObject_GetGameGold =
    function (Player: _TPlayObject): DWORD; stdcall;

  TPlayObject_SetGameGold =
    procedure(Player: _TPlayObject; Value: DWORD); stdcall;

  { 加元宝 }
  TPlayObject_IncGameGold =
    procedure(Player: _TPlayObject; Value: DWORD); stdcall;

  { 减元宝 }
  TPlayObject_DecGameGold =
    procedure(Player: _TPlayObject; Value: DWORD); stdcall;

  { 通知客户端刷新 (元宝，游戏点) }
  TPlayObject_GameGoldChanged =
    procedure(Player: _TPlayObject); stdcall;

  { 游戏点 }
  TPlayObject_GetGamePoint =
    function (Player: _TPlayObject): DWORD; stdcall;

  { 设置游戏点 }
  TPlayObject_SetGamePoint =
    procedure(Player: _TPlayObject; Value: DWORD); stdcall;

  { 加游戏点 }
  TPlayObject_IncGamePoint =
    procedure(Player: _TPlayObject; Value: DWORD); stdcall;

  { 减游戏点 }
  TPlayObject_DecGamePoint =
    procedure(Player: _TPlayObject; Value: DWORD); stdcall;

  { 金刚石 }
  TPlayObject_GetGameDiamond =
    function (Player: _TPlayObject): DWORD; stdcall;
    
  TPlayObject_SetGameDiamond =
    procedure(Player: _TPlayObject; Value: DWORD); stdcall;

  { 加金刚石 }
  TPlayObject_IncGameDiamond =
    procedure(Player: _TPlayObject; Value: DWORD); stdcall;

  { 减金刚石 }
  TPlayObject_DecGameDiamond =
    procedure(Player: _TPlayObject; Value: DWORD); stdcall;

  { 通知客户端刷新 (金刚石，灵符) }
  TPlayObject_NewGamePointChanged =
    procedure(Player: _TPlayObject); stdcall;

  { 灵符 }
  TPlayObject_GetGameGird =
    function (Player: _TPlayObject): DWORD; stdcall;

  TPlayObject_SetGameGird =
    procedure(Player: _TPlayObject; Value: DWORD); stdcall;

  { 加灵符 }
  TPlayObject_IncGameGird =
    procedure(Player: _TPlayObject; Value: DWORD); stdcall;

  { 减灵符 }
  TPlayObject_DecGameGird =
    procedure(Player: _TPlayObject; Value: DWORD); stdcall;

  { 新游戏点 }
  TPlayObject_GetGameGoldEx =
    function (Player: _TPlayObject): Integer; stdcall;

  TPlayObject_SetGameGoldEx =
    procedure(Player: _TPlayObject; Value: Integer); stdcall;

  { 荣誉 }
  TPlayObject_GetGameGlory =
    function (Player: _TPlayObject): Integer; stdcall;
    
  TPlayObject_SetGameGlory =
    procedure(Player: _TPlayObject; Value: Integer); stdcall;

  { 加荣誉 }
  TPlayObject_IncGameGlory =
    procedure(Player: _TPlayObject; Value: Integer); stdcall;

  { 减荣誉 }
  TPlayObject_DecGameGlory =
    procedure(Player: _TPlayObject; Value: Integer); stdcall;

  { 通知客户端刷新荣誉 }
  TPlayObject_GameGloryChanged =
    procedure(Player: _TPlayObject); stdcall;

  { 充值点 }
  TPlayObject_GetPayMentPoint =
    function (Player: _TPlayObject): Integer; stdcall;

  TPlayObject_SetPayMentPoint =
    procedure(Player: _TPlayObject; Value: Integer); stdcall;

  { 会员类型 }
  TPlayObject_GetMemberType =
    function (Player: _TPlayObject): Integer; stdcall;

  TPlayObject_SetMemberType =
    procedure(Player: _TPlayObject; Value: Integer); stdcall;

  { 会员等级 }
  TPlayObject_GetMemberLevel =
    function (Player: _TPlayObject): Integer; stdcall;

  TPlayObject_SetMemberLevel =
    procedure(Player: _TPlayObject; Value: Integer); stdcall;

  { 贡献度 }
  TPlayObject_GetContribution =
    function (Player: _TPlayObject): Word; stdcall;

  TPlayObject_SetContribution =
    procedure(Player: _TPlayObject; Value: Word); stdcall;

  { 加经验，调用些函数会自动刷新客户端 }
  TPlayObejct_IncExp =
    procedure(Player: _TPlayObject; Value: DWORD); stdcall;

  { 经验改变 }
  TPlayObject_SendExpChanged =
    procedure(Player: _TPlayObject); stdcall;

  { 加内功经验，调用此函数会自动刷新客户端 }
  TPlayObject_IncExpNG =
    procedure(Player: _TPlayObject; Value: DWORD); stdcall;

  { 内功经验改变 }
  TPlayObject_SendExpNGChanged =
    procedure(Player: _TPlayObject); stdcall;

  { 增加聚灵珠经验 }
  TPlayObject_IncBeadExp =
    procedure(Player: _TPlayObject; Value: DWORD; IsFromNPC: BOOL); stdcall;

  { P变量 m_nVal  [0..999] }
  TPlayObject_GetVarP =
    function (Player: _TPlayObject; Index: Integer): Integer; stdcall;
  
  TPlayObject_SetVarP =
    procedure(Player: _TPlayObject; Index: Integer; Value: Integer); stdcall;

  { M变量 m_nMval [0..999] }
  TPlayObject_GetVarM =
    function (Player: _TPlayObject; Index: Integer): Integer; stdcall;

  TPlayObject_SetVarM =
    procedure(Player: _TPlayObject; Index: Integer; Value: Integer); stdcall;

  { D变量 m_DyVal [0..999] }
  TPlayObject_GetVarD =
    function (Player: _TPlayObject; Index: Integer): Integer; stdcall;

  TPlayObject_SetVarD =
    procedure(Player: _TPlayObject; Index: Integer; Value: Integer); stdcall;

  { U变量 m_UVal [0..254] }
  TPlayObject_GetVarU =
    function (Player: _TPlayObject; Index: Integer): Integer; stdcall;

  TPlayObject_SetVarU =
    procedure(Player: _TPlayObject; Index: Integer; Value: Integer); stdcall;

  { T变量 m_UVal [0..254] }
  TPlayObject_GetVarT =
    function (Player: _TPlayObject; Index: Integer;
              Dest: PAnsiChar; var DestLen: DWORD): BOOL; stdcall;

  TPlayObject_SetVarT =
    procedure(Player: _TPlayObject; Index: Integer; Value: PAnsiChar); stdcall;

  { N变量 m_nInteger [0..999] }
  TPlayObject_GetVarN =
    function (Player: _TPlayObject; Index: Integer): Integer; stdcall;

  TPlayObject_SetVarN =
    procedure(Player: _TPlayObject; Index: Integer; Value: Integer); stdcall;

  { S变量 m_sString [0..999] }
  TPlayObject_GetVarS =
    function (Player: _TPlayObject; Index: Integer;
              Dest: PAnsiChar; var DestLen: DWORD): BOOL; stdcall;

  TPlayObject_SetVarS =
    procedure(Player: _TPlayObject; Index: Integer; Value: PAnsiChar); stdcall;

  { 自定义动态变量列表 (结果的元素为 pTDynamicVar) }
  TPlayObject_GetDynamicVarList = function (Player: _TPlayObject): _TList; stdcall;

  //m_IntegerList: TQuickList; { N }
  //m_StringList: TValueList; { S }

  TPlayObject_GetQuestFlagStatus =
    function (Player: _TPlayObject; nFlag: Integer): Integer; stdcall;

  TPlayObject_SetQuestFlagStatus =
    procedure(Player: _TPlayObject; nFlag: Integer; Value: Integer); stdcall;

  { 是否离线挂机 }
  TPlayObject_IsOffLine =
    function (Player: _TPlayObject): BOOL; stdcall;

  { 是否是师傅 }
  TPlayObject_IsMaster =
    function (Player: _TPlayObject): BOOL; stdcall;

  { 取得师傅名字 }
  TPlayObject_GetMasterName =
    function (Player: _TPlayObject; Dest: PAnsiChar; var DestLen: DWORD): BOOL; stdcall;

  { 师傅 }
  TPlayObject_GetMasterHuman =
    function (Player: _TPlayObject): _TPlayObject; stdcall;

  { 当角色为徒弟时，徒弟排名 }
  TPlayObject_GetApprenticeNO =
    function (Player: _TPlayObject): Integer; stdcall;

  { 在线徒弟列表 }
  TPlayObject_GetOnlineApprenticeList =
    function (Player: _TPlayObject): _TList; stdcall;

  { 所有徒弟列表 (结果的元素为 pTMasterRankInfo) }
  TPlayObject_GetAllApprenticeList =
    function (Player: _TPlayObject): _TList; stdcall;

  { 取得爱人名字 }
  TPlayObject_GetDearName =
    function (Player: _TPlayObject; Dest: PAnsiChar; var DestLen: DWORD): BOOL; stdcall;

  { 爱人 }
  TPlayObject_GetDearHuman =
    function (Player: _TPlayObject): _TPlayObject; stdcall;

  { 离婚次数 }
  TPlayObject_GetMarryCount =
    function (Player: _TPlayObject): Byte; stdcall;

  { 队长 }
  TPlayObject_GetGroupOwner =
    function (Player: _TPlayObject): _TPlayObject; stdcall;

  { 队员列表 Item: 队员名 Objects: _TBaseObject}
  TPlayObject_GetGroupMembers =
    function (Player: _TPlayObject): _TStringList; stdcall;

  { 锁定登录 }
  TPlayObject_GetIsLockLogin =
    function (Player: _TPlayObject): BOOL; stdcall;

  TPlayObject_SetIsLockLogin =
    procedure(Player: _TPlayObject; Value: BOOL); stdcall;

  { 是否允许组队 }
  TPlayObject_GetIsAllowGroup =
    function (Player: _TPlayObject): BOOL; stdcall;

  TPlayObject_SetIsAllowGroup =
    procedure(Player: _TPlayObject; Value: BOOL); stdcall;

  { 是否允许天地合一 }
  TPlayObject_GetIsAllowGroupReCall =
    function (Player: _TPlayObject): BOOL; stdcall;

  TPlayObject_SetIsAllowGroupReCall =
    procedure(Player: _TPlayObject; Value: BOOL); stdcall;

  { 是否允许行会合一 }
  TPlayObject_GetIsAllowGuildReCall =
    function (Player: _TPlayObject): BOOL; stdcall;

  TPlayObject_SetIsAllowGuildReCall =
    procedure(Player: _TPlayObject; Value: BOOL); stdcall;

  { 允许交易 }
  TPlayObject_GetIsAllowTrading =
    function (Player: _TPlayObject): BOOL; stdcall;

  TPlayObject_SetIsAllowTrading =
    procedure(Player: _TPlayObject; Value: BOOL); stdcall;

  { 禁止邀请上马 }
  TPlayObject_GetIsDisableInviteHorseRiding =
    function (Player: _TPlayObject): BOOL; stdcall;

  TPlayObject_SetIsDisableInviteHorseRiding =
    procedure(Player: _TPlayObject; Value: BOOL); stdcall;

  { 是否开启元宝交易 }
  TPlayObject_GetIsGameGoldTrading =
    function (Player: _TPlayObject): BOOL; stdcall;

  TPlayObject_SetIsGameGoldTrading =
    procedure(Player: _TPlayObject; Value: BOOL); stdcall;

  { 合过区没有登录过的 }
  TPlayObject_GetIsNewServer =
    function (Player: _TPlayObject): BOOL; stdcall;

  { 过滤掉落提示信息 }
  TPlayObject_GetIsFilterGlobalDropItemMsg =
    function (Player: _TPlayObject): BOOL; stdcall;

  TPlayObject_SetIsFilterGlobalDropItemMsg =
    procedure(Player: _TPlayObject; Value: BOOL); stdcall;

  { 过滤SendCenterMsg }
  TPlayObject_GetIsFilterGlobalCenterMsg =
    function (Player: _TPlayObject): BOOL; stdcall;

  TPlayObject_SetIsFilterGlobalCenterMsg =
    procedure(Player: _TPlayObject; Value: BOOL); stdcall;

  { 过滤SendMsg全局信息 }
  TPlayObject_GetIsFilterGolbalSendMsg =
    function (Player: _TPlayObject): BOOL; stdcall;

  TPlayObject_SetIsFilterGolbalSendMsg =
    procedure(Player: _TPlayObject; Value: BOOL); stdcall;

  { 是否请过酒 }
  TPlayObject_GetIsPleaseDrink =
    function (Player: _TPlayObject): BOOL; stdcall;

  { 饮酒时酒的品质 }
  TPlayObject_GetIsDrinkWineQuality =
    function (Player: _TPlayObject): Integer; stdcall;

  TPlayObject_SetIsDrinkWineQuality =
    procedure(Player: _TPlayObject; Value: Integer); stdcall;

  { 饮酒时酒的度数 }
  TPlayObject_GetIsDrinkWineAlcohol =
    function (Player: _TPlayObject): Integer; stdcall;

  TPlayObject_SetIsDrinkWineAlcohol =
    procedure(Player: _TPlayObject; Value: Integer); stdcall;

  { 人是否喝酒醉了 }
  TPlayObject_GetIsDrinkWineDrunk =
    function (Player: _TPlayObject): BOOL; stdcall;

  TPlayObject_SetIsDrinkWineDrunk =
    procedure(Player: _TPlayObject; Value: BOOL); stdcall;

  { 回城 }
  TPlayObject_MoveToHome =
    procedure(Player: _TPlayObject); stdcall;

  { 随机传送到回城地图 }
  TPlayObject_MoveRandomToHome =
    procedure(Player: _TPlayObject); stdcall;

  { 发送数据 }
  TPlayObject_SendSocket =
    procedure(Player: _TPlayObject; DefMsg: pTDefaultMessage; sMsg: PAnsiChar); stdcall;

  { 发送消息  Int64 2021-01-06 }
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

  { 检测装备是否可穿戴 }
  TPlayObject_CheckTakeOnItems =
    function (Player: _TPlayObject; Where: Integer; StdItem: pTStdItem): BOOL; stdcall;

  { 处理装备穿脱时对应的技能 }
  TPlayObject_ProcessUseItemSkill =
    procedure(Player: _TPlayObject; Where: Integer; StdItem: pTStdItem; IsTakeOn: BOOL); stdcall;

  { 发送身上装备列表 }
  TPlayObject_SendUseItems =
    procedure(Player: _TPlayObject); stdcall;

  { 发送增加物品 }
  TPlayObject_SendAddItem =
    procedure(Player: _TPlayObject; UserItem: pTUserItem); stdcall;

  { 客户端删除多个物品 2020-01-20修改 物品名称/MakeIndex/物品名称/MakeIndex.... }
  TPlayObject_SendDelItemList =
    procedure(Player: _TPlayObject; Items: PAnsiChar; ItemsCount: Integer); stdcall;

  { 客户端删除物品 }
  TPlayObject_SendDelItem =
    procedure(Player: _TPlayObject; UserItem: pTUserItem); stdcall;

  { 客户端刷新物品 }
  TPlayObject_SendUpdateItem =
    procedure(Player: _TPlayObject; UserItem: pTUserItem); stdcall;

  { 客户端刷新装备持久改变 }
  TPlayObject_SendItemDuraChange =
    procedure(Player: _TPlayObject; ItemWhere: Integer; UserItem: pTUserItem); stdcall;

  { 刷新客户端包裹 }
  TPlayObject_SendBagItems =
    procedure(Plyaer: _TPlayObject); stdcall;

  { 发送首饰盒物品 }
  TPlayObject_SendJewelryBoxItems =
    procedure(Player: _TPlayObject); stdcall;

  { 发送神佑袋物品 }
  TPlayObject_SendGodBlessItems =
    procedure(Player: _TPlayObject); stdcall;

  { 神佑格开启 }
  TPlayObject_SendOpenGodBlessItem =
    procedure(Player: _TPlayObject; Index: Integer); stdcall;

  { 神佑格关闭 }
  TPlayObject_SendCloseGodBlessItem =
    procedure(Player: _TPlayObject; Index: Integer); stdcall;

  { 发送技能列表 }
  TPlayObject_SendUseMagics =
    procedure(Player: _TPlayObject); stdcall;

  { 发送技能添加 }
  TPlayObject_SendAddMagic =
    procedure(Player: _TPlayObject; UserMagic: pTUserMagic); stdcall;

  { 发送技能删除 }
  TPlayObject_SendDelMagic =
    procedure(Player: _TPlayObject; UserMagic: pTUserMagic); stdcall;

  { 发送封号物品 }
  TPlayObject_SendFengHaoItems =
    procedure(Player: _TPlayObject); stdcall;

  { 发送封号增加 }
  TPlayObject_SendAddFengHaoItem =
    procedure(Player: _TPlayObject; UserItem: PTUserItem); stdcall;

  { 发送封号删除 }
  TPlayObject_SendDelFengHaoItem =
    procedure(Player: _TPlayObject; Index: Integer); stdcall;

  { 发送走路/跑步失败 }
  TPlayObject_SendSocketStatusFail =
    procedure(Player: _TPlayObject); stdcall;

  TPlayObject_PlayEffect =
    procedure(Player: _TPlayObject; nFileIndex, nImageOffset,
              nImageCount, nLoopCount, nSpeedTime: Integer;
              btDrawOrder: Byte; nOffsetX: Integer; nOffsetY: Integer); stdcall;

  { 是否正在内挂挂机 }
  TPlayObject_IsAutoPlayGame =
    function (Player: _TPlayObject): BOOL; stdcall;

  { 开始内挂挂机 }
  TPlayObject_StartAutoPlayGame =
    function (Player: _TPlayObject): BOOL; stdcall;

  { 停止内挂挂机 }
  TPlayObject_StopAutoPlayGame =
    function (Player: _TPlayObject): BOOL; stdcall;

  //-------------------------------------------------------------------------------------------------------------------------------------------------------
  //---------------------------------------------- TDummyObject 假人对象，继承TPlayObject -----------------------------------------------------------------
  //-------------------------------------------------------------------------------------------------------------------------------------------------------

  { 假人是否开始挂机 }
  TDummyObject_IsStart =
    function (Dummyer: _TDummyObject): BOOL; stdcall;

  { 假人开始挂机 }
  TDummyObject_Start =
    procedure(Dummyer: _TDummyObject); stdcall;

  { 假人停止挂机 }
  TDummyObject_Stop =
    procedure(Dummyer: _TDummyObject); stdcall;


  //-------------------------------------------------------------------------------------------------------------------------------------------------------
  //---------------------------------------------- THeroObject 英雄对象，继承TSmartObject -----------------------------------------------------------------
  //-------------------------------------------------------------------------------------------------------------------------------------------------------

  { 攻击模式 }
  THeroObject_GetAttackMode =
    function (Hero: _THeroObject): Byte; stdcall;

  THeroObject_SetAttackMode =
    function (Hero: _THeroObject; Value: Byte; ShowSysMsg: BOOL): BOOL; stdcall;

  { 切换下一个攻击模式 }
  THeroObject_SetNextAttackMode =
    procedure(Hero: _THeroObject); stdcall;

  { 获取背包数量 }
  THeroObject_GetBagCount =
    function (Hero: _THeroObject): Integer; stdcall;

  { 当前怒气值 }
  THeroObject_GetAngryValue =
    function (Hero: _THeroObject): Integer; stdcall;

  { 忠诚度 }
  THeroObject_GetLoyalPoint =
    function (Hero: _THeroObject): Real; stdcall;

  THeroObject_SetLoyalPoint =
    procedure(Hero: _THeroObject; Value: Real); stdcall;

  THeroObject_SendLoyalPointChanged =
    procedure(Hero: _THeroObject); stdcall;

  { 是否副将英雄 }
  THeroObject_IsDeputy =
    function (Hero: _THeroObject): BOOL; stdcall;

  { 主人名称 }
  THeroObject_GetMasterName =
    function (Hero: _THeroObject; Dest: PAnsiChar; var DestLen: DWORD): BOOL; stdcall;

  THeroObject_GetQuestFlagStatus =
    function (Hero: _THeroObject; nFlag: Integer): Integer; stdcall;

  THeroObject_SetQuestFlagStatus =
    procedure(Hero: _THeroObject; nFlag: Integer; Value: Integer); stdcall;

  { 发送身上装备 }
  THeroObject_SendUseItems =
    procedure(Hero: _THeroObject); stdcall;

  { 刷新英雄背包 }
  THeroObject_SendBagItems =
    procedure(Hero: _THeroObject); stdcall;

  { 发送首饰盒物品 }
  THeroObject_SendJewelryBoxItems =
    procedure(Hero: _THeroObject); stdcall;

  { 发送神佑袋物品 }
  THeroObject_SendGodBlessItems =
    procedure(Hero: _THeroObject); stdcall;

  { 神佑格开启 }
  THeroObject_SendOpenGodBlessItem =
    procedure(Hero: _THeroObject; Index: Integer); stdcall;

  { 神佑格关闭 }
  THeroObject_SendCloseGodBlessItem =
    procedure(Hero: _THeroObject; Index: Integer); stdcall;

  { 发送增加物品 }
  THeroObject_SendAddItem =
    procedure(Hero: _THeroObject; UserItem: pTUserItem); stdcall;

  { 客户端删除物品 }
  THeroObject_SendDelItem =
    procedure(Hero: _THeroObject; UserItem: pTUserItem); stdcall;

  { 客户端刷新物品 }
  THeroObject_SendUpdateItem =
    procedure(Hero: _THeroObject; UserItem: pTUserItem); stdcall;

  { 客户端刷新装备持久改变 }
  THeroObject_SendItemDuraChange =
    procedure(Hero: _THeroObject; ItemWhere: Integer; UserItem: pTUserItem); stdcall;

  { 发送技能列表 }
  THeroObject_SendUseMagics =
    procedure(Hero: _THeroObject); stdcall;

  { 发送技能添加 }
  THeroObject_SendAddMagic =
    procedure(Hero: _THeroObject; UserMagic: pTUserMagic); stdcall;

  { 发送技能删除 }
  THeroObject_SendDelMagic =
    procedure(Hero: _THeroObject; UserMagic: pTUserMagic); stdcall;

  { 取得合击技能 }
  THeroObject_FindGroupMagic =
    function (Hero: _THeroObject; UserMagic: pTUserMagic): BOOL; stdcall;

  { 取得合击技能ID }
  THeroObject_GetGroupMagicId =
    function (Hero: _THeroObject): Integer; stdcall;

  { 发送封号物品 }
  THeroObject_SendFengHaoItems =
    procedure(Hero: _THeroObject); stdcall;

  { 发送封号增加 }
  THeroObject_SendAddFengHaoItem =
    procedure(Hero: _THeroObject; UserItem: pTUserItem);  stdcall;

  { 发送封号删除 }
  THeroObject_SendDelFengHaoItem =
    procedure(Hero: _THeroObject; Index: Integer); stdcall;

  THeroObject_IncExp =
    procedure(Hero: _THeroObject; dwExp: DWORD); stdcall;
    
  THeroObject_IncExpNG =
    procedure(Hero: _THeroObject; dwExp: DWORD); stdcall;

  THeroObject_IsOldClient =
    function (Hero: _THeroObject): BOOL; stdcall;


  //-------------------------------------------------------------------------------------------------------------------------------------------------------
  //---------------------------------------------- TNormNpc NPC对象，继承TBaseObject ---------------------------------------------------------------------
  //-------------------------------------------------------------------------------------------------------------------------------------------------------
  { 创建NPC，该NPC由引擎自动释放 }
  TNormNpc_Create =
    function (CharName, sMapName, sScript: PAnsiChar; X, Y: Integer;
              wAppr: Word; boIsHide: BOOL): _TNormNpc; stdcall;

  { 载入脚本 }
  TNormNpc_LoadNpcScript =
    procedure(NormNpc: _TNormNpc); stdcall;

  { 清脚本 }
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
  //---------------------------------------------- TUserEngine 对象 --------------------------------------------------------------------------------------
  //-------------------------------------------------------------------------------------------------------------------------------------------------------

  { 获取所有在线人物列表(含假人) }
  TUserEngine_GetPlayerList =
    function (): _TStringList; stdcall;

  { 根据在线人物名称获取对象 }
  TUserEngine_GetPlayerByName =
    function (ChrName: PAnsiChar): _TPlayObject; stdcall;

  { 根据在线帐户获取对象 }
  TUserEngine_GetPlayerByUserID =
    function (UserID: PAnsiChar): _TPlayObject; stdcall;

  { 判断对象是否是一个合法的在线人物 }
  TUserEngine_GetPlayerByObject =
    function (AObject: _TObject): _TPlayObject; stdcall;

  { 根据帐户获取一个离线挂机对象 }
  TUserEngine_GetOfflinePlayer =
    function (UserID: PAnsiChar): _TPlayObject; stdcall;

  { 踢人 }
  TUserEngine_KickPlayer  =
    procedure(ChrName: PAnsiChar); stdcall;

  { 获取英雄列表 }
  TUserEngine_GetHeroList =
    function (): _TStringList; stdcall;

  { 根据名称获取英雄对象 }
  TUserEngine_GetHeroByName =
    function (ChrName: PAnsiChar): _THeroObject; stdcall;

  { 踢英雄 }
  TUserEngine_KickHero =
    function (ChrName: PAnsiChar): BOOL; stdcall;

  { 获取交易NPC列表 }
  TUserEngine_GetMerchantList =
    function (): _TList; stdcall;

  { 获取自定义NPC配置列表 }
  TUserEngine_GetCustomNpcConfigList =
    function (): _TList; stdcall;

  { 获取MapQuest.txt中定义的NPC列表 }
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

  { 判断NPC对象是否合法 }
  TUserEngine_FindMerchant =
    function (AObject: _TObject): _TNormNpc; stdcall;

  { 根据地图坐标得到NPC }
  TUserEngine_FindMerchantByPos =
    function (MapName: PAnsiChar; nX, nY: Integer): _TNormNpc; stdcall;

  { 判断NPC对象是否合法 }
  TUserEngine_FindQuestNPC =
    function (AObject: _TObject): _TNormNpc; stdcall;

  { Magic.DB }
  TUserEngine_GetMagicList =
    function (): _TList; stdcall;

  { 自定义技能配置列表 }
  TUserEngine_GetCustomMagicConfigList =
    function (): _TList; stdcall;

  { M2 -> 功能设置 ->技能魔法 -> 技能破防百分比 }
  TUserEngine_GetMagicACList =
    function (): _TMagicACList; stdcall;

  { 根据技能名查找技能 }
  TUserEngine_FindMagicByName =
    function (MagName: PAnsiChar; Magic: pTMagic): BOOL; stdcall;

  { 根据技能编号查找技能 }
  TUserEngine_FindMagicByIndex =
    function (MagIdx: Integer; Magic: pTMagic): BOOL; stdcall;

  { 根据技能名及属性查找技能 }
  TUserEngine_FindMagicByNameEx =
    function (MagName: PAnsiChar; MagAttr: Integer; Magic: pTMagic): BOOL; stdcall;

  { 根据技能编号及属性查找技能 }
  TUserEngine_FindMagicByIndexEx =
    function (MagIdx: Integer; MagAttr: Integer; Magic: pTMagic): BOOL; stdcall;

  { 根据技能名查找英雄技能 }
  TUserEngine_FindHeroMagicByName =
    function (MagName: PAnsiChar; Magic: pTMagic): BOOL; stdcall;

  { 根据技能编号查找英雄技能 }
  TUserEngine_FindHeroMagicByIndex =
    function (MagIdx: Integer; Magic: pTMagic): BOOL; stdcall;

  { 根据技能名及属性查找英雄技能 }
  TUserEngine_FindHeroMagicByNameEx =
    function (MagName: PAnsiChar; MagAttr: Integer; Magic: pTMagic): BOOL; stdcall;

  { 根据技能编号及属性查找英雄技能 }
  TUserEngine_FindHeroMagicByIndexEx =
    function (MagIdx: Integer; MagAttr: Integer; Magic: pTMagic): BOOL; stdcall;

  { StdItem.DB }
  TUserEngine_GetStdItemList =
    function (): _TList; stdcall;

  { 根据物品名得到数据库的物品信息 }
  TUserEngine_GetStdItemByName =
    function (ItemName: PAnsiChar; StdItem: pTStdItem): BOOL; stdcall;

  { 根据物品编号得到数据库的物品信息 }
  TUserEngine_GetStdItemByIndex =
    function (ItemIdx: Integer; StdItem: pTStdItem): BOOL; stdcall;

  { 根据物品编号得到物品名 }
  TUserEngine_GetStdItemName =
    function (ItemIdx: Integer; Dest: PAnsiChar; var DestLen: DWORD): BOOL; stdcall;

  { 根据物品名得到物品编号 }
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

   { 换行消息 }
  TUserEngine_SendNewLineMsg =
    procedure(sMsg: PAnsiChar; btFColor, btBColor, btFontSize: Byte;
              nY, nShowMsgTime, nDrawType: Integer); stdcall;

  { 仿盛大顶部渐隐消息 }
  TUserEngine_SendSuperMoveMsg =
    procedure(sMsg: PAnsiChar; btFColor, btBColor, btFontSize: Byte; nY, nMoveCount: Integer); stdcall;

  { 发送屏幕震动消息 }
  TUserEngine_SendSceneShake =
    procedure(Count: Integer); stdcall;

  TUserEngine_CopyToUserItemFromName =
    function (ItemName: PAnsiChar; UserItem: pTUserItem): BOOL; stdcall;

  TUserEngine_CopyToUserItemFromItem =
    function (StdItem: pTStdItem; ItemIndex: Integer; UserItem: pTUserItem): BOOL; stdcall;

  TUserEngine_RandomUpgradeItem =
    procedure(UserItem: pTUserItem); stdcall;

  { 随机生成元素属性 }
  TUserEngine_RandomItemNewAbil =
    procedure(UserItem: pTUserItem); stdcall;

  TUserEngine_GetUnknowItemValue =
    procedure(UserItem: pTUserItem); stdcall;

  { 所有假人数量 }
  TUserEngine_GetAllDummyCount =
    function (): Integer; stdcall;

  { 指定地图假人数量 }
  TUserEngine_GetMapDummyCount =
    function (Envir: _TEnvirnoment): Integer; stdcall;

  { 离线挂机人物数量 }
  TUserEngine_GetOfflineCount =
    function (): Integer; stdcall;

  { 在线真人数量(不含离线挂机) }
  TUserEngine_GetRealPlayerCount =
    function (): Integer; stdcall;

  //-------------------------------------------------------------------------------------------------------------------------------------------------------
  //---------------------------------------------- _TGuild 行会对象 --------------------------------------------------------------------------------------
  //-------------------------------------------------------------------------------------------------------------------------------------------------------

  { 行会名称 }
  TGuild_GetGuildName =
    function (Guild: _TGuild; Dest: PAnsiChar; var DestLen: DWORD): BOOL; stdcall;

  { 加入行会职业 (1:战士; 2:法师; 3:道士，可组合) }
  TGuild_GetJoinJob =
    function (Guild: _TGuild): Integer; stdcall;

  { 加入行会最低等级 }
  TGuild_GetJoinLevel =
    function (Guild: _TGuild): DWORD; stdcall;

  { 招贤消息 }
  TGuild_GetJoinMsg =
    function (Guild: _TGuild; Dest: PAnsiChar; var DestLen: DWORD): BOOL; stdcall;

  { 建筑度 }
  TGuild_GetBuildPoint =
    function (Guild: _TGuild): Integer; stdcall;

  { 人气值/关注度 }
  TGuild_GetAurae =
    function (Guild: _TGuild): Integer; stdcall;

  { 安定度 }
  TGuild_GetStability =
    function (Guild: _TGuild): Integer; stdcall;

  { 繁荣度 }
  TGuild_GetFlourishing =
    function (Guild: _TGuild): Integer; stdcall;

  { 领取装备数量 }
  TGuild_GetChiefItemCount =
    function (Guild: _TGuild): Integer; stdcall;

  { 行会成员数量 }
  TGuild_GetMemberCount =
    function (Guild: _TGuild): Integer; stdcall;

  { 在线行会成员数量 }
  TGuild_GetOnlineMemeberCount =
    function (Guild: _TGuild): Integer; stdcall;

  { 掌门数量 }
  TGuild_GetMasterCount =
    function (Guild: _TGuild): Integer; stdcall;

  { 得到行会正副掌门 }
  TGuild_GetMaster =
    procedure(Guild: _TGuild; var Master1, Master2: _TPlayObject); stdcall;

  { 得到行会正副掌门名称 }
  TGuild_GetMasterName =
    function (Guild: _TGuild; Master1: PAnsiChar; var Master1Size: DWORD;
              Master2: PAnsiChar; var Master2Size: DWORD): BOOL; stdcall;

  { 检查行会是否满员 }
  TGuild_CheckMemberIsFull =
    function (Guild: _TGuild): BOOL; stdcall;

  { 检查人员是否为行会成员 }
  TGuild_IsMemeber =
    function (Guild: _TGuild; CharName: PAnsiChar): BOOL; stdcall;

  { 人员加入行会 }
  TGuild_AddMember =
    function (Guild: _TGuild; Player: _TPlayObject): BOOL; stdcall;

  TGuild_AddMemberEx =
    function (Guild: _TGuild; CharName: PAnsiChar): BOOL; stdcall;

  { 行会删除人员 }
  TGuild_DelMemeber =
    function (Guild: _TGuild; Player: _TPlayObject): BOOL; stdcall;

  TGuild_DelMemeberEx =
    function (Guild: _TGuild; CharName: PAnsiChar): BOOL; stdcall;

  { 判断 CheckGuild是否是Guild的联盟行会 }
  TGuild_IsAllianceGuild =
    function (Guild: _TGuild; CheckGuild: _TGuild): BOOL; stdcall;

  { 判断是否为战争行会 }
  TGuild_IsWarGuild =
    function (Guild: _TGuild; CheckGuild: _TGuild): BOOL; stdcall;

  { 判断是否为关注行会 }
  TGuild_IsAttentionGuild =
    function (Guild: _TGuild; CheckGuild: _TGuild): BOOL; stdcall;

  { 添加联盟行会 }
  TGuild_AddAlliance =
    function (Guild: _TGuild; AddGuild: _TGuild): BOOL; stdcall;

  { 添加战争行会 }
  TGuild_AddWarGuild =
    function (Guild: _TGuild; AddGuild: _TGuild): BOOL; stdcall;

  { 添加关注行会 }
  TGuild_AddAttentionGuild =
    function (Guild: _TGuild; AddGuild: _TGuild): BOOL; stdcall;

  { 删除联盟行会 }
  TGuild_DelAllianceGuild =
    function(Guild: _TGuild; DelGuild: _TGuild): BOOL; stdcall;

  { 删除关注行会 }
  TGuild_DelAttentionGuild =
    function(Guild: _TGuild; DelGuild: _TGuild): BOOL; stdcall;

  TGuild_GetRandNameByName =
    function (Guild: _TGuild; CharName: PAnsiChar; var nRankNo: Integer;
              Dest: PAnsiChar; var DestLen: DWORD): BOOL; stdcall;

  TGuild_GetRandNameByPlayer =
    function (Guild: _TGuild; Player: _TPlayObject; var nRankNo: Integer;
              Dest: PAnsiChar; var DestLen: DWORD): BOOL; stdcall;

  { 发送行会消息 }
  TGuild_SendGuildMsg =
    procedure(Guild: _TGuild; Msg: PAnsiChar); stdcall;

  //-------------------------------------------------------------------------------------------------------------------------------------------------------
  //---------------------------------------------- TGuildManager 行会管理 ---------------------------------------------------------------------------------
  //-------------------------------------------------------------------------------------------------------------------------------------------------------

  { 根据行会名得到行会对象 }
  TGuildManager_FindGuild =
    function (GuildName: PAnsiChar): _TGuild; stdcall;

  { 根据用户名得到行会对象 }
  TGuildManager_GetPlayerGuild =
    function (CharName: PAnsiChar): _TGuild; stdcall;

  { 创建新行会 }
  TGuildManager_AddGuild =
    function (GuildName, GuildMaster: PAnsiChar): BOOL; stdcall;

  { 删除行会，有成员时不能删 }
  TGuildManager_DelGuild =
    function (GuildName: PAnsiChar; var IsFoundGuild: BOOL): BOOL; stdcall;

type
  TMemoryFunc = record
    Allow: TMemory_Alloc;                                   // 申请内存
    Free: TMemory_Free;                                     // 释放内存
    Realloc: TMemory_Realloc;                               // 重新分配内存大小 (若扩大内存则保留原始内存的值)
    Reserved: array[0..3] of Pointer;
  end;

  TListFunc = record
    Create: TList_Create;                                   // 列表创建
    Free: TList_Free;                                       // 列表释放
    Count: TList_Count;                                     // 取列表数量
    Clear: TList_Clear;                                     // 清空列表
    Add: TList_Add;                                         // 添加元素
    Insert: TList_Insert;                                   // 插入元素}
    Remove: TList_Remove;                                   // 根据元素删除
    Delete: TList_Delete;                                   // 根据索引删除
    GetItem: TList_GetItem;                                 // 取得元素
    SetItem: TList_SetItem;                                 // 设置元素
    IndexOf: TList_IndexOf;                                 // 得到元素的索引
    Exchange: TList_Exchange;                               // 交换元素
    CopyTo: TList_CopyTo;                                   // 复制到另一个列表

    Reserved: array[0..19] of Pointer;
  end;


  TStringListFunc = record
    Create: TStrList_Create;                                // 创建文本列表
    Free: TStrList_Free;                                    // 释放文本列表
    GetCaseSensitive: TStrList_GetCaseSensitive;            // 判断是否分大小写
    SetCaseSensitive: TStrList_SetCaseSensitive;            // 设置是否分大小写
    GetSorted: TStrList_GetSorted;                          // 是否排序
    SetSorted: TStrList_SetSorted;                          // 设置是否自动排序
    GetDuplicates: TStrList_GetDuplicates;                  // 是否重复
    SetDuplicates: TStrList_SetDuplicates;                  // 设置是否允许重复
    Count: TStrList_Count;                                  // 取文本行数
    GetText: TStrList_GetText;                              // 取得所有内容
    SetText: TStrList_SetText;                              // 设置内容
    Add: TStrList_Add;                                      // 添加一行
    AddObject: TStrList_AddObject;                          // 添加一行，并将该行绑定一个对象
    Insert: TStrList_Insert;                                // 插入一行
    InsertObject: TStrList_InsertObject;                    // 插入一行，并将该行绑定一个对象
    Remove: TStrList_Remove;                                // 根据指定文本的行
    Delete: TStrList_Delete;                                // 删除指定的第几行(行数从0开始)
    GetItem: TStrList_GetItem;                              // 取一行的内容
    SetItem: TStrList_SetItem;                              // 设置某行的内容
    GetObject: TStrList_GetObject;                          // 取某行绑定的对象
    SetObject: TStrList_SetObject;                          // 设置某行的绑定对象
    IndexOf: TStrList_IndexOf;                              // 根据文本得到行的索引
    IndexOfObject: TStrList_IndexOfObject;                  // 根据绑定对象得到行索引
    Find: TStrList_Find;                                    // 二分查找某行的内容 (每行的内容必须是排序的)
    Exchange: TStrList_Exchange;                            // 交换两行的内容及绑定的对象
    LoadFromFile: TStrLit_LoadFromFile;                     // 从文件载入
    SaveToFile: TStrLit_SaveToFile;                         // 存到文件
    CopyTo: TStrList_CopyTo;                                // 复制

    Reserved: array[0..19] of Pointer;
  end;

  TMemoryStreamFunc = record
    Create: TMemStream_Create;                              // 创建内存流
    Free: TMemStream_Free;                                  // 释放内存流
    GetSize: TMemStream_GetSize;                            // 取得大小
    SetSize: TMemStream_SetSize;                            // 设置大小
    Clear: TMemStream_Clear;                                // 清空
    Read: TMemStream_Read;                                  // 把内存流的数据读取到 Buffer 中
    Write: TMemStream_Write;                                // 向内存流写入数据
    Seek: TMemStream_Seek;                                  // 指针定位 SeekOrigin: 0 (从头开始), 1 (当前位置开始), 2 (从尾部开始)
    Memory: TMemStream_Memory;                              // 获取流数据的内存指针
    GetPosition: TMemStream_GetPosition;                    // 获取指针位置
    SetPosition: TMemStream_SetPosition;                    // 指针定位 (定到第几个字节)
    LoadFromFile: TMemStream_LoadFromFile;                  // 从文件载入
    SaveToFile: TMemStream_SaveToFile;                      // 保存到文件
                                                         
    Reserved: array[0..19] of Pointer;                   
  end;                                                   
                                                         
  TMemuFunc = record                                     
    GetMainMenu: TMenu_GetMainMenu;                         // 获取主菜单
    GetControlMenu: TMenu_GetControlMenu;                   // 获取控制菜单
    GetViewMenu: TMenu_GetViewMenu;                         // 获取查看菜单
    GetOptionMenu: TMenu_GetOptionMenu;                     // 获取选项菜单
    GetManagerMenu: TMenu_GetManagerMenu;                   // 获取管理菜单
    GetToolsMenu: TMenu_GetToolsMenu;                       // 获取工具菜单
    GetHelpMenu: TMenu_GetHelpMenu;                         // 获取帮助菜单
    GetPluginMenu: TMenu_GetPluginMenu;                     // 获取插件菜单
    Count: TMenu_Count;                                     // 获取子菜单数量
    GetItems: TMenu_GetItems;                               // 获取某个子菜单
    Add: TMenu_Add;                                         // 添加菜单
    Insert: TMenu_Insert;                                   // 插入菜单
    GetCaption: TMenu_GetCaption;                           // 获取菜单标题
    SetCaption: TMenu_SetCaption;                           // 设置菜单标题
    GetEnabled: TMenu_GetEnabled;                           // 获取菜单可用
    SetEnabled: TMenu_SetEnabled;                           // 设置菜单可用
    GetVisable: TMenu_GetVisable;                           // 获取菜单可见
    SetVisable: TMenu_SetVisable;                           // 设置菜单可见
    GetChecked: TMenu_GetChecked;                           // 获取菜单选中状态
    SetChecked: TMenu_SetChecked;                           // 设置菜单选中状态
    GetRadioItem: TMenu_GetRadioItem;                       // 获取菜单是否为单选
    SetRadioItem: TMenu_SetRadioItem;                       // 设置菜单是否为单选
    GetGroupIndex: TMenu_GetGroupIndex;                     // 获取菜单单选分组
    SetGroupIndex: TMenu_SetGroupIndex;                     // 设置菜单单选分组
    GetTag: TMenu_GetTag;                                   // 获取附加数据
    SetTag: TMenu_SetTag;                                   // 设置附加数据

    Reserved: array[0..19] of Pointer;
  end;

  TIniFileFunc = record
    Create: TIniFile_Create;                                // 创建Ini对象
    Free: TIniFile_Free;                                    // 释放ini对象
    SectionExists: TIniFile_SectionExists;                  // 判断区段是否存在
    ValueExists: TIniFile_ValueExists;                      // 判断键是否存在
    ReadString: TIniFile_ReadString;                        // 读取文本
    WriteString: TIniFile_WriteString;                      // 写入文本
    ReadInteger: TIniFile_ReadInteger;                      // 读取整数
    WriteInteger: TIniFile_WriteInteger;                    // 写入整数
    ReadBool: TIniFile_ReadBool;                            // 读取布尔值
    WriteBool: TIniFile_WriteBool;                          // 写入布尔值

    Reserved: array[0..29] of Pointer;
  end;

  TMagicACListFunc = record
    Count: TMagicACList_Count;                              // 技能破防百分比列表数量
    GetItem: TMagicACList_GetItem;                          // 取单个元素
    FindByMagIdx: TMagicACList_FindByMagIdx;                // 根据技能得到破防百分比信息

    Reserved: array[0..9] of Pointer;
  end;

  TMapManagerFunc = record
    FindMap: TMapManager_FindMap;                           // 根据地图名得到地图对象
    GetMapList: TMapManager_GetMapList;                     // 得到地图列表; 返回值中每个元素为：_TEnvirnoment

    Reserved: array[0..39] of Pointer;
  end;

  TEnvirnomentFunc = record
    GetMapName: TEnvir_GetMapName;                          // 地图名称
    GetMapDesc: TEnvir_GetMapDesc;                          // 地图描述
    GetWidth: TEnvir_GetWidth;                              // 地图宽度
    GetHeight: TEnvir_GetHeight;                            // 地图高度
    GetMinMap: TEnvir_GetMinMap;                            // 小地图
    IsMainMap: TEnvir_IsMainMap;                            // 是否主地图
    GetMainMapName: TEnvir_GetMainMapName;                  // 主地图名
    IsMirrMap: TEnvir_IsMirrMap;                            // 是否动态镜像地图
    GetMirrMapCreateTick: TEnvir_GetMirrMapCreateTick;      // 动态镜像地图创建时间
    GetMirrMapSurvivalTime: TEnvir_GetMirrMapSurvivalTime;  // 动态镜像地图存活时间
    GetMirrMapExitToMap: TEnvir_GetMirrMapExitToMap;        // 动态地图退到哪个地图
    GetMirrMapMinMap: TEnvir_GetMirrMapMinMap;              // 动态镜像地图小地图编号
    GetAlwaysShowTime: TEnvir_GetAlwaysShowTime;            // 动态镜像地图是否一直显示时间
    IsFBMap: TEnvir_IsFBMap;                                // 是否副本地图
    GetFBMapName: TEnvir_GetFBMapName;                      // 副本地图名
    GetFBEnterLimit: TEnvir_GetFBEnterLimit;                // 副本进入限制 (0:队友必须有三职业; 1:不限制职业，队友均可进; 2:只允许自己; 3:允许行会进入)
    GetFBCreated: TEnvir_GetFBCreated;                      // 副本地图是否创建
    GetFBCreateTime: TEnvir_GetFBCreateTime;                // 副本地图创建时间
    GetMapParam: TEnvir_GetMapParam;                        // 获取地图是否设置某参数
    GetMapParamValue: TEnvir_GetMapParamValue;              // 获取地图设置某参数值
    CheckCanMove: TEnvir_CheckCanMove;                      // 地图点是否可达，boFlag = False时，会判断该坐标点是否有角色占据
    IsValidObject: TEnvir_IsValidObject;                    // 判断地图上以坐标(nX, nY)为空中，以nRange为半径的矩形范围内，是否有Obj对象
    GetItemObjects: TEnvir_GetItemObjects;                  // 获取地图上某坐标的物品列表
    GetBaseObjects: TEnvir_GetBaseObjects;                  // 获取地图上某坐标的角色列表
    GetPlayObjects: TEnvir_GetPlayObjects;                  // 获取地图上某坐标的人物列表

    Reserved: array[0..99] of Pointer;
  end;

  TM2EngineFunc = record
    GetVersion: TM2Engine_GetVersion;                       // 取M2版本号
    GetVersionInt: TM2Engine_GetVersionInt;                 // 取版本号
    GetMainFormHandle: TM2Engine_GetMainFormHandle;         // 取主窗体主柄
    SetMainFormCaption: TM2Engine_SetMainFormCaption;       // 设置主窗体标题
    GetAppDir: TM2Engine_GetAppDir;                         // 主程序所在目录
    GetGlobalIniFile: TM2Engine_GetGlobalIniFile;           // 获取服务器全局ini对象
    GetOtherFileDir: TM2Engine_GetOtherFileDir;             // 获取其他的文件或目录
    MainOutMessage: TM2Engine_MainOutMessage;               // M2输出信息
    GetGlobalVarI: TM2Engine_GetGlobalVarI;                 // 读取全局I变量
    SetGlobalVarI: TM2Engine_SetGlobalVarI;                 // 设置全局I变量
    GetGlobalVarG: TM2Engine_GetGlobalVarG;                 // 读取全局G变量
    SetGlobalVarG: TM2Engine_SetGlobalVarG;                 // 设置全局G变量
    GetGlobalVarA: TM2Engine_GetGlobalVarA;                 // 读取全局A变量
    SetGlobalVarA: TM2Engine_SetGlobalVarA;                 // 设置全局A变量
    EncodeBuffer: TM2Engine_EncodeBuffer;                   // 编码
    DecodeBuffer: TM2Engine_DecodeBuffer;                   // 解码
    ZLibEncodeBuffer: TM2Engine_ZLibEncodeBuffer;           // 压缩编码
    ZLibDecodeBuffer: TM2Engine_ZLibDecodeBuffer;           // 压缩解码
    EncryptBuffer: TM2Engine_EncryptBuffer;                 // 加密
    DecryptBuffer: TM2Engine_DecryptBuffer;                 // 解密
    EncryptPassword: TM2Engine_EncryptPassword;             // 密码加密(不同的电脑得到不同的结果)
    DecryptPassword: TM2Engine_DecryptPassword;             // 密码解密
    GetTakeOnPosition: TM2Engine_GetTakeOnPosition;         // 根据物品StdMode得到物品装备位置
    CheckBindType: TM2Engine_CheckBindType;                 // 检查物品是否有某个绑定类型
    SetBindValue: TM2Engine_SetBindValue;                   // 设置物品某个绑定类型
    GetRGB: TM2Engine_GetRGB;                               // 根据单字节颜色得到RGB颜色

    Reserved: array[0..99] of Pointer;
  end;

  TBaseObjectFunc = record
    GetChrName: TBaseObject_GetChrName;                     // 名称
    SetChrName: TBaseObject_SetChrName;                     // 设置名称(不能设置人物、英雄)
    RefShowName: TBaseObject_RefShowName;                   // 刷新名称到客户端
    RefNameColor: TBaseObject_RefNameColor;                 // 刷新名称颜色 PKPoint等改变时

    GetGender: TBaseObject_GetGender;                       // 获取性别
    SetGender: TBaseObject_SetGender;                       // 设置性别

    GetJob: TBaseObject_GetJob;                             // 获取职业
    SetJob: TBaseObject_SetJob;                             // 设置职业

    GetHair: TBaseObject_GetHair;                           // 获取发型
    SetHair: TBaseObject_SetHair;                           // 设置发型

    GetEnvir: TBaseObject_GetEnvir;                         // 所在地图
    GetMapName: TBaseObject_GetMapName;                     // 所在地图
    GetCurrX: TBaseObject_GetCurrX;                         // 坐标X
    GetCurrY: TBaseObject_GetCurrY;                         // 坐标Y
    GetDirection: TBaseObject_GetDirection;                 // 当前方向

    GetHomeMap: TBaseObject_GetHomeMap;                     // 回城地图
    GetHomeX: TBaseObject_GetHomeX;                         // 回城坐标X
    GetHomeY: TBaseObject_GetHomeY;                         // 回城坐标Y
    GetPermission: TBaseObject_GetPermission;               // 权限等级
    SetPermission: TBaseObject_SetPermission;               // 设置权限等级
    GetDeath: TBaseObject_GetDeath;                         // 是否死亡
    GetDeathTick: TBaseObject_GetDeathTick;                 // 死亡时间
    GetGhost: TBaseObject_GetGhost;                         // 是否死亡并清理
    GetGhostTick: TBaseObject_GetGhostTick;                 // 清理时间
    MakeGhost: TBaseObject_MakeGhost;                       // 杀死并清掉
    ReAlive: TBaseObject_ReAlive;                           // 复活

    GetRaceServer: TBaseObject_GetRaceServer;               // 类型
    GetAppr: TBaseObject_GetAppr;                           // Appr
    GetRaceImg: TBaseObject_GetRaceImg;                     // RaceImg

    GetCharStatus: TBaseObject_GetCharStatus;               // 状态
    SetCharStatus: TBaseObject_SetCharStatus;               // 状态改变
    StatusChanged: TBaseObject_StatusChanged;               // 发送状态改变

    GetHungerPoint: TBaseObject_GetHungerPoint;             // 获取饥饿点
    SetHungerPoint: TBaseObject_SetHungerPoint;             // 设置饥饿点

    IsNGMonster: TBaseobject_IsNGMonster;                   // 是否为内功怪
    IsDummyObject: TBaseObject_IsDummyObject;               // 是否假人

    GetViewRange: TBaseObject_GetViewRange;                 // 获取视觉范围
    SetViewRange: TBaseObject_SetViewRange;                 // 设置视觉范围
    GetAbility: TBaseObject_GetAbility;                     // 原始属性

    GetWAbility: TBaseObject_GetWAbility;                   // 最终属性
    SetWAbility: TBaseObject_SetWAbility;                   // 设置属性

    GetSlaveList: TBaseObject_GetSlaveList;                 // 宝宝列表
    GetMaster: TBaseObject_GetMaster;                       // 主人
    GetMasterEx: TBaseObject_GetMasterEx;                   // 最上层主人

    GetSuperManMode: TBaseObject_GetSuperManMode;           // 是否无敌模式
    SetSuperManMode: TBaseObject_SetSuperManMode;           // 设置无敌模式

    GetAdminMode: TBaseObject_GetAdminMode;                 // 是否管理模式
    SetAdminMode: TBaseObject_SetAdminMode;                 // 设置管理模式

    GetTransparent: TBaseObject_GetTransparent;             // 魔法隐身
    SetTransparent: TBaseObject_SetTransparent;             // 设置魔法隐身

    GetObMode: TBaseObject_GetObMode;                       // 隐身模式
    SetObMode: TBaseObject_SetObMode;                       // 设置隐身模式

    GetStoneMode: TBaseObject_GetStoneMode;                 // 石像化模式
    SetStoneMode: TBaseObject_SetStoneMode;                 // 设置石像化模式

    GetStickMode: TBaseObject_GetStickMode;                 // 是否能推动
    SetStickMode: TBaseObject_SetStickMode;                 // 设置不可推动模式

    GetIsAnimal: TBaseObject_GetIsAnimal;                   // 怪物是否可挖
    SetIsAnimal: TBaseObject_SetIsAnimal;                   // 设置怪物是否可挖

    GetIsNoItem: TBaseObject_GetIsNoItem;                   // 死亡是否不掉装备
    SetIsNoItem: TBaseObject_SetIsNoItem;                   // 设置死亡是否不掉装备

    GetCoolEye: TBaseObject_GetCoolEye;                     // 隐身免疫
    SetCoolEye: TBaseObject_SetCoolEye;                     // 设置隐身免疫

    GetHitPoint: TBaseObject_GetHitPoint;                   // 命中
    SetHitPoint: TBaseObject_SetHitPoint;                   // 设置命中

    GetSpeedPoint: TBaseObject_GetSpeedPoint;               // 敏捷
    SetSpeedPoint: TBaseObject_SetSpeedPoint;               // 设置敏捷

    GetHitSpeed: TBaseObject_GetHitSpeed;                   // 攻击速度
    SetHitSpeed: TBaseObject_SetHitSpeed;                   // 设置攻击速度

    GetWalkSpeed: TBaseObject_GetWalkSpeed;                 // 移动速度
    SetWalkSpeed: TBaseObject_SetWalkSpeed;                 // 设置移动速度

    GetHPRecover: TBaseObject_GetHPRecover;                 // HP恢复速度
    SetHPRecover: TBaseObject_SetHPRecover;                 // 设置HP恢复速度

    GetMPRecover: TBaseObject_GetMPRecover;                 // MP恢复速度
    SetMPRecover: TBaseObject_SetMPRecover;                 // 设置MP恢复速度

    GetPoisonRecover: TBaseObject_GetPoisonRecover;         // 中毒恢复
    SetPoisonRecover: TBaseObject_SetPoisonRecover;         // 设置中毒恢复

    GetAntiPoison: TBaseObject_GetAntiPoison;               // 毒躲避
    SetAntiPoison: TBaseObject_SetAntiPoison;               // 设置毒躲避

    GetAntiMagic: TBaseObject_GetAntiMagic;                 // 魔法躲避
    SetAntiMagic: TBaseObject_SetAntiMagic;                 // 设置魔法躲避

    GetLuck: TBaseObject_GetLuck;                           // 幸运
    SetLuck: TBaseObject_SetLuck;                           // 设置幸运

    GetAttatckMode: TBaseObject_GetAttatckMode;             // 攻击模式
    SetAttatckMode: TBaseObject_SetAttatckMode;             // 设置攻击模式

    GetNation: TBaseObject_GetNation;                       // 获取所属国家
    SetNation: TBaseObject_SetNation;                       // 设置所属国家

    GetNationaName: TBaseObject_GetNationaName;             // 获取国家名字

    GetGuild: TBaseObject_GetGuild;                         // 行会
    GetGuildRankNo: TBaseobject_GetGuildRankNo;             // 人物所在行会中的分组编号
    GetGuildRankName: TBaseobject_GetGuildRankName;         // 人物所在行会中的分组名称
    IsGuildMaster: TBaseObject_IsGuildMaster;               // 是否为行会老大

    GetHideMode: TBaseObject_GetHideMode;                   // 隐身戒指 特殊物品:111
    SetHideMode: TBaseObject_SetHideMode;

    GetIsParalysis: TBaseObject_GetIsParalysis;                     // 麻痹戒指  特殊物品:113
    SetIsParalysis: TBaseObject_SetIsParalysis;
    GetParalysisRate: TBaseObject_GetParalysisRate;                 // 麻痹几率
    SetParalysisRate: TBaseObject_SetParalysisRate;

    GetIsMDParalysis: TBaseObject_GetIsMDParalysis;                 // 魔道麻痹戒指  特殊物品:204
    SetIsMDParalysis: TBaseObject_SetIsMDParalysis;
    GetMDParalysisRate: TBaseObject_GetMDParalysisRate;             // 魔道麻痹几率
    SetMDParalysisRate: TBaseObject_SetMDParalysisRate;

    GetIsFrozen: TBaseObject_GetIsFrozen;                           // 冰冻戒指  特殊物品:205
    SetIsFrozen: TBaseObject_SetIsFrozen;
    GetFrozenRate: TBaseObject_GetFrozenRate;                       // 冰冻几率
    SetFrozenRate: TBaseObject_SetFrozenRate;

    GetIsCobwebWinding: TBaseObject_GetIsCobwebWinding;             // 蛛网戒指  特殊物品:206
    SetIsCobwebWinding: TBaseObject_SetIsCobwebWinding;
    GetCobwebWindingRate: TBaseObject_GetCobwebWindingRate;         // 蛛网几率
    SetCobwebWindingRate: TBaseObject_SetCobwebWindingRate;

    GetUnParalysisValue: TBaseObject_GetUnParalysisValue;           // 防麻几率
    SetUnParalysisValue: TBaseObject_SetUnParalysisValue;
    GetIsUnParalysis: TBaseObject_GetIsUnParalysis;                 // 根据几率取当次是否防麻

    GetUnMagicShieldValue: TBaseObject_GetUnMagicShieldValue;       // 防护身几率
    SetUnMagicShieldValue: TBaseObject_SetUnMagicShieldValue;
    GetIsUnMagicShield: TBaseObject_GetIsUnMagicShield;             // 根据几率取当次是否防护身

    GetUnRevivalValue: TBaseObject_GetUnRevivalValue;               // 防复活几率
    SetUnRevivalValue: TBaseObject_SetUnRevivalValue;
    GetIsUnRevival: TBaseObject_GetIsUnRevival;                     // 根据几率取当次是否防复活

    GetUnPosionValue: TBaseObject_GetUnPosionValue;                 // 防毒几率
    SetUnPosionValue: TBaseObject_SetUnPosionValue;
    GetIsUnPosion: TBaseObject_GetIsUnPosion;                       // 根据几率取当次是否防毒

    GetUnTammingValue: TBaseObject_GetUnTammingValue;               // 防诱惑几率
    SetUnTammingValue: TBaseObject_SetUnTammingValue;
    GetIsUnTamming: TBaseObject_GetIsUnTamming;                     // 根据几率取当次是否防诱惑

    GetUnFireCrossValue: TBaseObject_GetUnFireCrossValue;           // 防火墙几率
    SetUnFireCrossValue: TBaseObject_SetUnFireCrossValue;
    GetIsUnFireCross: TBaseObject_GetIsUnFireCross;                 // 根据几率取当次是否防火墙

    GetUnFrozenValue: TBaseObject_GetUnFrozenValue;                 // 防冰冻几率
    SetUnFrozenValue: TBaseObject_SetUnFrozenValue;
    GetIsUnFrozen: TBaseObject_GetIsUnFrozen;                       // 根据几率取当次是否防冰冻

    GetUnCobwebWindingValue: TBaseObject_GetUnCobwebWindingValue;   // 防蛛网几率
    SetUnCobwebWindingValue: TBaseObject_SetUnCobwebWindingValue;
    GetIsUnCobwebWinding: TBaseObject_GetIsUnCobwebWinding;         // 根据几率取当次是否防蛛网


    GetTargetCret: TBaseObject_GetTargetCret;                       // 获取当前攻击目标
    SetTargetCret: TBaseObject_SetTargetCret;                       // 设置当前攻击目标
    DelTargetCreat: TBaseObject_DelTargetCreat;                     // 删除当前攻击目标
    GetLastHiter: TBaseObject_GetLastHiter;                         // 被谁攻击
    GetExpHitter: TBaseObject_GetExpHitter;                         // 谁得经验
    GetPoisonHitter: TBaseObject_GetPoisonHitter;                   // 施毒者
    GetPoseCreate: TBaseObject_GetPoseCreate;                       // 面前的对象是谁

    IsProperTarget: TBaseObject_IsProperTarget;                     // 是否为攻击目标
    IsProperFriend: TBaseObject_IsProperFriend;                     // 是否为朋友

    TargetInRange: TBaseObject_TargetInRange;                       // 判断对象在指定范围内

    SendMsg: TBaseObject_SendMsg;                                   // 发消息
    SendDelayMsg: TBaseObject_SendDelayMsg;                         // 发延时消息
    SendRefMsg: TBaseObject_SendRefMsg;                             // 向全屏玩家发消息
    SendUpdateMsg: TBaseObject_SendUpdateMsg;                       // 更新发消息
    SysMsg: TBaseObject_SysMsg;                                     // 发聊天信息

    GetBagItemList: TBaseObject_GetBagItemList;                     // 背包物品
    IsEnoughBag: TBaseObject_IsEnoughBag;                           // 检测背包是否满
    IsEnoughBagEx: TBaseObject_IsEnoughBagEx;                       // 背包是否还有足够的空间放指定数量的物品
    AddItemToBag: TBaseObject_AddItemToBag;                         // 加物品到背包
    DelBagItemByIndex: TBaseObject_DelBagItemByIndex;               // 删除背包第几个物品
    DelBagItemByMakeIdx: TBaseObject_DelBagItemByMakeIdx;           // 根据MakeIndex删除背包物品
    DelBagItemByUserItem: TBaseObject_DelBagItemByUserItem;         // 根据UserItem删除背包物品

    IsInSafeZone: TBaseObject_IsInSafeZone;                         // 检查角色是否在安全区
    IsPtInSafeZone: TBaseObject_IsPtInSafeZone;                     // 检查坐标点是否在安全区内

    RecalcLevelAbil: TBaseObject_RecalcLevelAbil;                   // 重算等级属性(IsSysDef=True: 使用系统默认等级属性; IsSysDef=False: 使用自定义等级属性)
    RecalcAbil: TBaseObject_RecalcAbil;                             // 重算属性
    RecalcBagWeight: TBaseObject_RecalcBagWeight;                   // 重算背包重量

    GetLevelExp: TBaseObject_GetLevelExp;                           // 指定等级升到下级所要经验值

    HasLevelUp: TBaseObject_HasLevelUp;                             // 升级
    TrainSkill: TBaseObject_TrainSkill;                             // 加技能熟练点; IsDoChec = True,判断技能加点条件

    CheckMagicLevelup: TBaseObject_CheckMagicLevelup;               // 检查技能是否升级
    MagicTranPointChanged: TBaseObject_MagicTranPointChanged;       // 技能点改点

    DamageHealth: TBaseObject_DamageHealth;                         // 掉血
    DamageSpell: TBaseObject_DamageSpell;                           // 消耗MP
    IncHealthSpell: TBaseObject_IncHealthSpell;                     // 增加HP/MP
    HealthSpellChanged: TBaseObject_HealthSpellChanged;             // 通知客户端HP/MP改变

    FeatureChanged: TBaseObject_FeatureChanged;                     // 通知客户端外观改变
    WeightChanged: TBaseObject_WeightChanged;                       // 通知客户端负重改变

    GetHitStruckDamage: TBaseObject_GetHitStruckDamage;             // 减防后物理伤害, nType = 1:减物理防御；nType = 2:减魔法盾防御
    GetMagStruckDamage: TBaseObject_GetMagStruckDamage;             // 减防后魔法伤害

    GetActorIcon: TBaseObject_GetActorIcon;                         // 顶戴花花翎 (Index: 0-9)
    SetActorIcon: TBaseObject_SetActorIcon;                         // 顶戴花花翎 (Index: 0-9)

    RefUseIcons: TBaseObject_RefUseIcons;                           // 刷新顶戴花花翎
    RefUseEffects: TBaseObject_RefUseEffects;                       // 刷新效果

    SpaceMove: TBaseObject_SpaceMove;                               // 飞到指定地图及坐标
    MapRandomMove: TBaseObject_MapRandomMove;                       // 飞到指定地图随机坐标

    CanMove: TBaseObject_CanMove;                                   // 对象是否可移动 (当麻痹，冰结等状态时，不能移动)
    CanRun: TBaseObject_CanRun;                                     // 是否可以从一个点跑往另一个点
    TurnTo: TBaseObject_TurnTo;                                     // 转向
    WalkTo: TBaseObject_WalkTo;                                     // 指定方向走一步
    RunTo: TBaseObject_RunTo;                                       // 指定方向跑一步

    PluginList: TBaseObject_PluginList;                             // 预留给插件用，其他地方未使用

    Reserved: array[0..99] of Pointer;
  end;

  TSmartObjectFunc = record
    GetMagicList: TSmartObject_GetMagicList;                        // 获取技能列表

    GetUseItem: TSmartObject_GetUseItem;                            // 取某个位置的装备; Index: 0-29

    GetJewelryBoxStatus: TSmartObject_GetJewelryBoxStatus;          // 首饰盒状态 0:未激活; 1:激活; 2:开启
    SetJewelryBoxStatus: TSmartObject_SetJewelryBoxStatus;          // 设置首饰盒状态 0:未激活; 1:激活; 2:开启
    GetJewelryItem: TSmartObject_GetJewelryItem;                    // 取首饰盒物品; Index: 0-5

    GetIsShowGodBless: TSmartObject_GetIsShowGodBless;              // 是否显示神佑袋
    SetIsShowGodBless: TSmartObject_SetIsShowGodBless;              // 设置显示神佑袋

    GetGodBlessItemsState: TSmartObject_GetGodBlessItemsState;      // 取某个神佑格子的开关状态
    SetGodBlessItemsState: TSmartObject_SetGodBlessItemsState;      // 设置神佑格子的开关状态

    GetGodBlessItem: TSmartObject_GetGodBlessItem;                  // 取神佑袋物品; Index: 0-11

    GetFengHaoItems: TSmartObject_GetFengHaoItems;                  // 封号列表
    GetActiveFengHao: TSmartObject_GetActiveFengHao;                // 激活的封号
    SetActiveFengHao: TSmartObject_SetActiveFengHao;                // 设置当前激活封号; -1清封号
    ActiveFengHaoChanged: TSmartObject_ActiveFengHaoChanged;        // 刷新活动封号到客户端
    DeleteFengHao: TSmartObject_DeleteFengHao;                      // 删除封号
    ClearFengHao: TSmartObject_ClearFengHao;                        // 清空封号

    GetMoveSpeed: TSmartObject_GetMoveSpeed;
    SetMoveSpeed: TSmartObject_SetMoveSpeed;
    GetAttackSpeed: TSmartObject_GetAttackSpeed;
    SetAttackSpeed: TSmartObject_SetAttackSpeed;
    GetSpellSpeed: TSmartObject_GetSpellSpeed;
    SetSpellSpeed: TSmartObject_SetSpellSpeed;
    RefGameSpeed: TSmartObject_RefGameSpeed;                        // 刷新游戏速度
    GetIsButch: TSmartObject_GetIsButch;                            // 是否可挖
    SetIsButch: TSmartObject_SetIsButch;                            // 设置是否可挖

    GetIsTrainingNG: TSmartObject_GetIsTrainingNG;                  // 是否学内功
    SetIsTrainingNG: TSmartObject_SetIsTrainingNG;

    GetIsTrainingXF: TSmartObject_GetIsTrainingXF;                  // 是否学心法
    SetIsTrainingXF: TSmartObject_SetIsTrainingXF;

    GetIsOpenLastContinuous: TSmartObject_GetIsOpenLastContinuous;  // 第4个连击是否开启
    SetIsOpenLastContinuous: TSmartObject_SetIsOpenLastContinuous;  // 设置开启第4个连击

    GetContinuousMagicOrder: TSmartObject_GetContinuousMagicOrder;  // 连击顺序 Index:0-3
    SetContinuousMagicOrder: TSmartObject_SetContinuousMagicOrder;  // 设置连击顺序

    GetPKDieLostExp: TSmartObject_GetPKDieLostExp;                  // PK 死亡掉经验，不够经验就掉等级
    SetPKDieLostExp: TSmartObject_SetPKDieLostExp;

    GetPKDieLostLevel: TSmartObject_GetPKDieLostLevel;              // PK 死亡掉等级
    SetPKDieLostLevel: TSmartObject_SetPKDieLostLevel;

    GetPKPoint: TSmartObject_GetPKPoint;                            // PK点数
    SetPKPoint: TSmartObject_SetPKPoint;
    IncPKPoint: TSmartObject_IncPKPoint;                            // 增加PK值
    DecPKPoint: TSmartObject_DecPKPoint;                            // 减少PK值

    GetPKLevel: TSmartObject_GetPKLevel;                            // PK等级
    SetPKLevel: TSmartObject_SetPKLevel;

    GetIsTeleport: TSmartObject_GetIsTeleport;                      // 传送戒指 特殊物品:112
    SetIsTeleport: TSmartObject_SetIsTeleport;

    GetIsRevival: TSmartObject_GetIsRevival;                        // 复活戒指 特殊物品:114
    SetIsRevival: TSmartObject_SetIsRevival;

    GetRevivalTime: TSmartObject_GetRevivalTime;                    // 复活戒指: 复活间隔
    SetRevivalTime: TSmartObject_SetRevivalTime;

    GetIsFlameRing: TSmartObject_GetIsFlameRing;                    // 火焰戒指 特殊物品:115
    SetIsFlameRing: TSmartObject_SetIsFlameRing;

    GetIsRecoveryRing: TSmartObject_GetIsRecoveryRing;              // 治愈戒指 特殊物品:116
    SetIsRecoveryRing: TSmartObject_SetIsRecoveryRing;

    GetIsMagicShield: TSmartObject_GetIsMagicShield;                // 护身戒指 特殊物品:118
    SetIsMagicShield: TSmartObject_SetIsMagicShield;

    GetIsMuscleRing: TSmartObject_GetIsMuscleRing;                  // 活力戒指(超负载) 特殊物品:119
    SetIsMuscleRing: TSmartObject_SetIsMuscleRing;

    GetIsFastTrain: TSmartObject_GetIsFastTrain;                    // 技巧项链 特殊物品:120
    SetIsFastTrain: TSmartObject_SetIsFastTrain;

    GetIsProbeNecklace: TSmartObject_GetIsProbeNecklace;            // 探测项链 特殊物品:121
    SetIsProbeNecklace: TSmartObject_SetIsProbeNecklace;

    GetIsRecallSuite: TSmartObject_GetIsRecallSuite;                // 记忆物品 特殊物品:122, 124, 125
    SetIsRecallSuite: TSmartObject_SetIsRecallSuite;

    GetIsPirit: TSmartObject_GetIsPirit;                            // 祈祷装备 特殊物品:126 - 129
    SetIsPirit: TSmartObject_SetIsPirit;

    GetIsSupermanItem: TSmartObject_GetIsSupermanItem;              // 不死戒指 特殊物品:140
    SetIsSupermanItem: TSmartObject_SetIsSupermanItem;

    GetIsExpItem: TSmartObject_GetIsExpItem;                        // 经验物品 特殊物品:141
    SetIsExpItem: TSmartObject_SetIsExpItem;

    GetExpItemValue: TSmartObject_GetExpItemValue;                  // 经验物品值 特殊物品:141
    SetExpItemValue: TSmartObject_SetExpItemValue;

    GetExpItemRate: TSmartObject_GetExpItemRate;                    // 经验物品经验倍率 (物品装备->特殊属性->经验翻倍->倍率)

    GetIsPowerItem: TSmartObject_GetIsPowerItem;                    // 力量物品 特殊物品:142
    SetIsPowerItem: TSmartObject_SetIsPowerItem;

    GetPowerItemValue: TSmartObject_GetPowerItemValue;              // 力量物品值 特殊物品:142
    SetPowerItemValue: TSmartObject_SetPowerItemValue;              // 设置力量物品值 特殊物品:142
    
    GetPowerItemRate: TSmartObject_GetPowerItemRate;                // 力量物品经验倍率 (物品装备->特殊属性->攻击翻倍->倍率)

    GetIsGuildMove: TSmartObject_GetIsGuildMove;                    // 行会传送装备 特殊物品:145
    SetIsGuildMove: TSmartObject_SetIsGuildMove;

    GetIsAngryRing: TSmartObject_GetIsAngryRing;                    // 幸运戒指 特殊物品 170
    SetIsAngryRing: TSmartObject_SetIsAngryRing;

    GetIsStarRing: TSmartObject_GetIsStarRing;                      // 流星戒指
    SetIsStarRing: TSmartObject_SetIsStarRing;

    GetIsACItem: TSmartObject_GetIsACItem;                          // 防御物品
    SetIsACItem: TSmartObject_SetIsACItem;

    GetACItemValue: TSmartObject_GetACItemValue;                    // 防御值
    SetACItemValue: TSmartObject_SetACItemValue;

    GetIsMACItem: TSmartObject_GetIsMACItem;                        // 魔御物品
    SetIsMACItem: TSmartObject_SetIsMACItem;

    GetMACItemValue: TSmartObject_GetMACItemValue;                  // 魔御值
    SetMACItemValue: TSmartObject_SetMACItemValue;

    GetIsNoDropItem: TSmartObject_GetIsNoDropItem;                  // 171不掉背包物品装备
    SetIsNoDropItem: TSmartObject_SetIsNoDropItem;

    GetIsNoDropUseItem: TSmartObject_GetIsNoDropUseItem;            // 172不掉身上物品装备
    SetIsNoDropUseItem: TSmartObject_SetIsNoDropUseItem;            // 内功属性

    GetNGAbility: TSmartObject_GetNGAbility;
    SetNGAbility: TSmartObject_SetNGAbility;

    GetAlcohol: TSmartObject_GetAlcohol;                            // 酒属性
    SetAlcohol: TSmartObject_SetAlcohol;

    RepairAllItem: TSmartObject_RepairAllItem;                      // 修复所有装备
    IsAllowUseMagic: TSmartObject_IsAllowUseMagic;                  // 是否满足技能使用条件

    SelectMagic: TSmartObject_SelectMagic;                          // 选择技能

    AttackTarget: TSmartObject_AttackTarget;                        // 攻击目标

    Reserved: array[0..99] of Pointer;
  end;

  TPlayObjectFunc = record
    GetUserID: TPlayObject_GetUserID;                               // 帐户名
    GetIPAddr: TPlayObject_GetIPAddr;                               // IP
    GetIPLocal: TPlayObject_GetIPLocal;                             // IP归属地
    GetMachineID: TPlayObject_GetMachineID;                         // MAC
    GetIsReadyRun: TPlayObject_GetIsReadyRun;                       // 是否进入游戏完成
    GetLogonTime: TPlayObject_GetLogonTime;                         // 登录时间

    GetSoftVerDate: TPlayObject_GetSoftVerDate;                     // 客户端版本号
    GetClientType: TPlayObject_GetClientType;                       // 客户端类型 (0:176; 1:185; 2:英雄版; 3:连击版; 4:传奇续章; 5:外传; 6:归来)

    IsOldClient: TPlayObject_IsOldClient;                           // 是否为老客户端 (185兼容客户端)

    GetScreenWidth: TPlayObject_GetScreenWidth;                     // 客户端分辨率 宽
    GetScreenHeight: TPlayObject_GetScreenHeight;                   // 客户端分辨率 高

    GetClientViewRange: TPlayObject_GetClientViewRange;             // 客户端视觉范围大小

    GetRelevel: TPlayObject_GetRelevel;                             // 转生等级
    SetRelevel: TPlayObject_SetRelevel;

    GetBonusPoint: TPlayObject_GetBonusPoint;                       // 未分配属性点
    SetBonusPoint: TPlayObject_SetBonusPoint;
    SendAdjustBonus: TPlayObject_SendAdjustBonus;                   // 发送属性点

    GetHeroName: TPlayObject_GetHeroName;                           // 主将英雄名
    GetDeputyHeroName: TPlayObject_GetDeputyHeroName;               // 副将英雄名
    GetDeputyHeroJob: TPlayObject_GetDeputyHeroJob;                 // 副将英雄职业
    GetMyHero: TPlayObject_GetMyHero;                               // 英雄对象

    GetFixedHero: TPlayObject_GetFixedHero;                         // 是否评定主副英雄

    ClientHeroLogOn: TPlayObject_ClientHeroLogOn;                   // 召唤英雄

    GetStorageHero: TPlayObject_GetStorageHero;                     // 英雄是否寄存
    GetStorageDeputyHero: TPlayObject_GetStorageDeputyHero;         // 副将英雄是否寄存

    GetIsStorageOpen: TPlayObject_GetIsStorageOpen;                 // 仓库是否开启 Index:仓库序号(0-3);
    SetIsStorageOpen: TPlayObject_SetIsStorageOpen;

    GetGold: TPlayObject_GetGold;                                   // 金币数量
    SetGold: TPlayObject_SetGold;
    GetGoldMax: TPlayObject_GetGoldMax;                             // 人物身上最多可带金币

    IncGold: TPlayObject_IncGold;                                   // 加金币
    DecGold: TPlayObject_DecGold;                                   // 减金币                  
    GoldChanged: TPlayObject_GoldChanged;                           // 通知客户端刷新 (金币，元宝)

    GetGameGold: TPlayObject_GetGameGold;                           // 元宝数量
    SetGameGold: TPlayObject_SetGameGold;                         
    IncGameGold: TPlayObject_IncGameGold;                           // 加元宝
    DecGameGold: TPlayObject_DecGameGold;                           // 减元宝
    GameGoldChanged: TPlayObject_GameGoldChanged;                   // 通知客户端刷新 (元宝，游戏点)

    GetGamePoint: TPlayObject_GetGamePoint;                         // 游戏点
    SetGamePoint: TPlayObject_SetGamePoint;                         // 设置游戏点                  
    IncGamePoint: TPlayObject_IncGamePoint;                         // 加游戏点
    DecGamePoint: TPlayObject_DecGamePoint;                         // 减游戏点                  

    GetGameDiamond: TPlayObject_GetGameDiamond;                     // 金刚石                  
    SetGameDiamond: TPlayObject_SetGameDiamond;                     
    IncGameDiamond: TPlayObject_IncGameDiamond;                     // 加金刚石
    DecGameDiamond: TPlayObject_DecGameDiamond;                     // 减金刚石
    NewGamePointChanged: TPlayObject_NewGamePointChanged;           // 通知客户端刷新 (金刚石，灵符)

    GetGameGird: TPlayObject_GetGameGird;                           // 灵符
    SetGameGird: TPlayObject_SetGameGird;                         
    IncGameGird: TPlayObject_IncGameGird;                           // 加灵符
    DecGameGird: TPlayObject_DecGameGird;                           // 减灵符

    GetGameGoldEx: TPlayObject_GetGameGoldEx;                       // 新游戏点
    SetGameGoldEx: TPlayObject_SetGameGoldEx;

    GetGameGlory: TPlayObject_GetGameGlory;                         // 荣誉
    SetGameGlory: TPlayObject_SetGameGlory;
    IncGameGlory: TPlayObject_IncGameGlory;                         // 加荣誉
    DecGameGlory: TPlayObject_DecGameGlory;                         // 减荣誉
    GameGloryChanged: TPlayObject_GameGloryChanged;                 // 通知客户端刷新荣誉

    GetPayMentPoint: TPlayObject_GetPayMentPoint;                   // 充值点
    SetPayMentPoint: TPlayObject_SetPayMentPoint;

    GetMemberType: TPlayObject_GetMemberType;                       // 会员类型
    SetMemberType: TPlayObject_SetMemberType;
    GetMemberLevel: TPlayObject_GetMemberLevel;                     // 会员等级
    SetMemberLevel: TPlayObject_SetMemberLevel;

    GetContribution: TPlayObject_GetContribution;                   // 贡献度
    SetContribution: TPlayObject_SetContribution;

    IncExp: TPlayObejct_IncExp;                                     // 加经验，调用些函数会自动刷新客户端
    SendExpChanged: TPlayObject_SendExpChanged;                     // 经验改变

    IncExpNG: TPlayObject_IncExpNG;                                 // 加内功经验，调用些函数会自动刷新客户端
    SendExpNGChanged: TPlayObject_SendExpNGChanged;                 // 内功经验改变

    IncBeadExp: TPlayObject_IncBeadExp;                             // 增加聚灵珠经验
                                                                                      
    GetVarP: TPlayObject_GetVarP;                                   // P变量 m_nVal  [0..999]
    SetVarP: TPlayObject_SetVarP;
                                                                                      
    GetVarM: TPlayObject_GetVarM;                                   // M变量 m_nMval [0..999]
    SetVarM: TPlayObject_SetVarM;                                                           

    GetVarD: TPlayObject_GetVarD;                                   // D变量 m_DyVal [0..999]
    SetVarD: TPlayObject_SetVarD;
                                                                                            
    GetVarU: TPlayObject_GetVarU;                                   // U变量 m_UVal [0..254]
    SetVarU: TPlayObject_SetVarU;

    GetVarT: TPlayObject_GetVarT;                                   // T变量 m_UVal [0..254]
    SetVarT: TPlayObject_SetVarT;

    GetVarN: TPlayObject_GetVarN;                                   // N变量 m_nInteger [0..999]
    SetVarN: TPlayObject_SetVarN;

    GetVarS: TPlayObject_GetVarS;                                   // S变量 m_sString [0..999]
    SetVarS: TPlayObject_SetVarS;

    GetDynamicVarList: TPlayObject_GetDynamicVarList;               // 自定义动态变量列表 (结果的元素为 pTDynamicVar)

    GetQuestFlagStatus: TPlayObject_GetQuestFlagStatus;
    SetQuestFlagStatus: TPlayObject_SetQuestFlagStatus;

    IsOffLine: TPlayObject_IsOffLine;                               // 是否离线挂机

    IsMaster: TPlayObject_IsMaster;                                 // 是否是师傅
    GetMasterName: TPlayObject_GetMasterName;                       // 取得师傅名字
    GetMasterHuman: TPlayObject_GetMasterHuman;                     // 师傅

    GetApprenticeNO: TPlayObject_GetApprenticeNO;                   // 当角色为徒弟时，徒弟排名
    GetOnlineApprenticeList: TPlayObject_GetOnlineApprenticeList;   // 在线徒弟列表
    GetAllApprenticeList: TPlayObject_GetAllApprenticeList;         // 所有徒弟列表 (结果的元素为 pTMasterRankInfo)

    GetDearName: TPlayObject_GetDearName;                           // 取得爱人名字
    GetDearHuman: TPlayObject_GetDearHuman;                         // 爱人
    GetMarryCount: TPlayObject_GetMarryCount;                       // 离婚次数                     

    GetGroupOwner: TPlayObject_GetGroupOwner;                       // 队长
    GetGroupMembers: TPlayObject_GetGroupMembers;                   // 队员列表 Item: 队员名 Objects: _TBaseObject

    GetIsLockLogin: TPlayObject_GetIsLockLogin;                     // 锁定登录
    SetIsLockLogin: TPlayObject_SetIsLockLogin;

    GetIsAllowGroup: TPlayObject_GetIsAllowGroup;                   // 是否允许组队
    SetIsAllowGroup: TPlayObject_SetIsAllowGroup;

    GetIsAllowGroupReCall: TPlayObject_GetIsAllowGroupReCall;       // 是否允许天地合一
    SetIsAllowGroupReCall: TPlayObject_SetIsAllowGroupReCall;

    GetIsAllowGuildReCall: TPlayObject_GetIsAllowGuildReCall;       // 是否允许行会合一
    SetIsAllowGuildReCall: TPlayObject_SetIsAllowGuildReCall;

    GetIsAllowTrading: TPlayObject_GetIsAllowTrading;               // 允许交易
    SetIsAllowTrading: TPlayObject_SetIsAllowTrading;

    GetIsDisableInviteHorseRiding: TPlayObject_GetIsDisableInviteHorseRiding;     // 禁止邀请上马
    SetIsDisableInviteHorseRiding: TPlayObject_SetIsDisableInviteHorseRiding;

    GetIsGameGoldTrading: TPlayObject_GetIsGameGoldTrading;                       // 是否开启元宝交易
    SetIsGameGoldTrading: TPlayObject_SetIsGameGoldTrading;

    GetIsNewServer: TPlayObject_GetIsNewServer;                                   // 合过区没有登录过的

    GetIsFilterGlobalDropItemMsg: TPlayObject_GetIsFilterGlobalDropItemMsg;       // 过滤掉落提示信息
    SetIsFilterGlobalDropItemMsg: TPlayObject_SetIsFilterGlobalDropItemMsg;

    GetIsFilterGlobalCenterMsg: TPlayObject_GetIsFilterGlobalCenterMsg;           // 过滤SendCenterMsg
    SetIsFilterGlobalCenterMsg: TPlayObject_SetIsFilterGlobalCenterMsg;

    GetIsFilterGolbalSendMsg: TPlayObject_GetIsFilterGolbalSendMsg;               // 过滤SendMsg全局信息
    SetIsFilterGolbalSendMsg: TPlayObject_SetIsFilterGolbalSendMsg;

    GetIsPleaseDrink: TPlayObject_GetIsPleaseDrink;                 // 是否请过酒

    GetIsDrinkWineQuality: TPlayObject_GetIsDrinkWineQuality;       // 饮酒时酒的品质
    SetIsDrinkWineQuality: TPlayObject_SetIsDrinkWineQuality;

    GetIsDrinkWineAlcohol: TPlayObject_GetIsDrinkWineAlcohol;       // 饮酒时酒的度数
    SetIsDrinkWineAlcohol: TPlayObject_SetIsDrinkWineAlcohol;

    GetIsDrinkWineDrunk: TPlayObject_GetIsDrinkWineDrunk;           // 人是否喝酒醉了
    SetIsDrinkWineDrunk: TPlayObject_SetIsDrinkWineDrunk;

    MoveToHome: TPlayObject_MoveToHome;                             // 回城
    MoveRandomToHome: TPlayObject_MoveRandomToHome;                 // 随机传送到回城地图

    SendSocket: TPlayObject_SendSocket;                             // 发送数据
    SendDefMessage: TPlayObject_SendDefMessage;                     // 发送消息
    SendMoveMsg: TPlayObject_SendMoveMsg;
    SendCenterMsg: TPlayObject_SendCenterMsg;
    SendTopBroadCastMsg: TPlayObject_SendTopBroadCastMsg;

    CheckTakeOnItems: TPlayObject_CheckTakeOnItems;                 // 检测装备是否可穿戴
    ProcessUseItemSkill: TPlayObject_ProcessUseItemSkill;           // 处理装备穿脱时对应的技能

    SendUseItems: TPlayObject_SendUseItems;                         // 发送身上装备列表
    SendAddItem: TPlayObject_SendAddItem;                           // 发送增加物品
    SendDelItemList: TPlayObject_SendDelItemList;                   // 客户端删除多个物品 ItemList.AddObject(物品名称, MakeIndex)
    SendDelItem: TPlayObject_SendDelItem;                           // 客户端删除物品
    SendUpdateItem: TPlayObject_SendUpdateItem;                     // 客户端刷新物品
    SendItemDuraChange: TPlayObject_SendItemDuraChange;             // 客户端刷新装备持久改变

    SendBagItems: TPlayObject_SendBagItems;                         // 刷新客户端包裹

    SendJewelryBoxItems: TPlayObject_SendJewelryBoxItems;           // 发送首饰盒物品

    SendGodBlessItems: TPlayObject_SendGodBlessItems;               // 发送神佑袋物品
    SendOpenGodBlessItem: TPlayObject_SendOpenGodBlessItem;         // 神佑格开启
    SendCloseGodBlessItem: TPlayObject_SendCloseGodBlessItem;       // 神佑格关闭

    SendUseMagics: TPlayObject_SendUseMagics;                       // 发送技能列表
    SendAddMagic: TPlayObject_SendAddMagic;                         // 发送技能添加
    SendDelMagic: TPlayObject_SendDelMagic;                         // 发送技能删除

    SendFengHaoItems: TPlayObject_SendFengHaoItems;                 // 发送封号物品
    SendAddFengHaoItem: TPlayObject_SendAddFengHaoItem;             // 发送封号增加
    SendDelFengHaoItem: TPlayObject_SendDelFengHaoItem;             // 发送封号删除

    SendSocketStatusFail: TPlayObject_SendSocketStatusFail;         // 发送走路/跑步失败

    PlayEffect: TPlayObject_PlayEffect;
    IsAutoPlayGame: TPlayObject_IsAutoPlayGame;                     // 是否正在内挂挂机
    StartAutoPlayGame: TPlayObject_StartAutoPlayGame;               // 开始内挂挂机
    StopAutoPlayGame: TPlayObject_StopAutoPlayGame;                 // 停止内挂挂机

    Reserved: array[0..99] of Pointer;
  end;

  TDummyObjectFunc = record
    IsStart: TDummyObject_IsStart;                                  // 假人是否开始挂机
    Start: TDummyObject_Start;                                      // 假人开始挂机
    Stop: TDummyObject_Stop;                                        // 假人停止挂机

    Reserved: array[0..99] of Pointer;
  end;

  THeroObjectFunc = record
    GetAttackMode: THeroObject_GetAttackMode;                       // 攻击模式
    SetAttackMode: THeroObject_SetAttackMode;
    SetNextAttackMode: THeroObject_SetNextAttackMode;               // 切换下一个攻击模式

    GetBagCount: THeroObject_GetBagCount;                           // 获取背包数量
    GetAngryValue: THeroObject_GetAngryValue;                       // 当前怒气值

    GetLoyalPoint: THeroObject_GetLoyalPoint;                       // 忠诚度
    SetLoyalPoint: THeroObject_SetLoyalPoint;
    SendLoyalPointChanged: THeroObject_SendLoyalPointChanged;       // 忠诚度改变

    IsDeputy: THeroObject_IsDeputy;                                 // 是否副将英雄
    GetMasterName: THeroObject_GetMasterName;                       // 主人名称

    GetQuestFlagStatus: THeroObject_GetQuestFlagStatus;
    SetQuestFlagStatus: THeroObject_SetQuestFlagStatus;

    SendUseItems: THeroObject_SendUseItems;                         // 发送身上装备
    SendBagItems: THeroObject_SendBagItems;                         // 刷新英雄背包

    SendJewelryBoxItems: THeroObject_SendJewelryBoxItems;           // 发送首饰盒物品

    SendGodBlessItems: THeroObject_SendGodBlessItems;               // 发送神佑袋物品
    SendOpenGodBlessItem: THeroObject_SendOpenGodBlessItem;         // 神佑格开启
    SendCloseGodBlessItem: THeroObject_SendCloseGodBlessItem;       // 神佑格关闭

    SendAddItem: THeroObject_SendAddItem;                           // 发送增加物品
    SendDelItem: THeroObject_SendDelItem;                           // 客户端删除物品
    SendUpdateItem: THeroObject_SendUpdateItem;                     // 客户端刷新物品                
    SendItemDuraChange: THeroObject_SendItemDuraChange;             // 客户端刷新装备持久改变                

    SendUseMagics: THeroObject_SendUseMagics;                       // 发送技能列表                
    SendAddMagic: THeroObject_SendAddMagic;                         // 发送技能添加                
    SendDelMagic: THeroObject_SendDelMagic;                         // 发送技能删除

    FindGroupMagic: THeroObject_FindGroupMagic;                     // 取得合击技能                
    GetGroupMagicId: THeroObject_GetGroupMagicId;                   // 取得合击技能ID

    SendFengHaoItems: THeroObject_SendFengHaoItems;                 // 发送封号物品
    SendAddFengHaoItem: THeroObject_SendAddFengHaoItem;             // 发送封号增加                
    SendDelFengHaoItem: THeroObject_SendDelFengHaoItem;             // 发送封号删除

    IncExp: THeroObject_IncExp;                                     // 加经验
    IncExpNG: THeroObject_IncExpNG;                                 // 加内功经验

    IsOldClient: THeroObject_IsOldClient;

    Reserved: array[0..99] of Pointer;
  end;

  TNormNpcFunc = record                                             // 创建NPC
    Create: TNormNpc_Create;

    LoadNpcScript: TNormNpc_LoadNpcScript;                          // 载入脚本
    ClearScript: TNormNpc_ClearScript;                              // 清理脚本

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
    GetPlayerList: TUserEngine_GetPlayerList;                       // 获取所有在线人物列表(含假人)
    GetPlayerByName: TUserEngine_GetPlayerByName;                   // 根据在线人物名称获取对象
    GetPlayerByUserID: TUserEngine_GetPlayerByUserID;               // 根据在线帐户获取对象
    GetPlayerByObject: TUserEngine_GetPlayerByObject;               // 判断对象是否是一个合法的在线人物

    GetOfflinePlayer: TUserEngine_GetOfflinePlayer;                 // 根据帐户获取一个离线挂机对象
    KickPlayer: TUserEngine_KickPlayer;                             // 踢人

    GetHeroList: TUserEngine_GetHeroList;                           // 获取英雄列表
    GetHeroByName: TUserEngine_GetHeroByName;                       // 根据名称获取英雄对象
    KickHero: TUserEngine_KickHero;                                 // 踢英雄

    GetMerchantList: TUserEngine_GetMerchantList;                   // 获取交易NPC列表
    GetCustomNpcConfigList: TUserEngine_GetCustomNpcConfigList;     // 获取自定义NPC配置列表

    GetQuestNPCList: TUserEngine_GetQuestNPCList;                   // 获取MapQuest.txt中定义的NPC列表
    GetManageNPC: TUserEngine_GetManageNPC;
    GetFunctionNPC: TUserEngine_GetFunctionNPC;
    GetRobotNPC: TUserEngine_GetRobotNPC;
    MissionNPC: TUserEngine_MissionNPC;

    FindMerchant: TUserEngine_FindMerchant;                         // 判断NPC对象是否合法
    FindMerchantByPos: TUserEngine_FindMerchantByPos;               // 根据地图坐标得到NPC

    FindQuestNPC: TUserEngine_FindQuestNPC;                         // 判断NPC对象是否合法                 

    GetMagicList: TUserEngine_GetMagicList;                         // Magic.DB
    GetCustomMagicConfigList: TUserEngine_GetCustomMagicConfigList; // 自定义技能配置列表
    GetMagicACList: TUserEngine_GetMagicACList;                     // M2 -> 功能设置 ->技能魔法 -> 技能破防百分比

    FindMagicByName: TUserEngine_FindMagicByName;                   // 根据技能名查找技能                 
    FindMagicByIndex: TUserEngine_FindMagicByIndex;                 // 根据技能编号查找技能
    FindMagicByNameEx: TUserEngine_FindMagicByNameEx;               // 根据技能名及属性查找技能                 
    FindMagicByIndexEx: TUserEngine_FindMagicByIndexEx;             // 根据技能编号及属性查找技能

    FindHeroMagicByName: TUserEngine_FindHeroMagicByName;           // 根据技能名查找英雄技能
    FindHeroMagicByIndex: TUserEngine_FindHeroMagicByIndex;         // 根据技能编号查找英雄技能
    FindHeroMagicByNameEx: TUserEngine_FindHeroMagicByNameEx;       // 根据技能名及属性查找英雄技能
    FindHeroMagicByIndexEx: TUserEngine_FindHeroMagicByIndexEx;     // 根据技能编号及属性查找英雄技能


    GetStdItemList: TUserEngine_GetStdItemList;                     // StdItem.DB
    GetStdItemByName: TUserEngine_GetStdItemByName;                 // 根据物品名得到数据库的物品信息
    GetStdItemByIndex: TUserEngine_GetStdItemByIndex;               // 根据物品编号得到数据库的物品信息                 
    GetStdItemName: TUserEngine_GetStdItemName;                     // 根据物品编号得到物品名
    GetStdItemIndex: TUserEngine_GetStdItemIndex;                   // 根据物品名得到物品编号

    MonsterList: TUserEngine_MonsterList;                           // Monster.DB

    SendBroadCastMsg: TUserEngine_SendBroadCastMsg;
    SendBroadCastMsgExt: TUserEngine_SendBroadCastMsgExt;
    SendTopBroadCastMsg: TUserEngine_SendTopBroadCastMsg;
    SendMoveMsg: TUserEngine_SendMoveMsg;
    SendCenterMsg: TUserEngine_SendCenterMsg;
    SendNewLineMsg: TUserEngine_SendNewLineMsg;                     // 换行消息
    SendSuperMoveMsg: TUserEngine_SendSuperMoveMsg;                 // 仿盛大顶部渐隐消息
    SendSceneShake: TUserEngine_SendSceneShake;                     // 发送屏幕震动消息

    CopyToUserItemFromName: TUserEngine_CopyToUserItemFromName;     // 随机生成元素属性
    CopyToUserItemFromItem: TUserEngine_CopyToUserItemFromItem;

    RandomUpgradeItem: TUserEngine_RandomUpgradeItem;
    RandomItemNewAbil: TUserEngine_RandomItemNewAbil;
    GetUnknowItemValue: TUserEngine_GetUnknowItemValue;

    GetAllDummyCount: TUserEngine_GetAllDummyCount;                 // 所有假人数量
    GetMapDummyCount: TUserEngine_GetMapDummyCount;                 // 指定地图假人数量
    GetOfflineCount: TUserEngine_GetOfflineCount;                   // 离线挂机人物数量
    GetRealPlayerCount: TUserEngine_GetRealPlayerCount;             // 在线真人数量(不含离线挂机)

    Reserved: array[0..99] of Pointer;
  end;

  TGuildManagerFunc = record
    FindGuild: TGuildManager_FindGuild;                             // 根据行会名得到行会对象
    GetPlayerGuild: TGuildManager_GetPlayerGuild;                   // 根据用户名得到行会对象
    AddGuild: TGuildManager_AddGuild;                               // 创建新行会
    DelGuild: TGuildManager_DelGuild;                               // 删除行会，有成员时不能删

    Reserved: array[0..99] of Pointer;
  end;

  TGuildFunc = record
    GetGuildName: TGuild_GetGuildName;                              // 行会名称

    GetJoinJob: TGuild_GetJoinJob;                                  // 加入行会职业 (1:战士; 2:法师; 3:道士，可组合)
    GetJoinLevel: TGuild_GetJoinLevel;                              // 加入行会最低等级
    GetJoinMsg: TGuild_GetJoinMsg;                                  // 招贤消息

    GetBuildPoint: TGuild_GetBuildPoint;                            // 建筑度
    GetAurae: TGuild_GetAurae;                                      // 人气值/关注度
    GetStability: TGuild_GetStability;                              // 安定度
    GetFlourishing: TGuild_GetFlourishing;                          // 繁荣度
    GetChiefItemCount: TGuild_GetChiefItemCount;                    // 领取装备数量

    GetMemberCount: TGuild_GetMemberCount;                          // 行会成员数量
    GetOnlineMemeberCount: TGuild_GetOnlineMemeberCount;            // 在线行会成员数量
    GetMasterCount: TGuild_GetMasterCount;                          // 掌门数量

    GetMaster: TGuild_GetMaster;                                    // 得到行会正副掌门
    GetMasterName: TGuild_GetMasterName;                            // 得到行会正副掌门名称

    CheckMemberIsFull: TGuild_CheckMemberIsFull;                    // 检查行会是否满员
    IsMemeber: TGuild_IsMemeber;                                    // 检查人员是否为行会成员

    AddMember: TGuild_AddMember;                                    // 人员加入行会
    AddMemberEx: TGuild_AddMemberEx;

    DelMemeber: TGuild_DelMemeber;                                  // 行会删除人员
    DelMemeberEx: TGuild_DelMemeberEx;

    IsAllianceGuild: TGuild_IsAllianceGuild;                        // 判断 CheckGuild是否是Guild的联盟行会
    IsWarGuild: TGuild_IsWarGuild;                                  // 判断是否为战争行会
    IsAttentionGuild: TGuild_IsAttentionGuild;                      // 判断是否为关注行会

    AddAlliance: TGuild_AddAlliance;                                // 添加联盟行会
    AddWarGuild: TGuild_AddWarGuild;                                // 添加战争行会
    AddAttentionGuild: TGuild_AddAttentionGuild;                    // 添加关注行会

    DelAllianceGuild: TGuild_DelAllianceGuild;                      // 删除联盟行会
    DelAttentionGuild: TGuild_DelAttentionGuild;                    // 删除关注行会

    GetRandNameByName: TGuild_GetRandNameByName;
    GetRandNameByPlayer: TGuild_GetRandNameByPlayer;

    SendGuildMsg: TGuild_SendGuildMsg;                              // 发送行会消息

    Reserved: array[0..99] of Pointer;
  end;

type
  PAppFuncDef = ^TAppFuncDef;
  TAppFuncDef = record
    PluginID: NativeInt;                                            // 插件ID

    Memory: TMemoryFunc;                                            // 内存操作
    List: TListFunc;                                                // 列表
    StringList: TStringListFunc;                                    // 字符串列表
    MemStream: TMemoryStreamFunc;                                   // 内存流
    Menu: TMemuFunc;                                                // 菜单
    IniFile: TIniFileFunc;                                          // Ini文件
    MagicACList: TMagicACListFunc;                                  // 技能破防
    MapManager: TMapManagerFunc;                                    // 地图管理
    Envir: TEnvirnomentFunc;                                        // 地图
    M2Engine: TM2EngineFunc;                                        // M2引擎
    BaseObject: TBaseObjectFunc;                                    // 基本对象
    Smarter: TSmartObjectFunc;                                      // 智能对象
    Player: TPlayObjectFunc;                                        // 人物
    Dummy: TDummyObjectFunc;                                        // 假人
    Hero: THeroObjectFunc;                                          // 英雄
    Npc: TNormNpcFunc;                                              // NPC
    UserEngine: TUserEngineFunc;
    GuildManager: TGuildManagerFunc;                                // 行会管理
    Guild: TGuildFunc;                                              // 行会


    Reserved: array[0..999] of Pointer;
  end;


  //---------------------------------------------------------------------------
  //----------------------以下是插件支持的导出函数-----------------------------
  //---------------------------------------------------------------------------

  {

  // 插件初始化
  function Init(AppFunc: PAppFuncDef; AppFuncCrc: DWORD;
    ExtParam: DWORD; Desc: PAnsiChar; var DescLen: DWORD): BOOL; stdcall;

  // 插件反初始化
  procedure UnInit(); stdcall;

  // Hook IP归属地查询
  function HookGetIPLocal(sIPaddr: PAnsiChar;
    Dest: PAnsiChar; var DestLen: DWORD): BOOL; stdcall;

  // 引擎准备运行
  procedure HookEngineReadyToStart(); stdcall;

  // 引擎运行完成
  procedure HookEngineStartComplete(); stdcall;

  // HOOK M2重新加载信息完成 (控制-> 重新加载 ->... 加载完成)
  procedure HookEngineReloadComplete(ReloadType: Integer); stdcall;

  // Hook 加载脚本文件
  function HookLoadScriptFile(FileName: PAnsiChar;
    MemStream: _TMemoryStream): BOOL; stdcall;

  // Hook 脚本文件解密 (标记行除外，剩下的部分一次解密)
  // 脚本第1行解密标记为 ;-------****-------
  function HookDecryptScriptFile(Src: PAnsiChar; SrcLen: DWORD;
    Dest: PAnsiChar; var DestLen: DWORD): BOOL; stdcall;

  // Hook 单行解密脚本 (一行行解密)
  // 脚本第1行解密标记为 ;+++++++****+++++++
  function HookDecryptScriptLine(Src: PAnsiChar; SrcLen: DWORD;
    Dest: PAnsiChar; var DestLen: DWORD): BOOL; stdcall;

  // Hook NPC条件判断载入命令，返回值:1 - 500表示本插件处理该命令
  function HookNpcLoadConditionCmd(pCmd: PAnsiChar): Integer; stdcall;

  // Hook NPC条件判断执行命令
  function HookNpcConditionProcess(ScriptParam: PScriptCmdParam): BOOL; stdcall;

  // Hook NPC执行载入命令，返回值:1 - 500表示本插件处理该命令
  function HookNpcLoadActionCmd(pCmd: PAnsiChar): Integer; stdcall;

  // Hook NPC执行命令
  procedure HookNpcActionProcess(ScriptParam: PScriptCmdParam;
    var boSendMerChantSay, boBreak: BOOL); stdcall;

  // Hook 用户点击NPC命令
  function HookUserSelect(Merchant: TMerchant; PlayObject: _TPlayObject;
    sLabel, sMsg: PAnsiChar): BOOL; stdcall;

  // Hook 自定义聊天框命令
  function HookUserCommand(PlayObject: _TPlayObject; pCmd, pParam1, pParam2,
    pParam3, pParam4, pParam5, pParam6, pParam7: PAnsiChar): BOOL; stdcall;

  // Hook 获取自定义变量值
  function HookGetVariableText(NPC: _TNormNpc; PlayObject: _TPlayObject;
    sVariable: PAnsiChar; sValue: PAnsiChar; var nValueLen: DWORD): BOOL; stdcall;

  // Hook BaseObject创建
  procedure HookBaseObjectCreate(BaseObject: _TBaseObject); stdcall;

  // Hook BaseObject重算属性开始
  procedure HookBaseObjectRecalAbilBegin(BaseObject: _TBaseObject); stdcall;

  // Hook BaseObject重算属性结束
  procedure HookBaseObjectRecalAbilEnd(BaseObject: _TBaseObject); stdcall;

  // Hook BaseObject对象运行
  procedure HookBaseObjectRun(BaseObject: _TBaseObject); stdcall;

  // Hook BaseObject自定义消息处理 2021-01-05 changed
  procedure HookBaseObjectProcessMsg(BaseObject: _TBaseObject;
    wIdent: Word; wParam: Integer; nParam1, nParam2, nParam3: NativeInt; 
    MsgObject: _TObject; dwDeliveryTime: LongWord;
    pMsg: PAnsiChar; var boReturn: BOOL); stdcall;

  // Hook BaseObject受到物理攻击
  procedure HookBaseObjectStruck(BaseObject: _TBaseObject;
    AttackObject: _TBaseObject); stdcall;

  // Hook BaseObject受到魔法攻击
  procedure HookBaseObjectMagicStruck(BaseObject: _TBaseObject;
    AttackObject: _TBaseObject; MagicIdx: Integer); stdcall;

  // Hook BaseObject物理攻击目标
  procedure HookBaseObjectAttack(BaseObject: _TBaseObject;
    Target: _TBaseObject; MagicIdx: Integer; var nPower: Integer); stdcall;

  // Hook BaseObject魔法攻击目标
  procedure HookBaseObjectMagicAttack(BaseObject: _TBaseObject;
    Target: _TBaseObject; MagicIdx: Integer; var nPower: Integer); stdcall;

  // Hook BaseObject死亡
  procedure HookBaseObjectDie(BaseObject: _TBaseObject); stdcall;

  // Hook BaseObject清理尸体
  procedure HookBaseObjectMakeGhost(BaseObject: _TBaseObject); stdcall;

  // Hook BaseObject对象释放
  procedure HookBaseObjectFree(BaseObject: _TBaseObject); stdcall;

  // Hook PlayObject对象创建
  procedure HookPlayerCreate(PlayObject: _TPlayObject); stdcall;

  // Hook PlayObject对象登录1
  procedure HookPlayerLogin1(PlayObject: _TPlayObject); stdcall;

  // Hook PlayObject对象登录2
  procedure HookPlayerLogin2(PlayObject: _TPlayObject); stdcall;

  // Hook PlayObject对象登录3
  procedure HookPlayerLogin3(PlayObject: _TPlayObject); stdcall;

  // Hook PlayObject对象登录4
  procedure HookPlayerLogin4(PlayObject: _TPlayObject); stdcall;

  // Hook PlayObject对象运行
  procedure HookPlayerRun(PlayObject: _TPlayObject); stdcall;

  // Hook PlayObject对象视野范围内发现新对象
  procedure HookPlayerViewRangeNewObject(PlayeObject: _TPlayObject;
    AObject: _TObject; AObjectX, AObjectY: Integer); stdcall;

  // Hook PlayObject消息处理开始，当 boReturn = True时，会拦截系统处理及后面插件的处理  2021-01-05 changed
  procedure HookPlayerProcessMsgBegin(PlayObject: _TPlayObject;
      wIdent: Word; wParam: Integer; nParam1, nParam2, nParam3: NativeInt;
      MsgObject: _TObject; dwDeliveryTime: LongWord;
      pMsg: PAnsiChar; var boReturn: BOOL); stdcall;

  // Hook PlayObject消息处理开始，当 boReturn = True时，会拦截后面插件的处理  2021-01-05 changed
  procedure HookPlayerProcessMsgEnd(PlayObject: _TPlayObject;
      wIdent: Word; wParam: Integer; nParam1, nParam2, nParam3: NativeInt;
      MsgObject: _TObject; dwDeliveryTime: LongWord;
      pMsg: PAnsiChar; var boReturn: BOOL); stdcall;

  // Hook PlayObject对象释放
  procedure HookPlayerFree(PlayObject: _TPlayObject); stdcall;

  // Hook 假人运行开始，当 boReturn = True时，会拦截系统处理及后面插件的处理
  procedure HookDummyObjectRunBegin(DummyObject: _TDummyObject;
    var boReturn: BOOL); stdcall;

  // Hook 假人运行结束
  procedure HookDummyObjectRunEnd(DummyObject: _TDummyObject); stdcall;

  // Hook 英雄创建
  procedure HookHeroObjectCreate(Hero: _THeroObject); stdcall;

  // Hook 英雄释放
  procedure HookHeroObjectFree(Hero: _THeroObject); stdcall;

  }

implementation

end.

