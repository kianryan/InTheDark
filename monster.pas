{ monster management }

procedure GenerateMonsters;
var
	P: Single;
	I: Integer;
    Valid: Boolean;
begin
	MonsterI := 0;

	For I := 0 to RoomI do begin
		P := Random;
		If P > 0.6 Then Begin
			repeat
      	        With Rooms[I], Monsters[MonsterI] do begin
    		        DX := Random(X2 - X1 - 1) + X1 + 1;
    			    DY := Random(Y2 - Y1 - 1) + Y1 + 1;
    			    X := DX;
    			    Y := DY;
    			    Room := I; { monsters stay in room }
					Valid := (X <> CPlayer.X) and (Y <> CPlayer.Y) and 
    					(HitItem(X, Y) = -1);
    	        end;
			until Valid;
	        MonsterI := MonsterI + 1;
		end;
    End;

	MonsterI := MonsterI - 1;
end;

{ rules: }
{ in a room with a player: }
{ a monster will move away from player with light }
{ a monster will move towards player without light }
{ in a room without a player }
{ a monster will move in a random direction }

procedure MoveMonster(I: Integer);
var
	Tries: Integer; { 4 tries/ cardinalities }
	Valid : Boolean;
	D: Integer; { direction to try }
	TX, TY: Integer;
begin
	with Monsters[I] do begin
    { if (M.Room <> CPlayer.Room) then begin }
		D := Random(4);
		Tries := 0;

		repeat

			Tries := Tries + 1;

			if (Tries <> 1) then begin
				D := (D + 1) mod 4; { try next cardinality }
			end;

		    TX := X;
		    TY := Y;
            case D of
                0: TX := TX - 1;
                1: TX := TX + 1;
                2: TY := TY - 1;
                3: TY := TY + 1;
            end;
		    Valid := (not HitWall(TX, TY)) and (HitItem(TX, TY) = -1);

		until Valid or (Tries > 4); 

		if Valid then begin
			X := TX;
			Y := TY;
		end;
    { end; } 
    end;
end;

procedure MoveMonsters;
var
	I: Integer;
begin
	For I := 0 To MonsterI do MoveMonster(I);
end;


