{ drawing routines }

procedure DrawRoom(DR: Room);
var I: Integer;
begin
    with DR do
    begin
        if Discovered then
        begin
            GotoXY(X1,Y1);
            for I := X1 to X2 do Write('-');
            for I := Y1 + 1 to Y2 do
            begin
                GotoXY(X1, I); Write('!');
                GotoXY(X2, I); Write('!');
            end;
            GotoXY(X1, Y2);
            for I := X1 to X2 do Write('-');
        end;
    end;
end;

procedure DrawDoor(DD: Door);
begin
    with DD do
    begin

        { a door links two rooms - we only draw the door if one of the rooms
          is discovered }
        if (Rooms[Room1I].Discovered or Rooms[Room2I].Discovered) and (not Opened) then
        begin
            GotoXY(X, Y);
            Write('X');
        end
        else if Opened then
        begin
            GotoXY(X, Y);
            Write(' ');
        end
    end;
end;

procedure DrawItem(DI: Item);
begin
	with DI do
	begin
		if Rooms[Room].Discovered and (not Taken) then
		begin
			GotoXY(X, Y);
			Write('#');
		end
		else if Taken then
		begin
			GotoXY(X, Y);
			Write(' ');
		end
	end;
end;

procedure HideItem(DI: Item);
begin
	with DI do
	begin
	    GotoXY(X, Y);
	    Write(' ');
	end;
end;


procedure DrawMonster(DM: Monster; Glyph: String);
begin
	with DM do
	begin
        GotoXY(DX, DY);
        Write(' ');
        GotoXY(X, Y);
        Write(Glyph);
        DX := X; { Set new position on screen }
        DY := Y;
	end;
end;

procedure DrawDungeon;
var
    I: Integer;
begin
    for I := 0 to RoomI do DrawRoom(Rooms[I]);
    for I := 0 to DoorI do DrawDoor(Doors[I]);

	if L = 0 then begin
	    for I := 0 to ItemI do HideItem(Items[I]);
	    for I := 0 to MonsterI do DrawMonster(Monsters[I], ' ');
	end else begin
		for I := 0 to ItemI do DrawItem(Items[I]);
		for I := 0 to MonsterI do DrawMonster(Monsters[I], '%');
	end;
end;

procedure DrawFrame;
var
    X, Y: Integer;
begin
    GotoXY(1,1);
    for X := 1 to SWidth do
    begin
     GotoXY(X, 1);
     Write('*');
     GotoXY(X, SHeight);
     Write('*')
    end;
    for Y := 1 to SHeight do
    begin
        GotoXY(1, Y);
        Write('*');
        GotoXY(SWidth, Y);
        Write('*');
    end;
    GotoXY(1,1);
end;

procedure DrawPlayer;
begin
    with CPlayer do begin
        GotoXY(DX, DY);
        Write(' ');
        GotoXY(X, Y);
        Write('@');
        DX := X; { Set new position on screen }
        DY := Y;
    end;
end;

procedure DrawStatus;
var
	I: Integer;
begin
	GotoXY(2, SHeight);
	For I := 1 to SWidth - 1 do Write('*');
	GotoXY(2, SHeight);
	If (L = 0) Then
		Write('It is dark, you are likely eaten by a grue.')
	Else If (L < 5) Then begin
		Write('Your ');
		Write(Noun[Items[CItem].D1]);
		Write(' grows dim.  It will be dark soon.');
    end
	Else begin
		Write('A ');
		Write(Verb[Items[CItem].D2]);
		Write(' ');
		Write(Noun[Items[CItem].D1]);
		Write(' lights your way.  For now.');
	end;
end;
