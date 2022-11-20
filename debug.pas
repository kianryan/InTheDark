{ debugging code }

{ Debug print room co-ordinates}
Procedure WriteRoom(Debug: Room; L: Integer);
Begin
  GotoXY(1, L);
  Write('X1: ');
  Write(Debug.X1);
  Write(' Y1: ');
  Write(Debug.Y1);
  Write(' X2: ');
  Write(Debug.X2);
  Write(' Y2: ');
  WriteLn(Debug.Y2);
End;

Procedure WriteDoor(Debug:Door; L: Integer);
Begin
  GotoXY(1, L);
  Write('X: ');
  Write(Debug.X);
  Write(' Y: ');
  Write(Debug.Y);
  Write(' Room1I: ');
  Write(Debug.Room1I);
  Write(' Room2I: ');
  WriteLn(Debug.Room2I);
End;


Procedure WriteItem(Debug:Item; L:Integer);
Begin
  GotoXY(1, L);
  Write('X: ');
  Write(Debug.X);
  Write(' Y: ');
  Write(Debug.Y);
  Write(' L: ');
  Write(Debug.L);
  Write(' D1: ');
  Write(Debug.D1);
  Write(' D2: ');
  Write(Debug.D2);
  Write(' ');
  Write(Adjective[Debug.D2]);
  Write(' ');
  WriteLn(Noun[Debug.D1]);
End;

Procedure WriteMonster(Debug:Monster; L:Integer);
Begin
  GotoXY(1, L);
  Write('X: ');
  Write(Debug.X);
  Write(' Y: ');
  Write(Debug.Y);
  Write(' DX: ');
  Write(Debug.DX);
  Write(' DY: ');
  Write(Debug.DY);
  Write(' Room: ');
  WriteLn(Debug.Room);
End;
