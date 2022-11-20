{ main game loop }

Begin
  Randomize;

  SetupDict;

  DC := 0;
  NextDungeon := True;

  While (NextDungeon) Do
    Begin
      GenerateDungeon;
      GenerateItems;
      GeneratePlayer;
      GenerateMonsters;

      DrawFrame;
      DrawDungeon;
      DrawPlayer;
      DrawMonsters;
      DrawStatus;
      DrawScore;

      If (Debug) Then For I := 0 To RoomI Do
                        WriteRoom(Rooms[I], I + 1);
      If (Debug) Then For I := 0 To DoorI Do
                        WriteDoor(Doors[I], I + 1);
      If (Debug) Then For I := 0 To ItemI Do
                        WriteItem(Items[I], I + 1);
      If (Debug) Then For I := 0 To MonsterI Do
                        WriteMonster(Monsters[I], I + 1);

      L := 32767;

      While ((MDist <> 0) And (T < DT) And NextMove) Do
        Begin
          If (MovePlayer) Then DrawDungeon;
          DrawPlayer;
          DrawMonsters;
          MDist := HitMonster(CPlayer.X, CPlayer.Y);
          DrawStatus;
          DrawScore;
        End;

  { if not win, then end game.  Otherwise, new dungeon. }
      If T < DT Then NextDungeon := False
      Else DC := DC + 1;
    End;

  GotoXY(1,SHeight + 2);
End.
