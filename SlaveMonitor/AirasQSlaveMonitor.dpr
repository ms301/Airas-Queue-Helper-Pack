program AirasQSlaveMonitor;

uses
  System.StartUpCopy,
  FMX.Forms,
  AQSM.UI in 'AQSM.UI.pas' {Form16},
  AQSM.Config in 'AQSM.Config.pas',
  AQSM.Utils in 'AQSM.Utils.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm16, Form16);
  Application.Run;
end.
