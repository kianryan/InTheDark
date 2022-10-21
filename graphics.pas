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
			case (IType) of
				1: write('#');
				2: write('£');
			end;
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

procedure DrawMonster(I: Integer; Glyph: String);
begin
	with Monsters[I] do
	begin
        GotoXY(DX, DY);
		If not ((DX = CPlayer.X) and (DY = CPlayer.Y)) then Write(' ');
        GotoXY(X, Y);
        Write(Glyph);
        DX := X; { Set new position on screen }
        DY := Y;
	end;
end;

procedure DrawMonsters;
var
	Glyph: String;
begin
	for I := 0 to MonsterI do begin
		Glyph := ' ';
		if (Rooms[Monsters[I].Room].ShowContents) and (L > 0) then Glyph := '%';
		DrawMonster(I, Glyph);
	end		
end;

procedure DrawDungeon;
var
    I: Integer;
begin
    for I := 0 to RoomI do begin
		Rooms[I].ShowContents := CanSee(CPlayer.Room, I);
		DrawRoom(Rooms[I]);
	end;
    for I := 0 to DoorI do DrawDoor(Doors[I]);

	for I := 0 to ItemI do begin
		if (not Rooms[Items[I].Room].ShowContents) or (L = 0) then
			HideItem(Items[I])
		else
			DrawItem(Items[I]);
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

	if MDist <> -1 then begin
	    if (MDist = 0) and (L = 0) then
		    Write('In the dark, the the talons of the grue drag you to your end.')
	    else if MDist = 0 then
		    Write('In the light, you bump in to the grue. It extinguishes your light, and you.')
	    else if (MDist < 2) and (L = 0) then
		    Write('You can hear the grue breathing down your neck.')
	    else if ((MDist < 4) and (L = 0)) then
		    Write('You can hear the talons of the grue tapping the tiles nearby.')
	end
	else if CT > 0 then 
	begin
		Write('You pick up a ');
		Write(Adjective[Items[CTreasure].D2]);
		Write(' ');
		Write(Noun[Items[CTreasure].D1]);
		Write('.');
		CT := CT - 1;
	end
	else 
	begin
	    if (L = 0) then
	        Write('It is dark, you are likely eaten by a grue.')
		else if (L < 5) then begin
			Write('Your ');
			Write(Noun[Items[CLight].D1]);
			Write(' grows dim.  It will be dark soon.');
		end
		else begin
			Write('A ');
			Write(Adjective[Items[CLight].D2]);
			Write(' ');
			Write(Noun[Items[CLight].D1]);
			Write(' lights your way.  For now.');
		end;
	end;
end;

procedure DrawScore;
begin
	GotoXY(SWidth-5, SHeight);
	Write('*****');
	GotoXY(SWidth-5, SHeight);
	Write(T);
	Write('/');
	Write(DT);
end;
