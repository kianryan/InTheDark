{ drawing routines }

Procedure DrawRoom(DR: Room);

Var I: Integer;
Begin
  With DR Do
    Begin
      If Discovered Then
        Begin
          GotoXY(X1,Y1);
          For I := X1 To X2 Do
            Write(ChHWall);
          For I := Y1 + 1 To Y2 Do
            Begin
              GotoXY(X1, I);
              Write(ChVWall);
              GotoXY(X2, I);
              Write(ChVWall);
            End;
          GotoXY(X1, Y2);
          For I := X1 To X2 Do
            Write(ChHWall);
        End;
    End;
End;

Procedure DrawDoor(DD: Door);
Begin
  With DD Do
    Begin








{ a door links two rooms - we only draw the door if one of the rooms
          is discovered }
      If (Rooms[Room1I].Discovered Or Rooms[Room2I].Discovered) And (Not Opened)
        Then
        Begin
          GotoXY(X, Y);
          Write(ChDoor);
        End
      Else If Opened Then
             Begin
               GotoXY(X, Y);
               Write(ChSpace);
             End
    End;
End;

Procedure DrawItem(I: Integer);
Begin
  With Items[I] Do
    If Redraw Then
      Begin
        Redraw := False; { reset flag }
        GotoXY(X, Y);
        Case (IType) Of
          1: Write(ChHash); { Hash }
          2: Write(ChDollar); { Dollar }
          Else
            Write(IType);
        End;
      End;
End;

Procedure HideItem(I: Integer);
Begin
  With Items[I] Do
    If Redraw Then
      Begin
        Redraw := False; { reset flag }
        GotoXY(X, Y);
        Write(ChSpace);
      End;
End;

Procedure DrawMonster(I: Integer; Glyph: Char);
Begin
  With Monsters[I] Do
    Begin
      GotoXY(DX, DY);
      If Not ((DX = CPlayer.X) And (DY = CPlayer.Y)) Then Write(ChSpace);
      GotoXY(X, Y);
      Write(Glyph);
      DX := X; { Set new position on screen }
      DY := Y;
    End;
End;

Procedure DrawMonsters;

Var
  Glyph: Char;
Begin
  For I := 0 To MonsterI Do
    Begin
      Glyph := ChSpace;
      If (Rooms[Monsters[I].Room].ShowContents) And (L > 0) Then
        Glyph := ChMonster;
      DrawMonster(I, Glyph);
    End
End;

Procedure DrawDungeon;

Var
  I: Integer;
  NewShowContents: Boolean;
Begin
  For I := 0 To RoomI Do
    Begin
      NewShowContents := CanSee(CPlayer.Room, I);
      Rooms[I].Changed := NewShowContents <> Rooms[I].ShowContents;
      Rooms[I].ShowContents := NewShowContents;
      DrawRoom(Rooms[I]);
    End;

  For I := 0 To DoorI Do
    DrawDoor(Doors[I]);

  { we only redraw an item if its room has changed }
  For I := 1 To ItemI Do
    Begin
      Items[I].Redraw := Items[I].Redraw Or Rooms[Items[I].Room].Changed;

      If (Not Rooms[Items[I].Room].ShowContents) Or Items[I].Taken Or (L = 0)
        Then
        HideItem(I)
      Else
        DrawItem(I);
    End;
End;

Procedure DrawFrame;

Var
  X, Y: Integer;
Begin
  Clrscr;
  { Window(1, 1, SWidth, SHeight + 1); } { Not in TP3 }
  GotoXY(1,1);
  For X := 1 To SWidth Do
    Begin
      GotoXY(X, 1);
      Write(ChFrame);
      GotoXY(X, SHeight);
      Write(ChFrame)
    End;
  For Y := 1 To SHeight Do
    Begin
      GotoXY(1, Y);
      Write(ChFrame);
      GotoXY(SWidth, Y);
      Write(ChFrame);
    End;
  GotoXY(1,1);
End;

Procedure DrawPlayer;
Begin
  With CPlayer Do
    Begin
      GotoXY(DX, DY);
      Write(ChSpace);
      GotoXY(X, Y);
      Write(ChPlayer);
      DX := X; { Set new position on screen }
      DY := Y;
    End;
End;

Procedure DrawStatus;

Var
  I: Integer;
Begin
  GotoXY(1, SHeight);
  For I := 1 To SWidth Do
    Write(ChFrame);
  GotoXY(2, SHeight);

  If MDist = 0 Then
    If L = 0 Then
      Write('In the dark, the the talons of the grue drag you to your end.')
  Else
    Write('You bump in to the grue. It extinguishes your light, and you.')
  Else If (MDist <> -1) And (MDist < 2) And (L = 0) Then
         Write('You can hear the grue breathing down your neck.')
  Else If (MDist <> -1) And (MDist < 4) And (L = 0) Then
         Write('You can hear the talons of the grue tapping the tiles nearby.')
  Else If CT > 0 Then
         Begin
           Write('You pick up a ');
           Write(Adjective[Items[CTreasure].D2]);
           Write(ChSpace);
           Write(Noun[Items[CTreasure].D1]);
           Write('.');
           CT := CT - 1;
         End
  Else
    Begin
      If (L = 0) Then
        Write('It is dark, you are likely eaten by a grue.')
      Else If (L < 5) Then
             Begin
               Write('Your ');
               Write(Noun[Items[CLight].D1]);
               Write(' grows dim.  It will be dark soon.');
             End
      Else
        Begin
          Write('A ');
          Write(Adjective[Items[CLight].D2]);
          Write(ChSpace);
          Write(Noun[Items[CLight].D1]);
          Write(' lights your way.  For now.');
        End;
    End;
End;

Procedure DrawScore;

Var
  I : Integer;
Begin
  GotoXY(SWidth-5, SHeight);
  For I := 0 To 4 Do
    Write(ChFrame);
  GotoXY(SWidth-5, SHeight);
  Write(T);
  Write('/');
  Write(DT);

  GotoXY(SWidth-11, 1);
  Write('Dungeon: ');
  For I := 0 To 2 Do
    Write(ChFrame);
  GotoXY(SWidth-2, 1);
  Write(DC + 1);
End;
