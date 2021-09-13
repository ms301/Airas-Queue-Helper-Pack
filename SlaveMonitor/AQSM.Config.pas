unit AQSM.Config;

interface

uses
  System.JSON.Serializers;

type
  TConfig = class
  private
    [JsonName('ManagerName')]
    FManagerName: string;
    [JsonName('ManagerNumber')]
    FManagerNumber: Integer;
    [JsonName('CurrentCustomer')]
    FCurrentCustomer: Integer;
    [JsonName('Background')]
    FBackground: string;
    [JsonName('Display')]
    FDisplay: Byte;
  public
    class function LoadFromFile(const AFileName: string): TConfig;
  published
    property Display: Byte read FDisplay write FDisplay;
    property ManagerName: string read FManagerName write FManagerName;
    property ManagerNumber: Integer read FManagerNumber write FManagerNumber;
    property CurrentCustomer: Integer read FCurrentCustomer write FCurrentCustomer;
    property Background: string read FBackground write FBackground;
  end;

implementation

uses
  System.IOUtils,
  System.SysUtils;

{ TConfig }

class function TConfig.LoadFromFile(const AFileName: string): TConfig;
var
  LSerializer: TJsonSerializer;
  LFileData: string;
begin
  LSerializer := TJsonSerializer.Create;
  try
    LFileData := TFile.ReadAllText(AFileName, TEncoding.UTF8);
    Result := LSerializer.Deserialize<TConfig>(LFileData);
  finally
    LSerializer.Free;
  end;
end;

end.
