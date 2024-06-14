unit ClientAPI;

interface

uses
  ClientType;

type
  TImagesAPI = record
    GetHandle: function(const FileName: PChar): THandle; stdcall;                                   //获取WIL文件
    Count: function(FileHandle: THandle): Integer; stdcall;                                         //wil图片数
    Read: function(FileHandle: THandle; Index: Integer; var X, Y: Integer): TTexture; stdcall;      //获取图片纹理
    Clear: procedure(FileHandle: THandle); stdcall;
  end;
  pTImagesAPI = ^TImagesAPI;

  TTextureAPI = record
    Width: function(Texture: TTexture): Integer; stdcall;
    Height: function(Texture: TTexture): Integer; stdcall;
    Pixels: function(Texture: TTexture; X, Y: Integer): Cardinal; stdcall;
    Lock: function(Texture: TTexture; Rect: TRect; out Bits: Pointer; out Pitch: Integer; ReadOnly: Boolean): Boolean; stdcall;
    Unlock: procedure(Texture: TTexture); stdcall;
  end;
  pTTextureAPI = ^TTextureAPI;

  TDControl = record
    Create: function(Parent: TDxControl; InterfaceType: TGuiType): TDxControl; stdcall;
    InterfaceType: function(D: TDxControl): TGuiType; stdcall;                                      //类型
    Name: function(D: TDxControl): PChar; stdcall;                                                  //名称
    Left: function(D: TDxControl): Integer; stdcall;                                                //左
    Top: function(D: TDxControl): Integer; stdcall;                                                 //上
    Width: function(D: TDxControl): Integer; stdcall;                                               //宽
    Height: function(D: TDxControl): Integer; stdcall;                                              //高
    Tag: function(D: TDxControl): Integer; stdcall;                                                 //标志
    Visible: function(D: TDxControl): Boolean; stdcall;                                             //是否可见
    Enabled: function(D: TDxControl): Boolean; stdcall;                                             //是否可用
    Floating: function(D: TDxControl): Boolean; stdcall;                                            //是否可以移动
    ParentMove: function(D: TDxControl): Boolean; stdcall;                                          //Parent是否可以移动
    EnableFocus: function(D: TDxControl): Boolean; stdcall;                                         //是否可以设置焦点
    AutoSize: function(D: TDxControl): Boolean; stdcall;                                            //是否根据图片尺寸自动调整尺寸
    DrawBorder: function(D: TDxControl): Boolean; stdcall;                                          //绘制边框
    Caption: function(D: TDxControl): PChar; stdcall;                                               //标题
    Alignment: function(D: TDxControl): TAlignment; stdcall;                                        //标题显示位置
    Transparent: function(D: TDxControl): Boolean; stdcall;                                         //是否透明
    BackgroundColor: function(D: TDxControl): TColor; stdcall;                                      //背景色
    PopupMenu: function(D: TDxControl): TDxControl; stdcall;                                        //弹出菜单
    VisibleRect: procedure(D: TDxControl; var Value: TRect); stdcall;                               //组件可见矩形
    VirtualRect: procedure(D: TDxControl; var Value: TRect); stdcall;                               //组件真正矩形

    OnShow: function(D: TDxControl): Pointer; stdcall;                                              //显示触发事件
    OnHide: function(D: TDxControl): Pointer; stdcall;                                              //隐藏触发事件
    OnKeyDown: function(D: TDxControl): Pointer; stdcall;                                           //按键按下事件
    OnKeyPress: function(D: TDxControl): Pointer; stdcall;                                          //按键事件
    OnKeyUp: function(D: TDxControl): Pointer; stdcall;                                             //按键弹起事件
    OnClick: function(D: TDxControl): Pointer; stdcall;                                             //单击事件
    OnDblClick: function(D: TDxControl): Pointer; stdcall;                                          //双击事件
    OnMouseDown: function(D: TDxControl): Pointer; stdcall;                                         //鼠标按下事件
    OnMouseMove: function(D: TDxControl): Pointer; stdcall;                                         //鼠标移动事件
    OnMouseUp: function(D: TDxControl): Pointer; stdcall;                                           //鼠标弹起事件
    OnMouseEnter: function(D: TDxControl): Pointer; stdcall;                                        //鼠标进入事件
    OnMouseLeave: function(D: TDxControl): Pointer; stdcall;                                        //鼠标离开事件
    OnInRealArea: function(D: TDxControl): Pointer; stdcall;                                        //检测鼠标坐标事件
    OnPaint: function(D: TDxControl): Pointer; stdcall;                                             //绘制事件
    OnStartPaint: function(D: TDxControl): Pointer; stdcall;                                        //开始绘制事件
    OnStartSubPaint: function(D: TDxControl): Pointer; stdcall;                                     //开始绘制子控件事件
    OnStopPaint: function(D: TDxControl): Pointer; stdcall;                                         //绘制结束事件
    OnPress: function(D: TDxControl): Pointer; stdcall;                                             //运行事件

//------------------------------------------------------------------------------
    SetName: procedure(D: TDxControl; Value: PChar); stdcall;                                       //名称
    SetLeft: procedure(D: TDxControl; Value: Integer); stdcall;
    SetTop: procedure(D: TDxControl; Value: Integer); stdcall;
    SetWidth: procedure(D: TDxControl; Value: Integer); stdcall;
    SetHeight: procedure(D: TDxControl; Value: Integer); stdcall;
    SetTag: procedure(D: TDxControl; Value: Integer); stdcall;
    SetVisible: procedure(D: TDxControl; Value: Boolean); stdcall;
    SetEnabled: procedure(D: TDxControl; Value: Boolean); stdcall;
    SetFloating: procedure(D: TDxControl; Value: Boolean); stdcall;
    SetParentMove: procedure(D: TDxControl; Value: Boolean); stdcall;
    SetEnableFocus: procedure(D: TDxControl; Value: Boolean); stdcall;
    SetAutoSize: procedure(D: TDxControl; Value: Boolean); stdcall;
    SetDrawBorder: procedure(D: TDxControl; Value: Boolean); stdcall;                               //绘制边框
    SetCaption: procedure(D: TDxControl; Value: PChar); stdcall;
    SetAlignment: procedure(D: TDxControl; Value: TAlignment); stdcall;
    SetTransparent: procedure(D: TDxControl; Value: Boolean); stdcall;                              //是否透明
    SetBackgroundColor: procedure(D: TDxControl; Value: TColor); stdcall;                           //背景色
    SetPopupMenu: procedure(D: TDxControl; Value: TDxControl); stdcall;

    SetDefaultBorderColor: procedure(D: TDxControl; Value: TColor); stdcall;                        //默认边框颜色
    SetDefaultBorderBold: procedure(D: TDxControl; Value: Boolean); stdcall;                        //默认边框是否加粗
    SetMouseMoveBorderColor: procedure(D: TDxControl; Value: TColor); stdcall;                      //边框鼠标移动颜色
    SetMouseMoveBorderBold: procedure(D: TDxControl; Value: Boolean); stdcall;                      //边框鼠标移动是否加粗
    SetMouseDownBorderColor: procedure(D: TDxControl; Value: TColor); stdcall;                      //边框鼠标按下颜色
    SetMouseDownBorderBold: procedure(D: TDxControl; Value: Boolean); stdcall;                      //边框鼠标按下是否加粗
    SetDisabledBorderColor: procedure(D: TDxControl; Value: TColor); stdcall;                       //边框不可用时颜色
    SetDisabledBorderBold: procedure(D: TDxControl; Value: Boolean); stdcall;                       //边框不可用时是否加粗

    SetImages: procedure(D: TDxControl; Value: THandle); stdcall;
    SetDefaultImageIndex: procedure(D: TDxControl; Value: Integer); stdcall;                        //默认图库编号
    SetMouseMoveImageIndex: procedure(D: TDxControl; Value: Integer); stdcall;                      //鼠标移动图库编号
    SetMouseDownImageIndex: procedure(D: TDxControl; Value: Integer); stdcall;                      //鼠标按下图库编号
    SetDisabledImageIndex: procedure(D: TDxControl; Value: Integer); stdcall;                       //不可用时图库编号

    SetOnShow: procedure(ProCode: Pointer; D: TDxControl); stdcall;
    SetOnHide: procedure(ProCode: Pointer; D: TDxControl); stdcall;
    SetOnKeyDown: procedure(ProCode: Pointer; D: TDxControl); stdcall;
    SetOnKeyPress: procedure(ProCode: Pointer; D: TDxControl); stdcall;
    SetOnKeyUp: procedure(ProCode: Pointer; D: TDxControl); stdcall;
    SetOnClick: procedure(ProCode: Pointer; D: TDxControl); stdcall;
    SetOnDblClick: procedure(ProCode: Pointer; D: TDxControl); stdcall;
    SetOnMouseDown: procedure(ProCode: Pointer; D: TDxControl); stdcall;
    SetOnMouseMove: procedure(ProCode: Pointer; D: TDxControl); stdcall;
    SetOnMouseUp: procedure(ProCode: Pointer; D: TDxControl); stdcall;
    SetOnMouseEnter: procedure(ProCode: Pointer; D: TDxControl); stdcall;
    SetOnMouseLeave: procedure(ProCode: Pointer; D: TDxControl); stdcall;
    SetOnInRealArea: procedure(ProCode: Pointer; D: TDxControl); stdcall;
    SetOnPaint: procedure(ProCode: Pointer; D: TDxControl); stdcall;
    SetOnStartPaint: procedure(ProCode: Pointer; D: TDxControl); stdcall;
    SetOnStartSubPaint: procedure(ProCode: Pointer; D: TDxControl); stdcall;
    SetOnStopPaint: procedure(ProCode: Pointer; D: TDxControl); stdcall;
    SetOnPress: procedure(ProCode: Pointer; D: TDxControl); stdcall;

    //-----------------------------------------------------------------------------
    Parent: function(D: TDxControl): TDxControl; stdcall;                                           //显示在主控件 为NIL时为主表面
    SetParent: procedure(D, Value: TDxControl); stdcall;                                            //设置显示在主控件 为NIL时为主表面
    ControlCount: function(D: TDxControl): Integer; stdcall;                                        //子控件数
    Controls: function(D: TDxControl; Index: Integer): TDxControl; stdcall;                         //获取子控件

    SetFocus: procedure(D: TDxControl); stdcall;                                                    //设置为焦点
    BringToFront: procedure(D: TDxControl); stdcall;                                                //显示到最上层
    InRange: function(D: TDxControl; X, Y: Integer): Boolean; stdcall;                              //检测鼠标是否在范围

    // add chongchong 2014-04-14
    GetImages: function(D: TDxControl): THandle; stdcall;
    GetDefaultImageIndex: function(D: TDxControl): Integer; stdcall;                                //默认图库编号
    GetMouseMoveImageIndex: function(D: TDxControl): Integer; stdcall;                              //鼠标移动图库编号
    GetMouseDownImageIndex: function(D: TDxControl): Integer; stdcall;                              //鼠标按下图库编号
    GetDisabledImageIndex: function(D: TDxControl): Integer; stdcall;                               //不可用时图库编号
  end;
  pTDControl = ^TDControl;


  TDWindow = record
//-----------------------------------------------------------------------------
    SetIsBringToFront: procedure(D: TDxControl; Value: Boolean); stdcall;                           //单击窗体是否显示到最上层
//-----------------------------------------------------------------------------
    ShowModalEx: function(D: TDxControl): Integer; stdcall;
    ShowModalA: function(D: TDxControl): Integer; stdcall;
    ShowModalB: function(ProCode: Pointer; D: TDxControl): Integer; stdcall;
  end;
  pTDWindow = ^TDWindow;

  TDButton = record
    Style: function(D: TDxControl): TButtonStyle; stdcall;                                          //按钮样式
    Checked: function(D: TDxControl): Boolean; stdcall;
//-----------------------------------------------------------------------------
    SetDefaultCaptionFontFColor: procedure(D: TDxControl; Value: TColor); stdcall;                  //设置默认标题字体颜色
    SetDefaultCaptionFontBColor: procedure(D: TDxControl; Value: TColor); stdcall;                  //设置默认标题字体描边颜色
    SetDefaultCaptionFontStyle: procedure(D: TDxControl; Value: TFontStyles); stdcall;              //设置默认字体样式
    SetDefaultCaptionFontSize: procedure(D: TDxControl; Value: Integer); stdcall;                   //设置默认字体尺寸
    SetDefaultCaptionFontBold: procedure(D: TDxControl; Value: Boolean); stdcall;                   //设置默认字体是否描边
    SetDefaultCaptionFontName: procedure(D: TDxControl; Value: PChar); stdcall;                     //设置默认字体名称

    SetMouseMoveCaptionFontFColor: procedure(D: TDxControl; Value: TColor); stdcall;                //设置鼠标移动标题字体颜色
    SetMouseMoveCaptionFontBColor: procedure(D: TDxControl; Value: TColor); stdcall;                //设置鼠标移动标题字体描边颜色
    SetMouseMoveCaptionFontStyle: procedure(D: TDxControl; Value: TFontStyles); stdcall;            //设置鼠标移动字体样式
    SetMouseMoveCaptionFontSize: procedure(D: TDxControl; Value: Integer); stdcall;                 //设置鼠标移动字体尺寸
    SetMouseMoveCaptionFontBold: procedure(D: TDxControl; Value: Boolean); stdcall;                 //设置鼠标移动字体是否描边
    SetMouseMoveCaptionFontName: procedure(D: TDxControl; Value: PChar); stdcall;                   //设置鼠标移动字体名称

    SetMouseDownCaptionFontFColor: procedure(D: TDxControl; Value: TColor); stdcall;                //设置鼠标按下标题字体颜色
    SetMouseDownCaptionFontBColor: procedure(D: TDxControl; Value: TColor); stdcall;                //设置鼠标按下标题字体描边颜色
    SetMouseDownCaptionFontStyle: procedure(D: TDxControl; Value: TFontStyles); stdcall;            //设置鼠标按下字体样式
    SetMouseDownCaptionFontSize: procedure(D: TDxControl; Value: Integer); stdcall;                 //设置鼠标按下字体尺寸
    SetMouseDownCaptionFontBold: procedure(D: TDxControl; Value: Boolean); stdcall;                 //设置鼠标按下字体是否描边
    SetMouseDownCaptionFontName: procedure(D: TDxControl; Value: PChar); stdcall;                   //设置鼠标按下字体名称

    SetDisabledCaptionFontFColor: procedure(D: TDxControl; Value: TColor); stdcall;                 //设置不可用时标题字体颜色
    SetDisabledCaptionFontBColor: procedure(D: TDxControl; Value: TColor); stdcall;                 //设置不可用时标题字体描边颜色
    SetDisabledCaptionFontStyle: procedure(D: TDxControl; Value: TFontStyles); stdcall;             //设置不可用时字体样式
    SetDisabledCaptionFontSize: procedure(D: TDxControl; Value: Integer); stdcall;                  //设置不可用时字体尺寸
    SetDisabledCaptionFontBold: procedure(D: TDxControl; Value: Boolean); stdcall;                  //设置不可用时字体是否描边
    SetDisabledCaptionFontName: procedure(D: TDxControl; Value: PChar); stdcall;                    //设置不可用时字体名称

    SetCheckedCaptionFontFColor: procedure(D: TDxControl; Value: TColor); stdcall;                  //设置勾选时标题字体颜色
    SetCheckedCaptionFontBColor: procedure(D: TDxControl; Value: TColor); stdcall;                  //设置勾选时标题字体描边颜色
    SetCheckedCaptionFontStyle: procedure(D: TDxControl; Value: TFontStyles); stdcall;              //设置勾选时字体样式
    SetCheckedCaptionFontSize: procedure(D: TDxControl; Value: Integer); stdcall;                   //设置勾选时字体尺寸
    SetCheckedCaptionFontBold: procedure(D: TDxControl; Value: Boolean); stdcall;                   //设置勾选时字体是否描边
    SetCheckedCaptionFontName: procedure(D: TDxControl; Value: PChar); stdcall;                     //设置勾选时字体名称

    SetStyle: procedure(D: TDxControl; Value: TButtonStyle); stdcall;                               //按钮样式
    SetChecked: procedure(D: TDxControl; Value: Boolean); stdcall;
    SetCaptionDownOffsetX: procedure(D: TDxControl; Value: Integer); stdcall;                       //按下后标题偏移X
    SetCaptionDownOffsetY: procedure(D: TDxControl; Value: Integer); stdcall;                       //按下后标题偏移Y
    SetButtonDownOffsetX: procedure(D: TDxControl; Value: Integer); stdcall;                        //按下后偏移X
    SetButtonDownOffsetY: procedure(D: TDxControl; Value: Integer); stdcall;                        //按下后偏移Y
    SetClickCount: procedure(D: TDxControl; Value: TClickSound); stdcall;                           //按钮点击的声音
  end;
  pTDButton = ^TDButton;

  TDEdit = record
    Text: function(D: TDxControl): PChar; stdcall;
    Value: function(D: TDxControl): Integer; stdcall;
    ReadOnly: function(D: TDxControl): Boolean; stdcall;                                            //是否只读
    MaxLength: function(D: TDxControl): Integer; stdcall;                                           //最大长度
    SelectedColor: function(D: TDxControl): TColor; stdcall;                                        //光标颜色
    SelBackColor: function(D: TDxControl): TColor; stdcall;                                         //选择字体背景色
    SelFontColor: function(D: TDxControl): TColor; stdcall;                                         //选择字体色
    PasswordChar: function(D: TDxControl): Char; stdcall;
    AllowSelect: function(D: TDxControl): Boolean; stdcall;                                         //是否允许选择
    AllowPaste: function(D: TDxControl): Boolean; stdcall;                                          //是否允许粘贴
    InValue: function(D: TDxControl): TInValue; stdcall;                                            //允许输入控制
    TabOrder: function(D: TDxControl): Integer; stdcall;
    OnChange: function(D: TDxControl): Pointer; stdcall;                                            //输入框改变触发
//-----------------------------------------------------------------------------
    SetText: procedure(D: TDxControl; Value: PChar); stdcall;
    SetValue: procedure(D: TDxControl; Value: Integer); stdcall;
    SetReadOnly: procedure(D: TDxControl; Value: Boolean); stdcall;                                 //是否只读
    SetMaxLength: procedure(D: TDxControl; Value: Integer); stdcall;                                //最大长度
    SetSelectedColor: procedure(D: TDxControl; Value: TColor); stdcall;                             //光标颜色
    SetSelBackColor: procedure(D: TDxControl; Value: TColor); stdcall;                              //选择字体背景色
    SetSelFontColor: procedure(D: TDxControl; Value: TColor); stdcall;                              //选择字体色
    SetPasswordChar: procedure(D: TDxControl; Value: Char); stdcall;
    SetAllowSelect: procedure(D: TDxControl; Value: Boolean); stdcall;                              //是否允许选择
    SetAllowPaste: procedure(D: TDxControl; Value: Boolean); stdcall;                               //是否允许粘贴
    SetInValue: procedure(D: TDxControl; Value: TInValue); stdcall;                                 //允许输入控制
    SetTabOrder: procedure(D: TDxControl; Value: Integer); stdcall;
    SetOnChange: procedure(ProCode: Pointer; D: TDxControl); stdcall;
//-----------------------------------------------------------------------------
  end;
  pTDEdit = ^TDEdit;

  TDGrid = record
    ColCount: function(D: TDxControl): Integer; stdcall;                                            //列数
    RowCount: function(D: TDxControl): Integer; stdcall;                                            //组数
    ColWidth: function(D: TDxControl): Integer; stdcall;                                            //列宽
    RowHeight: function(D: TDxControl): Integer; stdcall;                                           //组高

    OnGridSelect: function(D: TDxControl): Pointer; stdcall;                                        //选择事件
    OnGridMouseMove: function(D: TDxControl): Pointer; stdcall;                                     //鼠标移动事件
    OnGridPaint: function(D: TDxControl): Pointer; stdcall;                                         //绘制事件
//-----------------------------------------------------------------------------

    SetColCount: procedure(D: TDxControl; Value: Integer); stdcall;                                 //列数
    SetRowCount: procedure(D: TDxControl; Value: Integer); stdcall;                                 //组数
    SetColWidth: procedure(D: TDxControl; Value: Integer); stdcall;                                 //列宽
    SetRowHeight: procedure(D: TDxControl; Value: Integer); stdcall;                                //组高

    SetOnGridSelect: procedure(ProCode: Pointer; D: TDxControl); stdcall;                           //选择事件
    SetOnGridMouseMove: procedure(ProCode: Pointer; D: TDxControl); stdcall;                        //鼠标移动事件
    SetOnGridPaint: procedure(ProCode: Pointer; D: TDxControl); stdcall;                            //绘制事件

    DrawGridItem: procedure(ARect: TRect; Item: pTClientItem; Effect: Pointer); stdcall;            //绘制网格物品
  end;
  pTDGrid = ^TDGrid;

  TDComboBox = record
    ItemIndex: function(D: TDxControl): Integer; stdcall;                                           //当前选择行
    Items: function(D: TDxControl): TStringList; stdcall;                                           //列表
    Text: function(D: TDxControl): PChar; stdcall;
    OnSelect: function(D: TDxControl): Pointer; stdcall;

//-----------------------------------------------------------------------------
    SetShowButton: procedure(D: TDxControl; Value: Boolean); stdcall;                               //是否显示按钮
    SetItemIndex: procedure(D: TDxControl; Value: Integer); stdcall;                                //当前选择行
    SetButtonColor: procedure(D: TDxControl; Value: TColor); stdcall;                               //按钮颜色
    SetItems: procedure(D: TDxControl; Value: TStringList); stdcall;                                //列表
    SetText: procedure(D: TDxControl; Value: PChar); stdcall;
    SetOnSelect: procedure(ProCode: Pointer; D: TDxControl); stdcall;

    SetDefaultTextFontFColor: procedure(D: TDxControl; Value: TColor); stdcall;                     //默认标题字体颜色
    SetDefaultTextFontBColor: procedure(D: TDxControl; Value: TColor); stdcall;                     //默认标题字体描边颜色
    SetDefaultTextFontStyle: procedure(D: TDxControl; Value: TFontStyles); stdcall;                 //默认字体样式
    SetDefaultTextFontSize: procedure(D: TDxControl; Value: Integer); stdcall;                      //默认字体尺寸
    SetDefaultTextFontBold: procedure(D: TDxControl; Value: Boolean); stdcall;                      //默认是否描边
    SetDefaultTextFontName: procedure(D: TDxControl; Value: PChar); stdcall;                        //默认字体名称

    SetMouseMoveTextFontFColor: procedure(D: TDxControl; Value: TColor); stdcall;                   //鼠标移动标题字体颜色
    SetMouseMoveTextFontBColor: procedure(D: TDxControl; Value: TColor); stdcall;                   //鼠标移动标题字体描边颜色
    SetMouseMoveTextFontStyle: procedure(D: TDxControl; Value: TFontStyles); stdcall;               //鼠标移动字体样式
    SetMouseMoveTextFontSize: procedure(D: TDxControl; Value: Integer); stdcall;                    //鼠标移动字体尺寸
    SetMouseMoveTextFontBold: procedure(D: TDxControl; Value: Boolean); stdcall;                    //鼠标移动字体是否描边
    SetMouseMoveTextFontName: procedure(D: TDxControl; Value: PChar); stdcall;                      //鼠标移动字体名称

    SetMouseDownTextFontFColor: procedure(D: TDxControl; Value: TColor); stdcall;                   //鼠标按下标题字体颜色
    SetMouseDownTextFontBColor: procedure(D: TDxControl; Value: TColor); stdcall;                   //鼠标按下标题字体描边颜色
    SetMouseDownTextFontStyle: procedure(D: TDxControl; Value: TFontStyles); stdcall;               //鼠标按下字体样式
    SetMouseDownTextFontSize: procedure(D: TDxControl; Value: Integer); stdcall;                    //鼠标按下字体尺寸
    SetMouseDownTextFontBold: procedure(D: TDxControl; Value: Boolean); stdcall;                    //鼠标按下字体是否描边
    SetMouseDownTextFontName: procedure(D: TDxControl; Value: PChar); stdcall;                      //鼠标按下字体名称

    SetDisabledTextFontFColor: procedure(D: TDxControl; Value: TColor); stdcall;                    //不可用时标题字体颜色
    SetDisabledTextFontBColor: procedure(D: TDxControl; Value: TColor); stdcall;                    //不可用时标题字体描边颜色
    SetDisabledTextFontStyle: procedure(D: TDxControl; Value: TFontStyles); stdcall;                //不可用时字体样式
    SetDisabledTextFontSize: procedure(D: TDxControl; Value: Integer); stdcall;                     //不可用时字体尺寸
    SetDisabledTextFontBold: procedure(D: TDxControl; Value: Boolean); stdcall;                     //不可用时字体是否描边
    SetDisabledTextFontName: procedure(D: TDxControl; Value: PChar); stdcall;                       //不可用时字体名称
  end;
  pTDComboBox = ^TDComboBox;


  TDxItemMenuList = TObject;

  TItemMenuListAPI = record                                                                         //TDxItemMenuList 相关API
    Count: function(List: TDxItemMenuList): Integer; stdcall;
    Add: procedure(List: TDxItemMenuList; S: PChar); stdcall;
    AddObject: procedure(List: TDxItemMenuList; S: PChar; AObject: TObject); stdcall;
    Get: function(List: TDxItemMenuList; Index: Integer): PChar; stdcall;
    GetObject: function(List: TDxItemMenuList; Index: Integer): TObject; stdcall;
    Delete: procedure(List: TDxItemMenuList; Index: Integer); stdcall;
    Clear: procedure(List: TDxItemMenuList); stdcall;
  end;


  TDPopupMenu = record
    ItemIndex: function(D: TDxControl): Integer; stdcall;                                           //选择行
    ItemHeight: function(D: TDxControl): Integer; stdcall;                                          //组高
    Items: function(D: TDxControl): TDxItemMenuList; stdcall;                                       //列表
//-----------------------------------------------------------------------------
    SetSelectColor: procedure(D: TDxControl; Value: TColor); stdcall;                               //选择颜色
    SetItemIndex: procedure(D: TDxControl; Value: Integer); stdcall;                                //选择行
    SetItemHeight: procedure(D: TDxControl; Value: Integer); stdcall;                               //组高
    SetAlpha: procedure(D: TDxControl; Value: Byte); stdcall;                                       //背景透明度

    SetDefaultItemFontFColor: procedure(D: TDxControl; Value: TColor); stdcall;                     //设置默认标题字体颜色
    SetDefaultItemFontBColor: procedure(D: TDxControl; Value: TColor); stdcall;                     //设置默认标题字体描边颜色
    SetDefaultItemFontStyle: procedure(D: TDxControl; Value: TFontStyles); stdcall;                 //设置默认字体样式
    SetDefaultItemFontSize: procedure(D: TDxControl; Value: Integer); stdcall;                      //设置默认字体尺寸
    SetDefaultItemFontBold: procedure(D: TDxControl; Value: Boolean); stdcall;                      //设置默认字体是否描边
    SetDefaultItemFontName: procedure(D: TDxControl; Value: PChar); stdcall;                        //设置默认字体名称

    SetMouseMoveItemFontFColor: procedure(D: TDxControl; Value: TColor); stdcall;                   //设置鼠标移动标题字体颜色
    SetMouseMoveItemFontBColor: procedure(D: TDxControl; Value: TColor); stdcall;                   //设置鼠标移动标题字体描边颜色
    SetMouseMoveItemFontStyle: procedure(D: TDxControl; Value: TFontStyles); stdcall;               //设置鼠标移动字体样式
    SetMouseMoveItemFontSize: procedure(D: TDxControl; Value: Integer); stdcall;                    //设置鼠标移动字体尺寸
    SetMouseMoveItemFontBold: procedure(D: TDxControl; Value: Boolean); stdcall;                    //设置鼠标移动字体是否描边
    SetMouseMoveItemFontName: procedure(D: TDxControl; Value: PChar); stdcall;                      //设置鼠标移动字体名称

    SetMouseDownItemFontFColor: procedure(D: TDxControl; Value: TColor); stdcall;                   //设置鼠标按下标题字体颜色
    SetMouseDownItemFontBColor: procedure(D: TDxControl; Value: TColor); stdcall;                   //设置鼠标按下标题字体描边颜色
    SetMouseDownItemFontStyle: procedure(D: TDxControl; Value: TFontStyles); stdcall;               //设置鼠标按下字体样式
    SetMouseDownItemFontSize: procedure(D: TDxControl; Value: Integer); stdcall;                    //设置鼠标按下字体尺寸
    SetMouseDownItemFontBold: procedure(D: TDxControl; Value: Boolean); stdcall;                    //设置鼠标按下字体是否描边
    SetMouseDownItemFontName: procedure(D: TDxControl; Value: PChar); stdcall;                      //设置鼠标按下字体名称

    SetDisabledItemFontFColor: procedure(D: TDxControl; Value: TColor); stdcall;                    //设置不可用时标题字体颜色
    SetDisabledItemFontBColor: procedure(D: TDxControl; Value: TColor); stdcall;                    //设置不可用时标题字体描边颜色
    SetDisabledItemFontStyle: procedure(D: TDxControl; Value: TFontStyles); stdcall;                //设置不可用时字体样式
    SetDisabledItemFontSize: procedure(D: TDxControl; Value: Integer); stdcall;                     //设置不可用时字体尺寸
    SetDisabledItemFontBold: procedure(D: TDxControl; Value: Boolean); stdcall;                     //设置不可用时字体是否描边
    SetDisabledItemFontName: procedure(D: TDxControl; Value: PChar); stdcall;                       //设置不可用时字体名称
  end;
  pTDPopupMenu = ^TDPopupMenu;

  TInterfaceAPI = record                                                                            //界面操作API
    DControl: TDControl;
    DWindow: TDWindow;
    DButton: TDButton;
    DEdit: TDEdit;
    DGrid: TDGrid;
    DComboBox: TDComboBox;
    DPopupMenu: TDPopupMenu;
  end;
  pTInterfaceAPI = ^TInterfaceAPI;

  TGameInterfaceAPI = record                                                                        //客户端内部界面
    DMainMenu: function: TDxControl; stdcall;                                                       //右键弹出菜单
    DLoginDlg: function: TDxControl; stdcall;                                                       //登录背景窗口
    DRandomCodeDlg: function: TDxControl; stdcall;                                                  //随机码窗口
    DLogin: function: TDxControl; stdcall;                                                          //登录对话框窗口
    DNewAccount: function: TDxControl; stdcall;                                                     //注册帐号窗口
    DChgPw: function: TDxControl; stdcall;                                                          //修改密码窗口
    DSelServerDlg: function: TDxControl; stdcall;                                                   //选择服务器背景窗口
    DServerDlg: function: TDxControl; stdcall;                                                      //选择服务器窗口
    DDoorDlg: function: TDxControl; stdcall;                                                        //开门时的背景窗口
    DSelectChr: function: TDxControl; stdcall;                                                      //选择角色背景窗口
    DCreateChr: function: TDxControl; stdcall;                                                      //创建角色窗口
    DDeleteHumanDlg: function: TDxControl; stdcall;                                                 //恢复角色窗口
    DNoticeDlg: function: TDxControl; stdcall;                                                      //公告窗口
    DMerchantDlg: function: TDxControl; stdcall;                                                    //NPC对话框
    DBottomLeft: function: TDxControl; stdcall;                                                     //游戏界面左
    DBottomCenter: function: TDxControl; stdcall;                                                   //游戏界面中
    DBottomRight: function: TDxControl; stdcall;                                                    //游戏界面右
    DItemBag: function: TDxControl; stdcall;                                                        //包裹窗口
    DStateWin: function: TDxControl; stdcall;                                                       //人物属性窗口 自己
    DUserState1: function: TDxControl; stdcall;                                                     //人物属性窗口 查看对方
    DHeroStateWin: function: TDxControl; stdcall;                                                   //英雄属性窗口
    DHeroStateDlg: function: TDxControl; stdcall;                                                   //英雄状态窗口
    DHeroItemBag: function: TDxControl; stdcall;                                                    //英雄包裹窗口
    DMenuDlg: function: TDxControl; stdcall;                                                        // NPC列表框
    DSellDlg: function: TDxControl; stdcall;                                                        //OK框
    DDealDlg: function: TDxControl; stdcall;                                                        //交易对话框 自己
    DDealRemoteDlg: function: TDxControl; stdcall;                                                  //交易对话框 对方
    DShopDlg: function: TDxControl; stdcall;                                                        //商铺窗口
    DGroupDlg: function: TDxControl; stdcall;                                                       //组队窗口
    DRankingDlg: function: TDxControl; stdcall;                                                     //排行榜窗口
    DGuildDlg: function: TDxControl; stdcall;                                                       //行会窗口
    DGuildEditNotice: function: TDxControl; stdcall;                                                //行会编辑窗口
    DAdjustAbility: function: TDxControl; stdcall;                                                  //附加属性窗口
    DMissionDlg: function: TDxControl; stdcall;                                                     //任务日记窗口
  end;
  pTGameInterfaceAPI = ^TGameInterfaceAPI;

  TListAPI = record
    Create: function: TList; stdcall;
    Free: procedure(List: TList); stdcall;
    Count: function(List: TList): Integer; stdcall;
    Add: procedure(List: TList; Item: Pointer); stdcall;
    Insert: procedure(List: TList; Index: Integer; Item: Pointer); stdcall;
    Get: function(List: TList; Index: Integer): Pointer; stdcall;
    Delete: procedure(List: TList; Index: Integer); stdcall;
    Clear: procedure(List: TList); stdcall;
  end;

  TStringListAPI = record
    Create: function: TStringList; stdcall;
    Free: procedure(List: TStringList); stdcall;
    Count: function(List: TStringList): Integer; stdcall;
    Add: procedure(List: TStringList; S: PChar); stdcall;
    AddObject: procedure(List: TStringList; S: PChar; AObject: TObject); stdcall;
    Insert: procedure(List: TStringList; Index: Integer; S: PChar; AObject: TObject); stdcall;
    Get: function(List: TStringList; Index: Integer): PChar; stdcall;
    GetObject: function(List: TStringList; Index: Integer): TObject; stdcall;
    Delete: procedure(List: TStringList; Index: Integer); stdcall;
    Clear: procedure(List: TStringList); stdcall;
  end;

  //------------------------------------------------------------------------------
  // 地面上某个点的物品列表 2019-12-23
  TPointDropItemListAPI = record
    Count: function(DropItemList: TPointDropItemList): Integer; stdcall;
    Get: function(DropItemList: TPointDropItemList; Index: Integer): PTDropItem; stdcall;
    X: function(DropItemList: TPointDropItemList): Word; stdcall;
    Y: function(DropItemList: TPointDropItemList): Word; stdcall;
  end;

  // 地面物品列表 2019-12-23
  TDropItemsMgrAPI = record
    Lock: procedure(DropItemsMgr: TDropItemsMgr); stdcall;
    UnLock: procedure(DropItemsMgr: TDropItemsMgr); stdcall;

    Count: function(DropItemsMgr: TDropItemsMgr): Integer; stdcall;
    Get: function(DropItemsMgr: TDropItemsMgr; Index: Integer): TPointDropItemList; stdcall;

    GetItemByID: function(DropItemsMgr: TDropItemsMgr; ID: Integer): pTDropItem; stdcall;
    GetItemListByPoint: function(DropItemsMgr: TDropItemsMgr; X, Y: Word): TPointDropItemList; stdcall;
    GetItemListIndexByY: function(DropItemsMgr: TDropItemsMgr; Y: Word): Integer; stdcall;
  end;
  //------------------------------------------------------------------------------

  TDrawAPI = record                                                                                 //绘制图片相关API
    Draw: procedure(X, Y: Integer; SrcRect: TRect; Texture: TTexture; BlendMode: Integer); stdcall;
    DrawColor: procedure(X, Y: Integer; SrcRect: TRect; Texture: TTexture; Color: TColor; BlendMode: Integer); stdcall;
    StretchDraw: procedure(DestRect, SrcRect: TRect; Texture: TTexture; BlendMode: Integer); stdcall; //缩放模式绘制
    DrawAlpha: procedure(X, Y: Integer; SrcRect: TRect; Texture: TTexture; Alpha: Byte; BlendMode: Integer); stdcall;
    DrawColorAlpha: procedure(X, Y: Integer; SrcRect: TRect; Texture: TTexture; Color: TColor; Alpha: Byte; BlendMode: Integer); stdcall;
    DrawBlend: procedure(X, Y: Integer; SrcRect: TRect; Texture: TTexture); stdcall;                //魔法效果绘制
    DrawEffect: procedure(GameImages, nImageIndex, X, Y: Integer; SrcRect: TRect; boEffect: Boolean; BlendMode: Integer); stdcall; // 绘制加亮和灰度效果  boEffect=True加亮  boEffect=False灰度

    FrameRect: procedure(Rect: TRect; Color: TColor; BlendMode: Integer); stdcall;                  //绘制矩形框
    FillRect: procedure(Rect: TRect; Color: TColor; BlendMode: Integer); stdcall;                   //绘制矩形框且填冲该矩形
    FillRectAlpha: procedure(DestRect: TRect; Color: TColor; Alpha: Byte; BlendMode: Integer); stdcall;
    Line: procedure(Pt1, Pt2: TPoint; Color: TColor; BlendMode: Integer); stdcall;                  //画线
    FillTri: procedure(p1, p2, p3: TPoint; c1, c2, c3: TColor; BlendMode: Integer); stdcall;        //画三角形
    Circle: procedure(X, Y, Radius: Single; Color: TColor; Filled: Boolean; BlendMode: Integer); stdcall; //画圆
    CurrentFont: function: THGEFont; stdcall;                                                       //当前默认字体
    FindFont: function(FontName: PChar; FontSize: Integer; FontStyles: TFontStyles): THGEFont; stdcall;
    TextRect: procedure(HGEFont: THGEFont; X, Y: Integer; SrcRect: TRect; Text: PChar; Color: TColor; BlendMode: Integer); stdcall;
    TextOut: procedure(HGEFont: THGEFont; X, Y: Integer; Text: PChar; Color: TColor; BlendMode: Integer); stdcall;
    BoldTextOut: procedure(HGEFont: THGEFont; X, Y: Integer; Text: PChar; FColor, BColor: TColor); stdcall;
    TextWidth: function(HGEFont: THGEFont; Text: PChar): Integer; stdcall;
    TextHeight: function(HGEFont: THGEFont; Text: PChar): Integer; stdcall;
  end;
  pTDrawAPI = ^TDrawAPI;

  TSocketAPI = record                                                                               //数据发送
    SendSocket: procedure(S: PChar); stdcall;
    SendClientMessage: procedure(Msg: Word; Recog: Int64; param, tag, series: Word; S: PChar); stdcall; // 2021-01-06 changed
    SendLogin: procedure(uid, passwd: PChar); stdcall;                                              //登录
    SendSelectServer: procedure(sServerName: PChar); stdcall;                                       //选择服务器
    SendQueryChr: procedure; stdcall;                                                               //查询角色
    SendSelChr: procedure(sChrName: PChar); stdcall;                                                //选择角色
    SendSay: procedure(S: PChar); stdcall;
    Close: procedure; stdcall;                                                                      //断开连接
  end;
  pTSocketAPI = ^TSocketAPI;

  pTList = ^TList;

  TGameAPI = record
    ClientPath: function: PChar; stdcall;                                                           //登录器路径
    ClientName: function: PChar; stdcall;                                                           //登录器名称
    MySelf: function: TActor; stdcall;                                                              //自己
    MyHero: function: TActor; stdcall;                                                              //我的英雄
    MagicList: function: TList; stdcall;                                                            //技能列表
    MagicNGList: function: TList; stdcall;                                                          //内功技能列表
    ContinuousMagicList: function: TList; stdcall;                                                  //连击技能列表

    HeroMagicList: function: TList; stdcall;                                                        //英雄魔法列表
    HeroMagicNGList: function: TList; stdcall;                                                      //英雄内功技能列表
    HeroContinuousMagicList: function: TList; stdcall;                                              //英雄连击技能列表

    GroupMembers: function: TList; stdcall;                                                         //组列表
    DropedItemList: function: TDropItemsMgr; stdcall;                                               //地面物品列表 ### 2019-12-23
    MenuItemList: function: TList; stdcall;                                                         //当前NPC出售物品列表
    ActorList: function: TList; stdcall;                                                            //角色列表
    ScreenXYfromMCXY: procedure(cx, cy: Integer; var sx, sY: Integer); stdcall;                     //地图坐标转换屏幕坐标
    CXYfromMouseXY: procedure(mx, my: Integer; var ccx, ccy: Integer); stdcall;                     //屏幕坐标转换地图坐标
    FindActor1: function(nRecogId: Int64): TActor; stdcall;                                         //查找角色 2020-01-11 64位支持 
    FindActor2: function(sName: PChar): TActor; stdcall;
    FindActorXY1: function(X, Y: Integer): TActor; stdcall;
    FindActorXY2: function(X, Y: Integer; Actor: TActor): TActor; stdcall;
    CanWalk: function(mx, my: Integer): Boolean; stdcall;
    CanRun: function(sx, sY, ex, ey: Integer): Boolean; stdcall;
    CanHorseRun: function(sx, sY, ex, ey: Integer): Boolean; stdcall;
    GetRGB: function(c256: Byte): Integer; stdcall;                                                 //获取颜色
    DebugOutStr: procedure(Msg: PChar; boWriteDate: Boolean); stdcall;                              //写入日记
    AppLogout: procedure; stdcall;                                                                  //小退
    AppExit: procedure; stdcall;                                                                    //退出游戏
    DMessageDlg: function(Msg: PChar; DlgButtons: TMsgDlgButtons): TModalResult; stdcall;           //弹出对话框
    AddChatBoardString: procedure(Msg: PChar; FColor, BColor: Byte); stdcall;                       //聊天框显示信息
    AddTopChatBoardString: procedure(Msg: PChar; FColor, BColor: Byte; TimeOut: Integer); stdcall;  //聊天框固顶信息
    AddMoveMsg: procedure(Msg: PChar; FColor, BColor: Byte; nX, nY, nCount: Integer); stdcall;      //滚动信息
    ShowHint: procedure(X, Y: Integer; Msg: PChar; Color: TColor; DrawUp: Boolean; DrawLeft: Boolean; ShowBackground: Boolean); stdcall; //显示悬浮框
    ShowMouseItemInfo: procedure(Actor: TActor; MouseItem: pTClientItem; X, Y: Integer; Secret {是否是神秘装备}: Boolean; ShowTzItemDesc {套装备注类型 0=自己 1=英雄 2=查看的人其他人}: Byte; DrawUp: Boolean; DrawLeft: Boolean); stdcall; //悬浮框显示装备信息
    ClearHint: procedure; stdcall;                                                                  //清除悬浮框
    DlgEditText: function: PChar; stdcall;                                                          //DMessageDlg 对话框用户输入的信息
    PlaySound: procedure(idx: Integer); stdcall;
    PlaySoundA: procedure(sFileName: PChar; LoopCount: Integer); stdcall;
    ItemClickSound: procedure(StdItem: TStdItem); stdcall;
    ItemBag: function: pTClientBagItems; stdcall;                                                   //包裹物品指针
    HeroItemBag: function: pTClientHeroBagItems; stdcall;                                                  //英雄包裹物品指针
    UseItems: function: pTUseItems; stdcall;                                                        //身上装备指针
    HeroUseItems: function: pTUseItems; stdcall;                                                    //英雄身上装备指针

    JewelryBoxItems: function: pTJewelryBoxItems; stdcall;                                          // 首饰盒物品指针
    HeroJewelryBoxItems: function: PTJewelryBoxItems; stdcall;                                      // 英雄首饰盒物品指针
    GodBlessItems: function: PTGodBlessItems; stdcall;                                              // 神佑盒物品指针
    HeroGodBlessItems: function: PTGodBlessItems; stdcall;                                          // 英雄神佑盒物品指针
    ItemBoxItems: function: PTItemBoxItems; stdcall;                                                // 自定义OK框物品指针

    UserState1: function: pTUserStateInfo; stdcall;                                                 // 查看的别人身上装备指针
    boItemMoving: function: Boolean; stdcall;
    MovingItem: function: pTMovingItem; stdcall;                                                    //pTMovingItem; //当前正在移动的物品指针
    WaitingUseItem: function: pTMovingItem; stdcall;                                                //pTMovingItem;
    SellDlgItem: function: pTMovingItem; stdcall;                                                   //pTMovingItem; 当前OK框物品
    nTargetX: function: PInteger; stdcall;                                                          //目标座标
    nTargetY: function: PInteger; stdcall;                                                          //目标座标
    TargetCret: function: pTActor; stdcall;
    FocusCret: function: TActor; stdcall;
    MagicTarget: function: pTActor; stdcall;
    Gold: function: Integer; stdcall;                                                               //金币数量
    GameGold: function: Integer; stdcall;                                                           //元宝数量
    GamePoint: function: Integer; stdcall;                                                          //游戏点数量
    GloryPoint: function: Integer; stdcall;                                                         //荣誉
    GameDiamond: function: Integer; stdcall;                                                        //金刚石
    GameGird: function: Integer; stdcall;                                                           //灵符
    GameGlory: function: Integer; stdcall;                                                          //荣誉
    LoyaltyPoint: function: Integer; stdcall;                                                       //忠诚度
    GameGoldName: function: PChar; stdcall;                                                         //元宝名称
    GamePointName: function: PChar; stdcall;                                                        //游戏点名称
    GameDiamondName: function: PChar; stdcall;                                                      //金刚石名称
    GameGirdName: function: PChar; stdcall;                                                         //灵符名称
    EncodeBuffer: function(InData: PChar; InBytes: Integer; OutData: PChar): Integer; stdcall;
    DecodeBuffer: function(InData: PChar; InBytes: Integer; OutData: PChar): Integer; stdcall;
    FullScreenDrawScene: procedure(Value: Boolean); stdcall;                                        //全屏绘制场景
    AreaStateValue: function: Boolean; stdcall;                                                     //当前是在攻城区域
    MapTitle: function: PChar; stdcall;                                                             //当前地图名称
    EatItem: procedure(idx: Integer); stdcall;                                                      //使用物品
    HeroEatItem: procedure(idx: Integer); stdcall;                                                  //英雄使用物品
    ServerImageList: function: TStringList; stdcall;                                                //M2列表信息2的WIL列表
    ClassDlg: function: TObject; stdcall;

    SetMovingItem: procedure(Item: Pointer); stdcall;                                               //pTMovingItem; //当前正在移动的物品
    SetWaitingUseItem: procedure(Item: Pointer); stdcall;                                           //pTMovingItem;
    SetSellDlgItem: procedure(Item: pTClientItem); stdcall;                                         //pTMovingItem; 当前OK框物品

    SetItemBag: procedure(Index: Integer; Item: pTClientItem); stdcall;                             //包裹物品
    SetHeroItemBag: procedure(Index: Integer; Item: pTClientItem); stdcall;                         //英雄包裹物品
    SetUseItems: procedure(Index: Integer; Item: pTClientItem); stdcall;                            //身上装备
    SetHeroUseItems: procedure(Index: Integer; Item: pTClientItem); stdcall;                        //英雄身上装备

    SetJewelryBoxItems: procedure(Index: Integer; Item: pTClientItem); stdcall;                     // 首饰盒物品指针
    SetHeroJewelryBoxItems: procedure(Index: Integer; Item: pTClientItem); stdcall;                 // 英雄首饰盒物品指针
    SetGodBlessItems: procedure(Index: Integer; Item: pTClientItem); stdcall;                       // 神佑盒物品指针
    SetHeroGodBlessItems: procedure(Index: Integer; Item: pTClientItem); stdcall;                   // 英雄神佑盒物品指针
    SetItemBoxItems: procedure(Index: Integer; Item: pTClientItem); stdcall;                        // 自定义OK框物品指针

    SetUserState1: procedure(UserStateInfo: pTUserStateInfo); stdcall;                              //查看的别人身上装备
    SetItemMoving: procedure(Value: Boolean); stdcall;
    Reserveds: array[0..99] of Integer;
  end;

  TInitialize = procedure(Handle: THandle; FirstInit: Boolean; WindowMode: Boolean; ScreenWidth, ScreenHeight: Word; ClientVersion: TClientVersion); stdcall;
  TStartPro = procedure; stdcall;
  TFormKeyDown = procedure(Sender: TObject; var Key: Word; Shift: TShiftState); stdcall;
  TFormKeyPress = procedure(Sender: TObject; var Key: Char); stdcall;
  TFormMouseDown = procedure(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer); stdcall;
  TFormMouseMove = procedure(Sender: TObject; Shift: TShiftState; X, Y: Integer); stdcall;
  TDecodeMessagePacket = procedure(DefMsg: pTDefaultMessage; sData: PChar); stdcall;

  TObjectAction = procedure(Actor: TActor); stdcall;
  TTActor_DrawChr = procedure(Actor: TActor; dx, dy: Integer; blend: Boolean; boFlag: Boolean); stdcall;

  THookAPI = record
    GetHookInitialize: function: TInitialize; stdcall;
    GetHookFinalize: function: TStartPro; stdcall;
    GetHookFormKeyDown: function: TFormKeyDown; stdcall;
    GetHookFormKeyPress: function: TFormKeyPress; stdcall;
    GetHookFormMouseDown: function: TFormMouseDown; stdcall;
    GetHookFormMouseMove: function: TFormMouseMove; stdcall;
    GetHookDecodeMessagePacketStart: function: TDecodeMessagePacket; stdcall;
    GetHookDecodeMessagePacketStop: function: TDecodeMessagePacket; stdcall;
    GetHookDecodeMessagePacket: function: TDecodeMessagePacket; stdcall;

    GetHookDrawScene1: function: TStartPro; stdcall;
    GetHookDrawScene2: function: TStartPro; stdcall;
    GetHookDrawScene3: function: TStartPro; stdcall;
    GetHookDrawScene4: function: TStartPro; stdcall;

    GetHookTActor_FeatureChanged: function: TObjectAction; stdcall;
    GetHookTActor_CalcActorFrame: function: TObjectAction; stdcall;
    GetHookTActor_DrawChr1: function: TTActor_DrawChr; stdcall;
    GetHookTActor_DrawChr2: function: TTActor_DrawChr; stdcall;

    GetHookTHumActor_CalcActorFrame: function: TObjectAction; stdcall;
    GetHookTHumActor_DrawChr1: function: TTActor_DrawChr; stdcall;
    GetHookTHumActor_DrawChr2: function: TTActor_DrawChr; stdcall;
    GetHookTHumActor_DrawChr3: function: TTActor_DrawChr; stdcall;
    GetHookTHumActor_DrawChr4: function: TTActor_DrawChr; stdcall;

//------------------------------------------------------------------------------
    SetHookInitialize: procedure(Value: TInitialize); stdcall;
    SetHookFinalize: procedure(Value: TStartPro); stdcall;
    SetHookFormKeyDown: procedure(Value: TFormKeyDown); stdcall;
    SetHookFormKeyPress: procedure(Value: TFormKeyPress); stdcall;
    SetHookFormMouseDown: procedure(Value: TFormMouseDown); stdcall;
    SetHookFormMouseMove: procedure(Value: TFormMouseMove); stdcall;
    SetHookDecodeMessagePacketStart: procedure(Value: TDecodeMessagePacket); stdcall;
    SetHookDecodeMessagePacketStop: procedure(Value: TDecodeMessagePacket); stdcall;
    SetHookDecodeMessagePacket: procedure(Value: TDecodeMessagePacket); stdcall;

    SetHookDrawScene1: procedure(Value: TStartPro); stdcall;
    SetHookDrawScene2: procedure(Value: TStartPro); stdcall;
    SetHookDrawScene3: procedure(Value: TStartPro); stdcall;
    SetHookDrawScene4: procedure(Value: TStartPro); stdcall;

    SetHookTActor_FeatureChanged: procedure(Value: TObjectAction); stdcall;
    SetHookTActor_CalcActorFrame: procedure(Value: TObjectAction); stdcall;
    SetHookTActor_DrawChr1: procedure(Value: TTActor_DrawChr); stdcall;
    SetHookTActor_DrawChr2: procedure(Value: TTActor_DrawChr); stdcall;

    SetHookTHumActor_CalcActorFrame: procedure(Value: TObjectAction); stdcall;
    SetHookTHumActor_DrawChr1: procedure(Value: TTActor_DrawChr); stdcall;
    SetHookTHumActor_DrawChr2: procedure(Value: TTActor_DrawChr); stdcall;
    SetHookTHumActor_DrawChr3: procedure(Value: TTActor_DrawChr); stdcall;
    SetHookTHumActor_DrawChr4: procedure(Value: TTActor_DrawChr); stdcall;

    Reserveds: array[0..99] of Integer;
  end;

  TActorAPI = record
    m_wAppearance: function(Actor: TActor): PWord; stdcall;
    m_nRecogId: function(Actor: TActor): PInt64; stdcall;                                           //角色标识 2020-01-11 64位支持
    m_nCurrX: function(Actor: TActor): PInteger; stdcall;                                           //当前所在地图座标X
    m_nCurrY: function(Actor: TActor): PInteger; stdcall;                                           //当前所在地图座标Y
    m_btDir: function(Actor: TActor): PByte; stdcall;                                               //当前站立方向
    m_btSex: function(Actor: TActor): PByte; stdcall;                                               //性别
    m_btRace: function(Actor: TActor): PByte; stdcall;                                              //怪物DB库的RaceImg
    m_btHair: function(Actor: TActor): PByte; stdcall;                                              //头发类型
    m_wDress: function(Actor: TActor): PWord; stdcall;                                              //衣服类型
    m_wWeapon: function(Actor: TActor): PWord; stdcall;                                             //武器类型
    m_btJob: function(Actor: TActor): PByte; stdcall;                                               //职业 0:武士  1:法师  2:道士
    m_btCaseltGuild: function(Actor: TActor): PByte; stdcall;                                       //1=沙行会成员 //2=沙行会掌门
    m_sDescUserName: function(Actor: TActor): PChar; stdcall;                                       //人物封号
    m_sUserName: function(Actor: TActor): PChar; stdcall;                                           //名称
    m_nNameColor: function(Actor: TActor): PInteger; stdcall;                                       //名称颜色
    m_Abil: function(Actor: TActor): pTAbility; stdcall;                                            //属性
    m_boOpenShop: function(Actor: TActor): Boolean; stdcall;                                        //是否在摆摊

    m_nSayX: function(Actor: TActor): Integer; stdcall;
    m_nSayY: function(Actor: TActor): Integer; stdcall;
    m_nShiftX: function(Actor: TActor): Integer; stdcall;
    m_nShiftY: function(Actor: TActor): Integer; stdcall;
    m_nTargetX: function(Actor: TActor): PInteger; stdcall;
    m_nTargetY: function(Actor: TActor): PInteger; stdcall;
    m_nTargetRecog: function(Actor: TActor): PInt64; stdcall;                                       // 2020-01-11 64位支持
    m_boCobweb: function(Actor: TActor): PBoolean; stdcall;                                         //网罩住了
    m_boCanDraw: function(Actor: TActor): Boolean; stdcall;                                         //该角色是否可以绘制
    m_nBagCount: function(Actor: TActor): Integer; stdcall;                                         //包裹最大数


    m_btColor: function(Actor: TActor): Byte; stdcall;                                              //脚本命令修改的身体颜色
    m_nState: function(Actor: TActor): PInteger; stdcall;                                           //人物中毒麻痹等
//------------------------------------------------------------------------------
    m_nBodyOffset: function(Actor: TActor): PInteger; stdcall;
    m_boUseMagic: function(Actor: TActor): PBoolean; stdcall;
    m_nCurrentFrame: function(Actor: TActor): PInteger; stdcall;
    m_nStartFrame: function(Actor: TActor): PInteger; stdcall;
    m_nEndFrame: function(Actor: TActor): PInteger; stdcall;
    m_dwFrameTime: function(Actor: TActor): PLongWord; stdcall;
    m_dwStartTime: function(Actor: TActor): PLongWord; stdcall;

    Reserveds: array[0..99] of Integer;
  end;

  TClientAPI = record
    ListAPI: TListAPI;
    StringListAPI: TStringListAPI;
    ItemMenuListAPI: TItemMenuListAPI;
    TextureAPI: TTextureAPI;
    ImagesAPI: TImagesAPI;                                                                          //读取WIL API
    InterfaceAPI: TInterfaceAPI;                                                                    //游戏界面API
    DrawAPI: TDrawAPI;                                                                              //绘制API
    ActorAPI: TActorAPI;                                                                            //角色相关API
    SocketAPI: TSocketAPI;
    HookAPI: THookAPI;                                                                              //HookAPI
    GameAPI: TGameAPI;
    GameInterfaceAPI: TGameInterfaceAPI;                                                            //

    PointDropItemList: TPointDropItemListAPI;                                                       // +++ 地面上某个点的物品列表 2019-12-23
    DropItemsMgr: TDropItemsMgrAPI;                                                                 // +++ 地面物品列表管理 2019-12-23

    Reserveds: array[0..88] of Integer;                                                             // ### 减少11个预留值 2019-12-23
  end;
  pTClientAPI = ^TClientAPI;


var
  ListAPI: TListAPI;
  StringListAPI: TStringListAPI;
  ItemMenuListAPI: TItemMenuListAPI;                                                                //操作TDPopupMenu.Items
  TextureAPI: TTextureAPI;
  ImagesAPI: TImagesAPI;                                                                            //读取WIL API

  DControlAPI: TDControl;
  DWindowAPI: TDWindow;
  DButtonAPI: TDButton;
  DEditAPI: TDEdit;
  DGridAPI: TDGrid;
  DComboBoxAPI: TDComboBox;
  DPopupMenuAPI: TDPopupMenu;

  DrawAPI: TDrawAPI;                                                                                //绘制API
  ActorAPI: TActorAPI;                                                                              //角色相关API
  SocketAPI: TSocketAPI;
  HookAPI: THookAPI;                                                                                //HookAPI
  GameAPI: TGameAPI;
  GameInterfaceAPI: TGameInterfaceAPI;                                                              //

// 2021-01-05 changed
function MakeDefaultMsg(wIdent: Word; nRecog: Int64; wParam, wTag, wSeries: Word): TDefaultMessage;
function EncodeMessage(Msg: TDefaultMessage): string;
function DecodeMessage(const Str: string): TDefaultMessage;
function EncodeString(const Str: string): string;
function DecodeString(const Str: string): string;
function EncodeBuffer(buf: PChar; bufsize: Integer): string;
procedure DecodeBuffer(const src: string; buf: PChar);
implementation

function GetEncodeSize(nSize: Integer): Integer;
var
  X: Double;
begin
  X := nSize * 4 / 3;
  if Int(X) < X then
    Result := Trunc(X) + 1
  else
    Result := Trunc(X)
end;

function GetDecodeSize(nSize: Integer): Integer;
begin
  Result := Trunc(nSize - nSize / 4);
end;

// 2021-01-05 changed
function MakeDefaultMsg(wIdent: Word; nRecog: Int64; wParam, wTag, wSeries: Word): TDefaultMessage;
begin
  Result.nRecog := nRecog;
  Result.wIdent := wIdent;
  Result.wParam := wParam;
  Result.wTag := wTag;
  Result.wSeries := wSeries;
end;

function EncodeMessage(Msg: TDefaultMessage): string;
var
  nLen: Integer;
  S: string;
begin
  SetLength(S, SizeOf(TDefaultMessage) * 2);
  nLen := GameAPI.EncodeBuffer(@Msg, SizeOf(TDefaultMessage), @S[1]);
  Result := Copy(S, 1, nLen);
end;

function DecodeMessage(const Str: string): TDefaultMessage;
begin
  GameAPI.DecodeBuffer(PChar(Str), Length(Str), @Result);
end;

function EncodeString(const Str: string): string;
var
  nLen: Integer;
  S: string;
begin
  SetLength(Result, Length(Str) * 2);
  nLen := GameAPI.EncodeBuffer(PChar(Str), Length(Str), @S[1]);
  Result := Copy(S, 1, nLen);
end;


function DecodeString(const Str: string): string;
var
  nLen: Integer;
  S: string;
begin
  SetLength(S, Length(Str));
  nLen := GameAPI.DecodeBuffer(PChar(Str), Length(Str), @S[1]);
  Result := Copy(S, 1, nLen);
end;

function EncodeBuffer(buf: PChar; bufsize: Integer): string;
var
  nLen: Integer;
  S: string;
begin
  SetLength(S, bufsize * 2);
  nLen := GameAPI.EncodeBuffer(buf, bufsize, @S[1]);
  Result := Copy(S, 1, nLen);
end;

procedure DecodeBuffer(const src: string; buf: PChar);
begin
  GameAPI.DecodeBuffer(PChar(src), Length(src), buf);
end;

end.

