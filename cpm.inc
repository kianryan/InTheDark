{ emulate missing CRT functions }
function ReadKey : Char;
begin
    ReadKey := Chr(Bios(2)); {ConIn}
end;
