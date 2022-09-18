{ global types and variable declerations }

type
    Room = record
        X1, Y1, X2, Y2: Integer;
    end;

    Door = record
        X, Y: Integer; { pos }
        Room1I : Integer; { index of room 1 }
        Room2I : Integer; { index of room 2 }
    end;

    Player = record
        X, Y: Integer;
        DX, DY: Integer; { last disp X, Y }
    end;

var
    Rooms: array[0..10] of Room;
    RoomI: Integer;

    Doors: array[0..40] of Door; { we won't need this many}
    DoorI: Integer;

    D: Integer; { player direction }
    CPlayer: Player;

    I: Integer;

const
   SWidth = 80;
   SHeight = 24;
   LWidth = 10;
   LHeight = 6;
   UWidth = 20;
   UHeight = 10;
   MWidth = 3;
   MHeight = 3;
   Debug = False;

