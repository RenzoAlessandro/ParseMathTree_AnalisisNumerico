unit ParseR;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, gstack, math, Dialogs;
type
  TParseR = Class
  Private
  Public
    Expression: String;
    function Evaluate():Double;
    procedure SetExpression(NewExp:String);
  end;

implementation

function TParseR.Evaluate(): Double;
type
  TCharStack = specialize TStack<String>;
  TIntegerStack = specialize TStack<Extended>;
const
  NUM = ['0'..'9','.',','];
var
  OperatorsStack: TCharStack;
  OperandStack: TIntegerStack;
  i,numberStart,numberEnd: integer;
  aux1,aux2,preaux: Extended;
  sNumber: String;
  AuxOperator: String;
begin
  OperatorsStack:= TCharStack.Create;
  OperandStack:= TIntegerStack.Create;
  Expression:=Expression.Replace('pi',FloatToStr(pi),[rfReplaceAll]);
  Expression:='('+Expression+')';
  i:=1;
  while i <= Length(Expression) do begin
    if Expression[i] in NUM then begin
      numberStart:=i;
      sNumber:='';
      while Expression[i] in NUM do begin
          i:=i+1;
      end;
      numberEnd:=i;
      sNumber:= Expression.Substring(numberStart-1,numberEnd-numberStart);
      if(not OperatorsStack.IsEmpty()) and (String(OperatorsStack.Top()) = '-') then begin
          OperandStack.push(-StrToFloat(sNumber));
          OperatorsStack.Pop();
          OperatorsStack.Push('+');
      end
      else begin
          OperandStack.push(StrToFloat(sNumber));
      end;
      //i:=i-1;
    end;
    if Expression[i] = '(' then
       OperatorsStack.push('(');
    if Expression[i] = '*' then
       OperatorsStack.push('*');
    if Expression[i] = 'l' then begin
       OperatorsStack.push('ln');
       i:=i+1;
    end;
    if Expression[i] = 's' then begin
       OperatorsStack.push('sin');
       i:=i+2;
    end;
    if Expression[i] = 'c' then begin
       OperatorsStack.push('cos');
       i:=i+2;
    end;
    if Expression[i] = 't' then begin
       OperatorsStack.push('tan');
       i:=i+2;
    end;
    if Expression[i] = 'e' then begin
       OperatorsStack.push('exp');
       i:=i+2;
    end;
    if Expression[i] = '^' then begin
       OperatorsStack.push('^');
    end;
    if Expression[i] = '+' then begin
      if OperatorsStack.IsEmpty() then begin
         Break;
      end;
      case OperatorsStack.top() of
          '*' : begin
                  aux1:= OperandStack.top();
                  OperandStack.pop();
                  aux2:= OperandStack.top();
                  OperandStack.pop();
                  OperandStack.push(aux1*aux2);
                  OperatorsStack.pop();
                end;
          '/' : begin
                  aux1:=OperandStack.top();
                  OperandStack.pop();
                  aux2:=OperandStack.top();
                  OperandStack.pop();
                  OperandStack.push(aux2/aux1);
                  OperatorsStack.pop();
                end;
          'ln': begin
                aux1:=OperandStack.top();
                OperandStack.pop();
                OperandStack.push(ln(aux1));
                OperatorsStack.pop();
                end;
          'sin': begin
                 aux1:=OperandStack.top();
                 OperandStack.pop();
                 OperandStack.push(sin(aux1));
                 OperatorsStack.pop();
                 end;
          'cos': begin
                 aux1:=OperandStack.top();
                 OperandStack.pop();
                 OperandStack.push(cos(aux1));
                 OperatorsStack.pop();
                 end;
          'tan': begin
                 aux1:=OperandStack.top();
                 OperandStack.pop();
                 OperandStack.push(tan(aux1));
                 OperatorsStack.pop();
                 end;
          'exp': begin
                 aux1:=OperandStack.top();
                 OperandStack.pop();
                 OperandStack.push(exp(aux1));
                 OperatorsStack.pop();
                 end;
          '^': begin
                  aux1:=OperandStack.top();
                  OperandStack.pop();
                  aux2:=OperandStack.top();
                  OperandStack.pop();
                  OperandStack.push((power(aux2,aux1)));
                  OperatorsStack.pop();
                  end;
      end;
      OperatorsStack.push('+');
    end;
    if Expression[i] = '-' then begin
      if OperatorsStack.IsEmpty() then begin
         Break;
      end;
      case OperatorsStack.top() of
          '*' : begin
                  aux1:= OperandStack.top();
                  OperandStack.pop();
                  aux2:= OperandStack.top();
                  OperandStack.pop();
                  OperandStack.push(aux1*aux2);
                  OperatorsStack.pop();
                end;
          '/' : begin
                  aux1:=OperandStack.top();
                  OperandStack.pop();
                  aux2:=OperandStack.top();
                  OperandStack.pop();
                  OperandStack.push(aux2/aux1);
                  OperatorsStack.pop();
                end;
          'ln': begin
                aux1:=OperandStack.top();
                OperandStack.pop();
                OperandStack.push(ln(aux1));
                OperatorsStack.pop();
                end;
          'sin': begin
                 aux1:=OperandStack.top();
                 OperandStack.pop();
                 OperandStack.push(sin(aux1));
                 OperatorsStack.pop();
                 end;
          'cos': begin
                 aux1:=OperandStack.top();
                 OperandStack.pop();
                 OperandStack.push(cos(aux1));
                 OperatorsStack.pop();
                 end;
          'tan': begin
                 aux1:=OperandStack.top();
                 OperandStack.pop();
                 OperandStack.push(tan(aux1));
                 OperatorsStack.pop();
                 end;
          'exp': begin
                 aux1:=OperandStack.top();
                 OperandStack.pop();
                 OperandStack.push(exp(aux1));
                 OperatorsStack.pop();
                 end;
          '^': begin
                 aux1:=OperandStack.top();
                 OperandStack.pop();
                 aux2:=OperandStack.top();
                 OperandStack.pop();
                 OperandStack.push((power(aux2,aux1)));
                 OperatorsStack.pop();
                 end;
      end;
      OperatorsStack.push('-');
    end;
    if Expression[i] = '/' then
      OperatorsStack.push('/');
    if Expression[i] = ')' then
    begin
      while OperatorsStack.top() <> '(' do
      begin
        AuxOperator := OperatorsStack.top();
        OperatorsStack.pop();
        preaux:= OperandStack.Top();
        OperandStack.Pop();
        case AuxOperator of
          '+': begin
               case OperatorsStack.top() of
                    '*' : begin
                        aux1:= OperandStack.top();
                        OperandStack.pop();
                        aux2:= OperandStack.top();
                        OperandStack.pop();
                        OperandStack.push(aux1*aux2);
                        OperatorsStack.pop();
                    end;
                    '/' : begin
                        aux1:=OperandStack.top();
                        OperandStack.pop();
                        aux2:=OperandStack.top();
                        OperandStack.pop();
                        OperandStack.push(aux2/aux1);
                        OperatorsStack.pop();
                    end;
                    'ln': begin
                          aux1:=OperandStack.top();
                          OperandStack.pop();
                          OperandStack.push(ln(aux1));
                          OperatorsStack.pop();
                          end;
                    'sin': begin
                           aux1:=OperandStack.top();
                           OperandStack.pop();
                           OperandStack.push(sin(aux1));
                           OperatorsStack.pop();
                           end;
                    'cos': begin
                           aux1:=OperandStack.top();
                           OperandStack.pop();
                           OperandStack.push(cos(aux1));
                           OperatorsStack.pop();
                           end;
                    'tan': begin
                           aux1:=OperandStack.top();
                           OperandStack.pop();
                           OperandStack.push(tan(aux1));
                           OperatorsStack.pop();
                           end;
                    'exp': begin
                           aux1:=OperandStack.top();
                           OperandStack.pop();
                           OperandStack.push(exp(aux1));
                           OperatorsStack.pop();
                           end;
                    '^': begin
                           aux1:=OperandStack.top();
                           OperandStack.pop();
                           aux2:=OperandStack.top();
                           OperandStack.pop();
                           OperandStack.push((power(aux2,aux1)));
                           OperatorsStack.pop();
                           end;
               end;
               aux1:=preaux;
               if not (String(OperatorsStack.Top()) = '(') then begin
                  aux2:=OperandStack.top();
                  OperandStack.pop();
                  OperandStack.push(aux2+aux1);
               end
               else begin
                    OperandStack.Push(aux1);
               end;
               end;
          '-': begin
               case OperatorsStack.top() of
                    '*' : begin
                        aux1:= OperandStack.top();
                        OperandStack.pop();
                        aux2:= OperandStack.top();
                        OperandStack.pop();
                        OperandStack.push(aux1*aux2);
                        OperatorsStack.pop();
                    end;
                    '/' : begin
                        aux1:=OperandStack.top();
                        OperandStack.pop();
                        aux2:=OperandStack.top();
                        OperandStack.pop();
                        OperandStack.push(aux2/aux1);
                        OperatorsStack.pop();
                        end;
                    'ln': begin
                          aux1:=OperandStack.top();
                          OperandStack.pop();
                          OperandStack.push(ln(aux1));
                          OperatorsStack.pop();
                          end;
                    'sin': begin
                           aux1:=OperandStack.top();
                           OperandStack.pop();
                           OperandStack.push(sin(aux1));
                           OperatorsStack.pop();
                           end;
                    'cos': begin
                           aux1:=OperandStack.top();
                           OperandStack.pop();
                           OperandStack.push(cos(aux1));
                           OperatorsStack.pop();
                           end;
                    'tan': begin
                           aux1:=OperandStack.top();
                           OperandStack.pop();
                           OperandStack.push(tan(aux1));
                           OperatorsStack.pop();
                           end;
                    'exp': begin
                           aux1:=OperandStack.top();
                           OperandStack.pop();
                           OperandStack.push(exp(aux1));
                           OperatorsStack.pop();
                           end;
                    '^': begin
                           aux1:=OperandStack.top();
                           OperandStack.pop();
                           aux2:=OperandStack.top();
                           OperandStack.pop();
                           OperandStack.push((power(aux2,aux1)));
                           OperatorsStack.pop();
                           end;
               end;
               aux1:=preaux;
               if not (String(OperatorsStack.Top()) = '(') then begin
                  aux2:=OperandStack.top();
                  OperandStack.pop();
                  OperandStack.push(aux2-aux1);
               end
               else begin
                    OperandStack.Push(-aux1);
               end;

               end;
          '*': begin
               case OperatorsStack.top() of
                    'ln': begin
                          aux1:=OperandStack.top();
                          OperandStack.pop();
                          OperandStack.push(ln(aux1));
                          OperatorsStack.pop();
                          end;
                    'sin': begin
                           aux1:=OperandStack.top();
                           OperandStack.pop();
                           OperandStack.push(sin(aux1));
                           OperatorsStack.pop();
                           end;
                    'cos': begin
                           aux1:=OperandStack.top();
                           OperandStack.pop();
                           OperandStack.push(cos(aux1));
                           OperatorsStack.pop();
                           end;
                    'tan': begin
                           aux1:=OperandStack.top();
                           OperandStack.pop();
                           OperandStack.push(tan(aux1));
                           OperatorsStack.pop();
                           end;
                    'exp': begin
                           aux1:=OperandStack.top();
                           OperandStack.pop();
                           OperandStack.push(exp(aux1));
                           OperatorsStack.pop();
                           end;
                    '^': begin
                           aux1:=OperandStack.top();
                           OperandStack.pop();
                           aux2:=OperandStack.top();
                           OperandStack.pop();
                           OperandStack.push((power(aux2,aux1)));
                           OperatorsStack.pop();
                           end;
               end;
               aux1:=preaux;
               aux2:=OperandStack.top();
               OperandStack.pop();
               OperandStack.push(aux1*aux2);
               end;
          '/': begin
               case OperatorsStack.top() of
                    'ln': begin
                          aux1:=OperandStack.top();
                          OperandStack.pop();
                          OperandStack.push(ln(aux1));
                          OperatorsStack.pop();
                          end;
                    'sin': begin
                           aux1:=OperandStack.top();
                           OperandStack.pop();
                           OperandStack.push(sin(aux1));
                           OperatorsStack.pop();
                           end;
                    'cos': begin
                           aux1:=OperandStack.top();
                           OperandStack.pop();
                           OperandStack.push(cos(aux1));
                           OperatorsStack.pop();
                           end;
                    'tan': begin
                           aux1:=OperandStack.top();
                           OperandStack.pop();
                           OperandStack.push(tan(aux1));
                           OperatorsStack.pop();
                           end;
                    'exp': begin
                           aux1:=OperandStack.top();
                           OperandStack.pop();
                           OperandStack.push(exp(aux1));
                           OperatorsStack.pop();
                           end;
                    '^': begin
                           aux1:=OperandStack.top();
                           OperandStack.pop();
                           aux2:=OperandStack.top();
                           OperandStack.pop();
                           OperandStack.push((power(aux2,aux1)));
                           OperatorsStack.pop();
                           end;
               end;
               aux1:=preaux;
               aux2:=OperandStack.top();
               OperandStack.pop();
               OperandStack.push(aux2/aux1);
               end;
          'ln': begin
                aux1:=preaux;
                OperandStack.push(ln(aux1));
                end;
          'sin': begin
                 aux1:=preaux;
                 OperandStack.push(sin(aux1));
                 end;
          'cos': begin
                 aux1:=preaux;
                 OperandStack.push(cos(aux1));
                 end;
          'tan': begin
                 aux1:=preaux;
                 OperandStack.push(tan(aux1));
                 end;
          'exp': begin
                 aux1:=preaux;
                 OperandStack.push(exp(aux1));
                 end;
          '^': begin
                 aux1:=preaux;
                 aux2:=OperandStack.top();
                 OperandStack.pop();
                 OperandStack.push((power(aux2,aux1)));
                 end;
        end;
      end;
    OperatorsStack.pop();
    end;
    i:=i+1;
  end;
  result:= OperandStack.top();
end;


procedure TParseR.SetExpression(NewExp:String);
begin
     self.Expression := NewExp;
end;

end.
