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

procedure MoveRandom(I: Integer);
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

{ Attempt to move closer to the player char }

{ D: 1 - towards, -1 away }
procedure MoveToPlayer(I: Integer; D: Integer);
var
    CX, CY: Integer; { change X/Y }
	TX, TY: Integer; { try X/Y }
begin
    with Monsters[I] do begin
		CX := X - CPlayer.X;
		CY := Y - CPlayer.Y;

		{ work out which is the greater disparity and move closer towards the player }
		TX := X;
		TY := Y;
		if Abs(CX) > Abs(CY) then
			If CX > 0 Then TX := X - D Else TX := X + D
		else
			If CY > 0 Then TY := Y - D Else TY := Y + D;

		If (not HitWall(TX, TY)) and (HitItem(TX, TY) = -1) then begin
				X := TX;
				Y := TY;
		end
		else MoveRandom(I);
    end;
end;

procedure MoveMonsters;
var
	I: Integer;
	D: Integer; { Dir of monster movement }
begin
	If L = 0 then D := 1 else D := -1;
	For I := 0 To MonsterI do
		if Monsters[I].Room = CPlayer.Room then MoveToPlayer(I, D) else MoveRandom(I)
end;


