{ Item generation }
Procedure GenerateLight(I: Integer);

Var
  P: Real;
  DU, DL: Integer;
Begin
  P := Random;
  If P > 0.95 Then
    Begin
      DL := 9;
      DU := 10;
    End
  Else If P > 0.9 Then
         Begin
           DL := 7;
           DU := 9;
         End
  Else If P > 0.8 Then
         Begin
           DL := 4;
           DU := 8;
         End
  Else If P > 0.6 Then
         Begin
           DL := 2;
           DU := 5;
         End
  Else
    Begin
      DL := 1;
      DU := 3;
    End;

  With Items[I] Do
    Begin
      IType := 1; { light }
      Taken := False;
      L := (Random(DU - DL) + DL) * 4; { more! }
      T := 0;
      D1 := Random(DU - DL) + DL;
      D2 := Random(10);
    End;
End;

Procedure GenerateTreasure(I: Integer);
Begin
  With Items[I] Do
    Begin
      IType := 2; { treasure }
      Taken := False;
      L := 0;
      T := 1; { all treasure equal val }
      D1 := Random(10) + 10;
      D2 := Random(10) + 10;
    End;
  DT := DT + 1;
End;

{ check for collisions with items }
Function HitItem(X1, Y1: Integer): Integer;

Var
  I: Integer;
  Found: Boolean;
Begin
  Found := False;
  I := 1;

  If ItemI > 0 Then
    Repeat
      Begin
        With Items[I] Do
          Begin
            If (X = X1) And (Y = Y1) And (Not Taken) Then
              Found := True
            Else
              I := I + 1;
          End;
      End;
    Until (I > ItemI) Or Found;

  If Found Then HitItem := I
  Else HitItem := -1;
End;

{ Generate upto 3 items per room }
Procedure GenerateItems;

Var
  I, J: Integer;
  P: Real;
  Valid: Boolean;
Begin

  CLight := -1;
  CTreasure := -1;

 { player is given 1st light }
  GenerateLight(0);

  ItemI := 0;
  T := 0;
  DT := 0;
  CT := 0;

  For I := 0 To RoomI Do
    Begin
      For J := 0 To 5 Do
        Begin
          Repeat
            Begin
              Valid := True;
              P := Random;
              If P > 0.4 Then
                Begin { we can adjust this as a difficulty }
                  With Items[ItemI + 1], Rooms[I] Do
                    Begin
                      X := Random(X2 - X1 - 2) + X1 + 1;
                      Y := Random(Y2 - Y1 - 2) + Y1 + 1;
                      Room := I;
                      Valid := HitItem(X, Y) = -1;
                      If Valid Then
                        Begin
                          If P > 0.8 Then GenerateTreasure(ItemI + 1)
                          Else GenerateLight(ItemI + 1);
                          ItemI := ItemI + 1;
                        End

                    End;
                End
            End;
          Until Valid;
        End;
    End;
End;
{ take the item, apply side effects to globals }
Procedure TakeItem(I: Integer);
Begin
  Items[I].Taken := True;
  If Items[I].L > 0 Then
    Begin
      L := Items[I].L;
      CLight := I;
    End;
  If Items[I].T > 0 Then
    Begin
      T := T + Items[I].T;
      CTreasure := I;
      CT := 3;
    End;
End;
