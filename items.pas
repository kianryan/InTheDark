{ Item generation }
procedure GenerateLight(I: Integer);
var
	P: Single;
	DU, DL: Integer;
begin
    P := Random;
    If P > 0.95 then begin DL := 9; DU := 10; end
    else if P > 0.9 then begin DL := 7; DU := 9; end
    else if P > 0.8 then begin DL := 4; DU := 8; end
    else if P > 0.6 then begin DL := 2; DU := 5; end
    else begin DL := 1; DU := 3; end;
    with Items[I] do begin
        IType := 1; { light }
        Taken := False;
        L := (Random(DU - DL) + DL) * 4; { more! }
        T := 0;
        D1 := Random(DU - DL) + DL;
        D2 := Random(10);
    end;
end;

procedure GenerateTreasure(I: Integer);
begin
	with Items[I] do begin
		IType := 2; { treasure }
		Taken := False;
		L := 0;
		T := 1; { all treasure equal val }
		D1 := Random(10) + 10;
		D2 := Random(10) + 10;
	end;
	DT := DT + 1;
end;


{ Generate upto 3 items per room }
procedure GenerateItems;
var
	I, J: Integer;
	P: Single;
begin

	CLight := -1;
	CTreasure := -1;


	{ player is given 1st light }
	GenerateLight(0);

	ItemI := 1;
	T := 0;
	DT := 0;
	CT := 0;

	For I := 0 to RoomI do begin
		For J := 0 to 5 do begin
			P := Random;
			if P > 0.4 then begin { we can adjust this as a difficulty }
				if P > 0.8 then GenerateTreasure(ItemI) else GenerateLight(ItemI);
			    With Items[ItemI], Rooms[I] do begin
				    X := Random(X2 - X1 - 2) + X1 + 1;
				    Y := Random(Y2 - Y1 - 2) + Y1 + 1;
					Room := I;
				end;

				ItemI := ItemI + 1;
			end;
		end;
	end;	

	ItemI := ItemI - 1;
end;

{ check for collisions with items }
function HitItem(X1, Y1: Integer): Integer;
var
	I: Integer;
	Found: Boolean;
begin
	Found := False;
	For I := 0 To ItemI do begin
	    with Items[I] do
	    begin
		    if (X = X1) and (Y = Y1) and (not Taken) then begin
			    Found := True;
			    Break;
		    end;
	    end;
	end;

	If Found then HitItem := I else HitItem := -1;
end;

{ take the item, apply side effects to globals }
procedure TakeItem(I: Integer);
begin
		Items[I].Taken := True;
		if Items[I].L > 0 then begin
			L := Items[I].L;
			CLight := I;
		end;
		if Items[I].T > 0 then begin
			T := T + Items[I].T;
			CTreasure := I;
			CT := 3;
		end;
end;
