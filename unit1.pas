unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, Menus,
  StdCtrls, ExtDlgs, Clipbrd;

type

  { TForm1 }

  TForm1 = class(TForm)
    Image1: TImage;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    OpenPictureDialog1: TOpenPictureDialog;
    procedure Image1Click(Sender: TObject);
    procedure Image1DblClick(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem6Click(Sender: TObject);
    procedure OpenPictureDialog1Close(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;
implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.MenuItem1Click(Sender: TObject);
begin

end;

procedure TForm1.Image1Click(Sender: TObject);
begin

end;

procedure TForm1.Image1DblClick(Sender: TObject);
begin
  OpenPictureDialog1.execute;
end;

procedure TForm1.MenuItem2Click(Sender: TObject);
begin
  OpenPictureDialog1.execute;
end;

procedure TForm1.MenuItem4Click(Sender: TObject);
begin
  Form1.close();
end;

procedure TForm1.MenuItem6Click(Sender: TObject);
begin
  ShowMessage('JustView 0.1'+#13+#13+'Simplest image viewer for Linux.'+#13+#13+'License: GNU GPL v2'+#13+'Copyright (c) KATAR 2021');
end;

procedure TForm1.OpenPictureDialog1Close(Sender: TObject);
begin
  If (OpenPictureDialog1.FileName = '') then
  begin

  end
  else
  begin
  Image1.Picture.LoadFromFile(OpenPictureDialog1.FileName);
  end;
end;

end.

