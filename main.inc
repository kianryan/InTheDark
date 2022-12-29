
{ main game loop }
Procedure Main;
Begin

  CursorOff;
  Randomize;

  SetupDict;

  MDist := 0;
  CT := 0;
  T := 0;

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

      { L := 32767; }

      While ((MDist <> 0) And (T < DT) And NextMove) Do
        Begin
          If (MovePlayer) Then DrawDungeon;
          If D = 111 Then LightSpell;
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

  GotoXY(1,SHeight+1);

  If (D = 666) Then
    Begin
      ClrScr;
      DebugAll;
    End;

  CursorOn;
End;
