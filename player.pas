{ player management }

{ set player position in random room }
Procedure GeneratePlayer;

Var
  I : Integer;
  Valid: Boolean;
Begin
  I := Random(RoomI);

  Repeat
    Begin
      With CPlayer, Rooms[I] Do
        Begin
          DX := Random(X2 - X1 - 1) + X1 + 1;
          DY := Random(Y2 - Y1 - 1) + Y1 + 1;
          Valid := HitItem(DX, DY) = -1;
          If Valid Then
            Begin
            X := DX;
            Y := DY; { first play - no tidy }
              Room := I;
              Discovered := True;
            End;
        End;
    End;
  Until Valid;
  TakeItem(0);
End;

{ move player, report on if redraw is necessary }
Function MovePlayer : Boolean;

Var
  X, Y: Integer;
  FoundDoorI: Integer;
  FoundItemI: Integer;
  Redraw, Valid: Boolean;
  NewRoom: Integer;
Begin
  X := CPlayer.X;
  Y := CPlayer.Y;
  Redraw := False;
  Valid := True;

  If (D >= 0) And (D < 4) Then
    Begin

      Case D Of
        0: X := CPlayer.X - 1;
        1: X := CPlayer.X + 1;
        2: Y := CPlayer.Y - 1;
        3: Y := CPlayer.Y + 1;
      End;

        { if going though door, open door and adjacent rooms }
      FoundDoorI := HitDoor(X, Y);
      If FoundDoorI <> -1 Then
        Begin
          With Doors[FoundDoorI] Do
            Begin
              Rooms[Room1I].Discovered := True;
              Rooms[Room2I].Discovered := True;
              Opened := True;
            End;
          Redraw := True;
        End
      Else Valid := Not HitWall(X, Y);

      If Valid Then
        Begin
          CPlayer.X := X;
          CPlayer.Y := Y;

   { check for change in room }
          NewRoom := HitRoom(X, Y);
          If (NewRoom <> -1) And (CPlayer.Room <> NewRoom) Then
            Begin
              CPlayer.Room := NewRoom;
              Redraw := True;
            End;

   { check for items }
          FoundItemI := HitItem(X, Y);
          If FoundItemI <> -1 Then
            Begin
              TakeItem(FoundItemI);
              Redraw := True;
            End
          Else
            Begin
              If (L > 0) Then L := L - 1;
              If L = 0 Then Redraw := True; { Hide items }
            End;

          MoveMonsters;
        End;
    End;

  MovePlayer := Redraw;
End;
