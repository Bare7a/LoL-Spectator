unit MainForm;

interface

uses
  System.SysUtils, System.Classes, System.Net.URLClient, Winapi.Windows,
  Vcl.Controls, Vcl.ComCtrls, Vcl.Forms, Vcl.ExtCtrls, Vcl.StdCtrls,
  DateUtils, IniFile, IOUtils, JSON, ShellAPI, SettingsForm, Types,
  Data.Bind.Components, Data.Bind.ObjectScope, REST.Client, IPPeerClient;

type
  TFormMain = class(TForm)
    PanelTop: TPanel;
    LabelUsername: TLabel;
    EditUsername: TEdit;
    PanelBottom: TPanel;
    PanelMiddle: TPanel;
    RadioGroupRegion: TRadioGroup;
    StatusBar: TStatusBar;
    ButtonSearch: TButton;
    ButtonSettings: TButton;
    RESTClient: TRESTClient;
    RESTResponse: TRESTResponse;
    RESTRequest: TRESTRequest;
    procedure ButtonSettingsClick(Sender: TObject);
    procedure RadioGroupRegionClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ButtonSearchClick(Sender: TObject);
    procedure EditUsernameExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  const ApplicationName = 'LoL Spectator';
var
  FormMain: TFormMain;

  function GetLoLLocation : String;

implementation

{$R *.dfm}

procedure TFormMain.ButtonSearchClick(Sender: TObject);
var
  Username, Region, LoLLocation, APIKey : String;
  UserID, GameID, GameCode : String;
  AccountQuery, GameQuery, CMDParams : String;
  JSONResponse : TJSONObject;
begin
  Username := GetUsername;
  Region := GetRegion;
  LoLLocation := GetLoLLocation;
  APIKey := GetAPIKey;

  if Username = ''
    then StatusBar.Panels.Items[1].Text := 'Please provide a Username'
  else if Region = ''
    then StatusBar.Panels.Items[1].Text := 'Please provide a Region'
  else if LoLLocation = ''
    then StatusBar.Panels.Items[1].Text := 'Please provide a valid LoL Folder (Settings)'
  else if APIKey = ''
    then StatusBar.Panels.Items[1].Text := 'Please provide a valid API Key (Settings)'
  else
    begin
      AccountQuery := 'https://' + LowerCase(Region) + '.api.riotgames.com/lol/' +
                 'summoner/v3/summoners/by-name/' + Username;// + '?api_key=' + APIKey;

      try
        RESTClient.BaseURL := AccountQuery;
        RESTClient.Params.AddHeader('X-Riot-Token', APIKey);

        RESTRequest.Execute;
        JSONResponse := RESTResponse.JSONValue as TJSONObject;

        UserID := JSONResponse.Values['id'].Value;
        //-------------------------------------------------------------
        GameQuery := 'https://' + LowerCase(Region) + '.api.riotgames.com/lol/' +
                      'spectator/v3/active-games/by-summoner/' + UserID;
        RESTClient.BaseURL := GameQuery;


        RESTRequest.Execute;
        JSONResponse := RESTResponse.JSONValue as TJSONObject;

        GameID := JSONResponse.Values['gameId'].Value;
        GameCode := (JSONResponse.Values['observers'] as TJSONObject)
                                            .Values['encryptionKey'].Value;
      except

      end;

      if RESTRequest.Response.StatusCode = 403
        then StatusBar.Panels.Items[1].Text := 'The provided API Key is not valid'
      else if UserID = ''
        then StatusBar.Panels.Items[1].Text := 'Wrong username/region'
      else if GameID = ''
        then StatusBar.Panels.Items[1].Text := Username + ' is not currently ingame'
      else
        begin
          StatusBar.Panels.Items[1].Text := 'Starting spectator mode';

          CMDParams := 	'"8394" "LoLLauncher.exe" "" "spectator spectator.' +
            LowerCase(Region) + '.lol.riotgames.com:80 ' + GameCode + ' '  +
            GameID + ' ' + Region + '" "-UseRads"';

          ShellExecute(Handle, 'open', PWChar(LoLLocation), PChar(CMDParams), nil, SW_SHOWNORMAL);
        end;
    end;
end;

procedure TFormMain.ButtonSettingsClick(Sender: TObject);
begin
  FormSettings.ShowModal;
end;

procedure TFormMain.EditUsernameExit(Sender: TObject);
var
  Username : String;
begin
  Username := EditUsername.Text;
  SetUsername(Username);
end;

procedure TFormMain.FormCreate(Sender: TObject);
begin
  Application.Title := ApplicationName;
end;

procedure TFormMain.FormShow(Sender: TObject);
var
  RegionID, RegionCount : Cardinal;
  Username, Region : String;
begin
  Username := GetUsername;
  Region := GetRegion;

  EditUsername.Text := GetUsername;

  RegionCount := RadioGroupRegion.Items.Count;
  for RegionID := 0 to RegionCount - 1 do
    begin
      if RadioGroupRegion.Items[RegionID] = Region then
        begin
          RadioGroupRegion.ItemIndex := RegionID;
          break;
        end;
    end;
end;

procedure TFormMain.RadioGroupRegionClick(Sender: TObject);
var
  Region : String;
begin
  Region := RadioGroupRegion.Items[RadioGroupRegion.ItemIndex];
  SetRegion(Region);
end;

function GetLoLLocation : String;
var
  LoLFolder : String;
  LoLLocation: String;

  function FindLastCreatedDirectory(const APath: string): string;
  var
    LastCreateTime : TDateTime;
    PathsInQuestion: TStringDynArray;
    n : Integer;
  begin
    LastCreateTime := MinDateTime;
    Result := '';

    PathsInQuestion := TDirectory.GetDirectories(APath);
    for n := Low(PathsInQuestion) to High(PathsInQuestion) do
    begin
      if CompareDateTime( TDirectory.GetCreationTime(PathsInQuestion[n]), LastCreateTime ) = GreaterThanValue then
      begin
        LastCreateTime := TDirectory.GetCreationTime(PathsInQuestion[n]);
        Result := PathsInQuestion[n];
      end;
    end;
  end;

begin
  LoLFolder := IncludeTrailingPathDelimiter(GetLoLFolder);
  LoLFolder := LoLFolder + 'RADS\solutions\lol_game_client_sln\releases\';

  if DirectoryExists(LoLFolder) then
    begin
      LoLFolder := FindLastCreatedDirectory(LoLFolder);

      LoLLocation := IncludeTrailingPathDelimiter(LoLFolder) +  'deploy\League of Legends.exe';

      if NOT FileExists(LoLLocation)
        then LoLLocation := '';
    end
  else
    LoLLocation := '';

  Result := LoLLocation;
end;

end.
