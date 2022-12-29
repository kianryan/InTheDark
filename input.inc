{ input handling }

Function NextMove : Boolean;

Var
  ch: char;
Begin

  D := -1;

  ch := ReadKey;
  ch := lowercase(ch);
  Case ch Of
    'a': D := 0;
    's': D := 3;
    'd': D := 1;
    'w': D := 2;
    'q': D := 999;
    { 'p': D := 666; } { debug code }
    { 'l': D := 111; } { debug code }
  End;

  NextMove := Not ((D = 999) or (D = 666)); { we are quitting? }
End;
