{ global types and variable declerations }

type
    Room = record
        X1, Y1, X2, Y2: Integer;
        Discovered: Boolean;
		ShowContents: Boolean;
    end;

    Door = record
        X, Y: Integer; { pos }
        Room1I : Integer; { index of room 1 }
        Room2I : Integer; { index of room 2 }
        Opened : Boolean;
    end;

    Item = record
	    X, Y: Integer; { pos }
	    Room: Integer; { idx of room }
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
		Room: Integer;
    end;

    Monster = record
    	X, Y: Integer;
    	DX, DY: Integer; { last disp X, Y }
    	Room: Integer;
    end;

var
    Rooms: array[0..10] of Room;
    RoomI: Integer;

    Doors: array[0..40] of Door; { we won't need this many }
    DoorI: Integer;

    Items: array[0..50] of Item; { up to 3 items per room }
    ItemI: Integer;
    CLight: Integer;  { last light picked up }
    CTreasure: Integer;  { last light picked up }

    Monsters: array[0..10] of Monster;
    MonsterI: Integer;

    D: Integer; { player direction }
    CPlayer: Player;
    MDist: Integer; { dist to monster }

    I: Integer; { idx counter }

    L: Integer; { number of turns remaining with light }
    T: Integer; { total treasure taken }
	DT: Integer; { total treasure in dungeon }
	CT: Integer; { turns to display treasure for }

	DC: Integer; { total number of dungeons cleared by player }
	NextDungeon: Boolean;

    Noun: array[0..20] of String;
    Adjective: array[0..20] of String;

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

	Noun[10] := 'painting';
	Noun[11] := 'egg';
	Noun[12] := 'jewel';
	Noun[13] := 'belt buckle';
	Noun[14] := 'casket';
	Noun[15] := 'crystal skull';
	Noun[16] := 'pearl';
	Noun[17] := 'piece of eight';
	Noun[18] := 'fish scale';
	Noun[19] := 'carpenter''s chalice';

    Adjective[0] := 'glimmering'; { All glimmer/shimmer/etc. }
    Adjective[1] := 'shimmering';
    Adjective[2] := 'bright';
    Adjective[3] := 'golden';
    Adjective[4] := 'sparkling';
    Adjective[5] := 'battery powered';
    Adjective[6] := 'radiant';
    Adjective[7] := 'luminos';
    Adjective[8] := 'flashing';
    Adjective[9] := 'brilliant';

	Adjective[10] := 'wooden';
	Adjective[11] := 'illustrated';
	Adjective[12] := 'golden';
	Adjective[13] := 'bejewled';
	Adjective[14] := 'plain';
	Adjective[15] := 'resplendant';
	Adjective[16] := 'ghostly';
	Adjective[17] := 'oozing';
	Adjective[18] := 'gigantic';
	Adjective[19] := 'clockwork';
end;
