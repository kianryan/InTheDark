{ monster management }

Procedure GenerateMonsters;

Var
  P: Real;
  I: Integer;
  Valid: Boolean;
Begin
  MDist := -1;
  MonsterI := 0;
  Valid := False;

  For I := 0 To RoomI Do
    Begin
      P := Random;
      If P > 0.6 Then
        Begin
          Repeat
            With Rooms[I], Monsters[MonsterI] Do
              Begin
                DX := Random(X2 - X1 - 1) + X1 + 1;
                DY := Random(Y2 - Y1 - 1) + Y1 + 1;
                X := DX;
                Y := DY;
                Room := I; { monsters stay in room }
                Valid := (X <> CPlayer.X) And (Y <> CPlayer.Y) And
                         (HitItem(X, Y) = -1);
              End;
          Until Valid;
          MonsterI := MonsterI + 1;
        End;
    End;

  MonsterI := MonsterI - 1;
End;

{ rules: }
{ in a room with a player: }
{ a monster will move away from player with light }
{ a monster will move towards player without light }
{ in a room without a player }
{ a monster will move in a random direction }

Procedure MoveRandom(I: Integer);

Var
  Tries: Integer; { 4 tries/ cardinalities }
  Valid : Boolean;
  D: Integer; { direction to try }
  TX, TY: Integer;
Begin
  With Monsters[I] Do
    Begin
    { if (M.Room <> CPlayer.Room) then begin }
      D := Random(4);
      Tries := 0;

      Repeat

        Tries := Tries + 1;

        If (Tries <> 1) Then
          Begin
            D := (D + 1) Mod 4; { try next cardinality }
          End;

        TX := X;
        TY := Y;
        Case D Of
          0: TX := TX - 1;
          1: TX := TX + 1;
          2: TY := TY - 1;
          3: TY := TY + 1;
        End;
        Valid := (Not HitWall(TX, TY)) And (HitItem(TX, TY) = -1);

      Until Valid Or (Tries > 4);

      If Valid Then
        Begin
          X := TX;
          Y := TY;
        End;
    { end; }
    End;
End;

{ Attempt to move closer to the player char }

{ D: 1 - towards, -1 away }
Procedure MoveToPlayer(I: Integer; D: Integer);

Var
  CX, CY: Integer; { change X/Y }
  TX, TY: Integer; { try X/Y }
Begin
  With Monsters[I] Do
    Begin
      CX := X - CPlayer.X;
      CY := Y - CPlayer.Y;

      If Not ((CX = 0) And (CY = 0)) Then
        Begin

  { work out which is the greater disparity and move closer towards the player }
          TX := X;
          TY := Y;
          If Abs(CX) > Abs(CY) Then
            If CX > 0 Then TX := X - D
          Else TX := X + D
          Else
            If CY > 0 Then TY := Y - D
          Else TY := Y + D;

          If (Not HitWall(TX, TY)) And (HitItem(TX, TY) = -1) Then
            Begin
              X := TX;
              Y := TY;
            End
          Else MoveRandom(I);
        End;
    End;
End;

Procedure MoveMonsters;

Var
  I: Integer;
  D: Integer; { Dir of monster movement }
Begin
  If L = 0 Then D := 1
  Else D := -1;
  For I := 0 To MonsterI Do
    If Monsters[I].Room = CPlayer.Room Then MoveToPlayer(I, D)
    Else MoveRandom(I)
End;


{ check for collisions with monsters }
{ return distance to monster if < 4 }
Function HitMonster(X1, Y1: Integer): Integer;

Var
  I: Integer;
  CX, CY: Integer;
  Found: Boolean;
Begin
  Found := False;
  I := 0;
  Repeat
    Begin
      With Monsters[I] Do
        Begin
   { only care if same room }
          If HitRoom(X1, Y1) = Room Then
            Begin
              CX := Abs(X1 - X);
              CY := Abs(Y1 - Y);
              If (CX < 4) And (CY < 4) Then
                Found := True
              Else
                I := I + 1;
            End
          Else
            I := I + 1;
        End;
    End;
  Until (I > MonsterI) Or Found;

  If Found Then
    HitMonster := Max(CX, CY)
  Else
    HitMonster := -1;
End;
