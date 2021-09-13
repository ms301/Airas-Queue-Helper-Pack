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
    Rectangle1: TRectangle;
    lblCurrentCustomer: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ApplyConfig(AConfig: TConfig);
    procedure ShowOnDisplay(const ADisplay: Byte);
  end;

var
  Form16: TForm16;

implementation

{$R *.fmx}

procedure TForm16.ApplyConfig(AConfig: TConfig);
begin
  ShowOnDisplay(AConfig.Display);
  lblManagerName.Text := AConfig.ManagerName;
  if AConfig.ManagerNumber >= 0 then
    lblManagerName.Text := lblManagerName.Text + ' ' + AConfig.ManagerNumber.ToString;
  if AConfig.CurrentCustomer >= 0 then
    lblCurrentCustomer.Text := AConfig.CurrentCustomer.ToString;
end;

procedure TForm16.FormCreate(Sender: TObject);
const
  x = 0;
var
  lConfig: TConfig;
begin
  lblCurrentCustomer.Text := string.Empty;
  lConfig := TConfig.LoadFromFile('config.json');
  try
    ApplyConfig(lConfig);
  finally
    lConfig.Free;
  end;
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

end.
