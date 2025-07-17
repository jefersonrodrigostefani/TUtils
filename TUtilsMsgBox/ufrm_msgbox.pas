{******************************************************************************}
{*                                                                            *}
{*                                  TUtils                                    *}
{*                                JRS.NET.BR                                  *}
{*                          Tela de Mensagens Padrão                          *}
{*                                                                            *}
{* Autor: Jrs                                                                 *}
{* Data.: 17/07/2025                                                          *}
{*                                                                            *}
{******************************************************************************}

unit ufrm_msgbox;

{$mode ObjFPC}{$H+}

interface

uses
  Buttons,
  Classes,
  SysUtils,
  Forms,
  Controls,
  Graphics,
  Dialogs,
  ExtCtrls,
  StdCtrls;

type

  { Tfrm_msgbox }

  Tfrm_msgbox = class(TForm)
    bvl_btn_frm: TBevel;
    btn_add_reg: TSpeedButton;
    btn_cnc_reg: TSpeedButton;
    img_ico_reg: TImage;
    img_lst_btn: TImageList;
    img_lst_msg: TImageList;
    lbl_atc_reg: TLabel;
    procedure btn_add_regClick(Sender: TObject);
    procedure btn_cnc_regClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormPaint(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    lstTexto: TStringList;
    procedure Mostrar;
    procedure Fechar;
  public
    Texto: String;
  end;

implementation

{$R *.lfm}

procedure Tfrm_msgbox.Mostrar;
begin
  case Self.Tag of
    1:
      begin
        btn_add_reg.Visible         := True;
        btn_add_reg.Caption         := 'F2 Sim';
        btn_cnc_reg.Caption         := 'F4 Cancelar';
        btn_cnc_reg.Visible         := True;
        Self.Caption                := 'Atenção!';
        Self.img_ico_reg.ImageIndex := 0;
      end;
    2:
      begin
        btn_add_reg.Visible         := False;
        btn_add_reg.Caption         := 'F2 Sim';
        btn_cnc_reg.Caption         := 'F4 Sair';
        btn_cnc_reg.Visible         := True;
        Self.Caption                := 'Atenção!';
        Self.img_ico_reg.ImageIndex := 1;
      end;
    3:
      begin
        btn_add_reg.Visible         := False;
        btn_add_reg.Caption         := 'F2 Sim';
        btn_cnc_reg.Caption         := 'F4 Fechar';
        btn_cnc_reg.Visible         := True;
        Self.Caption                := 'Atenção!';
        Self.img_ico_reg.ImageIndex := 2;
      end;
  end;
  ExtractStrings( [#10], [], PChar( Texto ), LstTexto );
end;

procedure Tfrm_msgbox.Fechar;
begin
  if Assigned( lstTexto ) then
    FreeAndNil( lstTexto );
end;

procedure Tfrm_msgbox.FormCreate(Sender: TObject);
begin
  try
    lstTexto := TStringList.Create;
  except

  end;
end;

procedure Tfrm_msgbox.FormShow(Sender: TObject);
begin
  Mostrar;
end;

procedure Tfrm_msgbox.FormPaint(Sender: TObject);
var
  nroLinha: Integer;
  posLinha: Integer;
begin
  Self.Canvas.Brush.Style := bsClear;
  Self.Canvas.Font.Style  := [];
  Self.Canvas.Font.Name   := 'Verdana';
  Self.Canvas.Font.Size   := 14;
  Self.Canvas.Font.Color  := clBlack;
  posLinha                := 75;
  for nroLinha := 0 to lstTexto.Count-1 do
  begin
    Self.Canvas.MoveTo( lbl_atc_reg.Left, posLinha );
    Self.Canvas.TextOut( Self.Canvas.PenPos.X,
                         Self.Canvas.PenPos.Y,
                         lstTexto.Strings[nroLinha] );
    Inc( posLinha, 25 );
  end;
end;

procedure Tfrm_msgbox.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    113: btn_add_regClick( Self );
    115: btn_cnc_regClick( Self );
  end;
end;

procedure Tfrm_msgbox.btn_add_regClick(Sender: TObject);
begin
  ModalResult := mrOK;
end;

procedure Tfrm_msgbox.btn_cnc_regClick(Sender: TObject);
begin
  ModalResult := mrClose;
end;

procedure Tfrm_msgbox.FormDestroy(Sender: TObject);
begin
  Fechar;
end;

end.

