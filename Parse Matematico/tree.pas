unit Tree;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,Node;

type
  TPTree = class
    type
        PNode = ^Tnode;
    public
     root: PNode;

     constructor Create();
     procedure addNode(data:String; path:Boolean);
     procedure buildTree(data:String);
  end;

implementation
    constructor TPTree.Create();
    begin
      root:=Nil;
    end;

procedure TPTree.addNode(data:String; path:Boolean);
begin
//path 0 right - 1 left
     if not Assigned(root)then begin
        root := new (PNode, create(data));
        Exit;
     end;
     if path then
        root^.leftNode  := new (PNode, create(data) )
     else
        root^.rightNode := new (PNode, create(data) );
end;

procedure TPTree.buildTree(data:String);
var i: integer;
begin
  i:=0;
  while i<data.Length do begin
    if data[i] = '(' then begin
       addNode('',True);
    end;

  end;

end;

end.

