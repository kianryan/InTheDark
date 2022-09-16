program Rogue;
uses Crt;

type
    Room = record
        X1, Y1, X2, Y2: Integer;
    end;

var
    Rooms: array[0..6] of Room;
    RoomI: Integer;
    I: Integer;


const
   SWidth = 80;
   SHeight = 24;
   MinWidth = 9;
   MinHeight = 4;
   MaxWidth = 20;
   MaxHeight = 10;

{ Generate the first room }
procedure FirstRoom;
var
    W, H: Integer;
begin
         { Generate first room dims }
         RoomI := 0;
         with Rooms[0] do
         begin
             X1 := Random(SWidth - MaxWidth - 1) + 1;
             Y1 := Random(SHeight - MaxHeight - 1) + 1;
             W := Random(MaxWidth-MinWidth) + MinWidth + 1;
             H := Random(MaxHeight-MinHeight) + MinHeight + 1;
             X2 := X1 + W;
             Y2 := Y1 + H;
        end;
end;

{ Generate another room }
{ Will return False if a room can no longer be generated. }
function NextRoom : Boolean;
var
    W, H, X, Y: Integer;
    D: Integer; { direction of travel }
    CR: Room;
    GenNext: Boolean;
begin
    { So, we know the current room, and we can decide a direction}
    D := Random(4);
    D := 0;         { But not that random }

    W := Random(MaxWidth-MinWidth) + MinWidth + 1;
    H := Random(MaxHeight-MinHeight) + MinHeight + 1;

    { Attempt to draw the rectangle.  If it fits, great.
     If it doesn't, attempt to make it fit. }

    CR := Rooms[RoomI];

    GenNext := True;

    with Rooms[RoomI + 1] do
    begin
        case D of
            0: begin
                X2 := CR.X1;
                if (X2 - W < 1) then W := X2 - 1;
                if (W < 3) then GenNext := False; { esc out}
                X1 := X2 - W;
                Y := Random(CR.Y2 - CR.Y1 - 1) + CR.Y1 + 1;
                if (Y - (H div 2) < 1) then H := Y;
                if (Y - (H div 2) + H >= SHeight) then H := (SHeight - Y - 1);
                Y1 := Y - (H div 2);
                Y2 := Y1 + H;
            end;
        end;
   end;

    if (GenNext) then RoomI := RoomI + 1;
    NextRoom := GenNext;
end;

{ Debug print room co-ordinates}
procedure WriteRoom(Debug: Room; L: Integer);
begin
    GotoXY(1, L);
    Write('X1: ');
    Write(Debug.X1);
    Write(' Y1: ');
    Write(Debug.Y1);
    Write(' X2: ');
    Write(Debug.X2);
    Write(' Y2: ');
    WriteLn(Debug.Y2);
end;

procedure DrawRoom(DR: Room);
var I: Integer;
begin
    with DR do
    begin
        GotoXY(X1,Y1);
        for I := X1 to X2 do Write('-');
        for I := Y1 + 1 to Y2 do
        begin
            GotoXY(X1, I); Write('!');
            GotoXY(X2, I); Write('!');
        end;
        GotoXY(X1, Y2);
        for I := X1 to X2 do Write('-');
    end;
end;

begin
    Randomize;
    ClrScr;
    FirstRoom;

    while((RoomI < 5) and NextRoom()) do ;

    for I := 0 to RoomI do DrawRoom(Rooms[I]);

    GotoXY(1,SHeight);
end.




