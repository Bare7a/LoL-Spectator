unit SettingsForm;

interface

uses
  System.SysUtils, System.Classes,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, IniFile;

type
  TFormSettings = class(TForm)
    LabelFolder: TLabel;
    EditLoLFolder: TEdit;
    ButtonFolder: TButton;
    EditAPIKey: TEdit;
    LabelApi: TLabel;
    ButtonSave: TButton;
    ButtonCancel: TButton;
    procedure ButtonCancelClick(Sender: TObject);
    procedure ButtonSaveClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ButtonFolderClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormSettings: TFormSettings;

implementation

{$R *.dfm}

procedure TFormSettings.ButtonCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TFormSettings.ButtonFolderClick(Sender: TObject);
var
  StartDir : String;
begin
  StartDir := EditLoLFolder.Text;

  with TFileOpenDialog.Create(nil) do
    try
      if DirectoryExists(StartDir)
        then DefaultFolder := StartDir;

      Options := [fdoPickFolders];
      if Execute then
        EditLoLFolder.Text := FileName;
    finally
      Free;
    end;
end;

procedure TFormSettings.ButtonSaveClick(Sender: TObject);
var
  LoLFolder, APIKey : String;
begin
  LoLFolder := EditLoLFolder.Text;
  APIKey := EditAPIKey.Text;

  SåtLoLFolder(LoLFolder);
  SetAPIKey(APIKey);

  ModalResult := mrYes;
end;

procedure TFormSettings.FormShow(Sender: TObject);
var
  LoLFolder, APIKey : String;
begin
  LoLFolder := GetLoLFolder;
  APIKey := GetAPIKey;

  EditLoLFolder.Text :=  LoLFolder;
  EditAPIKey.Text := APIKey;
end;

end.
