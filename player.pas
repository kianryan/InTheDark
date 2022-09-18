{ player management }

{ set player position in random room }
procedure GeneratePlayer;
var
    I : Integer;
begin
    I := Random(RoomI);

    with CPlayer do
        with Rooms[I] do
            begin
                DX := Random(X2 - X1 - 1) + X1 + 1;
                DY := Random(Y2 - Y1 - 1) + Y1 + 1;
                X := DX;
                Y := DY; { first play - no tidy }
            end;
end;

{ move player, report on outcome of movement }
{ 0 - player doesn't move }
{ 1 - player success moves }
function MovePlayer : Boolean;
var
    X, Y: Integer;
    Valid: Boolean;
begin
    X := CPlayer.X;
    Y := CPlayer.Y;
    Valid := True;

    if (D >= 0) and (D < 4) then
    begin

        case D of
            0: X := CPlayer.X - 1;
            1: X := CPlayer.X + 1;
            2: Y := CPlayer.Y - 1;
            3: Y := CPlayer.Y + 1;
        end;

        { check for overlap with any existing room walls }
        Valid := (not HitWall(X, Y)) or HitDoor(X, Y);

        if Valid then begin
            CPlayer.X := X;
            CPlayer.Y := Y;
        end;
    end
    else
        Valid := False;

    MovePlayer := Valid;
end;
