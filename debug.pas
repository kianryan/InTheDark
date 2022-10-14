{ debugging code }

{ Debug print room co-ordinates}
procedure WriteRoom(Debug: Room; L: Integer);
begin
    GotoXY(1, L);
    Write('X1: ');
    Write(Debug.X1);
    Write(' Y1: ');
    Write(Debug.Y1);
    Write(' X2: ');
    Write(Debug.X2);
    Write(' Y2: ');
    WriteLn(Debug.Y2);
end;

procedure WriteDoor(Debug:Door; L: Integer);
begin
    GotoXY(1, L);
    Write('X: ');
    Write(Debug.X);
    Write(' Y: ');
    Write(Debug.Y);
    Write(' Room1I: ');
    Write(Debug.Room1I);
    Write(' Room2I: ');
    WriteLn(Debug.Room2I);
end;


procedure WriteItem(Debug:Item; L:Integer);
begin
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
	Write(Verb[Debug.D2]);
	Write(' ');
	WriteLn(Noun[Debug.D1]);
end;
