unit PlugMain;

interface
uses
  Windows, ClientAPI, ClientType;

type
  TGridSelect = procedure(ObjSelf: TObject; Sender: TObject; ACol, ARow: Integer; Button: TMouseButton; Shift: TShiftState); stdcall;
procedure InitPlug;
procedure UnInitPlug;
procedure HookInitialize(Handle: THandle; FirstInit: Boolean; WindowMode: Boolean; ScreenWidth, ScreenHeight: Word; ClientVersion: TClientVersion); stdcall;
procedure HookFinalize(); stdcall;
procedure HookFormMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer); stdcall;


procedure HookDecodeMessagePacketStop(DefMsg: pTDefaultMessage; sData: PChar); stdcall;
procedure HookDecodeMessagePacket(DefMsg: pTDefaultMessage; sData: PChar); stdcall;
procedure HookFeatureChanged(Actor: TActor); stdcall;


procedure ItemBagGridSelect(ObjSelf: TObject; Sender: TObject; ACol, ARow: Integer; Button: TMouseButton; Shift: TShiftState); stdcall;

implementation
var
  OldHookInitialize: TInitialize = nil;
  OldHookFinalize: TStartPro = nil;
  OldHookFormMouseDown: TFormMouseDown = nil;
  OldHookDecodeMessagePacket: TDecodeMessagePacket = nil;
  OldHookDecodeMessagePacketStop: TDecodeMessagePacket = nil;
  OldHookFeatureChanged: TObjectAction = nil;


  OldItemBagGridSelect: TGridSelect = nil;
//------------------------------------------------------------------------------
  DUserShopDlg: TDxControl = nil;                                                                   // ��̯����
  DUserShopRemoteDlg: TDxControl = nil;                                                             // �鿴�Է��İ�̯����
  DInputPriceDlg: TDxControl = nil;                                                                 // ��̯����۸񴰿�

  NewopUI: Integer = 0;                                                                             // NewopUI.pak
  Prguse3: Integer = 0;                                                                             // Prguse3.wil
  g_WindowMode: Boolean;
  g_ScreenWidth, g_ScreenHeight: Word;
  g_ClientVersion: TClientVersion;


  g_boInputPriceOK: Boolean = False;
  g_nMoneyType: Integer = 0;
  g_nPrice: Integer = 0;
  g_nSelectRecogId: Integer = 0;
  g_SelectActor: TActor = nil;
  g_SelectShopItem: TClientItem;

  g_UserShopWaiting: TClientItem;
  g_UserShopMouseItem: TClientItem;
  g_UserShopItems: array[0..20 - 1] of TClientItem;
  g_UserShopItemEffects: array[0..20 - 1] of TDrawItemEffect;

  g_UserShopRemoteMouseItem: TClientItem;
  g_UserShopRemoteItems: array[0..20 - 1] of TClientItem;
  g_UserShopRemoteItemEffects: array[0..20 - 1] of TDrawItemEffect;
const
  {CM_STARTSHOPSTALL = 163;                                                                          // ��ʼ��̯
  CM_STOPSHOPSTALL = 164;                                                                           // ֹͣ��̯
  CM_BUYUSERSHOPITEM = 165;                                                                         // �����̯��Ʒ
  CM_ADDUSERSHOPITEM = 166;                                                                         // ���Ӱ�̯��Ʒ
  CM_DELUSERSHOPITEM = 167;                                                                         // ɾ����̯��Ʒ
  CM_SENDCLOSESHOP = 168;                                                                           // �رչ����̯��Ʒ����
  CM_SENDSHOPNAME = 150;                                                                            // ���ð�̯��������

  SM_ADDUSERSHOPITEM_OK = 1497;                                                                     // ���Ӱ�̯��Ʒ�ɹ�
  SM_ADDUSERSHOPITEM_FAIL = 1498;                                                                   // ���Ӱ�̯��Ʒʧ��
  SM_DELUSERSHOPITEM_OK = 1499;                                                                     // ɾ����̯��Ʒ�ɹ�
  SM_DELUSERSHOPITEM_FAIL = 1500;                                                                   // ɾ����̯��Ʒʧ��
  SM_DELUSERSHOPITEM = 1501;                                                                        // ɾ����̯��Ʒ
  SM_DELREMOTEUSERSHOPITEM = 1502;                                                                  // ɾ����̯��Ʒ
  SM_SENDSHOPITEM = 1503;                                                                           // ��̯��Ʒ
  SM_SENDCLOSESHOP = 1504;                                                                          // �رչ����̯��Ʒ����
  }
  CM_STARTSHOPSTALL = 36008; //��ʼ��̯
  CM_STOPSHOPSTALL = 36009; //ֹͣ��̯
  CM_BUYUSERSHOPITEM = 36010; //�����̯��Ʒ
  CM_ADDUSERSHOPITEM = 36011; //���Ӱ�̯��Ʒ
  CM_DELUSERSHOPITEM = 36012; //ɾ����̯��Ʒ
  SM_ADDUSERSHOPITEM_OK = 36013; //���Ӱ�̯��Ʒ�ɹ�
  SM_ADDUSERSHOPITEM_FAIL = 36014; //���Ӱ�̯��Ʒʧ��
  SM_DELUSERSHOPITEM_OK = 36015; //ɾ����̯��Ʒ�ɹ�
  SM_DELUSERSHOPITEM_FAIL = 36016; //ɾ����̯��Ʒʧ��
  SM_DELUSERSHOPITEM = 36017; //ɾ����̯��Ʒ
  SM_DELREMOTEUSERSHOPITEM = 36018; //ɾ����̯��Ʒ
  SM_SENDSHOPITEM = 36019; //��̯��Ʒ
  SM_SENDCLOSESHOP = 36020; //�رչ����̯��Ʒ����
  CM_SENDCLOSESHOP = 36021; //�رչ����̯��Ʒ����
  //CM_SENDSHOPNAME = 5211; //���ð�̯��������


  mtUserShopItem = 12;

procedure InitPlug;
begin
  OldHookInitialize := HookAPI.GetHookInitialize();
  OldHookFinalize := HookAPI.GetHookFinalize();
  OldHookFormMouseDown := HookAPI.GetHookFormMouseDown();
  OldHookDecodeMessagePacket := HookAPI.GetHookDecodeMessagePacket();
  OldHookDecodeMessagePacketStop := HookAPI.GetHookDecodeMessagePacketStop();
  OldHookFeatureChanged := HookAPI.GetHookTActor_FeatureChanged();

  HookAPI.SetHookInitialize(HookInitialize);
  HookAPI.SetHookFinalize(HookFinalize);
  HookAPI.SetHookFormMouseDown(HookFormMouseDown);
  HookAPI.SetHookDecodeMessagePacket(HookDecodeMessagePacket);
  HookAPI.SetHookDecodeMessagePacketStop(HookDecodeMessagePacketStop);
  HookAPI.SetHookTActor_FeatureChanged(HookFeatureChanged);
end;

procedure UnInitPlug;
begin
  HookAPI.SetHookInitialize(OldHookInitialize);
  HookAPI.SetHookFinalize(OldHookFinalize);
  HookAPI.SetHookFormMouseDown(OldHookFormMouseDown);
  HookAPI.SetHookDecodeMessagePacket(OldHookDecodeMessagePacket);
  HookAPI.SetHookDecodeMessagePacketStop(OldHookDecodeMessagePacketStop);
  HookAPI.SetHookTActor_FeatureChanged(OldHookFeatureChanged);
end;



procedure CvtInt;
{ IN:
    EAX:  The integer value to be converted to text
    ESI:  Ptr to the right-hand side of the output buffer:  LEA ESI, StrBuf[16]
    ECX:  Base for conversion: 0 for signed decimal, 10 or 16 for unsigned
    EDX:  Precision: zero padded minimum field width
  OUT:
    ESI:  Ptr to start of converted text (not start of buffer)
    ECX:  Length of converted text
}
asm
        OR      CL,CL
        JNZ     @CvtLoop
@C1:    OR      EAX,EAX
        JNS     @C2
        NEG     EAX
        CALL    @C2
        MOV     AL,'-'
        INC     ECX
        DEC     ESI
        MOV     [ESI],AL
        RET
@C2:    MOV     ECX,10

@CvtLoop:
        PUSH    EDX
        PUSH    ESI
@D1:    XOR     EDX,EDX
        DIV     ECX
        DEC     ESI
        ADD     DL,'0'
        CMP     DL,'0'+10
        JB      @D2
        ADD     DL,('A'-'0')-10
@D2:    MOV     [ESI],DL
        OR      EAX,EAX
        JNE     @D1
        POP     ECX
        POP     EDX
        SUB     ECX,ESI
        SUB     EDX,ECX
        JBE     @D5
        ADD     ECX,EDX
        MOV     AL,'0'
        SUB     ESI,EDX
        JMP     @z
@zloop: MOV     [ESI+EDX],AL
@z:     DEC     EDX
        JNZ     @zloop
        MOV     [ESI],AL
@D5:
end;
//------------------------------------------------------------------------------

function IntToStr(Value: Integer): string;
//  FmtStr(Result, '%d', [Value]);
asm
        PUSH    ESI
        MOV     ESI, ESP
        SUB     ESP, 16
        XOR     ECX, ECX       // base: 0 for signed decimal
        PUSH    EDX            // result ptr
        XOR     EDX, EDX       // zero filled field width: 0 for no leading zeros
        CALL    CvtInt
        MOV     EDX, ESI
        POP     EAX            // result ptr
        CALL    System.@LStrFromPCharLen
        ADD     ESP, 16
        POP     ESI
end;
//------------------------------------------------------------------------------

function GetValidStr3(Str: string; var Dest: string; const Divider: array of Char): string;
const
  BUF_SIZE = 20480;                                                                                 //$7FFF;
var
  buf: array[0..BUF_SIZE] of Char;
  BufCount, Count, srclen, I, ArrCount: LongInt;
  Ch: Char;
label
  CATCH_DIV;
begin
  Ch := #0;                                                                                         //Jacky
  try
    srclen := Length(Str);
    BufCount := 0;
    Count := 1;

    if srclen >= BUF_SIZE - 1 then
    begin
      Result := '';
      Dest := '';
      Exit;
    end;

    if Str = '' then
    begin
      Dest := '';
      Result := Str;
      Exit;
    end;
    ArrCount := SizeOf(Divider) div SizeOf(Char);

    while True do
    begin
      if Count <= srclen then
      begin
        Ch := Str[Count];
        for I := 0 to ArrCount - 1 do
          if Ch = Divider[I] then
            goto CATCH_DIV;
      end;
      if (Count > srclen) then
      begin
        CATCH_DIV:
        if (BufCount > 0) then
        begin
          if BufCount < BUF_SIZE - 1 then
          begin
            buf[BufCount] := #0;
            Dest := string(buf);
            Result := Copy(Str, Count + 1, srclen - Count);
          end;
          Break;
        end
        else
        begin
          if (Count > srclen) then
          begin
            Dest := '';
            Result := Copy(Str, Count + 2, srclen - 1);
            Break;
          end;
        end;
      end
      else
      begin
        if BufCount < BUF_SIZE - 1 then
        begin
          buf[BufCount] := Ch;
          Inc(BufCount);
        end;                                                                                        // else
        //ShowMessage ('BUF_SIZE overflow !');
      end;
      Inc(Count);
    end;
  except
    Dest := '';
    Result := '';
  end;
end;

function AddItemBag(cu: TClientItem): Boolean;
var
  I: Integer;
begin
  Result := FALSE;
  for I := 0 to Length(GameAPI.ItemBag^) - 1 do
  begin
    if (GameAPI.ItemBag[I].MakeIndex = cu.MakeIndex) and (GameAPI.ItemBag[I].S.Name = cu.S.Name) then
    begin
      Exit;
    end;
  end;

  if cu.S.Name = '' then Exit;
  if cu.S.StdMode <= 3 then
  begin
    for I := 0 to 5 do
      if GameAPI.ItemBag[I].S.Name = '' then
      begin
        GameAPI.ItemBag[I] := cu;
        Result := True;
        Exit;
      end;
  end;
  for I := 6 to Length(GameAPI.ItemBag^) - 1 do
  begin
    if GameAPI.ItemBag[I].S.Name = '' then
    begin
      GameAPI.ItemBag[I] := cu;
      Result := True;
      Break;
    end;
  end;
end;

procedure AddUserShopItem(cu: TClientItem);
var
  I: Integer;
begin
  for I := 0 to Length(g_UserShopItems) - 1 do
  begin
    if g_UserShopItems[I].S.Name = '' then
    begin
      g_UserShopItems[I] := cu;
      break;
    end;
  end;
end;

procedure DelUserShopItem(nMakeIndex: Integer);
var
  I: Integer;
begin
  for I := 0 to Length(g_UserShopItems) - 1 do
  begin
    if g_UserShopItems[I].MakeIndex = nMakeIndex then
    begin
      g_UserShopItems[I].S.Name := '';
    end;
  end;
end;

procedure AddRemoteUserShopItem(cu: TClientItem);
var
  I: Integer;
begin
  for I := 0 to Length(g_UserShopRemoteItems) - 1 do
  begin
    if g_UserShopRemoteItems[I].S.Name = '' then
    begin
      g_UserShopRemoteItems[I] := cu;
      break;
    end;
  end;
end;

procedure DelRemoteUserShopItem(nMakeIndex: Integer);
var
  I: Integer;
begin
  for I := 0 to Length(g_UserShopRemoteItems) - 1 do
  begin
    if g_UserShopRemoteItems[I].MakeIndex = nMakeIndex then
    begin
      g_UserShopRemoteItems[I].S.Name := '';
    end;
  end;
end;

//------------------------------------------------------------------------------

procedure OnMouseDown(ObjSelf: TObject; Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer); stdcall; // ��갴���¼�
begin

end;
//------------------------------------------------------------------------------

procedure OnMouseMove(ObjSelf: TObject; Sender: TObject; Shift: TShiftState; X, Y: Integer); stdcall; // ����ƶ��¼�
begin
  g_UserShopMouseItem.S.Name := '';
  g_UserShopRemoteMouseItem.S.Name := '';
  GameAPI.ClearHint;
end;


//------------------------------------------------------------------------------

procedure OnStartSubPaint(ObjSelf: TObject; Sender: TObject); stdcall;                              // ��ʼ�����ӿؼ��¼�
begin

end;

//------------------------------------------------------------------------------

procedure OnInRealArea(ObjSelf: TObject; Sender: TObject; X, Y: Integer; var IsRealArea: Boolean); stdcall;
begin

end;
//------------------------------------------------------------------------------

procedure HookFormMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if (Button = mbRight) and GameAPI.boItemMoving and (GameAPI.MovingItem.ItemType = mtUserShopItem) and
    (GameAPI.MovingItem.Index in [0..19]) and (GameAPI.MovingItem.Item.S.Name <> '') and (g_UserShopItems[GameAPI.MovingItem.Index].S.Name = '') then
  begin                                                                                             // �Ƿ�ǰ���ƶ���Ʒ
    if (GameAPI.MySelf <> nil) and (not ActorAPI.m_boOpenShop(GameAPI.MySelf)) then
    begin
      g_UserShopItems[GameAPI.MovingItem.Index] := GameAPI.MovingItem.Item;
      GameAPI.MovingItem.Item.S.Name := '';
      GameAPI.SetItemMoving(False);
    end;
  end;
  if Assigned(OldHookFormMouseDown) then
    OldHookFormMouseDown(Sender, Button, Shift, X, Y);
end;
//------------------------------------------------------------------------------

procedure HookFeatureChanged(Actor: TActor);
begin
  if (g_nSelectRecogId <> 0) and (ActorAPI.m_nRecogId(Actor)^ = g_nSelectRecogId) then
  begin
    if not ActorAPI.m_boOpenShop(Actor) then
    begin
      g_nSelectRecogId := 0;
      g_SelectActor := nil;
      g_SelectShopItem.S.Name := '';
      if DUserShopRemoteDlg <> nil then
        DControlAPI.SetVisible(DUserShopRemoteDlg, False);

      if (GameAPI.MySelf <> Actor) then
        GameAPI.AddChatBoardString('�Է��Ѿ�ȡ���˰�̯������', 249, 255);
    end;
  end;
  if Assigned(OldHookFeatureChanged) then
    OldHookFeatureChanged(Actor);
end;
//------------------------------------------------------------------------------

procedure HookDecodeMessagePacket(DefMsg: pTDefaultMessage; sData: PChar);
var
  I: Integer;
  sText, sBody: string;
  ClientItem: TClientItem;
begin
  case DefMsg.wIdent of
    SM_ADDUSERSHOPITEM_OK:
      begin                                                                                         // ���Ӱ�̯��Ʒ�ɹ�
        //GameAPI.AddChatBoardString('SM_ADDUSERSHOPITEM_OK', 249, 255);
        if (g_UserShopWaiting.S.Name <> '') then
        begin
          if g_UserShopWaiting.MakeIndex = DefMsg.nRecog then
          begin
            g_UserShopWaiting.S.Reserved1 := DefMsg.wSeries;
            g_UserShopWaiting.S.Price := MakeLong(DefMsg.wParam, DefMsg.wTag);
            AddUserShopItem(g_UserShopWaiting);
          end;
          g_UserShopWaiting.S.Name := '';
          //MessageBox(0,'111','2222',MB_OK);
        end;

      end;
    SM_ADDUSERSHOPITEM_FAIL:
      begin                                                                                         // ���Ӱ�̯��Ʒʧ��
        //GameAPI.AddChatBoardString('SM_ADDUSERSHOPITEM_FAIL', 249, 255);
        if g_UserShopWaiting.S.Name <> '' then
        begin
          AddItemBag(g_UserShopWaiting);
          g_UserShopWaiting.S.Name := '';
        end;
      end;
    SM_DELUSERSHOPITEM_OK:
      begin                                                                                         // ɾ����̯��Ʒ�ɹ�
        //GameAPI.AddChatBoardString('SM_DELUSERSHOPITEM_OK', 249, 255);
        if g_UserShopWaiting.S.Name <> '' then
        begin
          AddItemBag(g_UserShopWaiting);
          g_UserShopWaiting.S.Name := '';
        end;
      end;
    SM_DELUSERSHOPITEM_FAIL:
      begin                                                                                         // ɾ����̯��Ʒʧ��
        //GameAPI.AddChatBoardString('SM_DELUSERSHOPITEM_FAIL', 249, 255);
        if g_UserShopWaiting.S.Name <> '' then
        begin
          AddUserShopItem(g_UserShopWaiting);
          g_UserShopWaiting.S.Name := '';
        end;
      end;
    SM_DELUSERSHOPITEM:
      begin                                                                                         // ɾ����̯��Ʒ
        DelUserShopItem(DefMsg.nRecog);
      end;
    SM_DELREMOTEUSERSHOPITEM:
      begin
        if g_SelectShopItem.MakeIndex = DefMsg.nRecog then
          g_SelectShopItem.S.Name := '';
        DelRemoteUserShopItem(DefMsg.nRecog);
      end;
    SM_SENDSHOPITEM:
      begin                                                                                         // ��̯��Ʒ
        //GameAPI.AddChatBoardString(PChar('SM_SENDSHOPITEM '+sData), 249, 255);
        g_nSelectRecogId := 0;
        g_SelectActor := nil;
        g_SelectShopItem.S.Name := '';
        g_UserShopRemoteMouseItem.S.Name := '';
        FillChar(g_UserShopRemoteItems, SizeOf(g_UserShopRemoteItems), #0);
        FillChar(g_UserShopRemoteItemEffects, SizeOf(g_UserShopRemoteItemEffects), #0);
        sText := sData;

        g_nSelectRecogId := DefMsg.nRecog;
        g_SelectActor := GameAPI.FindActor1(g_nSelectRecogId);
        if GameAPI.MySelf <> g_SelectActor then
        begin
          while True do
          begin
            if sText = '' then break;
            sText := GetValidStr3(sText, sBody, ['/']);
            if sBody = '' then break;
            DecodeBuffer(sBody, @ClientItem);
            if ClientItem.S.Name <> '' then
              AddRemoteUserShopItem(ClientItem);
          end;
          if DUserShopRemoteDlg <> nil then
            DControlAPI.SetVisible(DUserShopRemoteDlg, True);
        end
        else
        begin
          g_nSelectRecogId := 0;
          g_SelectActor := nil;
          g_SelectShopItem.S.Name := '';
          g_UserShopRemoteMouseItem.S.Name := '';
          if DUserShopDlg <> nil then
            DControlAPI.SetVisible(DUserShopDlg, True);
        end;
      end;
    SM_SENDCLOSESHOP:
      begin
        if g_nSelectRecogId = DefMsg.nRecog then
        begin
          GameAPI.AddChatBoardString('��̯�����Ѿ����ߣ�����', 249, 255);
          if DUserShopRemoteDlg <> nil then
            DControlAPI.SetVisible(DUserShopRemoteDlg, False);
        end;
      end;
  end;

  if Assigned(OldHookDecodeMessagePacket) then
    OldHookDecodeMessagePacket(DefMsg, sData);
end;

procedure HookDecodeMessagePacketStop(DefMsg: pTDefaultMessage; sData: PChar);
begin
  case DefMsg.wIdent of
    SM_LOGON:
      begin                                                                                         // ��¼
        g_boInputPriceOK := False;
        g_nMoneyType := 0;
        g_nPrice := 0;
        g_UserShopWaiting.S.Name := '';
        g_UserShopMouseItem.S.Name := '';

        g_nSelectRecogId := 0;
        g_SelectActor := nil;
        g_SelectShopItem.S.Name := '';
        g_UserShopRemoteMouseItem.S.Name := '';
        FillChar(g_UserShopItems, SizeOf(g_UserShopItems), #0);
        FillChar(g_UserShopItemEffects, SizeOf(g_UserShopItemEffects), #0);

        FillChar(g_UserShopRemoteItems, SizeOf(g_UserShopRemoteItems), #0);
        FillChar(g_UserShopRemoteItemEffects, SizeOf(g_UserShopRemoteItemEffects), #0);
      end;
    SM_NEWMAP: ;                                                                                    // �µ�ͼ
    SM_ABILITY: ;                                                                                   // ��ȡ����
    SM_CHANGEMAP: ;                                                                                 // �ı��ͼ

    SM_SOFTCLOSE:
      begin                                                                                         // С��
        if DUserShopDlg <> nil then
          DControlAPI.SetVisible(DUserShopDlg, False);                                              // �رմ���

        if DUserShopRemoteDlg <> nil then
          DControlAPI.SetVisible(DUserShopRemoteDlg, False);                                        // �رմ���

        if DInputPriceDlg <> nil then
          DControlAPI.SetVisible(DInputPriceDlg, False);                                            // �رմ���
      end;
  end;

  if Assigned(OldHookDecodeMessagePacketStop) then
    OldHookDecodeMessagePacketStop(DefMsg, sData);
end;
//------------------------------------------------------------------------------

procedure DUserShopDlgShowOnClick(ObjSelf: TObject; Sender: TObject; X, Y: Integer); stdcall;       // �򿪰�̯����
begin
  if GameAPI.MySelf <> nil then
  begin
    if not ActorAPI.m_boOpenShop(GameAPI.MySelf) then
    begin
      g_boInputPriceOK := False;
      g_nMoneyType := 0;
      g_nPrice := 0;
      g_UserShopWaiting.S.Name := '';
      g_UserShopMouseItem.S.Name := '';
      FillChar(g_UserShopItems, SizeOf(g_UserShopItems), #0);
      FillChar(g_UserShopItemEffects, SizeOf(g_UserShopItemEffects), #0);
    end;
  end;
  if DUserShopDlg <> nil then
    DControlAPI.SetVisible(DUserShopDlg, True);
end;

procedure DUserShopDlgOpenOnClick(ObjSelf: TObject; Sender: TObject; X, Y: Integer); stdcall;       // ��ʼ��̯
var
  sShopName: string;
begin
  if (GameAPI.MySelf <> nil) and (not ActorAPI.m_boOpenShop(GameAPI.MySelf)) then
  begin
    GameAPI.DMessageDlg('����������Ϣ.', [mbOk, mbAbort]);
    sShopName := GameAPI.DlgEditText;
    SocketAPI.SendClientMessage(CM_SENDSHOPNAME, 0, 0, 0, 0, PChar(sShopName));
    SocketAPI.SendClientMessage(CM_STARTSHOPSTALL, 0, 0, 0, 0, nil);
  end;
end;

procedure DUserShopDlgCloseOnClick(ObjSelf: TObject; Sender: TObject; X, Y: Integer); stdcall;      // �رհ�̯����
var
  I: Integer;
begin
  if GameAPI.MySelf <> nil then
  begin
    if not ActorAPI.m_boOpenShop(GameAPI.MySelf) then
    begin
      for I := 0 to Length(g_UserShopItems) - 1 do
      begin
        if g_UserShopItems[I].S.Name <> '' then
        begin
          SocketAPI.SendClientMessage(CM_DELUSERSHOPITEM, g_UserShopItems[I].MakeIndex, 1, 0, 0, nil);
          AddItemBag(g_UserShopItems[I]);
          g_UserShopItems[I].S.Name := '';
        end;
      end;
    end;
  end;
  if DUserShopDlg <> nil then
    DControlAPI.SetVisible(DUserShopDlg, False);                                                    // �رմ���
end;

procedure DUserShopDlgCloseShopOnClick(ObjSelf: TObject; Sender: TObject; X, Y: Integer); stdcall;  // ȡ����̯
var
  I: Integer;
begin
  for I := 0 to Length(g_UserShopItems) - 1 do
  begin
    if g_UserShopItems[I].S.Name <> '' then
    begin
      if (GameAPI.MySelf <> nil) and (not ActorAPI.m_boOpenShop(GameAPI.MySelf)) then
        SocketAPI.SendClientMessage(CM_DELUSERSHOPITEM, g_UserShopItems[I].MakeIndex, 1, 0, 0, nil);
      AddItemBag(g_UserShopItems[I]);
      g_UserShopItems[I].S.Name := '';
    end;
  end;
  if DUserShopDlg <> nil then
    DControlAPI.SetVisible(DUserShopDlg, False);                                                    // �رմ���
  if (GameAPI.MySelf <> nil) and ActorAPI.m_boOpenShop(GameAPI.MySelf) then
    SocketAPI.SendClientMessage(CM_STOPSHOPSTALL, 0, 0, 0, 0, nil);
end;
//-------------------------------------------------------------------------------

procedure DUserShopRemoteDlgCloseOnClick(ObjSelf: TObject; Sender: TObject; X, Y: Integer); stdcall; // �رնԷ��İ�̯����
begin
  if (g_nSelectRecogId <> 0) and (GameAPI.MySelf <> nil) and (ActorAPI.m_nRecogId(GameAPI.MySelf)^ <> g_nSelectRecogId) then
    SocketAPI.SendClientMessage(CM_SENDCLOSESHOP, g_nSelectRecogId, 0, 0, 0, nil);

  g_nSelectRecogId := 0;
  g_SelectActor := nil;
  g_SelectShopItem.S.Name := '';
  if DUserShopRemoteDlg <> nil then
    DControlAPI.SetVisible(DUserShopRemoteDlg, False);                                              // �رմ���
end;

procedure DUserShopRemoteDlgOnStopPaint(ObjSelf: TObject; Sender: TObject); stdcall;                // ���� �¼�
var
  sText: string;
  vtRect: TRect;
begin
  if (g_nSelectRecogId <> 0) and (DUserShopRemoteDlg <> nil) then
  begin
    g_SelectActor := GameAPI.FindActor1(g_nSelectRecogId);
    if g_SelectActor <> nil then
    begin
      sText := ActorAPI.m_sUserName(g_SelectActor) + ' �ĸ����̵�';
      DControlAPI.VirtualRect(DUserShopRemoteDlg, vtRect);
      DrawAPI.TextOut(DrawAPI.CurrentFont, vtRect.Left + 14, vtRect.Top + 9, PChar(sText), clLime, Blend_Default);
    end
    else
    begin
      if DUserShopRemoteDlg <> nil then
        DControlAPI.SetVisible(DUserShopRemoteDlg, False);                                          // �رմ���
    end;
  end;
end;
//------------------------------------------------------------------------------

procedure DInputPriceDlgOnShow(ObjSelf: TObject; Sender: TObject); stdcall;
var
  I: Integer;
  D: TDxControl;
begin
  g_boInputPriceOK := False;
  if DInputPriceDlg <> nil then
  begin
    for I := 0 to DControlAPI.ControlCount(DInputPriceDlg) - 1 do
    begin
      D := DControlAPI.Controls(DInputPriceDlg, I);
      if DControlAPI.InterfaceType(D) = t_Edit then
      begin
        DEditAPI.SetValue(D, g_nPrice);
        break;
      end;
    end;
    for I := 0 to DControlAPI.ControlCount(DInputPriceDlg) - 1 do
    begin
      D := DControlAPI.Controls(DInputPriceDlg, I);
      if (DControlAPI.InterfaceType(D) = t_Button) and (DButtonAPI.Style(D) = bsRadio) and (DControlAPI.Tag(D) = g_nMoneyType) then
      begin
        DButtonAPI.SetChecked(D, True);
        break;
      end;
    end;
  end;
end;

procedure DInputPriceDlgCloseOnClick(ObjSelf: TObject; Sender: TObject; X, Y: Integer); stdcall;    // �ر�DInputPriceDlg����
begin
  g_boInputPriceOK := False;
  if DInputPriceDlg <> nil then
    DControlAPI.SetVisible(DInputPriceDlg, False);                                                  // �رմ���
end;

procedure DInputPriceDlgOKOnClick(ObjSelf: TObject; Sender: TObject; X, Y: Integer); stdcall;
begin
  if g_nPrice <= 0 then
  begin
    GameAPI.AddChatBoardString('����������Ʒ�۸�', 249, 255);
    Exit;
  end;
  g_boInputPriceOK := True;
  if DInputPriceDlg <> nil then
    DControlAPI.SetVisible(DInputPriceDlg, False);                                                  // �رմ���
end;

procedure DInputPriceDlgCancelOnClick(ObjSelf: TObject; Sender: TObject; X, Y: Integer); stdcall;
begin
  g_boInputPriceOK := False;
  if DInputPriceDlg <> nil then
    DControlAPI.SetVisible(DInputPriceDlg, False);                                                  // �رմ���
end;
//-------------------------------------------------------------------------------

procedure DInputPriceDlgRadioOnClick(ObjSelf: TObject; Sender: TObject; X, Y: Integer); stdcall;
begin
  g_nMoneyType := DControlAPI.Tag(Sender);
end;

procedure DInputPriceDlgEditOnChange(ObjSelf: TObject; Sender: TObject); stdcall;
begin
  g_nPrice := DEditAPI.Value(Sender);
end;

procedure DBuyShopItemOnClick(ObjSelf: TObject; Sender: TObject; X, Y: Integer); stdcall;           // �����̯��Ʒ
begin
  if (g_nSelectRecogId <> 0) and (g_SelectShopItem.S.Name <> '') then
  begin
    if g_SelectShopItem.S.Reserved1 = 0 then
    begin
      if GameAPI.GameGold < g_SelectShopItem.S.Price then
      begin
        GameAPI.AddChatBoardString(PChar(GameAPI.GameGoldName + '���㣬�޷����򣡣���'), 249, 255);
        Exit;
      end;
    end
    else
    begin
      if GameAPI.Gold < g_SelectShopItem.S.Price then
      begin
        GameAPI.AddChatBoardString(PChar('��Ҳ��㣬�޷����򣡣���'), 249, 255);
        Exit;
      end;
    end;
    SocketAPI.SendClientMessage(CM_BUYUSERSHOPITEM, g_nSelectRecogId, LoWord(g_SelectShopItem.MakeIndex), HiWord(g_SelectShopItem.MakeIndex), 0, nil);
  end;
end;

//------------------------------------------------------------------------------

procedure DUserShopDlgOnGridMove(ObjSelf: TObject; Sender: TObject; ACol, ARow: Integer; Shift: TShiftState); stdcall; // �����ƶ��¼� �Լ�
var
  nIdx: Integer;
  vtRect: TRect;
begin
  nIdx := ACol + ARow * DGridAPI.ColCount(Sender);
  if (nIdx in [0..19]) and (g_UserShopItems[nIdx].s.Name <> '') then
  begin
    g_UserShopMouseItem := g_UserShopItems[nIdx];
    DControlAPI.VirtualRect(Sender, vtRect);
    GameAPI.ShowMouseItemInfo(GameAPI.MySelf, @g_UserShopItems[nIdx],
      vtRect.Left + ACol * DGridAPI.ColWidth(Sender),
      vtRect.Top + +(ARow + 1) * DGridAPI.RowHeight(Sender), True, 0, False, False);
  end
  else
  begin
    g_UserShopMouseItem.S.Name := '';
    GameAPI.ClearHint;
  end;
end;
//------------------------------------------------------------------------------

procedure ItemBagGridSelect(ObjSelf: TObject; Sender: TObject; ACol, ARow: Integer; Button: TMouseButton; Shift: TShiftState); stdcall; // ����ѡ����Ʒ�¼�
var
  nIdx: Integer;
  vtRect: TRect;
begin
  if GameAPI.boItemMoving and (GameAPI.MovingItem.ItemType = mtUserShopItem) then
  begin
    if (GameAPI.MySelf <> nil) and (not ActorAPI.m_boOpenShop(GameAPI.MySelf)) then
    begin
      nIdx := ACol + ARow * DGridAPI.ColCount(Sender) + 6;
      if nIdx in [6..46 - 1] then
      begin
        g_UserShopWaiting := GameAPI.MovingItem.Item;
        GameAPI.SetItemMoving(False);
        GameAPI.MovingItem.Item.S.Name := '';
        GameAPI.MovingItem.ItemType := mtBagItem;
        SocketAPI.SendClientMessage(CM_DELUSERSHOPITEM, g_UserShopWaiting.MakeIndex, 0, 0, 0, nil);
      end;
    end;
  end
  else if @OldItemBagGridSelect <> nil then
    OldItemBagGridSelect(GameAPI.ClassDlg, Sender, ACol, ARow, Button, Shift);
end;

procedure DUserShopDlgOnGridSelect(ObjSelf: TObject; Sender: TObject; ACol, ARow: Integer; Button: TMouseButton; Shift: TShiftState); stdcall; // ��̯����ѡ���¼� �Լ�
var
  nIdx: Integer;
  temp: TClientItem;
begin
  if (g_UserShopWaiting.S.Name = '') and (GameAPI.MySelf <> nil) and (not ActorAPI.m_boOpenShop(GameAPI.MySelf)) then
  begin
    nIdx := ACol + ARow * DGridAPI.ColCount(Sender);
    if nIdx in [0..19] then
    begin
      if not GameAPI.boItemMoving then
      begin
        if g_UserShopItems[nIdx].S.Name <> '' then
        begin
          GameAPI.SetItemMoving(True);
          GameAPI.MovingItem.Index := nIdx;
          GameAPI.MovingItem.Item := g_UserShopItems[nIdx];
          GameAPI.MovingItem.ItemType := mtUserShopItem;
          g_UserShopItems[nIdx].S.Name := '';
          GameAPI.ItemClickSound(GameAPI.MovingItem.Item.S);
        end;
      end
      else
      begin
        if GameAPI.MovingItem.ItemType in [mtBagItem, mtUserShopItem] then
        begin
          GameAPI.ItemClickSound(GameAPI.MovingItem.Item.S);
          if GameAPI.MovingItem.ItemType = mtBagItem then
          begin
            GameAPI.SetItemMoving(False);
            g_UserShopWaiting := GameAPI.MovingItem.Item;
            GameAPI.MovingItem.Item.S.Name := '';
            if DInputPriceDlg <> nil then
            begin
              g_boInputPriceOK := False;
              DWindowAPI.ShowModalA(DInputPriceDlg);
              if g_boInputPriceOK and (g_nPrice > 0) then
              begin
                SocketAPI.SendClientMessage(CM_ADDUSERSHOPITEM, g_UserShopWaiting.MakeIndex, LoWord(g_nPrice), HiWord(g_nPrice), g_nMoneyType, nil);
                //GameAPI.AddChatBoardString(PChar('g_nPrice 1:' + IntToStr(g_nPrice)), 249, 255);
              end
              else
              begin
                AddItemBag(g_UserShopWaiting);
                g_UserShopWaiting.S.Name := '';
                //GameAPI.AddChatBoardString(PChar('g_nPrice 2:' + IntToStr(g_nPrice)), 249, 255);
              end;
            end;
          end
          else
          begin
            AddUserShopItem(GameAPI.MovingItem.Item);
            GameAPI.MovingItem.Item.S.Name := '';
            GameAPI.SetItemMoving(False);
          end;
        end;
      end;
    end;
  end;
end;
//------------------------------------------------------------------------------

procedure DUserShopDlgOnGridPaint(ObjSelf: TObject; Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState); stdcall; // ��̯��������¼� �Լ�
var
  nIdx: Integer;
  vtRect, PaintRect: TRect;
  sText: string;
begin
  nIdx := ACol + ARow * DGridAPI.ColCount(Sender);
  if nIdx in [0..19] then
  begin
    PaintRect := Rect;
    PaintRect.Right := Rect.Left + DGridAPI.ColWidth(Sender);
    PaintRect.Bottom := Rect.Top + DGridAPI.RowHeight(Sender);
    DGridAPI.DrawGridItem(PaintRect, @g_UserShopItems[nIdx], @g_UserShopItemEffects[nIdx]);

    if g_UserShopMouseItem.S.Name <> '' then
    begin
      DControlAPI.VirtualRect(DUserShopDlg, vtRect);
      DrawAPI.TextOut(DrawAPI.CurrentFont, vtRect.Left + 90, vtRect.Top + 176, PChar(string(g_UserShopMouseItem.S.Name)), clWhite, Blend_Default);
      if g_UserShopMouseItem.S.Reserved1 = 0 then
      begin
        sText := IntToStr(g_UserShopMouseItem.S.Price) + GameAPI.GameGoldName;
      end
      else
      begin
        sText := IntToStr(g_UserShopMouseItem.S.Price) + '���';
      end;
      DrawAPI.TextOut(DrawAPI.CurrentFont, vtRect.Left + 90, vtRect.Top + 206, PChar(sText), clWhite, Blend_Default);
    end;
  end;
end;

//------------------------------------------------------------------------------

procedure DUserShopRemoteDlgOnGridMove(ObjSelf: TObject; Sender: TObject; ACol, ARow: Integer; Shift: TShiftState); stdcall; // �����ƶ��¼� �Է�
var
  nIdx: Integer;
  vtRect: TRect;
begin
  nIdx := ACol + ARow * DGridAPI.ColCount(Sender);
  if (nIdx in [0..19]) and (g_UserShopRemoteItems[nIdx].s.Name <> '') then
  begin
    g_UserShopRemoteMouseItem := g_UserShopRemoteItems[nIdx];
    DControlAPI.VirtualRect(Sender, vtRect);
    GameAPI.ShowMouseItemInfo(GameAPI.MySelf, @g_UserShopRemoteItems[nIdx],
      vtRect.Left + ACol * DGridAPI.ColWidth(Sender),
      vtRect.Top + +(ARow + 1) * DGridAPI.RowHeight(Sender), True, 0, False, False);
  end
  else
  begin
    g_UserShopRemoteMouseItem.S.Name := '';
    GameAPI.ClearHint;
  end;
end;
//------------------------------------------------------------------------------

procedure DUserShopRemoteDlgOnGridSelect(ObjSelf: TObject; Sender: TObject; ACol, ARow: Integer; Button: TMouseButton; Shift: TShiftState); stdcall; // ��̯����ѡ���¼� �Է�
var
  nIdx: Integer;
begin
  if (GameAPI.MySelf <> nil) and (g_nSelectRecogId <> 0) then
  begin
    if (g_nSelectRecogId <> 0) then
    begin
      g_SelectActor := GameAPI.FindActor1(g_nSelectRecogId);
      if (g_SelectActor <> nil) and (ActorAPI.m_boOpenShop(g_SelectActor)) then
      begin
        nIdx := ACol + ARow * DGridAPI.ColCount(Sender);
        if (nIdx in [0..19]) and (g_UserShopRemoteItems[nIdx].s.Name <> '') then
        begin
          g_SelectShopItem := g_UserShopRemoteItems[nIdx];
          Exit;
        end;
      end;
    end;
  end;
  g_SelectShopItem.S.Name := '';
end;
//------------------------------------------------------------------------------

procedure DUserShopRemoteDlgOnGridPaint(ObjSelf: TObject; Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState); stdcall; // ��̯��������¼� �Է�
var
  nIdx: Integer;
  PaintRect: TRect;
  sText: string;
  vtRect: TRect;
  SrcRect: TRect;
  Texture: TTexture;
  nX, nY: Integer;
  ClientItem: TClientItem;
begin
  nIdx := ACol + ARow * DGridAPI.ColCount(Sender);
  if nIdx in [0..19] then
  begin
    PaintRect := Rect;
    PaintRect.Right := Rect.Left + DGridAPI.ColWidth(Sender);
    PaintRect.Bottom := Rect.Top + DGridAPI.RowHeight(Sender);
    DGridAPI.DrawGridItem(PaintRect, @g_UserShopRemoteItems[nIdx], @g_UserShopRemoteItemEffects[nIdx]);

    if (g_UserShopRemoteItems[nIdx].S.Name <> '') and (g_SelectShopItem.S.Name <> '') and (g_SelectShopItem.MakeIndex = g_UserShopRemoteItems[nIdx].MakeIndex) and (Prguse3 <> 0) then
    begin                                                                                           // ����ѡ��
      Texture := ImagesAPI.Read(Prguse3, 602, nX, nY);
      if Texture <> nil then
      begin
        SrcRect.Left := 0;
        SrcRect.Top := 0;
        SrcRect.Right := TextureAPI.Width(Texture);
        SrcRect.Bottom := TextureAPI.Height(Texture);
        DrawAPI.DrawBlend(PaintRect.Left + (DGridAPI.ColWidth(Sender) - TextureAPI.Width(Texture)) div 2,
          PaintRect.Top + (DGridAPI.RowHeight(Sender) - TextureAPI.Height(Texture)) div 2, SrcRect, Texture);
      end;
    end;

    if g_UserShopRemoteMouseItem.S.Name <> '' then
      ClientItem := g_UserShopRemoteMouseItem
    else if g_SelectShopItem.S.Name <> '' then
      ClientItem := g_SelectShopItem
    else
      ClientItem.S.Name := '';

    if ClientItem.S.Name <> '' then
    begin
      DControlAPI.VirtualRect(DUserShopRemoteDlg, vtRect);
      DrawAPI.TextOut(DrawAPI.CurrentFont, vtRect.Left + 90, vtRect.Top + 176, PChar(string(ClientItem.S.Name)), clWhite, Blend_Default);
      if ClientItem.S.Reserved1 = 0 then
      begin
        sText := IntToStr(ClientItem.S.Price) + GameAPI.GameGoldName;
      end
      else
      begin
        sText := IntToStr(ClientItem.S.Price) + '���';
      end;

      DrawAPI.TextOut(DrawAPI.CurrentFont, vtRect.Left + 90, vtRect.Top + 206, PChar(sText), clWhite, Blend_Default);
    end;
  end;
end;

procedure HookInitialize(Handle: THandle; FirstInit: Boolean; WindowMode: Boolean; ScreenWidth, ScreenHeight: Word; ClientVersion: TClientVersion);
var
  I: Integer;
  D: TDxControl;
  Images: Integer;
begin
  g_WindowMode := WindowMode;
  g_ScreenWidth := ScreenWidth;
  g_ScreenHeight := ScreenHeight;
  g_ClientVersion := ClientVersion;
  if FirstInit then
  begin                                                                                             // ��һ�μ���
    NewopUI := ImagesAPI.GetHandle(PChar(string(GameAPI.ClientPath) + 'Data\NewopUI.pak'));         // ��ȡWIL���
    Prguse3 := ImagesAPI.GetHandle(PChar(string(GameAPI.ClientPath) + 'Data\Prguse3.wil'));         // ��ȡWIL���
    Images := ImagesAPI.GetHandle(PChar(string(GameAPI.ClientPath) + 'Data\Prguse.wil'));           // ��ȡWIL���
    DUserShopDlg := DControlAPI.Create(nil, t_Form);                                                // ����һ������
    if DUserShopDlg <> nil then
    begin
      DControlAPI.SetVisible(DUserShopDlg, False);                                                  // ����
      DControlAPI.SetImages(DUserShopDlg, NewopUI);                                                 // ���ô���ʹ��WIL
      DControlAPI.SetDefaultImageIndex(DUserShopDlg, 181);                                          // ���ô����ͼƬ���
      DControlAPI.SetAutoSize(DUserShopDlg, True);                                                  // �Զ������ߴ�
      DControlAPI.SetLeft(DUserShopDlg, g_ScreenWidth - DControlAPI.Width(DUserShopDlg) - 50);
      DControlAPI.SetTop(DUserShopDlg, 50);
      DControlAPI.SetOnMouseMove(@OnMouseMove, DUserShopDlg);


      D := DControlAPI.Create(DUserShopDlg, t_Button);                                              // ��DUserShopDlg�����ϴ����رհ�ť
      if D <> nil then
      begin
        DControlAPI.SetImages(D, Images);                                                           // ���ð�ťʹ��WIL
        DControlAPI.SetMouseDownImageIndex(D, 64);                                                  // ���ð�ť����ͼƬ���
        DControlAPI.SetLeft(D, DControlAPI.Width(DUserShopDlg) - DControlAPI.Width(D) - 1);
        DControlAPI.SetTop(D, 3);
        DControlAPI.SetOnClick(@DUserShopDlgCloseOnClick, D);
      end;

      D := DControlAPI.Create(DUserShopDlg, t_Button);                                              // ��DUserShopDlg�����ϴ�����̯��ť
      if D <> nil then
      begin
        DControlAPI.SetImages(D, NewopUI);                                                          // ���ð�ťʹ��WIL
        DControlAPI.SetDefaultImageIndex(D, 182);                                                   // ���ð�ť��ͼƬ���
        DControlAPI.SetMouseDownImageIndex(D, 183);                                                 // ���ð�ť����ͼƬ���
        DControlAPI.SetLeft(D, 50);
        DControlAPI.SetTop(D, DControlAPI.Height(DUserShopDlg) - DControlAPI.Height(D) - 8);
        DControlAPI.SetOnClick(@DUserShopDlgOpenOnClick, D);
      end;

      D := DControlAPI.Create(DUserShopDlg, t_Button);                                              // ��DUserShopDlg�����ϴ���ȡ����̯��ť
      if D <> nil then
      begin
        DControlAPI.SetImages(D, NewopUI);                                                          // ���ð�ťʹ��WIL
        DControlAPI.SetDefaultImageIndex(D, 186);                                                   // ���ð�ť��ͼƬ���
        DControlAPI.SetMouseDownImageIndex(D, 187);                                                 // ���ð�ť����ͼƬ���
        DControlAPI.SetLeft(D, DControlAPI.Width(DUserShopDlg) - DControlAPI.Width(D) - 50);
        DControlAPI.SetTop(D, DControlAPI.Height(DUserShopDlg) - DControlAPI.Height(D) - 8);
        DControlAPI.SetOnClick(@DUserShopDlgCloseShopOnClick, D);
      end;

      D := DControlAPI.Create(DUserShopDlg, t_Grid);                                                // ��DUserShopDlg�����ϴ�����Ʒ����
      if D <> nil then
      begin
        DControlAPI.SetLeft(D, 12);
        DControlAPI.SetTop(D, 33);
        DGridAPI.SetColCount(D, 5);                                                                 // ��������
        DGridAPI.SetRowCount(D, 4);                                                                 // ��������
        DGridAPI.SetColWidth(D, 37);                                                                // �����п�
        DGridAPI.SetRowHeight(D, 32);                                                               // �������

        DGridAPI.SetOnGridSelect(@DUserShopDlgOnGridSelect, D);
        DGridAPI.SetOnGridMouseMove(@DUserShopDlgOnGridMove, D);
        DGridAPI.SetOnGridPaint(@DUserShopDlgOnGridPaint, D);
      end;
    end;
//------------------------------------------------------------------------------
    DUserShopRemoteDlg := DControlAPI.Create(nil, t_Form);                                          // ����DUserShopRemoteDlg����
    if DUserShopRemoteDlg <> nil then
    begin
      DControlAPI.SetVisible(DUserShopRemoteDlg, False);                                            // ����
      DControlAPI.SetImages(DUserShopRemoteDlg, NewopUI);                                           // ���ô���ʹ��WIL
      DControlAPI.SetDefaultImageIndex(DUserShopRemoteDlg, 181);                                    // ���ô����ͼƬ���
      DControlAPI.SetAutoSize(DUserShopRemoteDlg, True);                                            // �Զ������ߴ�
      DControlAPI.SetLeft(DUserShopRemoteDlg, 50);
      DControlAPI.SetTop(DUserShopRemoteDlg, 50);
      DControlAPI.SetOnStopPaint(@DUserShopRemoteDlgOnStopPaint, DUserShopRemoteDlg);
      DControlAPI.SetOnMouseMove(@OnMouseMove, DUserShopRemoteDlg);

      D := DControlAPI.Create(DUserShopRemoteDlg, t_Button);                                        // ��DUserShopRemoteDlg�����ϴ����رհ�ť
      if D <> nil then
      begin
        DControlAPI.SetImages(D, Images);                                                           // ���ð�ťʹ��WIL
        DControlAPI.SetMouseDownImageIndex(D, 64);                                                  // ���ð�ť����ͼƬ���
        DControlAPI.SetLeft(D, DControlAPI.Width(DUserShopRemoteDlg) - DControlAPI.Width(D) - 1);
        DControlAPI.SetTop(D, 3);
        DControlAPI.SetOnClick(@DUserShopRemoteDlgCloseOnClick, D);
      end;

      D := DControlAPI.Create(DUserShopRemoteDlg, t_Button);                                        // ��DUserShopDlg�����ϴ�������ť
      if D <> nil then
      begin
        DControlAPI.SetImages(D, NewopUI);                                                          // ���ð�ťʹ��WIL
        DControlAPI.SetDefaultImageIndex(D, 184);                                                   // ���ð�ť��ͼƬ���
        DControlAPI.SetMouseDownImageIndex(D, 185);                                                 // ���ð�ť����ͼƬ���
        DControlAPI.SetLeft(D, (DControlAPI.Width(DUserShopRemoteDlg) - DControlAPI.Width(D)) div 2);
        DControlAPI.SetTop(D, DControlAPI.Height(DUserShopRemoteDlg) - DControlAPI.Height(D) - 8);
        DControlAPI.SetOnClick(@DBuyShopItemOnClick, D);
      end;

      D := DControlAPI.Create(DUserShopRemoteDlg, t_Grid);                                          // ��DUserShopRemoteDlg�����ϴ�����Ʒ����
      if D <> nil then
      begin
        DControlAPI.SetLeft(D, 12);
        DControlAPI.SetTop(D, 33);
        DGridAPI.SetColCount(D, 5);                                                                 //��������
        DGridAPI.SetRowCount(D, 4);                                                                 //��������
        DGridAPI.SetColWidth(D, 37);                                                                //�����п�
        DGridAPI.SetRowHeight(D, 32);                                                               //�������

        DGridAPI.SetOnGridSelect(@DUserShopRemoteDlgOnGridSelect, D);
        DGridAPI.SetOnGridMouseMove(@DUserShopRemoteDlgOnGridMove, D);
        DGridAPI.SetOnGridPaint(@DUserShopRemoteDlgOnGridPaint, D);
      end;
    end;

//------------------------------------------------------------------------------
    DInputPriceDlg := DControlAPI.Create(nil, t_Form);                                              //����DInputPriceDlg����
    if DInputPriceDlg <> nil then
    begin
      DControlAPI.SetVisible(DInputPriceDlg, False);                                                //����
      DControlAPI.SetImages(DInputPriceDlg, NewopUI);                                               //���ô���ʹ��WIL
      DControlAPI.SetDefaultImageIndex(DInputPriceDlg, 180);                                        //���ô����ͼƬ���
      DControlAPI.SetAutoSize(DInputPriceDlg, True);                                                //�Զ������ߴ�
      DControlAPI.SetLeft(DInputPriceDlg, (g_ScreenWidth - DControlAPI.Width(DInputPriceDlg)) div 2);
      DControlAPI.SetTop(DInputPriceDlg, (g_ScreenHeight - DControlAPI.Height(DInputPriceDlg)) div 2);
      DControlAPI.SetOnMouseMove(@OnMouseMove, DInputPriceDlg);
      DControlAPI.SetOnShow(@DInputPriceDlgOnShow, DInputPriceDlg);

      D := DControlAPI.Create(DInputPriceDlg, t_Button);                                            //��DInputPriceDlg�����ϴ����رհ�ť
      if D <> nil then
      begin
        DControlAPI.SetImages(D, Images);                                                           //���ð�ťʹ��WIL
        DControlAPI.SetMouseDownImageIndex(D, 64);                                                  //���ð�ť����ͼƬ���
        DControlAPI.SetLeft(D, DControlAPI.Width(DInputPriceDlg) - DControlAPI.Width(D) - 2);
        DControlAPI.SetTop(D, 2);
        DControlAPI.SetOnClick(@DInputPriceDlgCloseOnClick, D);
      end;

      D := DControlAPI.Create(DInputPriceDlg, t_Button);                                            //��DInputPriceDlg�����ϴ���ȷ����ť
      if D <> nil then
      begin
        DControlAPI.SetImages(D, NewopUI);                                                          //���ð�ťʹ��WIL
        DControlAPI.SetDefaultImageIndex(D, 188);                                                   //���ð�ť��ͼƬ���
        DControlAPI.SetMouseDownImageIndex(D, 189);                                                 //���ð�ť����ͼƬ���
        DControlAPI.SetLeft(D, 88);
        DControlAPI.SetTop(D, 105);
        DControlAPI.SetOnClick(@DInputPriceDlgOKOnClick, D);
      end;

      D := DControlAPI.Create(DInputPriceDlg, t_Button);                                            //��DInputPriceDlg�����ϴ���ȡ����ť
      if D <> nil then
      begin
        DControlAPI.SetImages(D, NewopUI);                                                          //���ð�ťʹ��WIL
        DControlAPI.SetDefaultImageIndex(D, 190);                                                   //���ð�ť��ͼƬ���
        DControlAPI.SetMouseDownImageIndex(D, 191);                                                 //���ð�ť����ͼƬ���
        DControlAPI.SetLeft(D, 148);
        DControlAPI.SetTop(D, 105);
        DControlAPI.SetOnClick(@DInputPriceDlgCancelOnClick, D);
      end;

      D := DControlAPI.Create(DInputPriceDlg, t_Button);                                            //��DInputPriceDlg�����ϴ�����ť ���
      if D <> nil then
      begin
        DControlAPI.SetImages(D, NewopUI);                                                          //���ð�ťʹ��WIL
        DControlAPI.SetDefaultImageIndex(D, 192);                                                   //���ð�ť��ͼƬ���
        DControlAPI.SetMouseDownImageIndex(D, 193);                                                 //���ð�ť����ͼƬ���
        DControlAPI.SetLeft(D, 110);
        DControlAPI.SetTop(D, 70);
        DControlAPI.SetTag(D, 1);
        DControlAPI.SetAutoSize(D, False);
        DControlAPI.SetWidth(D, 74);
        DButtonAPI.SetStyle(D, bsRadio);
        DControlAPI.SetOnClick(@DInputPriceDlgRadioOnClick, D);
      end;

      D := DControlAPI.Create(DInputPriceDlg, t_Button);                                            //��DInputPriceDlg�����ϴ�����ť Ԫ��
      if D <> nil then
      begin
        DControlAPI.SetImages(D, NewopUI);                                                          //���ð�ťʹ��WIL
        DControlAPI.SetDefaultImageIndex(D, 192);                                                   //���ð�ť��ͼƬ���
        DControlAPI.SetMouseDownImageIndex(D, 193);                                                 //���ð�ť����ͼƬ���
        DControlAPI.SetLeft(D, 20);
        DControlAPI.SetTop(D, 70);
        DControlAPI.SetTag(D, 0);
        DControlAPI.SetAutoSize(D, False);
        DControlAPI.SetWidth(D, 74);
        DButtonAPI.SetStyle(D, bsRadio);
        DButtonAPI.SetChecked(D, True);
        DControlAPI.SetOnClick(@DInputPriceDlgRadioOnClick, D);
      end;

      D := DControlAPI.Create(DInputPriceDlg, t_Edit);                                              //��DInputPriceDlg�����ϴ��������
      if D <> nil then
      begin
        DControlAPI.SetLeft(D, 90);
        DControlAPI.SetTop(D, 40);
        DControlAPI.SetWidth(D, 94);
        DControlAPI.SetDrawBorder(D, False);
        DControlAPI.SetTransparent(D, True);
        DEditAPI.SetInValue(D, vInteger);
        DEditAPI.SetMaxLength(D, 9);
        DEditAPI.SetOnChange(@DInputPriceDlgEditOnChange, D);
      end;
    end;


//==============================================================================
//===================���ҵ�¼���ڲ�һ����ť���޸Ĵ˰�ť�ĵ����¼�===============
//==============================================================================
    for I := 0 to DControlAPI.ControlCount(GameInterfaceAPI.DBottomRight) - 1 do
    begin                                                                                           //���ҽ������ϵĸ����̵갴ť
      D := DControlAPI.Controls(GameInterfaceAPI.DBottomRight, I);
      if string(DControlAPI.Name(D)) = 'DOpenShop' then
      begin                                                                                         //�����̵갴ť
        //MessageBox(0,'111','222',mb_ok);
        DControlAPI.SetOnClick(@DUserShopDlgShowOnClick, D);
        break;
      end;
    end;

    for I := 0 to DControlAPI.ControlCount(GameInterfaceAPI.DItemBag) - 1 do
    begin                                                                                           //���Ұ���������ؼ��滻������¼�
      D := DControlAPI.Controls(GameInterfaceAPI.DItemBag, I);
      if DControlAPI.InterfaceType(D) = t_Grid then
      begin
        OldItemBagGridSelect := DGridAPI.OnGridSelect(D);                                           //��ȡԭ���ĺ���
        DGridAPI.SetOnGridSelect(@ItemBagGridSelect, D);                                            //�º����滻
        break;
      end;
    end;
  end;
  if Assigned(OldHookInitialize) then
    OldHookInitialize(Handle, FirstInit, WindowMode, ScreenWidth, ScreenHeight, ClientVersion);
end;
//------------------------------------------------------------------------------

procedure HookFinalize();
begin
  if Assigned(OldHookFinalize) then
    OldHookFinalize();
end;

end.

