{ main game loop }

Begin

  { CursorOff; }
{ fpSystem('tput civis'); } { hide cursor }
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

  GotoXY(1,SHeight+1);
  { fpSystem('tput cnorm'); } { restore cursor }

  If (D = 666) Then
    Begin
      { Window(1, 1, ScreenWidth, ScreenHeight); Not in TP3 }
      ClrScr;
      DebugAll;
    End
End.
