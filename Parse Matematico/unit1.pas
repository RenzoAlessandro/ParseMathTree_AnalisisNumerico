unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, RTTICtrls, Forms, Controls, Graphics, Dialogs,
  StdCtrls, ComCtrls, tree,ParseR;

type

  { TForm1 }

  TForm1 = class(TForm)
    Go: TButton;
    EditOperacion: TEdit;
    Operacion: TLabel;
    Respuesta: TLabel;
    ParceMatematico: TLabel;
    Memo1: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure GoClick(Sender: TObject);
    procedure ParceMatematicoClick(Sender: TObject);
  private
    { private declarations }
  public
    Arbol :TPTree;
    SParser : TParseR;
    { public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
     Arbol:= TPTree.Create();
     SParser:= TParseR.Create;
end;

procedure TForm1.GoClick(Sender: TObject);
begin
  SParser.Expression:=EditOperacion.Text;
  Memo1.Lines.Add(FloatToStr(SParser.Evaluate()));
end;

procedure TForm1.ParceMatematicoClick(Sender: TObject);
begin

end;

end.

