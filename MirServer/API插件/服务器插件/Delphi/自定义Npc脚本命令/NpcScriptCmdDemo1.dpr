library NpcScriptCmdDemo1;

{ Important note about DLL memory management: ShareMem must be the
  first unit in your library's USES clause AND your project's (select
  Project-View Source) USES clause if your DLL exports any procedures or
  functions that pass strings as parameters or function results. This
  applies to all strings passed to and from your DLL--even those that
  are nested in records and classes. ShareMem is the interface unit to
  the BORLNDMM.DLL shared memory manager, which must be deployed along
  with your DLL. To avoid using BORLNDMM.DLL, pass string information
  using PChar or ShortString parameters. }

uses
  Windows,
  SysUtils,
  Classes,
  CRCUtils,
  PluginTypeDef,
  PluginInterface,
  PluginDelphiUtils;

{$R *.res}

//�����ʼ��
function Init(AppFunc: PAppFuncDef; AppFuncCrc: DWORD;
  ExtParam: DWORD; Desc: PAnsiChar; var DescLen: DWORD): BOOL; stdcall;
var
  S: AnsiString;
begin
  Result := True;
  if Crc32(PByte(AppFunc), SizeOf(TAppFuncDef)) <> AppFuncCrc then
  begin
    Result := False;
    Exit;
  end;
  g_AppFunc := AppFunc^;

  S := '�Զ���NPC�ű��������';

  if DescLen > Length(S) then
  begin
    Move(S[1], Desc^, Length(S));
  end;

  g_AppFunc.M2Engine.MainOutMessage('�Զ���NPC�ű��������ɹ�.', False);
end;

//�������ʼ��
procedure UnInit(); stdcall;
begin
  g_AppFunc.M2Engine.MainOutMessage('�Զ���NPC�ű����ж�سɹ�.', False);
end;

//Hook NPC�����ж�����������Զ������CheckTest��������ֵ��Ϊ 1
function HookNpcLoadConditionCmd(pCmd: PAnsiChar): Integer; stdcall;
begin
  Result := 0;
  if lstrcmpiA(pCmd, 'MyCheckLevel') = 0 then   // �����ִ�Сд�Ƚ�
  begin
    Result := 1;
  end;
end;

//Hook NPC�����ж�ִ�����ScriptParam.nCMDCode = 1 ��Ϊ CheckTest����
function HookNpcConditionProcess(ScriptParam: PScriptCmdParam): Boolean; stdcall;
var
  Abil: TAbility;
begin
  if ScriptParam.nCMDCode = 1 then
  begin
    Result := False;

    if g_AppFunc.BaseObject.GetWAbility(ScriptParam.PlayObject, @Abil) then
    begin
      Result := Abil.Level >= ScriptParam.nParam01;
    end;
  end;
end;

// Hook NPCִ������������Զ������MySendMsg��������ֵ����Ϊ1
function HookNpcLoadActionCmd(pCmd: PAnsiChar): Integer; stdcall;
begin
  Result := 0;
  if lstrcmpiA(pCmd, 'MySendMsg') = 0 then   // �����ִ�Сд�Ƚ�
  begin
    Result := 1;
  end;
end;

//Hook NPCִ�����ScriptParam.nCMDCode = 1 ��Ϊ MySendMsg����
procedure HookNpcActionProcess(ScriptParam: PScriptCmdParam; var boSendMerChantSay, boBreak: BOOL); stdcall;
begin
  if ScriptParam.nCMDCode = 1 then
  begin
    g_AppFunc.BaseObject.SysMsg(ScriptParam.PlayObject, ScriptParam.sParam01, ScriptParam.nParam02, ScriptParam.nParam03, MSGTYEPE_HINT);
  end;
end;

exports
  Init,
  UnInit,
  HookNpcLoadConditionCmd,
  HookNpcConditionProcess,
  HookNpcLoadActionCmd,
  HookNpcActionProcess;

{
#if
MyCheckLevel 100
#act
MySendMsg ��������ļ����� 249 0
}
begin

end.
