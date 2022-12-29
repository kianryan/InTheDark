
function Lowercase(Ch: Char) : Char;
begin
     if Ord(Ch) < 96 then
        Lowercase := Chr(Ord(Ch)+32)
     else
        Lowercase := Ch;
end;

{ Stub math function }
function Max(X1, X2: Integer) : Integer;
begin
    if X1 >= X2 then Max := X1 else Max := X2;
end;

function Min(X1, X2: Integer) : Integer;
begin
   if X1 <= X2 then Min := X1 else Min := X2;
end;
