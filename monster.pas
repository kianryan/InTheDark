{ monster management }

procedure GenerateMonsters;
var
	P: Single;
	I: Integer;
	NoCollide: Boolean;
begin
	MonsterI := 0;
	NoCollide := True;

	For I := 0 to RoomI do begin
		P := Random;
		If P > 0.6 Then Begin
	        With Rooms[I], Monsters[MonsterI] do begin
		        DX := Random(X2 - X1 - 1) + X1 + 1;
			    DY := Random(Y2 - Y1 - 1) + Y1 + 1;
			    X := DX;
			    Y := DY;
			    Room := I; { monsters stay in room }
	        end;
	        MonsterI := MonsterI + 1;
		end;
    End;

	MonsterI := MonsterI - 1;
end;
