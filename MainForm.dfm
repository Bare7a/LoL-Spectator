object FormMain: TFormMain
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'LoL Spectator'
  ClientHeight = 250
  ClientWidth = 495
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PanelTop: TPanel
    Left = 0
    Top = 0
    Width = 495
    Height = 40
    Align = alTop
    Caption = 'PanelTop'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ShowCaption = False
    TabOrder = 0
    object LabelUsername: TLabel
      Left = 9
      Top = 9
      Width = 71
      Height = 19
      Caption = 'Username'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object EditUsername: TEdit
      Left = 95
      Top = 6
      Width = 300
      Height = 27
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnExit = EditUsernameExit
    end
    object ButtonSettings: TButton
      Left = 410
      Top = 6
      Width = 75
      Height = 27
      Caption = 'Settings'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = ButtonSettingsClick
    end
  end
  object PanelBottom: TPanel
    Left = 0
    Top = 190
    Width = 495
    Height = 60
    Align = alBottom
    Caption = 'PanelBottom'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ShowCaption = False
    TabOrder = 1
    object ButtonSearch: TButton
      Left = 1
      Top = 1
      Width = 493
      Height = 34
      Align = alClient
      Caption = 'Spectate'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = ButtonSearchClick
    end
    object StatusBar: TStatusBar
      Left = 1
      Top = 35
      Width = 493
      Height = 24
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      Panels = <
        item
          Text = 'Status:'
          Width = 60
        end
        item
          BiDiMode = bdLeftToRight
          ParentBiDiMode = False
          Width = 0
        end>
      UseSystemFont = False
    end
  end
  object PanelMiddle: TPanel
    Left = 0
    Top = 40
    Width = 495
    Height = 150
    Align = alClient
    Caption = 'PanelMiddle'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ShowCaption = False
    TabOrder = 2
    object RadioGroupRegion: TRadioGroup
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 487
      Height = 142
      Align = alClient
      Caption = 'Region'
      Columns = 6
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ItemIndex = 2
      Items.Strings = (
        'NA1'
        'RU'
        'EUN1'
        'EUW1'
        'KR'
        'JP1'
        'BR1'
        'OC1'
        'LA1'
        'LA2'
        'TR1')
      ParentFont = False
      TabOrder = 0
      OnClick = RadioGroupRegionClick
    end
  end
  object RESTClient: TRESTClient
    AcceptCharset = 'application/x-www-form-urlencoded; charset=UTF-8'
    Params = <>
    HandleRedirects = True
    Left = 300
    Top = 202
  end
  object RESTResponse: TRESTResponse
    Left = 440
    Top = 202
  end
  object RESTRequest: TRESTRequest
    Client = RESTClient
    Params = <>
    Response = RESTResponse
    SynchronizedEvents = False
    Left = 366
    Top = 202
  end
end
