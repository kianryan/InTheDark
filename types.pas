{ global types and variable declerations }

type
    Room = record
        X1, Y1, X2, Y2: Integer;
        Discovered: Boolean;
    end;

    Door = record
        X, Y: Integer; { pos }
        Room1I : Integer; { index of room 1 }
        Room2I : Integer; { index of room 2 }
        Opened : Boolean;
    end;

    Item = record
	X, Y: Integer; { pos }
	IType: Integer; { no enum in TP3 }
	Taken: Boolean;
	L: Integer; { duration of light }
	T: Integer; { add to treasure }
	D1: Integer; { desc idx 1 }
	D2: Integer; { desc idx 2 }
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

    Items: array[0..30] of Item; { up to 3 items per room }
    ItemI: Integer;

    D: Integer; { player direction }
    CPlayer: Player;

    I: Integer;

    L: Integer; { number of turns remaining with light }

    Noun: array[0..10] of String;
    Verb: array[0..10] of String;

const
   SWidth = 80;
   SHeight = 24;
   LWidth = 10;
   LHeight = 6;
   UWidth = 20;
   UHeight = 10;
   MWidth = 3;
   MHeight = 3;
   Debug = True;

{ Init dict for nouns and verbs }
procedure SetupDict;
begin
    Noun[0] := 'match'; { Smaller light }
    Noun[1] := 'candle';
    Noun[2] := 'glow worms';
    Noun[3] := 'branch';
    Noun[4] := 'squash';
    Noun[5] := 'bulb';
    Noun[6] := 'torch';
    Noun[7] := 'rock';
    Noun[8] := 'torch';
    Noun[9] := 'brass lantern'; { Bigger light }

    Verb[0] := 'glimmering'; { All glimmer/shimmer/etc. }
    Verb[1] := 'shimmering';
    Verb[2] := 'bright';
    Verb[3] := 'golden';
    Verb[4] := 'sparkling';
    Verb[5] := 'battery powered';
    Verb[6] := 'radiant';
    Verb[7] := 'luminos';
    Verb[8] := 'flashing';
    Verb[9] := 'brilliant';
end;
