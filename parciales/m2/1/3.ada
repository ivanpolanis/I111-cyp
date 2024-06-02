Program EJ3 is
Task Type Server is
  ENTRY Peticion(s: IN String, res: OUT int);
End Server;

Task Type Cliente;

Task Admin is
  ENTRY Cambio(id: IN int);
  ENTRY PeticionA(s: IN String, res: OUT int);
End Admin;

Task Body Admin is
  curServer,res,id: int; s: string;
Begin
  Accept Cambio(curServer);
  Loop
    Select
      Accept PeticionA(s,res) is
        arrServer(curServer).Peticion(s,res);
      End PeticionA;
    Or
      Accept Cambio(curServer);
  End Loop;
End Admin;

Task Body Server is
Begin
  Loop
    Accept Peticion(s,res) is
      res = ResolverPeticion(s);
    End Peticion;
  End Loop;
End;

Task Body Cliente is
Begin
  Loop
    s := Request();
    Admin.PeticionA(s,res);
    UsarRes(res);
  End Loop;
End;

arrClientes: Array(1..P) of Cliente;
arrServers: Array(1..4) of Server;



Begin
  Server = 1;
  Admin.Cambio(Server);

  Loop
    Delay 6HS;
    Server := ((Server + 1) mod 4) + 1;
    Admin.Cambio(Server);
  End Loop;
End EJ3;
