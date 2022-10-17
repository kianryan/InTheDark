{ main game loop }

begin
    Randomize;
    ClrScr;

    SetupDict;

    GenerateDungeon;
    GenerateItems;
    GeneratePlayer;
	GenerateMonsters;

    DrawFrame;
    DrawDungeon;
	DrawMonsters;
    DrawPlayer;
    DrawStatus;

	if (Debug) then for I := 0 to RoomI do WriteRoom(Rooms[I], I + 1);
    if (Debug) then for I := 0 to DoorI do WriteDoor(Doors[I], I + 1);
    if (Debug) then for I := 0 to ItemI do WriteItem(Items[I], I + 1);
    if (Debug) then for I := 0 to MonsterI do WriteMonster(Monsters[I], I + 1);

	L := 32767;

    while ((MDist <> 0) and NextMove) do
    begin
		MoveMonsters;
        if (MovePlayer) then DrawDungeon;
		DrawMonsters;
        DrawPlayer;
		MDist := HitMonster(CPlayer.X, CPlayer.Y);
		DrawStatus;
    end;

    GotoXY(1,SHeight + 2);
end.

