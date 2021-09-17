unit AQSM.UI;

interface

uses
  AQSM.Config,
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Effects, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts;

type
  TForm16 = class(TForm)
    lblManagerName: TLabel;
    lblCurrentCustomer: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Single);
    procedure FormResize(Sender: TObject);
  private
    { Private declarations }
    FConfig: TConfig;
  public
    { Public declarations }
    procedure ApplyConfig(AConfig: TConfig);
    procedure ShowOnDisplay(const ADisplay: Byte);
    procedure KickOutMouse(X, Y: Single; AScreen: Byte);
    procedure UpdateLabelFontSize(lbl: TLabel);
  end;

var
  Form16: TForm16;

implementation

uses
  AQSM.Utils,
  Winapi.Windows;

{$R *.fmx}

procedure TForm16.ApplyConfig(AConfig: TConfig);
begin
  ShowOnDisplay(AConfig.Display);
  lblManagerName.Text := AConfig.ManagerName;
  if AConfig.ManagerNumber >= 0 then
    lblManagerName.Text := lblManagerName.Text + ' ' + AConfig.ManagerNumber.ToString;
  if AConfig.CurrentCustomer >= 0 then
    lblCurrentCustomer.Text := AConfig.CurrentCustomer.ToString;
  Fill.Bitmap.Bitmap.LoadFromFile(AConfig.Background);
end;

procedure TForm16.FormCreate(Sender: TObject);
const
  X = 0;

begin
  lblCurrentCustomer.Text := string.Empty;
  FConfig := TConfig.LoadFromFile('config.json');

  ApplyConfig(FConfig);

end;

procedure TForm16.FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Single);
begin
  KickOutMouse(X, Y, FConfig.Display);

end;

procedure TForm16.FormResize(Sender: TObject);
begin
  lblManagerName.Height := ClientHeight * 0.2;
  UpdateLabelFontSize(lblManagerName);
  UpdateLabelFontSize(lblCurrentCustomer);
end;

procedure TForm16.KickOutMouse(X, Y: Single; AScreen: Byte);
var
  lCenter: Single;
begin
  lCenter := Screen.Displays[AScreen].WorkArea.Width / 2;
  if X < lCenter then
    SetCursorPos(0, Trunc(Y))
  else
    SetCursorPos(ClientWidth + 1, Trunc(Y))
end;

procedure TForm16.ShowOnDisplay(const ADisplay: Byte);
begin
  if Screen.MultiDisplaySupported then
  begin
    Left := Screen.Displays[ADisplay].WorkArea.Left;
    Top := Screen.Displays[ADisplay].WorkArea.Top;
    Width := Screen.Displays[ADisplay].WorkArea.Width;
    Height := Screen.Displays[ADisplay].WorkArea.Height;
  end
  else
    raise Exception.Create('В системі встановлено лише один монітор');
end;

procedure TForm16.UpdateLabelFontSize(lbl: TLabel);

begin
  lbl.Font.Size := FontSizeForBox(lbl.Text, lbl.Font, lbl.Width, lbl.Height);
end;

end.
