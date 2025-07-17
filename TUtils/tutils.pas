{******************************************************************************}
{*                                                                            *}
{*                                  TUtils                                    *}
{*                                JRS.NET.BR                                  *}
{*          Agrupamento de rotinas facilitadoras para uso em sistemas         *}
{*                                                                            *}
{* Autor: Jrs                                                                 *}
{* Data.: 17/07/2025                                                          *}
{*                                                                            *}
{******************************************************************************}

unit TUtils;

{$mode ObjFPC}{$H+}

interface

uses
  { Units Nativas }
  base64,
  Classes,
  Controls,
  ComCtrls,
  DateUtils,
  ExtCtrls,
  Forms,
  md5,
  SysUtils,
  { Units Próprias }
  ufrm_msgbox;

type
  TCustomFrameClass = class of TCustomFrame;
  TMsgBoxTipoMsgBox = ( mbxAlerta, mbxConfirmar, mbxOk );

  { TUtilsApp }

  TUtilsApp = class
    public
      class function AppDir: String;
      class function AppExe: String;
      class function AppIni: String;
      class function AppIco: String;
      class function NomeMQ: String;
  end;

  { TUtilsDataHora }

  TUtilsDataHora = class
    public
      class function Saudacao: String;
      class function MesInt: Integer;
      class function MesInt(Const Data: TDateTime): Integer; overload;
      class function MesStr: String;
      class function MesStr(Const Data: TDateTime): String; overload;
      class function DataOk(Const Data: TDateTime): Boolean;
      class function AnoBissexto(Const Data: TDateTime): Boolean;
      class function QtdDias(Const Data: TDatetime): Integer;
  end;

  { TUtilsDiversos }

  TUtilsDiversos = class
    public
      class function IIF( Const AValue: Boolean; ATrue: String ; AFalse: String  ): String;  overload;
      class function IIF( const AValue: Boolean; ATrue: Integer; AFalse: Integer ): Integer; overload;
      class function EncodeBase64(Const Valor: String): String;
      class function DecodeBase64(Const Valor: String): String;
  end;

  { TUtilsForms }

  TUtilsForms = class
    public
      class var LimiteDeAbas: Integer;
      class var QtdAbasAbertas: Integer;
      class function ShowFrm(Aowner: TComponent; AFormName: TFormClass; iTag: Integer): Boolean;
      class function ShowTdi(Aowner: TComponent; AFormName: TFormClass; APageControl: TPageControl; ACaption: String = ''; AImageIndex: Integer = -1): Boolean;
      class function CloseTdi( APageControl: TPageControl ): Boolean;
      class function ShowFrame(Aowner: TComponent; APanel: TPanel; AFrameClass: TCustomFrameClass; AFrameName: String): TFrame;
      class function CloseFrame(Aowner: TComponent; AFrameName: String): Boolean;
      class function ShowMsg(Aowner: TComponent; Texto: String; TipoMsgBox: TMsgBoxTipoMsgBox ): Boolean;
  end;

  { TUtilsSeguranca }

  TUtilsSeguranca = class
    public
      class function GeraMD5Str(Const Valor: String): String;
      class function GeraMD5App(Const Valor: String): String;
  end;

  { TUtilsTeclado }

  TUtilsTeclado = class
    public
      class function TECLA_NULL      : Integer;
      class function TECLA_BACKSPACE : Integer;
      class function TECLA_TAB       : Integer;
      class function TECLA_ENTER     : Integer;
      class function TECLA_ESC       : Integer;
      class function TECLA_DELETE    : Integer;
      class function TECLA_INSERT    : Integer;
      class function TECLA_VIRGULA   : Integer;
      class function TECLA_PONTO     : Integer;
      class function TECLA_F1        : Integer;
      class function TECLA_F2        : Integer;
      class function TECLA_F3        : Integer;
      class function TECLA_F4        : Integer;
      class function TECLA_F5        : Integer;
      class function TECLA_F6        : Integer;
      class function TECLA_F7        : Integer;
      class function TECLA_F8        : Integer;
      class function TECLA_F9        : Integer;
      class function TECLA_F10       : Integer;
  end;

implementation

{ TUtilsApp }

class function TUtilsApp.AppDir: String;
begin
  Result := ExtractFilePath( Application.ExeName );
end;

class function TUtilsApp.AppExe: String;
begin
  Result := ExtractFileName( Application.ExeName );
end;

class function TUtilsApp.AppIni: String;
begin
  Result := ChangeFileExt( AppExe, '.ini' );
end;

class function TUtilsApp.AppIco: String;
begin
  Result := ChangeFileExt( AppExe, '.ico' );
end;

class function TUtilsApp.NomeMQ: String;
begin
  Result := GetEnvironmentVariable('COMPUTERNAME');
end;

{ TUtilsDataHora }

class function TUtilsDataHora.Saudacao: String;
var
  hora      : Integer;
  minuto    : Integer;
  intervalo : Integer;
begin
  hora      := StrToInt( FormatDateTime( 'hh', Time ) );
  minuto    := StrToInt( FormatDateTime( 'nn', Time ) );
  intervalo := ( 60 * hora ) + minuto;

  if ( intervalo >= 360 ) and ( intervalo < 720 ) then
    Result := 'Bom dia!'
  else
  if ( intervalo >= 720 ) and ( intervalo < 1080 ) then
    Result := 'Boa tarde!'
  else
    Result := 'Boa noite!';
end;

class function TUtilsDataHora.MesInt: Integer;
begin
  Result := MonthOf( Now );
end;

class function TUtilsDataHora.MesStr: String;
begin
  case MonthOf( Now ) of
    01: Result := 'Janeiro';
    02: Result := 'Fevereiro';
    03: Result := 'Março';
    04: Result := 'Abril';
    05: Result := 'Maio';
    06: Result := 'Junho';
    07: Result := 'Julho';
    08: Result := 'Agosto';
    09: Result := 'Setembro';
    10: Result := 'Outubro';
    11: Result := 'Novembro';
    12: Result := 'Dezembro';
  end;
end;

class function TUtilsDataHora.MesInt(const Data: TDateTime): Integer;
begin
  Result := MonthOf( Data );
end;

class function TUtilsDataHora.MesStr(const Data: TDateTime): String;
begin
  case MonthOf( Data ) of
    01: Result := 'Janeiro';
    02: Result := 'Fevereiro';
    03: Result := 'Março';
    04: Result := 'Abril';
    05: Result := 'Maio';
    06: Result := 'Junho';
    07: Result := 'Julho';
    08: Result := 'Agosto';
    09: Result := 'Setembro';
    10: Result := 'Outubro';
    11: Result := 'Novembro';
    12: Result := 'Dezembro';
  end;
end;

class function TUtilsDataHora.DataOk(const Data: TDateTime): Boolean;
var
  dia: Word;
  mes: Word;
  ano: Word;
begin
  DecodeDate( Data, ano, mes, dia );

  if ( dia <= 0 ) or ( dia > 31 ) then
    Result := False
  else
  if ( mes <= 0 ) or ( mes > 12 ) then
    Result := False
  else
  if ( mes = 2 ) and AnoBissexto( Data ) and ( dia > 29 ) then
    Result := False
  else
    Result := True;
end;

class function TUtilsDataHora.AnoBissexto(const Data: TDateTime): Boolean;
var
  dia: Word;
  mes: Word;
  ano: Word;
begin
  DecodeDate( Data, ano, mes, dia );

  if ( ano MOD 400 = 0 ) then
    Result := True
  else
  if ( ano MOD 4 = 0 ) and ( ano MOD 100 <> 0 ) then
    Result := True
  else
    Result := False;
end;

class function TUtilsDataHora.QtdDias(const Data: TDatetime): Integer;
begin
  case MonthOf( Data ) of
    01: Result := 000 + DayOf( Data );
    02: Result := 031 + DayOf( Data );
    03: Result := 059 + DayOf( Data ) + TUtilsDiversos.IIF( AnoBissexto( Data), 1, 0 );
    04: Result := 090 + DayOf( Data ) + TUtilsDiversos.IIF( AnoBissexto( Data), 1, 0 );
    05: Result := 120 + DayOf( Data ) + TUtilsDiversos.IIF( AnoBissexto( Data), 1, 0 );
    06: Result := 151 + DayOf( Data ) + TUtilsDiversos.IIF( AnoBissexto( Data), 1, 0 );
    07: Result := 181 + DayOf( Data ) + TUtilsDiversos.IIF( AnoBissexto( Data), 1, 0 );
    08: Result := 212 + DayOf( Data ) + TUtilsDiversos.IIF( AnoBissexto( Data), 1, 0 );
    09: Result := 242 + DayOf( Data ) + TUtilsDiversos.IIF( AnoBissexto( Data), 1, 0 );
    10: Result := 273 + DayOf( Data ) + TUtilsDiversos.IIF( AnoBissexto( Data), 1, 0 );
    11: Result := 304 + DayOf( Data ) + TUtilsDiversos.IIF( AnoBissexto( Data), 1, 0 );
    12: Result := 334 + DayOf( Data );
  end;
end;

{ TUtilsDiversos }

class function TUtilsDiversos.IIF(const AValue: Boolean; ATrue: String;
  AFalse: String): String;
begin
  if AValue then Result := ATrue else Result := AFalse;
end;

class function TUtilsDiversos.IIF(const AValue: Boolean; ATrue: Integer;
  AFalse: Integer): Integer;
begin
  if AValue then Result := ATrue else Result := AFalse;
end;

class function TUtilsDiversos.EncodeBase64(const Valor: String): String;
begin
  Result := EncodeStringBase64( Valor );
end;

class function TUtilsDiversos.DecodeBase64(const Valor: String): String;
begin
  Result := DecodeStringBase64( Valor );
end;

{ TUtilsForms }

class function TUtilsForms.ShowFrm(Aowner: TComponent; AFormName: TFormClass;
  iTag: Integer): Boolean;
var
  Frm: TForm;
begin
  try
    Frm     := AFormName.Create( Aowner );
    Frm.Tag := iTag;

    if ( Frm.ShowModal = mrOk ) then
      Result := True
    else
      Result := False;

  finally
    FreeAndNil( Frm );
  end;
end;

class function TUtilsForms.ShowTdi(Aowner: TComponent; AFormName: TFormClass;
  APageControl: TPageControl; ACaption: String; AImageIndex: Integer): Boolean;
var
  oFrm   : TForm;
  oTbs   : TTabSheet;
  i      : Integer;
  bAchou : Boolean;
begin
  if ( QtdAbasAbertas > LimiteDeAbas ) then
  begin
    Result := False;
    Exit;
  end;

  Result := True;
  bAchou := False;

  for i := 0 to Pred( APageControl.PageCount ) do
  begin
    if APageControl.Pages[i].Caption = ACaption then
    begin
      bAchou := True;
      APageControl.ActivePage := APageControl.Pages[i];
      Break;
    end;
  end;

  if not bAchou then
  begin
    oTbs                    := TTabSheet.Create( APageControl );
    oTbs.Caption            := ACaption;
    oTbs.PageControl        := APageControl;
    oTbs.ImageIndex         := AImageIndex;
    oFrm                    := AFormName.Create( Aowner );
    oFrm.Caption            := ACaption;
    oFrm.Parent             := oTbs;
    oFrm.BorderStyle        := bsNone;
    oFrm.Align              := alClient;
    oFrm.Visible            := True;
    APageControl.ActivePage := oTbs;

    if ( QtdAbasAbertas = 0 ) then
      QtdAbasAbertas := 1
    else
      Inc( QtdAbasAbertas, 1 );
  end;
end;

class function TUtilsForms.CloseTdi(APageControl: TPageControl): Boolean;
begin
  Result := True;
  Dec( QtdAbasAbertas, 1 );
  APageControl.Pages[ APageControl.ActivePageIndex ].Destroy;
end;

class function TUtilsForms.ShowFrame(Aowner: TComponent; APanel: TPanel;
  AFrameClass: TCustomFrameClass; AFrameName: String): TFrame;
var
  Frame: TCustomFrame;
begin
  try
    Frame         := AFrameClass.Create( Aowner );
    Frame.Name    := AFrameName;
    Frame.Parent  := APanel;
    Frame.Visible := True;
    Result        := ( Aowner.FindComponent( AFrameName ) As TFrame );
  except
    Result := nil;
  end;
end;

class function TUtilsForms.CloseFrame(Aowner: TComponent; AFrameName: String
  ): Boolean;
var
  Frame: TFrame;
begin
  try
    Result := True;
    Frame  := ( Aowner.FindComponent( AFrameName ) As TFrame );

    if Assigned( Frame ) then
      FreeAndNil( Frame );
  except
    Result := False;
  end;
end;

class function TUtilsForms.ShowMsg(Aowner: TComponent; Texto: String;
  TipoMsgBox: TMsgBoxTipoMsgBox): Boolean;
var
  frmMsgBox: Tfrm_msgbox;
begin
  try
    frmMsgBox       := Tfrm_msgbox.Create( Aowner );
    frmMsgBox.Texto := Texto;

    case TipoMsgBox of
      mbxAlerta    : frmMsgBox.Tag := 2;
      mbxConfirmar : frmMsgBox.Tag := 1;
      mbxOk        : frmMsgBox.Tag := 3;
    end;

    if ( frmMsgBox.ShowModal = mrOk ) then
      Result := True
    else
      Result := False;

  finally
    FreeAndNil( frmMsgBox );
  end;
end;

{ TUtilsSeguranca }

class function TUtilsSeguranca.GeraMD5Str(const Valor: String): String;
begin
  Result := MD5Print( MD5String( Valor ) );
end;

class function TUtilsSeguranca.GeraMD5App(const Valor: String): String;
var
  I     : Integer;
  digest: TMD5Digest;
  md5Str: String;
begin
  md5Str := EmptyStr;
  Result := EmptyStr;
  try
    if ( Valor.IsEmpty ) then
      digest := MD5File( TUtilsApp.AppDir+ParamStr(0) )
    else
      digest := MD5File( Valor );

    for I := 0 to 15 do
      md5Str := md5Str + IntToHex( digest[I], 2 );

    Result := md5Str;
  except
    Result := EmptyStr
  end;
end;

{ TUtilsTeclado }

class function TUtilsTeclado.TECLA_NULL: Integer;
begin
  Result := 0;
end;

class function TUtilsTeclado.TECLA_BACKSPACE: Integer;
begin
  Result := 8;
end;

class function TUtilsTeclado.TECLA_TAB: Integer;
begin
  Result := 9;
end;

class function TUtilsTeclado.TECLA_ENTER: Integer;
begin
  Result := 13;
end;

class function TUtilsTeclado.TECLA_ESC: Integer;
begin
  Result := 27;
end;

class function TUtilsTeclado.TECLA_DELETE: Integer;
begin
  Result := 127;
end;

class function TUtilsTeclado.TECLA_INSERT: Integer;
begin
  Result := 45;
end;

class function TUtilsTeclado.TECLA_VIRGULA: Integer;
begin
  Result := 44;
end;

class function TUtilsTeclado.TECLA_PONTO: Integer;
begin
  Result := 46;
end;

class function TUtilsTeclado.TECLA_F1: Integer;
begin
  Result := 112;
end;

class function TUtilsTeclado.TECLA_F2: Integer;
begin
  Result := 113;
end;

class function TUtilsTeclado.TECLA_F3: Integer;
begin
  Result := 114;
end;

class function TUtilsTeclado.TECLA_F4: Integer;
begin
  Result := 115;
end;

class function TUtilsTeclado.TECLA_F5: Integer;
begin
  Result := 116;
end;

class function TUtilsTeclado.TECLA_F6: Integer;
begin
  Result := 117;
end;

class function TUtilsTeclado.TECLA_F7: Integer;
begin
  Result := 118;
end;

class function TUtilsTeclado.TECLA_F8: Integer;
begin
  Result := 119;
end;

class function TUtilsTeclado.TECLA_F9: Integer;
begin
  Result := 120;
end;

class function TUtilsTeclado.TECLA_F10: Integer;
begin
  Result := 121;
end;

end.

