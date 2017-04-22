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
    function FLexel(x:String):String;
    procedure FormCreate(Sender: TObject);
    function FParser(x:String):String;
    function FInterpreter(x:String):String;
    procedure EditOperacionChange(Sender: TObject);
    procedure GoClick(Sender: TObject);
    procedure Memo1Change(Sender: TObject);
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

procedure TForm1.EditOperacionChange(Sender: TObject);
begin

end;
function TForm1.FLexel(x:String):String;
begin
  FLexel:=x;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
     Arbol:= TPTree.Create();
     SParser:= TParseR.Create;
end;

function TForm1.FParser(x:String):String;
begin
  FParser:=x;
end;
function TForm1.FInterpreter(x:String):String;
begin
  FInterpreter:=x;
end;
{function TForm1.interpret():String;
begin

end; }

procedure TForm1.GoClick(Sender: TObject);
var
   lexer,parser,result:String;
begin
  text:=EditOperacion.Caption;  {TOMAREMOS EL STRING}
  lexer := FLexel(text); {ANALIZAMOS EL LEXICO --> IDENTIFICANDO NUMEROS Y OPERADORES}
  parser := FParser(lexer); {DESARROLLAMOS EL ARBOL --> ARMAMOS JERARQUIA}
  {interpreter := Interpreter(parser);
  result := interpreter.interpret();}
  result :=FInterpreter(parser); {DAR SOLUCION A LO INTERPRETADO Y JERARQUIZADO}
  SParser.Expression:=EditOperacion.Text;
  //Memo1.Lines.Add(result);
  Memo1.Lines.Add(FloatToStr(SParser.Evaluate()));
end;

procedure TForm1.Memo1Change(Sender: TObject);
begin

end;

end.

