{ Item generation }

{ Generate upto 3 items per room }
procedure GenerateItems;
var
	I, J: Integer;
	P: Single;
	DU, DL: Integer;
begin

	ItemI := 0;

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

				With Items[ItemI] do begin
					L := Random(DU - DL) + DL;
					D1 := Random(DU - DL) + DL;
					D2 := Random(10);
			    end;

				ItemI := ItemI + 1;
		    end;
		end;
	end;	
end;
