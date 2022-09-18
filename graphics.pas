{ drawing routines }

procedure DrawRoom(DR: Room);
var I: Integer;
begin
    with DR do
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

procedure DrawDoor(DD: Door);
begin
    with DD do
    begin
        GotoXY(X, Y);
        Write('X');
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
