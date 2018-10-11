unit IniFile;

interface

uses
 SysUtils, IniFiles;

function GetAPIKey : String;
function GetLoLFolder : String;
function GetUsername : String;
function GetRegion : String;
procedure SetAPIKey(APIKey : String);
procedure SåtLoLFolder(LoLFolder : String);
procedure SetUsername(Username : String);
procedure SetRegion(Region : String);

implementation

function GetAPIKey : String;
var
  MySettings  : TIniFile;
  APIKey   : String;
begin
  APIKey := '';

  MySettings := TIniFile.Create(GetCurrentDir +  '\LoLReplay.ini');
  try
    APIKey := MySettings.ReadString('Settings','APIKey', '');
  finally
    MySettings.Free;
  end;

  Result := APIKey;
end;

function GetLoLFolder : String;
var
  MySettings  : TIniFile;
  LoLFolder   : String;
begin
  LoLFolder := '';

  MySettings := TIniFile.Create(GetCurrentDir +  '\LoLReplay.ini');
  try
    LoLFolder := MySettings.ReadString('Settings','LoLFolder', '');
  finally
    MySettings.Free;
  end;

  Result := LoLFolder;
end;

function GetUsername : String;
var
  MySettings  : TIniFile;
  Username   : String;
begin
  Username := '';

  MySettings := TIniFile.Create(GetCurrentDir +  '\LoLReplay.ini');
  try
    Username := MySettings.ReadString('Settings','Username', '');
  finally
    MySettings.Free;
  end;

  Result := Username;
end;

function GetRegion : String;
var
  MySettings  : TIniFile;
  Region   : String;
begin
  Region := '';

  MySettings := TIniFile.Create(GetCurrentDir +  '\LoLReplay.ini');
  try
    Region := MySettings.ReadString('Settings','Region', '');
  finally
    MySettings.Free;
  end;

  Result := Region;
end;
//------------------------------------------------------------------------------------
procedure SetAPIKey(APIKey : String);
var
  MySettings : TIniFile;
begin
  MySettings := TIniFile.Create(GetCurrentDir +  '\LoLReplay.ini');
  try
    MySettings.WriteString('Settings','APIKey', APIKey);
  finally
    MySettings.Free;
  end;
end;

procedure SåtLoLFolder(LoLFolder : String);
var
  MySettings : TIniFile;
begin
  MySettings := TIniFile.Create(GetCurrentDir +  '\LoLReplay.ini');
  try
    MySettings.WriteString('Settings','LoLFolder', LoLFolder);
  finally
    MySettings.Free;
  end;
end;

procedure SetUsername(Username : String);
var
  MySettings : TIniFile;
begin
  MySettings := TIniFile.Create(GetCurrentDir +  '\LoLReplay.ini');
  try
    MySettings.WriteString('Settings','Username', Username);
  finally
    MySettings.Free;
  end;
end;

procedure SetRegion (Region : String);
var
  MySettings : TIniFile;
begin
  MySettings := TIniFile.Create(GetCurrentDir +  '\LoLReplay.ini');
  try
    MySettings.WriteString('Settings','Region', Region);
  finally
    MySettings.Free;
  end;
end;

end.
