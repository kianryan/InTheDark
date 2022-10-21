{ player management }

{ set player position in random room }
procedure GeneratePlayer;
var
    I : Integer;
begin
    I := Random(RoomI);

    with CPlayer, Rooms[I] do begin
		Discovered := True;
		DX := Random(X2 - X1 - 1) + X1 + 1;
		DY := Random(Y2 - Y1 - 1) + Y1 + 1;
		X := DX;
		Y := DY; { first play - no tidy }
		Room := I;
    end;

	TakeItem(0);
end;

{ move player, report on if redraw is necessary }
function MovePlayer : Boolean;
var
    X, Y: Integer;
    FoundDoorI: Integer;
	FoundItemI: Integer;
    Redraw, Valid: Boolean;
	NewRoom: Integer;
begin
    X := CPlayer.X;
    Y := CPlayer.Y;
    Redraw := False;
    Valid := True;

    if (D >= 0) and (D < 4) then
    begin

        case D of
            0: X := CPlayer.X - 1;
            1: X := CPlayer.X + 1;
            2: Y := CPlayer.Y - 1;
            3: Y := CPlayer.Y + 1;
        end;

        { if going though door, open door and adjacent rooms }
        FoundDoorI := HitDoor(X, Y);
        if FoundDoorI <> -1 then
        begin
            with Doors[FoundDoorI] do
            begin
                Rooms[Room1I].Discovered := True;
                Rooms[Room2I].Discovered := True;
                Opened := True;
            end;
            Redraw := True;
        end
        else Valid := not HitWall(X, Y);

        if Valid then begin
            CPlayer.X := X;
            CPlayer.Y := Y;

			{ check for change in room }
			NewRoom := HitRoom(X, Y);
			if (NewRoom <> -1) and (CPlayer.Room <> NewRoom) then begin 
				CPlayer.Room := NewRoom;
				Redraw := True;
			end;

			{ check for items }
			FoundItemI := HitItem(X, Y);
			if FoundItemI <> -1 then begin
				TakeItem(FoundItemI);
				Redraw := True;
			end
			else begin
				If (L > 0) then L := L - 1;
				If L = 0 Then Redraw := True; { Hide items }
			end;

			MoveMonsters;
        end;
    end;

    MovePlayer := Redraw;
end;
