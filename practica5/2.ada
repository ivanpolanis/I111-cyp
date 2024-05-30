Program Ejercicio2 is
Task Empleado is
  Entry Atender(datos: IN string; res: out string);
End Empleado;

Task Type Cliente;

arrClientes: array(1..N-1) of Cliente;

Task Body Empleado is
  res: string;
Begin
  loop
    accept Atender(datos: IN string; res: out string) do
      res := AtenderAlCliente(datos);
    end Atender;
  end loop;
End;

Task Body Cliente is
  datos: string = ...; res: string;
Begin
  Select
    Empleado.Atender(datos,res);
  or Delay 600.0
    NULL
  End Select;
End;

Begin
  NULL
End Ejercicio2;
