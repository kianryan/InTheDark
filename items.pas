{ Item generation }

{ Generate upto 3 items per room }
procedure GenerateItems;
var
	I, J: Integer;
	P: Single;
	DU, DL: Integer;
begin

	ItemI := 0;
	CItem := -1; { no item }

	For I := 0 to RoomI do begin
		For J := 0 to 3 do begin
			P := Random;
			If P > 0.8 then begin { we can adjust this as a difficulty }
			    P := Random;
    			If P > 0.95 then begin DL := 9; DU := 10; end
			    else if P > 0.9 then begin DL := 7; DU := 9; end
			    else if P > 0.8 then begin DL := 4; DU := 8; end
			    else if P > 0.6 then begin DL := 2; DU := 5; end
			    else begin DL := 1; DU := 3; end;

			    With Items[ItemI], Rooms[I] do begin
				    X := Random(X2 - X1 - 2) + X1 + 1;
				    Y := Random(Y2 - Y1 - 2) + Y1 + 1;
					Room := I;
					IType := 1; { light }
					Taken := False;
					L := (Random(DU - DL) + DL) * 4; { more! }
					T := 0;
					D1 := Random(DU - DL) + DL;
					D2 := Random(10);
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
		L := Items[I].L;
		T := T + Items[I].T;
		CItem := I; { set ptr to current item for dsp }
end;
