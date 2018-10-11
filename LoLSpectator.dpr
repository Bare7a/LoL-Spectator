program LoLSpectator;

uses
  Vcl.Forms,
  MainForm in 'MainForm.pas' {FormMain},
  Vcl.Themes,
  Vcl.Styles,
  SettingsForm in 'SettingsForm.pas' {FormSettings},
  IniFile in 'IniFile.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Amakrits');
  Application.CreateForm(TFormMain, FormMain);
  Application.CreateForm(TFormSettings, FormSettings);
  Application.Run;
end.
