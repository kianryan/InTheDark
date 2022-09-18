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

procedure DrawDungeon;
var
    I: Integer;
begin
    for I := 0 to RoomI do DrawRoom(Rooms[I]);
    for I := 0 to DoorI do DrawDoor(Doors[I]);
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