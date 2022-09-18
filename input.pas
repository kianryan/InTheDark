{ input handling }

function NextMove : Boolean;
var
    ch: char;
begin

    D := -1;

    ch := ReadKey;
    ch := lowercase(ch);
    GotoXY(1,1);
    case ch of
        'a': D := 0;
        's': D := 3;
        'd': D := 1;
        'w': D := 2;
        'q': D := 999;
    end;

    NextMove := D <> 999; { we are quitting? }
end;