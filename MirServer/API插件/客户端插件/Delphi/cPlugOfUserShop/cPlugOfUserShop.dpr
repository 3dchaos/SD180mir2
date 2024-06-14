library CPlugOfUserShop;

{ Important note about DLL memory management: ShareMem must be the
  first unit in your library's USES clause AND your project's (select
  Project-View Source) USES clause if your DLL exports any procedures or
  functions that pass strings as parameters or function results. This
  applies to all strings passed to and from your DLL--even those that
  are nested in records and classes. ShareMem is the interface unit to
  the BORLNDMM.DLL shared memory manager, which must be deployed along
  with your DLL. To avoid using BORLNDMM.DLL, pass string information
  using PChar or ShortString parameters. }

{$R *.res}


uses
  //FastMM4,
  ClientAPI in '..\Common\ClientAPI.pas',
  ClientType in '..\Common\ClientType.pas',
  PlugMain in 'PlugMain.pas';

function CInit(ClientAPI: pTClientAPI; APISize: Integer): Integer; stdcall;
begin
  if APISize <> SizeOf(TClientAPI) then begin //大小不一样退出
    Result := SizeOf(TClientAPI);
    Exit;
  end;
  ListAPI := ClientAPI.ListAPI;
  StringListAPI := ClientAPI.StringListAPI;
  TextureAPI := ClientAPI.TextureAPI;
  ImagesAPI := ClientAPI.ImagesAPI;

  DControlAPI := ClientAPI.InterfaceAPI.DControl;
  DWindowAPI := ClientAPI.InterfaceAPI.DWindow;
  DButtonAPI := ClientAPI.InterfaceAPI.DButton;
  DEditAPI := ClientAPI.InterfaceAPI.DEdit;
  DGridAPI := ClientAPI.InterfaceAPI.DGrid;
  DComboBoxAPI := ClientAPI.InterfaceAPI.DComboBox;
  DPopupMenuAPI := ClientAPI.InterfaceAPI.DPopupMenu;

  DrawAPI := ClientAPI.DrawAPI;
  ActorAPI := ClientAPI.ActorAPI;
  SocketAPI := ClientAPI.SocketAPI;
  HookAPI := ClientAPI.HookAPI;
  GameAPI := ClientAPI.GameAPI;
  GameInterfaceAPI := ClientAPI.GameInterfaceAPI;
//--------------------------------------------------------------
  InitPlug;

  Result := SizeOf(TClientAPI);
end;

procedure CUnInit(); stdcall;
begin
  UnInitPlug;
end;

exports
  CInit, CUnInit;
begin

end.

