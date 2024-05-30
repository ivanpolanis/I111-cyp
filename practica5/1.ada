Program Ejercicio1 is
Task Administrador is
  Entry PasarAuto;
  Entry PasarCamioneta;
  Entry PasarCamion;
  Entry Liberar(p: IN integer);
End Administrador;

Task Type Auto;
Task Type Camioneta;
Task Type Camion;

Task Body Administrador is
  peso: integer;
Begin
  peso := 0;
  loop
    Select
      when(peso + 1 <= 5) => accept PasarAuto do
        peso := peso + 1;
      end PasarAuto;
    or
      when(peso + 2 <= 5) => accept PasarCamioneta do
        peso := peso + 2;
      end PasarCamioneta;
    or
      when(peso + 3 <= 5) => accept PasarCamion do
        peso := peso + 3;
      end PasarCamion;
    or
      accept Liberar(P: IN integer) do
        peso := peso - P;
      end Liberar;
    End Select;
  end loop;
End Administrador;

Task Body Auto is
Begin
  Administrador.PasarAuto();
  Administrador.Liberar(1);
End;

Task Body Camioneta is
Begin
  Administrador.PasarCamioneta();
  Administrador.Liberar(2);
End;

Task Body Camion is
Begin
  Administrador.PasarCamion();
  Administrador.Liberar(3);
End;

Begin
  NULL
End Ejercicio1;
