{ Room and door generation }

{ Generate the first room }
Procedure FirstRoom;

Var
  W, H: Integer;
Begin
 { Generate first room dims }
  RoomI := 0;
  With Rooms[0] Do
    Begin
      Discovered := False;
      X1 := Random(SWidth - UWidth - 1) + 1;
      Y1 := Random(SHeight - UHeight - 1) + 1;
      W := Random(UWidth-LWidth) + LWidth + 1;
      H := Random(UHeight-LHeight) + LHeight + 1;
      X2 := X1 + W;
      Y2 := Y1 + H;
      ShowContents := True;
    End;
End;

{ Check to see if there's an overlap between a room and a set of co-ords }
Function Overlap(SR : Room; DR: Room) : Boolean;
Begin
  Overlap := (SR.X1 < DR.X2) And (SR.X2 > DR.X1) And
             (SR.Y1 < DR.Y2) And (SR.Y2 > DR.Y1);
End;

{ Checks each room to see if X,Y intersects a wall }
{ We can make this more efficient by tracking object/room location }
Function HitWall(X, Y: Integer): Boolean;

Var
  I : Integer;
  Found: Boolean;
Begin
  Found := False;
  I := 0;
  Repeat
    With Rooms[I] Do
      Begin
        If (((X >= X1) And (X <= X2)) And ((Y = Y1) Or (Y = Y2))) Or
           (((Y >= Y1) And (Y <= Y2)) And ((X = X1) Or (X = X2))) Then
          Found := True
        Else
          I := I + 1;
      End;
  Until (I > RoomI) Or Found;
  HitWall := Found;
End;

Function HitDoor(X1, Y1: Integer): Integer;

Var
  I: Integer;
  Found: Boolean;
Begin
  Found := False;
  I := 0;
  Repeat
    With Doors[I] Do
      Begin
        If (X = X1) And (Y = Y1) Then
          Found := True
        Else
          I := I + 1;
      End;
  Until (I > DoorI) Or Found;

  If Found Then HitDoor := I
  Else HitDoor := -1;
End;

Function HitRoom(X, Y: Integer): Integer;

Var
  I: Integer;
  Found: Boolean;
Begin
  Found := False;
  I := 0;
  Repeat
    With Rooms[I] Do
      Begin
        If (X > X1) And (X < X2) And (Y > Y1) And (Y < Y2) Then
          Found := True
        Else
          I := I + 1;
      End;
  Until (I > RoomI) Or Found;

  If Found Then HitRoom := I
  Else HitRoom := -1;
End;

{ Returns if room R is visible from index I }
{ Room is visible if immediately linked by door and door }
{ is open }
Function CanSee(RI: Integer; RT:Integer): Boolean;

Var
  I: Integer;
  Found: Boolean;
Begin
  Found := False;
  If RI = RT Then CanSee := True
  Else
    Begin
      I := 0;
      Found := False;
      Repeat
        Begin
          With Doors[I] Do
            Begin
              If (((Room1I = RI) And (Room2I = RT)) Or
                 ((Room1I = RT) And (Room2I = RI))) And
                 Opened
                Then
                Found := True
              Else
                I := I + 1;
            End;
        End;
      Until (I > DoorI) Or Found;
      CanSee := Found;
    End;
End;

{ Generate another room }
{ Will return False if a room can no longer be generated. }
Function NextRoom : Boolean;

Var
  W, H, X, Y: Integer;
  D, DS: Integer; { direction of travel }
  CR: Room;
  TryAgain, GenNext: Boolean;
Begin
    { So, we know the current room, and we can decide a direction}
  D := Random(4);
  DS := D; { Keep track of the starting position }

{ Attempt to draw the rectangle.  If it fits, great.
     If it doesn't, attempt to make it fit. }

  CR := Rooms[RoomI];

  TryAgain := True;

  With Rooms[RoomI + 1] Do
    Begin
      While (TryAgain) Do
        Begin

          W := Random(UWidth-LWidth) + LWidth + 1;
          H := Random(UHeight-LHeight) + LHeight + 1;
          Discovered := False;
          GenNext := True;
          ShowContents := True;

          Case D Of
            0:
               Begin
                 X2 := CR.X1;
                 If (X2 - W < 1) Then W := X2 - 1;
                 If (W < LWidth) Then GenNext := False; { esc out}
                 X1 := X2 - W;
                 Y := Random(CR.Y2 - CR.Y1 - 1) + CR.Y1 + 1;
                 If (Y - (H Div 2) < 1) Then H := Y;
                 If (Y - (H Div 2) + H >= SHeight) Then H := (SHeight - Y - 1);
                 If (H < MHeight) Then GenNext := False;
                 Y1 := Y - (H Div 2);
                 Y2 := Y1 + H;
               End;
            1:
               Begin
                 X1 := CR.X2;
                 If (X1 + W > SWidth) Then W := SWidth - X1;
                 If (W < LWidth) Then GenNext := False; { esc out}
                 X2 := X1 + W;
                 Y := Random(CR.Y2 - CR.Y1 - 1) + CR.Y1 + 1;
                 If (Y - (H Div 2) < 1) Then H := Y;
                 If (Y - (H Div 2) + H >= SHeight) Then H := (SHeight - Y - 1);
                 If (H < MHeight) Then GenNext := False;
                 Y1 := Y - (H Div 2);
                 Y2 := Y1 + H;
               End;
            2:
               Begin
                 Y2 := CR.Y1;
                 If (Y2 - H < 1) Then H := Y2 - 1;
                 If (H < LHeight) Then GenNext := False; { esc out}
                 Y1 := Y2 - H;
                 X := Random(CR.X2 - CR.X1 - 1) + CR.X1 + 1;
                 If (X - (W Div 2) < 1) Then W := X;
                 If (X - (W Div 2) + W >= SWidth) Then W := (SWidth - X - 1);
                 If (W < MWidth) Then GenNext := False;
                 X1 := X - (W Div 2);
                 X2 := X1 + W;
               End;
            3:
               Begin
                 Y1 := CR.Y2;
                 If (Y1 + H > SHeight) Then H := SHeight - Y1;
                 If (H < LHeight) Then GenNext := False; { esc out}
                 Y2 := Y1 + H;
                 X := Random(CR.X2 - CR.X1 - 1) + CR.X1 + 1;
                 If (X - (W Div 2) < 1) Then W := X;
                 If (X - (W Div 2) + W >= SWidth) Then W := (SWidth - X - 1);
                 If (W < MWidth) Then GenNext := False;
                 X1 := X - (W Div 2);
                 X2 := X1 + W;
               End;
          End;

            { Test for collision, if collision, then mark for try again. }
          For I := 0 To RoomI Do
            Begin
              If (Overlap(Rooms[I], Rooms[RoomI + 1])) Then
                Begin
                  If (Y2 > Rooms[I].Y1) Then Y2 := Rooms[I].Y1
                  Else
                    If (Y1 < Rooms[I].Y2) Then Y1 := Rooms[I].Y2
                  Else
                    If (X2 > Rooms[I].X1) Then X2 := Rooms[I].X1
                  Else
                    If (X1 > Rooms[I].X2) Then X1 := Rooms[I].X2;
                  W := X2 - X1;
                  H := Y2 - Y1;
                  If ((W < MWidth) Or (H < MHeight)) Then GenNext := False;
                End;
            End;

          If GenNext Then TryAgain := False
          Else
            Begin
              D := (D + 1) Mod 4;

              If D = DS Then
                Begin
                  TryAgain := False; { We have tried all ords }
                  GotoXY(CR.X1 + 1, CR.Y1 + 1);
                End
              Else
            End;
        End;
    End;

  If (GenNext) Then RoomI := RoomI + 1;
  NextRoom := GenNext;
End;

{ check if door indexes have already been processed }
Function DoorNotFound(Room1, Room2: Integer) : Boolean;

Var
  Found: Boolean;
  I: Integer;
Begin
  Found := False;
  I := 0;
  Repeat
    Begin
      With Doors[DoorI] Do
        Begin
          If ((Room1I = Room1) And (Room2I = Room2)) Or
             ((Room2I = Room1) And (Room1I = Room2)) Then
            Found := True
          Else
            I := I + 1;
        End;
    End;
  Until (I > DoorI) Or Found;
  DoorNotFound := Not Found;
End;

Function RandomInRange(Min1, Min2, Max1, Max2: Integer) : Integer;

Var
  AMin, AMax, A: Integer;
Begin
  AMin := Max(Min1, Min2) + 1;
  AMax := Min(Max1, Max2) - 1;
  A := AMax - AMin;
  RandomInRange := AMin + Random(A);
End;

{ After room generation, calc where doors can be placed. }
{ The possibility for doors exist where axis meet. }
Procedure GenerateDoors;

Var
  CR, TR: Room;
  I, J: Integer;
Begin
  DoorI := 0;
  For I := 0 To RoomI Do
    Begin
      CR := Rooms[I];
        { compare this room to all rooms previous. }
      For J := 0 To I - 1 Do
        Begin
          TR := Rooms[J];
          With Doors[DoorI] Do
            Begin
              DoorI := DoorI + 1; { assume success }

              Room1I := I;
              Room2I := J;
              Opened := False;

                { check for collisions before doing anything else }
              If (DoorNotFound(I, J)) Then
                Begin
                    { see if axis overlap, if they do, then generate a door }
                  If (CR.X2 = TR.X1) And ((TR.Y1 < CR.Y2) And (TR.Y2 > CR.Y1))
                    Then { E }
                    Begin
                      X := CR.X2;
                      Y := RandomInRange(CR.Y1, TR.Y1, CR.Y2, TR.Y2);
                    End
                  Else If (CR.X1 = TR.X2) And ((TR.Y1 < CR.Y2) And (TR.Y2 > CR.
                          Y1)) Then { W }
                         Begin
                           X := CR.X1;
                           Y := RandomInRange(CR.Y1, TR.Y1, CR.Y2, TR.Y2);
                         End
                  Else If (CR.Y2 = TR.Y1) And ((TR.X1 < CR.X2) And (TR.X2 > CR.
                          X1)) Then { N }
                         Begin
                           Y := CR.Y2;
                           X := RandomInRange(CR.X1, TR.X1, CR.X2, TR.X2);
                         End
                  Else If (CR.Y1 = TR.Y2) And ((TR.X1 < CR.X2) And (TR.X2 > CR.
                          X1)) Then { N }
                         Begin
                           Y := CR.Y1;
                           X := RandomInRange(CR.X1, TR.X1, CR.X2, TR.X2);
                         End
                  Else DoorI := DoorI - 1; { door not found }
                End
              Else
                DoorI := DoorI - 1; { collision }
            End;
        End;
    End;

  DoorI := DoorI - 1;

End;

{ Generates new dungeon, resets dungeon variables }
Procedure GenerateDungeon;
Begin
  RoomI := 0;
  While (RoomI < 5) Do
    Begin { we need a minimum of 5 room dungeon }
      FirstRoom;
      While ((RoomI < 10) And NextRoom()) Do ;
    End;
  GenerateDoors;
End;
