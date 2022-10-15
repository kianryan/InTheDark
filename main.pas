{ main game loop }

begin
    Randomize;
    ClrScr;

    SetupDict;

    GenerateDungeon;
    GenerateItems;
    GeneratePlayer;

    DrawFrame;
    DrawDungeon;
    DrawPlayer;

    if (Debug) then for I := 0 to RoomI do WriteRoom(Rooms[I], I + 1);
    if (Debug) then for I := 0 to DoorI do WriteDoor(Doors[I], I + 1);
    if (Debug) then for I := 0 to ItemI do WriteItem(Items[I], I + 1);

    while (NextMove) do
    begin
        if (MovePlayer) then DrawDungeon;
        DrawPlayer;
		DrawStatus;
    end;

    GotoXY(1,SHeight + 2);
end.

