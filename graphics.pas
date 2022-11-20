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
            Write('-');
          For I := Y1 + 1 To Y2 Do
            Begin
              GotoXY(X1, I);
              Write('!');
              GotoXY(X2, I);
              Write('!');
            End;
          GotoXY(X1, Y2);
          For I := X1 To X2 Do
            Write('-');
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
          Write('X');
        End
      Else If Opened Then
             Begin
               GotoXY(X, Y);
               Write(' ');
             End
    End;
End;

Procedure DrawItem(DI: Item);
Begin
  With DI Do
    Begin
      GotoXY(X, Y);
      Case (IType) Of
        1: Write('#');
        2: Write('£');
        Else
          Write(IType);
      End;
    End;
End;

Procedure HideItem(DI: Item);
Begin
  With DI Do
    Begin
      GotoXY(X, Y);
      Write(' ');
    End;
End;

Procedure DrawMonster(I: Integer; Glyph: String);
Begin
  With Monsters[I] Do
    Begin
      GotoXY(DX, DY);
      If Not ((DX = CPlayer.X) And (DY = CPlayer.Y)) Then Write(' ');
      GotoXY(X, Y);
      Write(Glyph);
      DX := X; { Set new position on screen }
      DY := Y;
    End;
End;

Procedure DrawMonsters;

Var
  Glyph: String;
Begin
  For I := 0 To MonsterI Do
    Begin
      Glyph := ' ';
      If (Rooms[Monsters[I].Room].ShowContents) And (L > 0) Then Glyph := '"';
      DrawMonster(I, Glyph);
    End
End;

Procedure DrawDungeon;

Var
  I: Integer;
Begin
  For I := 0 To RoomI Do
    Begin
      Rooms[I].ShowContents := CanSee(CPlayer.Room, I);
      DrawRoom(Rooms[I]);
    End;
  For I := 0 To DoorI Do
    DrawDoor(Doors[I]);
  For I := 1 To ItemI Do
    If (Not Rooms[Items[I].Room].ShowContents) Or Items[I].Taken Or (L = 0) Then
      HideItem(Items[I])
    Else
      DrawItem(Items[I]);
End;

Procedure DrawFrame;

Var
  X, Y: Integer;
Begin
  Clrscr;
  GotoXY(1,1);
  For X := 1 To SWidth Do
    Begin
      GotoXY(X, 1);
      Write('*');
      GotoXY(X, SHeight);
      Write('*')
    End;
  For Y := 1 To SHeight Do
    Begin
      GotoXY(1, Y);
      Write('*');
      GotoXY(SWidth, Y);
      Write('*');
    End;
  GotoXY(1,1);
End;

Procedure DrawPlayer;
Begin
  With CPlayer Do
    Begin
      GotoXY(DX, DY);
      Write(' ');
      GotoXY(X, Y);
      Write('@');
      DX := X; { Set new position on screen }
      DY := Y;
    End;
End;

Procedure DrawStatus;

Var
  I: Integer;
Begin
  GotoXY(2, SHeight);
  For I := 1 To SWidth - 1 Do
    Write('*');
  GotoXY(2, SHeight);

  If MDist <> -1 Then
    Begin
      If (MDist = 0) And (L = 0) Then
        Write('In the dark, the the talons of the grue drag you to your end.')
      Else If MDist = 0 Then
             Write(




   'In the light, you bump in to the grue. It extinguishes your light, and you.'
             )
      Else If (MDist < 2) And (L = 0) Then
             Write('You can hear the grue breathing down your neck.')
      Else If ((MDist < 4) And (L = 0)) Then
             Write(




                 'You can hear the talons of the grue tapping the tiles nearby.'
             )
    End
  Else If CT > 0 Then
         Begin
           Write('You pick up a ');
           Write(Adjective[Items[CTreasure].D2]);
           Write(' ');
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
          Write(' ');
          Write(Noun[Items[CLight].D1]);
          Write(' lights your way.  For now.');
        End;
    End;
End;

Procedure DrawScore;
Begin
  GotoXY(SWidth-5, SHeight);
  Write('*****');
  GotoXY(SWidth-5, SHeight);
  Write(T);
  Write('/');
  Write(DT);

  GotoXY(SWidth-11, 1);
  Write('Dungeon: ***');
  GotoXY(SWidth-2, 1);
  Write(DC);
End;
