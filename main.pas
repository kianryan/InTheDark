{ main game loop }

begin
    Randomize;
    ClrScr;

    DrawFrame;
    GenerateDungeon;
    GeneratePlayer;
    for I := 0 to RoomI do DrawRoom(Rooms[I]);
    for I := 0 to DoorI do DrawDoor(Doors[I]);

    if (Debug) then for I := 0 to RoomI do WriteRoom(Rooms[I], I + 1);
    if (Debug) then for I := 0 to DoorI do WriteDoor(Doors[I], I + 1);

    DrawPlayer;

    while (NextMove) do
    begin
        MovePlayer;
        DrawPlayer;
    end;

    GotoXY(1,SHeight + 2);
end.

