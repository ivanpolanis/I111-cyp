Program Ejercicio6 is
Task Type Persona is
  Entry Ok;
  Entry Recibir(id: IN int; grupo: IN int);
  Entry Ganador(gg: IN integer);
End Persona;

Task Admin is
  Entry Llegada(id: IN integer; grupo: IN integer, ultimo: OUT bool);
  Entry Termina(grupo: IN integer; monto: IN integer);
End Admin;

arrPersona: Array(1..20) of Persona;

Task Body Persona is
  id,grupo, gg: integer; monto: integer := 0; ultimo: bool;
Begin
  Accept Recibir(id,grupo);

  Admin.Llegada(id,grupo,ultimo);
  When (not ultimo) => Accept Ok();

  For i in 1..15 do
    monto := monto + Moneda();
  End For;

  Admin.Termina(grupo,monto);

  Accept Ganador(gg);
End persona;


Task Body Admin is
  tot[4]: integer := 0; terminaron: integer := 0; monto: integer; ganador: integer;
  q[4]: queue<integer>;
Begin
  While (terminaron < 20) do
    Select
      Accept Llegada(id, grupo, ultimo) is
        if (size(q[grupo]) = 3) do
          push(q[grupo],id);
          ultimo := false;
        else
          for i in 1..3 do
            arrPersona[pop(q[grupo])].Ok();
          end for;
          ultimo := true;
        End fi;
      End Llegada;
    or
      Accept Termina(grupo,monto) is
        tot[grupo] := tot[grupo] + monto;
      End Termina;
    End Select;
  End While;

  monto := tot[1];
  ganador := 1;
  For i in 2..4 do
    if (tot[i] > monto) do
      monto := tot[i];
      ganador := i;
    End if;
  End For;

  For i in 1..20 do
    arrPersona[i].Ganador(ganador);
  End For;
End Admin;

Begin
  For i in 1..20 do
    arrPersona[i].Recibir(i,(i%4)+1);
  End For;
End Ejercicio6;
