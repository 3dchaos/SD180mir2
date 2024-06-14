unit PluginDelphiUtils;

{-------------------------------------------------------------------------------}
{
  M2Server插件接口 - Delphi单元

  本单元主要是优化接口函数，处理类似于PChar传出字符串的函数
  使delphi操作起来更为方便，其他语言无需理会些单元

  版 本 号: 1.1

  发布日期: 2018-03-29

}
{-------------------------------------------------------------------------------}

interface

uses
  Windows, SysUtils, Classes, PluginInterface, PluginTypeDef;

  function StrList_GetText(Strings: _TStringList): AnsiString;
  function StrList_GetItem(Strings: _TStringList; Index: Integer): AnsiString;

  function Menu_GetCaption(MenuItem: _TMenuItem): AnsiString;

  function IniFile_ReadString(IniFile: _TIniFile; Section, Ident, Default: AnsiString): AnsiString;

  function Envir_GetMapName(Envir: _TEnvirnoment): AnsiString;
  function Envir_GetMapDesc(Envir: _TEnvirnoment): AnsiString;
  function Envir_GetMainMapName(Envir: _TEnvirnoment): AnsiString;
  function Envir_GetMirrMapExitToMap(Envir: _TEnvirnoment): AnsiString;
  function Envir_GetFBMapName(Envir: _TEnvirnoment): AnsiString;
  function Envir_GetMapParamValue(Envir: _TEnvirnoment; Param: AnsiString): AnsiString;

  function M2Engine_GetVersion(): AnsiString;
  function M2Engine_GetAppDir(): AnsiString;
  function M2Engine_GetOtherFileDir(M2FileType: Integer): AnsiString;
  function M2Engine_GetGlobalVarA(Index: Integer): AnsiString;

  function M2Engine_EncodeBuffer(S: AnsiString): AnsiString; overload;
  function M2Engine_EncodeBuffer(Src: PByte; SrcLen: DWORD): AnsiString; overload;

  function M2Engine_DecodeBuffer(Src: PByte; SrcLen: DWORD): AnsiString; overload
  function M2Engine_DecodeBuffer(S: AnsiString; Dest: PByte; var DestLen: DWORD): Boolean; overload

  function M2Engine_ZLibEncodeBuffer(S: AnsiString): AnsiString; overload;
  function M2Engine_ZLibEncodeBuffer(Src: PByte; SrcLen: DWORD): AnsiString; overload;

  function M2Engine_ZLibDecodeBuffer(S: AnsiString): AnsiString; overload;
  function M2Engine_ZLibDecodeBuffer(S: AnsiString; Dest: PByte; var DestLen: DWORD): Boolean; overload;

  function M2Engine_EncryptPassword(S: AnsiString): AnsiString;
  function M2Engine_DecryptPassword(S: AnsiString): AnsiString;

  function BaseObject_GetChrName(BaseObject: _TBaseObject): AnsiString;
  function BaseObject_GetMapName(BaseObject: _TBaseObject): AnsiString;
  function BaseObject_GetHomeMap(BaseObject: _TBaseObject): AnsiString;
  function BaseObject_GetNationaName(BaseObject: _TBaseObject): AnsiString;
  function BaseObject_GetGuildRankName(BaseObject: _TBaseObject): AnsiString;

  function PlayObject_GetUserID(Player: _TPlayObject): AnsiString;
  function PlayObject_GetIPAddr(Player: _TPlayObject): AnsiString;
  function PlayObject_GetIPLocal(Player: _TPlayObject): AnsiString;
  function PlayObject_GetMachineID(Player: _TPlayObject): AnsiString;
  function PlayObject_GetHeroName(Player: _TPlayObject): AnsiString;
  function PlayObject_GetDeputyHeroName(Player: _TPlayObject): AnsiString;
  function PlayObject_GetVarT(Player: _TPlayObject; Index: Integer): AnsiString;
  function PlayObject_GetVarS(Player: _TPlayObject; Index: Integer): AnsiString;
  function PlayObject_GetMasterName(Player: _TPlayObject): AnsiString;
  function PlayObject_GetDearName(Player: _TPlayObject): AnsiString;

  function HeroObject_GetMasterName(Hero: _THeroObject): AnsiString;

  function NormNpc_GetFilePath(NormNpc: _TNormNpc): AnsiString;
  function NormNpc_GetPath(NormNpc: _TNormNpc): AnsiString;
  function NormNpc_GetLineVariableText(NormNpc: _TNormNpc; Player: _TPlayObject; sMsg: AnsiString): AnsiString;

  function UserEngine_GetStdItemName(ItemIdx: Integer): AnsiString;

  function Guild_GetGuildName(Guild: _TGuild): AnsiString;
  function Guild_GetJoinMsg(Guild: _TGuild): AnsiString;
  function Guild_GetMasterName(Guild: _TGuild; var Master1Name, Master2Name: AnsiString): Boolean;
  function Guild_GetRandNameByName(Guild: _TGuild; CharName: AnsiString; var nRankNo: Integer; var RankName: AnsiString): Boolean;
  function Guild_GetRandNameByPlayer(Guild: _TGuild; Player: _TPlayObject; var nRankNo: Integer; var RankName: AnsiString): Boolean;

  function MakeDefaultMsg(wIdent: Word; nRecog: Int64; wParam, wTag, wSeries: Word): TDefaultMessage;
  function EncodeMessage(const DefMsg: TDefaultMessage): AnsiString;
  function DecodeMessage(const Msg: AnsiString; var DefMsg: TDefaultMessage): Boolean;
  function EncodeString(const S: AnsiString): AnsiString;
  function DecodeString(const S: AnsiString): AnsiString;

var
  g_AppFunc: TAppFuncDef;

implementation

function StrList_GetText(Strings: _TStringList): AnsiString;
var
  Len: LongWord;
begin
  Result := '';
  if not Assigned(g_AppFunc.StringList.GetText) then Exit;

  Len := 0;
  g_AppFunc.StringList.GetText(Strings, nil, Len);

  if Len > 0 then
  begin
    Len := Len + 1;
    SetLength(Result, Len);
    g_AppFunc.StringList.GetText(Strings, PAnsiChar(Result), Len);
    Result := Copy(Result, 1, Len);
  end;
end;

function StrList_GetItem(Strings: _TStringList; Index: Integer): AnsiString;
var
  Len: LongWord;
begin
  Result := '';
  if not Assigned(g_AppFunc.StringList.GetItem) then Exit;

  Len := 0;
  g_AppFunc.StringList.GetItem(Strings, Index, nil, Len);

  if Len > 0 then
  begin
    Len := Len + 1;
    SetLength(Result, Len);
    g_AppFunc.StringList.GetItem(Strings, Index, PAnsiChar(Result), Len);
    Result := Copy(Result, 1, Len);
  end;
end;

function Menu_GetCaption(MenuItem: _TMenuItem): AnsiString;
var
  Buffer: array[0..255] of AnsiChar;
  BufLen: LongWord;
begin
  Result := '';
  if not Assigned(g_AppFunc.Menu.GetCaption) then Exit;

  BufLen := SizeOf(Buffer);
  if g_AppFunc.Menu.GetCaption(MenuItem,@Buffer, BufLen) and (BufLen > 0) then
  begin
    SetLength(Result, BufLen);
    Move(Buffer[0], Result[1], BufLen);
  end;
end;

function IniFile_ReadString(IniFile: _TIniFile; Section, Ident, Default: AnsiString): AnsiString;
var
  Buffer: array[0..255] of AnsiChar;
  BufLen: LongWord;
begin
  Result := '';
  if not Assigned(g_AppFunc.IniFile.ReadString) then Exit;

  BufLen := SizeOf(Buffer);
  if g_AppFunc.IniFile.ReadString(IniFile, PAnsiChar(Section), PAnsiChar(Ident), PAnsiChar(Default), @Buffer, BufLen) and (BufLen > 0) then
  begin
    SetLength(Result, BufLen);
    Move(Buffer[0], Result[1], BufLen);
  end;
end;

function Envir_GetMapName(Envir: _TEnvirnoment): AnsiString;
var
  Buffer: array[0..255] of AnsiChar;
  BufLen: LongWord;
begin
  Result := '';
  if not Assigned(g_AppFunc.Envir.GetMapName) then Exit;

  BufLen := SizeOf(Buffer);
  if g_AppFunc.Envir.GetMapName(Envir, @Buffer, BufLen) and (BufLen > 0) then
  begin
    SetLength(Result, BufLen);
    Move(Buffer[0], Result[1], BufLen);
  end;
end;

function Envir_GetMapDesc(Envir: _TEnvirnoment): AnsiString;
var
  Buffer: array[0..255] of AnsiChar;
  BufLen: LongWord;
begin
  Result := '';
  if not Assigned(g_AppFunc.Envir.GetMapDesc) then Exit;

  BufLen := SizeOf(Buffer);
  if g_AppFunc.Envir.GetMapDesc(Envir, @Buffer, BufLen) and (BufLen > 0) then
  begin
    SetLength(Result, BufLen);
    Move(Buffer[0], Result[1], BufLen);
  end;
end;

function Envir_GetMainMapName(Envir: _TEnvirnoment): AnsiString;
var
  Buffer: array[0..255] of AnsiChar;
  BufLen: LongWord;
begin
  Result := '';
  if not Assigned(g_AppFunc.Envir.GetMainMapName) then Exit;

  BufLen := SizeOf(Buffer);
  if g_AppFunc.Envir.GetMainMapName(Envir, @Buffer, BufLen) and (BufLen > 0) then
  begin
    SetLength(Result, BufLen);
    Move(Buffer[0], Result[1], BufLen);
  end;
end;

function Envir_GetMirrMapExitToMap(Envir: _TEnvirnoment): AnsiString;
var
  Buffer: array[0..255] of AnsiChar;
  BufLen: LongWord;
begin
  Result := '';
  if not Assigned(g_AppFunc.Envir.GetMirrMapExitToMap) then Exit;

  BufLen := SizeOf(Buffer);
  if g_AppFunc.Envir.GetMirrMapExitToMap(Envir, @Buffer, BufLen) and (BufLen > 0) then
  begin
    SetLength(Result, BufLen);
    Move(Buffer[0], Result[1], BufLen);
  end;
end;

function Envir_GetFBMapName(Envir: _TEnvirnoment): AnsiString;
var
  Buffer: array[0..255] of AnsiChar;
  BufLen: LongWord;
begin
  Result := '';
  if not Assigned(g_AppFunc.Envir.GetFBMapName) then Exit;

  BufLen := SizeOf(Buffer);
  if g_AppFunc.Envir.GetFBMapName(Envir, @Buffer, BufLen) and (BufLen > 0) then
  begin
    SetLength(Result, BufLen);
    Move(Buffer[0], Result[1], BufLen);
  end;
end;

function Envir_GetMapParamValue(Envir: _TEnvirnoment; Param: AnsiString): AnsiString;
var
  Buffer: array[0..255] of AnsiChar;
  BufLen: LongWord;
begin
  Result := '';
  if not Assigned(g_AppFunc.Envir.GetMapParamValue) then Exit;

  BufLen := SizeOf(Buffer);
  if g_AppFunc.Envir.GetMapParamValue(Envir, PAnsiChar(Param), @Buffer, BufLen) and (BufLen > 0) then
  begin
    SetLength(Result, BufLen);
    Move(Buffer[0], Result[1], BufLen);
  end;
end;

function M2Engine_GetVersion(): AnsiString;
var
  Buffer: array[0..255] of AnsiChar;
  BufLen: LongWord;
begin
  Result := '';
  if not Assigned(g_AppFunc.M2Engine.GetVersion) then Exit;

  BufLen := SizeOf(Buffer);
  if g_AppFunc.M2Engine.GetVersion(@Buffer, BufLen) and (BufLen > 0) then
  begin
    SetLength(Result, BufLen);
    Move(Buffer[0], Result[1], BufLen);
  end;
end;

function M2Engine_GetAppDir(): AnsiString;
var
  Buffer: array[0..255] of AnsiChar;
  BufLen: LongWord;
begin
  Result := '';
  if not Assigned(g_AppFunc.M2Engine.GetAppDir) then Exit;

  BufLen := SizeOf(Buffer);
  if g_AppFunc.M2Engine.GetAppDir(@Buffer, BufLen) and (BufLen > 0) then
  begin
    SetLength(Result, BufLen);
    Move(Buffer[0], Result[1], BufLen);
  end;
end;

function M2Engine_GetOtherFileDir(M2FileType: Integer): AnsiString;
var
  Buffer: array[0..255] of AnsiChar;
  BufLen: LongWord;
begin
  Result := '';
  if not Assigned(g_AppFunc.M2Engine.GetOtherFileDir) then Exit;

  BufLen := SizeOf(Buffer);
  if g_AppFunc.M2Engine.GetOtherFileDir(M2FileType, @Buffer, BufLen) and (BufLen > 0) then
  begin
    SetLength(Result, BufLen);
    Move(Buffer[0], Result[1], BufLen);
  end;
end;

function M2Engine_GetGlobalVarA(Index: Integer): AnsiString;
var
  Buffer: array[0..1023] of AnsiChar;
  BufLen: LongWord;
begin
  Result := '';
  if not Assigned(g_AppFunc.M2Engine.GetGlobalVarA) then Exit;

  BufLen := SizeOf(Buffer);
  if g_AppFunc.M2Engine.GetGlobalVarA(Index, @Buffer, BufLen) and (BufLen > 0) then
  begin
    SetLength(Result, BufLen);
    Move(Buffer[0], Result[1], BufLen);
  end;
end;

function M2Engine_EncodeBuffer(S: AnsiString): AnsiString; overload;
var
  Buffer: PAnsiChar;
  BufLen: LongWord;
begin
  Result := '';
  if not Assigned(g_AppFunc.M2Engine.EncodeBuffer) then Exit;

  BufLen := Length(S) * 2;
  GetMem(Buffer, BufLen);
  if g_AppFunc.M2Engine.EncodeBuffer(PAnsiChar(S), Length(S), Buffer, BufLen) and (BufLen > 0) then
  begin
    SetLength(Result, BufLen);
    Move(Buffer[0], Result[1], BufLen);
  end;
  FreeMem(Buffer, BufLen);
end;

function M2Engine_EncodeBuffer(Src: PByte; SrcLen: DWORD): AnsiString; overload;
var
  Buffer: PAnsiChar;
  BufLen: LongWord;
begin
  Result := '';
  if not Assigned(g_AppFunc.M2Engine.EncodeBuffer) then Exit;

  BufLen := SrcLen * 2;
  GetMem(Buffer, BufLen);
  if g_AppFunc.M2Engine.EncodeBuffer(PAnsiChar(Src), SrcLen, Buffer, BufLen) and (BufLen > 0) then
  begin
    SetLength(Result, BufLen);
    Move(Buffer[0], Result[1], BufLen);
  end;
  FreeMem(Buffer, BufLen);
end;

function M2Engine_DecodeBuffer(Src: PByte; SrcLen: DWORD): AnsiString; overload
var
  Buffer: PAnsiChar;
  BufLen: LongWord;
begin
  Result := '';
  if not Assigned(g_AppFunc.M2Engine.DecodeBuffer) then Exit;

  BufLen := SrcLen;
  GetMem(Buffer, BufLen);
  if g_AppFunc.M2Engine.DecodeBuffer(PAnsiChar(Src), SrcLen, Buffer, BufLen) and (BufLen > 0) then
  begin
    SetLength(Result, BufLen);
    Move(Buffer[0], Result[1], BufLen);
  end;
  FreeMem(Buffer, BufLen);
end;

function M2Engine_DecodeBuffer(S: AnsiString; Dest: PByte; var DestLen: DWORD): Boolean; overload
begin
  Result := False;
  if not Assigned(g_AppFunc.M2Engine.DecodeBuffer) then Exit;

  Result := g_AppFunc.M2Engine.DecodeBuffer(PAnsiChar(S), Length(S), PAnsiChar(Dest), DestLen);
end;

function M2Engine_ZLibEncodeBuffer(S: AnsiString): AnsiString; overload;
var
  Buffer: PAnsiChar;
  BufLen: LongWord;
begin
  Result := '';
  if not Assigned(g_AppFunc.M2Engine.ZLibEncodeBuffer) then Exit;

  BufLen := Length(S) * 2;
  GetMem(Buffer, BufLen);
  if g_AppFunc.M2Engine.ZLibEncodeBuffer(PAnsiChar(S), Length(S), Buffer, BufLen) and (BufLen > 0) then
  begin
    SetLength(Result, BufLen);
    Move(Buffer[0], Result[1], BufLen);
  end;
  FreeMem(Buffer, BufLen);
end;

function M2Engine_ZLibEncodeBuffer(Src: PByte; SrcLen: DWORD): AnsiString; overload;
var
  Buffer: PAnsiChar;
  BufLen: LongWord;
begin
  Result := '';
  if not Assigned(g_AppFunc.M2Engine.ZLibEncodeBuffer) then Exit;

  BufLen := SrcLen * 2;
  GetMem(Buffer, BufLen);
  if g_AppFunc.M2Engine.ZLibEncodeBuffer(PAnsiChar(Src), SrcLen, Buffer, BufLen) and (BufLen > 0) then
  begin
    SetLength(Result, BufLen);
    Move(Buffer[0], Result[1], BufLen);
  end;
  FreeMem(Buffer, BufLen);
end;

function M2Engine_ZLibDecodeBuffer(S: AnsiString): AnsiString; overload;
var
  Buffer: PAnsiChar;
  BufLen: LongWord;
begin
  Result := '';
  if not Assigned(g_AppFunc.M2Engine.ZLibDecodeBuffer) then Exit;

  BufLen := Length(S) * 4;
  GetMem(Buffer, BufLen);
  if g_AppFunc.M2Engine.ZLibDecodeBuffer(PAnsiChar(S), Length(S), Buffer, BufLen) and (BufLen > 0) then
  begin
    SetLength(Result, BufLen);
    Move(Buffer[0], Result[1], BufLen);
  end;
  FreeMem(Buffer, BufLen);
end;

function M2Engine_ZLibDecodeBuffer(S: AnsiString; Dest: PByte; var DestLen: DWORD): Boolean; overload;
var
  Buffer: PAnsiChar;
  BufLen: LongWord;
begin
  Result := False;
  if not Assigned(g_AppFunc.M2Engine.ZLibDecodeBuffer) then Exit;

  Result := g_AppFunc.M2Engine.ZLibDecodeBuffer(PAnsiChar(S), Length(S), PAnsiChar(Dest), DestLen);
end;

function M2Engine_EncryptPassword(S: AnsiString): AnsiString;
var
  Buffer: array[0..255] of AnsiChar;
  BufLen: LongWord;
begin
  Result := '';
  if not Assigned(g_AppFunc.M2Engine.EncryptPassword) then Exit;

  BufLen := SizeOf(Buffer);
  if g_AppFunc.M2Engine.EncryptPassword(PAnsiChar(S), @Buffer, BufLen) and (BufLen > 0) then
  begin
    SetLength(Result, BufLen);
    Move(Buffer[0], Result[1], BufLen);
  end;
end;

function M2Engine_DecryptPassword(S: AnsiString): AnsiString;
var
  Buffer: array[0..255] of AnsiChar;
  BufLen: LongWord;
begin
  Result := '';
  if not Assigned(g_AppFunc.M2Engine.DecryptPassword) then Exit;

  BufLen := SizeOf(Buffer);
  if g_AppFunc.M2Engine.DecryptPassword(PAnsiChar(S), @Buffer, BufLen) and (BufLen > 0) then
  begin
    SetLength(Result, BufLen);
    Move(Buffer[0], Result[1], BufLen);
  end;
end;

function BaseObject_GetChrName(BaseObject: _TBaseObject): AnsiString;
var
  Buffer: array[0..255] of AnsiChar;
  BufLen: LongWord;
begin
  Result := '';
  if not Assigned(g_AppFunc.BaseObject.GetChrName) then Exit;

  BufLen := SizeOf(Buffer);
  if g_AppFunc.BaseObject.GetChrName(BaseObject, @Buffer, BufLen) and (BufLen > 0) then
  begin
    SetLength(Result, BufLen);
    Move(Buffer[0], Result[1], BufLen);
  end;
end;

function BaseObject_GetMapName(BaseObject: _TBaseObject): AnsiString;
var
  Buffer: array[0..255] of AnsiChar;
  BufLen: LongWord;
begin
  Result := '';
  if not Assigned(g_AppFunc.BaseObject.GetMapName) then Exit;

  BufLen := SizeOf(Buffer);
  if g_AppFunc.BaseObject.GetMapName(BaseObject, @Buffer, BufLen) and (BufLen > 0) then
  begin
    SetLength(Result, BufLen);
    Move(Buffer[0], Result[1], BufLen);
  end;
end;

function BaseObject_GetHomeMap(BaseObject: _TBaseObject): AnsiString;
var
  Buffer: array[0..255] of AnsiChar;
  BufLen: LongWord;
begin
  Result := '';
  if not Assigned(g_AppFunc.BaseObject.GetHomeMap) then Exit;

  BufLen := SizeOf(Buffer);
  if g_AppFunc.BaseObject.GetHomeMap(BaseObject, @Buffer, BufLen) and (BufLen > 0) then
  begin
    SetLength(Result, BufLen);
    Move(Buffer[0], Result[1], BufLen);
  end;
end;

function BaseObject_GetNationaName(BaseObject: _TBaseObject): AnsiString;
var
  Buffer: array[0..255] of AnsiChar;
  BufLen: LongWord;
begin
  Result := '';
  if not Assigned(g_AppFunc.BaseObject.GetNationaName) then Exit;

  BufLen := SizeOf(Buffer);
  if g_AppFunc.BaseObject.GetNationaName(BaseObject, @Buffer, BufLen) and (BufLen > 0) then
  begin
    SetLength(Result, BufLen);
    Move(Buffer[0], Result[1], BufLen);
  end;
end;

function BaseObject_GetGuildRankName(BaseObject: _TBaseObject): AnsiString;
var
  Buffer: array[0..255] of AnsiChar;
  BufLen: LongWord;
begin
  Result := '';
  if not Assigned(g_AppFunc.BaseObject.GetGuildRankName) then Exit;

  BufLen := SizeOf(Buffer);
  if g_AppFunc.BaseObject.GetGuildRankName(BaseObject, @Buffer, BufLen) and (BufLen > 0) then
  begin
    SetLength(Result, BufLen);
    Move(Buffer[0], Result[1], BufLen);
  end;
end;

function PlayObject_GetUserID(Player: _TPlayObject): AnsiString;
var
  Buffer: array[0..255] of AnsiChar;
  BufLen: LongWord;
begin
  Result := '';
  if not Assigned(g_AppFunc.Player.GetUserID) then Exit;

  BufLen := SizeOf(Buffer);
  if g_AppFunc.Player.GetUserID(Player, @Buffer, BufLen) and (BufLen > 0) then
  begin
    SetLength(Result, BufLen);
    Move(Buffer[0], Result[1], BufLen);
  end;
end;

function PlayObject_GetIPAddr(Player: _TPlayObject): AnsiString;
var
  Buffer: array[0..255] of AnsiChar;
  BufLen: LongWord;
begin
  Result := '';
  if not Assigned(g_AppFunc.Player.GetIPAddr) then Exit;

  BufLen := SizeOf(Buffer);
  if g_AppFunc.Player.GetIPAddr(Player, @Buffer, BufLen) and (BufLen > 0) then
  begin
    SetLength(Result, BufLen);
    Move(Buffer[0], Result[1], BufLen);
  end;
end;

function PlayObject_GetIPLocal(Player: _TPlayObject): AnsiString;
var
  Buffer: array[0..255] of AnsiChar;
  BufLen: LongWord;
begin
  Result := '';
  if not Assigned(g_AppFunc.Player.GetIPLocal) then Exit;

  BufLen := SizeOf(Buffer);
  if g_AppFunc.Player.GetIPLocal(Player, @Buffer, BufLen) and (BufLen > 0) then
  begin
    SetLength(Result, BufLen);
    Move(Buffer[0], Result[1], BufLen);
  end;
end;

function PlayObject_GetMachineID(Player: _TPlayObject): AnsiString;
var
  Buffer: array[0..255] of AnsiChar;
  BufLen: LongWord;
begin
  Result := '';
  if not Assigned(g_AppFunc.Player.GetMachineID) then Exit;

  BufLen := SizeOf(Buffer);
  if g_AppFunc.Player.GetMachineID(Player, @Buffer, BufLen) and (BufLen > 0) then
  begin
    SetLength(Result, BufLen);
    Move(Buffer[0], Result[1], BufLen);
  end;
end;

function PlayObject_GetHeroName(Player: _TPlayObject): AnsiString;
var
  Buffer: array[0..255] of AnsiChar;
  BufLen: LongWord;
begin
  Result := '';
  if not Assigned(g_AppFunc.Player.GetHeroName) then Exit;

  BufLen := SizeOf(Buffer);
  if g_AppFunc.Player.GetHeroName(Player, @Buffer, BufLen) and (BufLen > 0) then
  begin
    SetLength(Result, BufLen);
    Move(Buffer[0], Result[1], BufLen);
  end;
end;

function PlayObject_GetDeputyHeroName(Player: _TPlayObject): AnsiString;
var
  Buffer: array[0..255] of AnsiChar;
  BufLen: LongWord;
begin
  Result := '';
  if not Assigned(g_AppFunc.Player.GetDeputyHeroName) then Exit;

  BufLen := SizeOf(Buffer);
  if g_AppFunc.Player.GetDeputyHeroName(Player, @Buffer, BufLen) and (BufLen > 0) then
  begin
    SetLength(Result, BufLen);
    Move(Buffer[0], Result[1], BufLen);
  end;
end;

function PlayObject_GetVarT(Player: _TPlayObject; Index: Integer): AnsiString;
var
  Buffer: array[0..1023] of AnsiChar;
  BufLen: LongWord;
begin
  Result := '';
  if not Assigned(g_AppFunc.Player.GetVarT) then Exit;

  BufLen := SizeOf(Buffer);
  if g_AppFunc.Player.GetVarT(Player, Index, @Buffer, BufLen) and (BufLen > 0) then
  begin
    SetLength(Result, BufLen);
    Move(Buffer[0], Result[1], BufLen);
  end;
end;

function PlayObject_GetVarS(Player: _TPlayObject; Index: Integer): AnsiString;
var
  Buffer: array[0..1023] of AnsiChar;
  BufLen: LongWord;
begin
  Result := '';
  if not Assigned(g_AppFunc.Player.GetVarS) then Exit;

  BufLen := SizeOf(Buffer);
  if g_AppFunc.Player.GetVarS(Player, Index, @Buffer, BufLen) and (BufLen > 0) then
  begin
    SetLength(Result, BufLen);
    Move(Buffer[0], Result[1], BufLen);
  end;
end;

function PlayObject_GetMasterName(Player: _TPlayObject): AnsiString;
var
  Buffer: array[0..255] of AnsiChar;
  BufLen: LongWord;
begin
  Result := '';
  if not Assigned(g_AppFunc.Player.GetMasterName) then Exit;

  BufLen := SizeOf(Buffer);
  if g_AppFunc.Player.GetMasterName(Player, @Buffer, BufLen) and (BufLen > 0) then
  begin
    SetLength(Result, BufLen);
    Move(Buffer[0], Result[1], BufLen);
  end;
end;

function PlayObject_GetDearName(Player: _TPlayObject): AnsiString;
var
  Buffer: array[0..255] of AnsiChar;
  BufLen: LongWord;
begin
  Result := '';
  if not Assigned(g_AppFunc.Player.GetDearName) then Exit;

  BufLen := SizeOf(Buffer);
  if g_AppFunc.Player.GetDearName(Player, @Buffer, BufLen) and (BufLen > 0) then
  begin
    SetLength(Result, BufLen);
    Move(Buffer[0], Result[1], BufLen);
  end;
end;

function HeroObject_GetMasterName(Hero: _THeroObject): AnsiString;
var
  Buffer: array[0..255] of AnsiChar;
  BufLen: LongWord;
begin
  Result := '';
  if not Assigned(g_AppFunc.Hero.GetMasterName) then Exit;

  BufLen := SizeOf(Buffer);
  if g_AppFunc.Hero.GetMasterName(Hero, @Buffer, BufLen) and (BufLen > 0) then
  begin
    SetLength(Result, BufLen);
    Move(Buffer[0], Result[1], BufLen);
  end;
end;

function NormNpc_GetFilePath(NormNpc: _TNormNpc): AnsiString;
var
  Buffer: array[0..255] of AnsiChar;
  BufLen: LongWord;
begin
  Result := '';
  if not Assigned(g_AppFunc.Npc.GetFilePath) then Exit;

  BufLen := SizeOf(Buffer);
  if g_AppFunc.Npc.GetFilePath(NormNpc, @Buffer, BufLen) and (BufLen > 0) then
  begin
    SetLength(Result, BufLen);
    Move(Buffer[0], Result[1], BufLen);
  end;
end;

function NormNpc_GetPath(NormNpc: _TNormNpc): AnsiString;
var
  Buffer: array[0..255] of AnsiChar;
  BufLen: LongWord;
begin
  Result := '';
  if not Assigned(g_AppFunc.Npc.GetPath) then Exit;

  BufLen := SizeOf(Buffer);
  if g_AppFunc.Npc.GetPath(NormNpc, @Buffer, BufLen) and (BufLen > 0) then
  begin
    SetLength(Result, BufLen);
    Move(Buffer[0], Result[1], BufLen);
  end;
end;

function NormNpc_GetLineVariableText(NormNpc: _TNormNpc; Player: _TPlayObject; sMsg: AnsiString): AnsiString;
var
  Buffer: array[0..2047] of AnsiChar;
  BufLen: LongWord;
begin
  Result := '';
  if not Assigned(g_AppFunc.Npc.GetLineVariableText) then Exit;

  BufLen := SizeOf(Buffer);
  if g_AppFunc.Npc.GetLineVariableText(NormNpc, Player, PAnsiChar(sMsg), @Buffer, BufLen) and (BufLen > 0) then
  begin
    SetLength(Result, BufLen);
    Move(Buffer[0], Result[1], BufLen);
  end;
end;

function UserEngine_GetStdItemName(ItemIdx: Integer): AnsiString;
var
  Buffer: array[0..255] of AnsiChar;
  BufLen: LongWord;
begin
  Result := '';
  if not Assigned(g_AppFunc.UserEngine.GetStdItemName) then Exit;

  BufLen := SizeOf(Buffer);
  if g_AppFunc.UserEngine.GetStdItemName(ItemIdx, @Buffer, BufLen) and (BufLen > 0) then
  begin
    SetLength(Result, BufLen);
    Move(Buffer[0], Result[1], BufLen);
  end;
end;

function Guild_GetGuildName(Guild: _TGuild): AnsiString;
var
  Buffer: array[0..255] of AnsiChar;
  BufLen: LongWord;
begin
  Result := '';
  if not Assigned(g_AppFunc.Guild.GetGuildName) then Exit;

  BufLen := SizeOf(Buffer);
  if g_AppFunc.Guild.GetGuildName(Guild, @Buffer, BufLen) and (BufLen > 0) then
  begin
    SetLength(Result, BufLen);
    Move(Buffer[0], Result[1], BufLen);
  end;
end;

function Guild_GetJoinMsg(Guild: _TGuild): AnsiString;
var
  Buffer: array[0..255] of AnsiChar;
  BufLen: LongWord;
begin
  Result := '';
  if not Assigned(g_AppFunc.Guild.GetJoinMsg) then Exit;

  BufLen := SizeOf(Buffer);
  if g_AppFunc.Guild.GetJoinMsg(Guild, @Buffer, BufLen) and (BufLen > 0) then
  begin
    SetLength(Result, BufLen);
    Move(Buffer[0], Result[1], BufLen);
  end;
end;

function Guild_GetMasterName(Guild: _TGuild; var Master1Name, Master2Name: AnsiString): Boolean;
var
  Master1: array[0..255] of AnsiChar;
  Master1Len: LongWord;

  Master2: array[0..255] of AnsiChar;
  Master2Len: LongWord;
begin
  Result := False;
  if not Assigned(g_AppFunc.Guild.GetMasterName) then Exit;

  Master1Len := SizeOf(Master1);
  Master2Len := SizeOf(Master2);
  if g_AppFunc.Guild.GetMasterName(Guild, @Master1, Master1Len, @Master2, Master2Len) then
  begin
    if Master1Len > 0 then
    begin
      SetLength(Master1Name, Master1Len);
      Move(Master1[0], Master1Name[1], Master1Len);
    end
    else
    begin
      Master1Name := '';
    end;

    if Master2Len > 0 then
    begin
      SetLength(Master2Name, Master2Len);
      Move(Master2[0], Master2Name[1], Master2Len);
    end
    else
    begin
      Master2Name := '';
    end;
    
    Result := True;
  end;
end;

function Guild_GetRandNameByName(Guild: _TGuild; CharName: AnsiString; var nRankNo: Integer; var RankName: AnsiString): Boolean;
var
  Buffer: array[0..255] of AnsiChar;
  BufLen: LongWord;
begin
  Result := False;
  if not Assigned(g_AppFunc.Guild.GetRandNameByName) then Exit;

  BufLen := SizeOf(Buffer);
  if g_AppFunc.Guild.GetRandNameByName(Guild, PAnsiChar(CharName), nRankNo, @Buffer, BufLen) then
  begin
    if BufLen > 0 then
    begin
      SetLength(RankName, BufLen);
      Move(Buffer[0], RankName[1], BufLen);
    end
    else
    begin
      RankName := '';
    end;
    Result := True;
  end;
end;

function Guild_GetRandNameByPlayer(Guild: _TGuild; Player: _TPlayObject; var nRankNo: Integer; var RankName: AnsiString): Boolean;
var
  Buffer: array[0..255] of AnsiChar;
  BufLen: LongWord;
begin
  Result := False;
  if not Assigned(g_AppFunc.Guild.GetRandNameByPlayer) then Exit;

  BufLen := SizeOf(Buffer);
  if g_AppFunc.Guild.GetRandNameByPlayer(Guild, Player, nRankNo, @Buffer, BufLen) then
  begin
    if BufLen > 0 then
    begin
      SetLength(RankName, BufLen);
      Move(Buffer[0], RankName[1], BufLen);
    end
    else
    begin
      RankName := '';
    end;
    Result := True;
  end;
end;

function MakeDefaultMsg(wIdent: Word; nRecog: Int64; wParam, wTag, wSeries: Word): TDefaultMessage;
begin
  Result.Recog := nRecog;
  Result.Ident := wIdent;
  Result.Param := wParam;
  Result.Tag := wTag;
  Result.Series := wSeries;
end;

function EncodeMessage(const DefMsg: TDefaultMessage): AnsiString;
var
  nLen: LongWord;
  sTemp: AnsiString;
begin
  Result := '';
  if not Assigned(g_AppFunc.M2Engine.EncodeBuffer) then Exit;

  nLen := SizeOf(TDefaultMessage) * 2;
  SetLength(sTemp, nLen);
  if g_AppFunc.M2Engine.EncodeBuffer(@DefMsg, SizeOf(TDefaultMessage), PAnsiChar(sTemp), nLen) and (nLen > 0) then
  begin
    SetLength(Result, nLen);
    Move(sTemp[1], Result[1], nLen);
  end;
end;

function DecodeMessage(const Msg: AnsiString; var DefMsg: TDefaultMessage): Boolean;
var
  nLen: LongWord;
  sTemp: AnsiString;
begin
  Result := False;
  if not Assigned(g_AppFunc.M2Engine.DecodeBuffer) then Exit;

  sTemp := Copy(Msg, 1, 16);
  nLen := Length(Msg);
  Result := g_AppFunc.M2Engine.DecodeBuffer(PAnsiChar(sTemp), Length(sTemp), @DefMsg, nLen);
end;

function EncodeString(const S: AnsiString): AnsiString;
var
  nLen: LongWord;
  sTemp: AnsiString;
begin
  Result := '';
  if not Assigned(g_AppFunc.M2Engine.EncodeBuffer) then Exit;

  nLen := Length(S) * 2;
  SetLength(sTemp, nLen);
  if g_AppFunc.M2Engine.EncodeBuffer(PAnsiChar(S), Length(S), PAnsiChar(sTemp), nLen) and (nLen > 0) then
  begin
    SetLength(Result, nLen);
    Move(sTemp[1], Result[1], nLen);
  end;
end;

function DecodeString(const S: AnsiString): AnsiString;
var
  nLen: LongWord;
  sTemp: AnsiString;
begin
  Result := '';
  if not Assigned(g_AppFunc.M2Engine.DecodeBuffer) then Exit;

  nLen := Length(S);
  SetLength(sTemp, Length(S));
  if g_AppFunc.M2Engine.DecodeBuffer(PAnsiChar(S), Length(S), PAnsiChar(sTemp), nLen) and (nLen > 0) then
  begin
    SetLength(Result, nLen);
    Move(sTemp[1], Result[1], nLen);
  end;
end;

end.
