unit Node;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type
  TNode = Class
   Public
    data : String;
    datatype:String;
    leftNode : ^TNode;
    rightNode: ^TNode;
    constructor Create(cdata:String);
  end;

implementation

constructor TNode.Create(cData:String);
begin
     data:=cData;
     leftNode:=Nil;
     rightNode:=Nil;
end;

end.

