{ input handling }

Function NextMove : Boolean;

Var
  ch: char;
Begin

  D := -1;

  ch := ReadKey;
  ch := lowercase(ch);
  GotoXY(1,1);
  Case ch Of
    'a': D := 0;
    's': D := 3;
    'd': D := 1;
    'w': D := 2;
    'q': D := 999;
  End;

  NextMove := D <> 999; { we are quitting? }
End;
