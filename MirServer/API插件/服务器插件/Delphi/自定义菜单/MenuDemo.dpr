library MenuDemo;

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
  {$IF CompilerVersion >= 21.0}VCL.{$IFEND}Dialogs,
  CRCUtils,
  PluginTypeDef,
  PluginInterface,
  PluginDelphiUtils;

{$R *.res}


procedure MenuItem1Click(Sender: TObject); stdcall;
var
  Tag: Integer;
begin
  Tag := g_AppFunc.Menu.GetTag(Sender);
  ShowMessage(IntToStr(Tag) + ' ���');
end;

//�����ʼ��
function Init(AppFunc: PAppFuncDef; AppFuncCrc: DWORD;
  ExtParam: DWORD; Desc: PAnsiChar; var DescLen: DWORD): BOOL; stdcall;
var
  S: AnsiString;
  MenuItem, ParentMenu, MenuItem2: _TMenuItem;
begin
  Result := True;
  if Crc32(PByte(AppFunc), SizeOf(TAppFuncDef)) <> AppFuncCrc then
  begin
    Result := False;
    Exit;
  end;
  g_AppFunc := AppFunc^;

  S := '�Զ���˵�����';
  if DescLen > Length(S) then
  begin
    Move(S[1], Desc^, Length(S));
    DescLen := Length(S);
  end;

  MenuItem := g_AppFunc.Menu.GetPluginMenu;
  if MenuItem <> nil then
  begin
    if not g_AppFunc.Menu.GetVisable(MenuItem) then
    begin
      g_AppFunc.Menu.SetVisable(MenuItem, True);
    end;
  end;

  ParentMenu := g_AppFunc.Menu.Add(g_AppFunc.PluginID, MenuItem, '�˵�����1', 1, nil);

  MenuItem := g_AppFunc.Menu.Add(g_AppFunc.PluginID, ParentMenu, '�Ӳ˵�11', 11, MenuItem1Click);
  MenuItem := g_AppFunc.Menu.Add(g_AppFunc.PluginID, ParentMenu,'�Ӳ˵�12', 12, nil);

  MenuItem2 := g_AppFunc.Menu.Add(g_AppFunc.PluginID, MenuItem, '�Ӳ˵�121', 121, MenuItem1Click);
  MenuItem2 := g_AppFunc.Menu.Add(g_AppFunc.PluginID, MenuItem, '�Ӳ˵�122', 122, MenuItem1Click);

  ParentMenu := g_AppFunc.Menu.Add(g_AppFunc.PluginID, g_AppFunc.Menu.GetPluginMenu, '�˵�����2', 2, nil);

  MenuItem := g_AppFunc.Menu.Add(g_AppFunc.PluginID, ParentMenu, '�Ӳ˵�21', 21, MenuItem1Click);
  MenuItem := g_AppFunc.Menu.Add(g_AppFunc.PluginID, ParentMenu, '�Ӳ˵�22', 22, MenuItem1Click);
end;

//�������ʼ��
procedure UnInit(); stdcall;
begin

end;


exports
  Init,
  UnInit;

begin

end.
