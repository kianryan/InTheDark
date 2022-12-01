
{ ANSI CursorOff }
Procedure CursorOff;
Var Cmd : AnsiString;
Begin
  Cmd := 'tput civis';
  fpSystem(Cmd);  { hide cursor }
End;

{ ANSI CursorOn }
Procedure CursorOn;
Var Cmd : AnsiString;
Begin
  Cmd := 'tput cnorm';

  fpSystem(Cmd); { restore cursor }
End;
