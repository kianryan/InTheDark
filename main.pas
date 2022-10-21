{ main game loop }

begin
    Randomize;

    SetupDict;

	DC := 0;
	NextDungeon := True;

	while(NextDungeon) do
	begin
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

		if (Debug) then for I := 0 to RoomI do WriteRoom(Rooms[I], I + 1);
    	if (Debug) then for I := 0 to DoorI do WriteDoor(Doors[I], I + 1);
    	if (Debug) then for I := 0 to ItemI do WriteItem(Items[I], I + 1);
    	if (Debug) then for I := 0 to MonsterI do WriteMonster(Monsters[I], I + 1);

		L := 32767;

    	while ((MDist <> 0) and (T < DT) and NextMove) do
    	begin
        	if (MovePlayer) then DrawDungeon;
        	DrawPlayer;
			DrawMonsters;
			MDist := HitMonster(CPlayer.X, CPlayer.Y);
			DrawStatus;
			DrawScore;
    	end;

		{ if not win, then end game.  Otherwise, new dungeon. }
		if T < DT then NextDungeon := False else DC := DC + 1;
	end;

    GotoXY(1,SHeight + 2);
end.

