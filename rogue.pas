program Rogue;
uses Crt;

type
    Room = record
        X1, Y1, X2, Y2: Integer;
    end;

var
    Rooms: array[0..10] of Room;
    RoomI: Integer;
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
   Debug = True;

{ Generate the first room }
procedure FirstRoom;
var
    W, H: Integer;
begin
         { Generate first room dims }
         RoomI := 0;
         with Rooms[0] do
         begin
             X1 := Random(SWidth - UWidth - 1) + 1;
             Y1 := Random(SHeight - UHeight - 1) + 1;
             W := Random(UWidth-LWidth) + LWidth + 1;
             H := Random(UHeight-LHeight) + LHeight + 1;
             X2 := X1 + W;
             Y2 := Y1 + H;
        end;
end;

{ Check to see if there's an overlap between a room and a set of co-ords }
function Overlap(SR : Room; DR: Room) : Boolean;
begin
    Overlap := (SR.X1 < DR.X2) and (SR.X2 > DR.X1) and
        (SR.Y1 < DR.Y2) and (SR.Y2 > DR.Y1);
end;

{ Generate another room }
{ Will return False if a room can no longer be generated. }
function NextRoom : Boolean;
var
    W, H, X, Y: Integer;
    D, DS: Integer; { direction of travel }
    CR: Room;
    TryAgain, GenNext: Boolean;
begin
    { So, we know the current room, and we can decide a direction}
    D := Random(4);
    DS := D; { Keep track of the starting position }


    { Attempt to draw the rectangle.  If it fits, great.
     If it doesn't, attempt to make it fit. }

    CR := Rooms[RoomI];

    TryAgain := True;

    with Rooms[RoomI + 1] do
    begin
        while(TryAgain) do


        begin

            W := Random(UWidth-LWidth) + LWidth + 1;
            H := Random(UHeight-LHeight) + LHeight + 1;

            GenNext := True;
            case D of
                0: begin
                    X2 := CR.X1;
                    if (X2 - W < 1) then W := X2 - 1;
                    if (W < LWidth) then GenNext := False; { esc out}
                    X1 := X2 - W;
                    Y := Random(CR.Y2 - CR.Y1 - 1) + CR.Y1 + 1;
                    if (Y - (H div 2) < 1) then H := Y;
                    if (Y - (H div 2) + H >= SHeight) then H := (SHeight - Y - 1);
                    if (H < MHeight) then GenNext := False;
                    Y1 := Y - (H div 2);
                    Y2 := Y1 + H;
                end;
                1: begin
                    X1 := CR.X2;
                    if (X1 + W > SWidth) then W := SWidth - X1;
                    if (W < LWidth) then GenNext := False; { esc out}
                    X2 := X1 + W;
                    Y := Random(CR.Y2 - CR.Y1 - 1) + CR.Y1 + 1;
                    if (Y - (H div 2) < 1) then H := Y;
                    if (Y - (H div 2) + H >= SHeight) then H := (SHeight - Y - 1);
                    if (H < MHeight) then GenNext := False;
                    Y1 := Y - (H div 2);
                    Y2 := Y1 + H;
                end;
                2: begin
                    Y2 := CR.Y1;
                    if (Y2 - H < 1) then H := Y2 - 1;
                    if (H < LHeight) then GenNext := False; { esc out}
                    Y1 := Y2 - H;
                    X := Random(CR.X2 - CR.X1 - 1) + CR.X1 + 1;
                    if (X - (W div 2) < 1) then W := X;
                    if (X - (W div 2) + W >= SWidth) then W := (SWidth - X - 1);
                    if (W < MWidth) then GenNext := False;
                    X1 := X - (W div 2);
                    X2 := X1 + W;
                end;
                3: begin
                    Y1 := CR.Y2;
                    if (Y1 + H > SHeight) then H := SHeight - Y1;
                    if (H < LHeight) then GenNext := False; { esc out}
                    Y2 := Y1 + H;
                    X := Random(CR.X2 - CR.X1 - 1) + CR.X1 + 1;
                    if (X - (W div 2) < 1) then W := X;
                    if (X - (W div 2) + W >= SWidth) then W := (SWidth - X - 1);
                    if (W < MWidth) then GenNext := False;
                    X1 := X - (W div 2);
                    X2 := X1 + W;
                end;
            end;

            { Test for collision, if collision, then mark for try again. }
            For I := 0 to RoomI do begin
                If (Overlap(Rooms[I], Rooms[RoomI + 1])) then
                begin
                    if (Y2 > Rooms[I].Y1) then Y2 := Rooms[I].Y1 else
                    if (Y1 < Rooms[I].Y2) then Y1 := Rooms[I].Y2 else
                    if (X2 > Rooms[I].X1) then X2 := Rooms[I].X1 else
                    if (X1 > Rooms[I].X2) then X1 := Rooms[I].X2;
                    W := X2 - X1;
                    H := Y2 - Y1;
                    if ((W < MWidth) or (H < MHeight)) then GenNext := False;
                end;
           end;

            If GenNext then TryAgain := False
            else begin
                D := (D + 1) mod 4;

                if D = DS then begin
                    TryAgain := False; { We have tried all ords }
                    GotoXY(CR.X1 + 1, CR.Y1 + 1);
                end
                else
            end;
        end;
   end;

    if (GenNext) then RoomI := RoomI + 1;
    NextRoom := GenNext;
end;

{ Generates new dungeon, resets dungeon variables }
procedure GenerateDungeon;
begin
    while(RoomI < 5) do begin { we need a minimum of 5 room dungeon }
        FirstRoom;
        while((RoomI < 10) and NextRoom()) do ;
    end;
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

procedure DrawFrame;
var
    I: Integer;
    X, Y: Integer;
begin
    GotoXY(1,1);
    for I := 1 to SWidth do
    begin
     GotoXY(I, 1);
     Write('*');
     GotoXY(I, SHeight);
     Write('*')
    end;
    for Y := 1 to SHeight do
    begin
        GotoXY(1, Y);
        Write('*');
        GotoXY(SWidth, Y);
        Write('*');
    end;
    GotoXY(1,1);
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

    DrawFrame;
    GenerateDungeon;
    for I := 0 to RoomI do DrawRoom(Rooms[I]);

    // if (Debug) then for I := 0 to RoomI do WriteRoom(Rooms[I], I + 1);

    GotoXY(1,SHeight + 2);
end.




