unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, Menus,
  StdCtrls, ExtDlgs, Clipbrd, Unit2, Types;

type

  { TForm1 }

  TForm1 = class(TForm)
    Image: TImage;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem12: TMenuItem;
    MenuItem13: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    OpenPictureDialog1: TOpenPictureDialog;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDropFiles(Sender: TObject; const FileNames: array of String);
    procedure ImageDblClick(Sender: TObject);
    procedure ImageMouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure MenuItem10Click(Sender: TObject);
    procedure MenuItem11Click(Sender: TObject);
    procedure MenuItem13Click(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem6Click(Sender: TObject);
    procedure MenuItem7Click(Sender: TObject);
    procedure MenuItem9Click(Sender: TObject);
    procedure saveCfg();
    procedure loadCfg();
    procedure OpenPictureDialog1Close(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;
  picPath: string;
  configFile: TStringList;
  config: Text;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.MenuItem1Click(Sender: TObject);
begin

end;

procedure TForm1.ImageDblClick(Sender: TObject);
begin
  OpenPictureDialog1.Execute;
end;

procedure TForm1.ImageMouseWheelUp(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin

end;

procedure TForm1.MenuItem10Click(Sender: TObject);
begin
  if (MenuItem10.Checked = False) then
    MenuItem10.Checked := True
  else
    MenuItem10.Checked := False;
  Image.Center:=MenuItem10.Checked;
end;

procedure TForm1.MenuItem11Click(Sender: TObject);
begin
  Form1.WindowState:=wsNormal;
  Form1.Width:=Image.Picture.Width;
  Form1.Height:=Image.Picture.Height+MainMenu1.Height;
end;

procedure TForm1.MenuItem13Click(Sender: TObject);
begin
  If (Clipboard.HasPictureFormat = true) then
    begin
  Image.Picture.LoadFromClipboardFormat(Clipboard.FindPictureFormatID);
    form1.caption := 'Clipboard | Miatu'
    end
  else
  begin
       ShowMessage('There are no images in the clipboard.');
    end;
    end;

procedure TForm1.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  saveCfg();
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  if paramcount = 1 then
  begin
    picPath := ParamStr(1);
    Image.Picture.LoadFromFile(ParamStr(1));
    Form1.Caption := picPath + ' - Miatu';
    end
  else
    picPath := '';
  loadCfg();
end;

procedure TForm1.FormDropFiles(Sender: TObject; const FileNames: array of String
  );
var
  i: integer;
begin
  for i := Low(FileNames) to High(FileNames) do
    picPath := FileNames[i];
  Image.Picture.LoadFromFile(FileNames[i]);
    Form1.Caption := picPath + ' - Miatu';
end;

procedure TForm1.MenuItem2Click(Sender: TObject);
begin
  OpenPictureDialog1.Execute;
end;

procedure TForm1.MenuItem4Click(Sender: TObject);
begin
  Form1.Close();
end;

procedure TForm1.MenuItem6Click(Sender: TObject);
begin
  Form2.ShowModal;
end;

procedure TForm1.MenuItem7Click(Sender: TObject);
begin
  Image.Picture.Clear;
  Form1.Caption := 'No image | Miatu';
end;

procedure TForm1.MenuItem9Click(Sender: TObject);
begin
  if (MenuItem9.Checked = False) then
    MenuItem9.Checked := True
  else
    MenuItem9.Checked := False;
  Image.Stretch:=MenuItem9.Checked;
end;

procedure TForm1.saveCfg();
begin
  AssignFile(config, 'miatu.cfg');
  Rewrite(config);
  Writeln(config, WindowStateToStr(Form1.WindowState));
  Writeln(config, IntToStr(Form1.Width));
  Writeln(config, IntToStr(Form1.Height));
  Writeln(config, IntToStr(Form1.Left));
  Writeln(config, IntToStr(Form1.Top));
  Writeln(config, BoolToStr(MenuItem9.Checked));
  Writeln(config, BoolToStr(MenuItem10.Checked));
  Writeln(config, '');
  Writeln(config, '---');
  Writeln(config, '');
  WriteLn(config, 'Miatu configuration file.');
  WriteLn(config, '');
  WriteLn(config, 'If you are not an experienced user, PLEASE DON''T EDIT THIS FILE. ');
  WriteLn(config, '');
  Writeln(config, '1st string - Main form window state');
  Writeln(config, '2nd string - Main form width');
  Writeln(config, '3th string - Main form height');
  Writeln(config, '4th string - Main form X position');
  Writeln(config, '5th string - Main form Y position');
  writeln(config, '6th string - Stretch image?');
  writeln(config, '7th string - Center image?');

  CloseFile(config);
end;

procedure TForm1.loadCfg();
begin
  if FileExists('miatu.cfg') then
  begin
    configFile := TStringList.Create;
    configFile.LoadFromFile('miatu.cfg');
    Form1.WindowState:=StrToWindowState(configFile.Strings[0]);

    Form1.Width := StrToInt(configFile.Strings[1]);
    Form1.Height := StrToInt(configFile.Strings[2]);

    Form1.Left := StrToInt(configFile.Strings[3]);
    Form1.Top := StrToInt(configFile.Strings[4]);

    MenuItem9.Checked:=StrToBool(configFile.Strings[5]);
    MenuItem10.Checked:=StrToBool(configFile.Strings[6]);

    Image.Stretch:=MenuItem9.Checked;
    Image.Center:=MenuItem10.Checked;
  end;
end;

procedure TForm1.OpenPictureDialog1Close(Sender: TObject);
begin
  if (OpenPictureDialog1.FileName = '') then
  begin

  end
  else
  begin
    picPath := OpenPictureDialog1.FileName;
    form1.Caption := picPath + ' | Miatu';
    Image.Picture.LoadFromFile(OpenPictureDialog1.FileName);
  end;
end;

end.
