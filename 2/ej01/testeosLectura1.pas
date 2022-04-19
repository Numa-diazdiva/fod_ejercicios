
program p02je01;

Type
	cadena20 = string[20];
	comisionEmpleado  = record
		cod: integer;
		nombre: cadena20;
		monto: real;
	end;
	{Ordenado por cod de empleado}
	arch = file of comisionEmpleado;


Var
	a1 : arch;
	r1: comisionEmpleado;
Begin
	assign(a1,'compactado');
	reset(a1);
	while(not eof(a1)) do begin
		read(a1,r1);
		writeln('-------------');
		writeln('Cod Empleado: ',r1.cod);
		writeln('Nombre Empleado: ',r1.nombre);
		writeln('Monto vendido: ',r1.monto:6:2);
	end;
	
	
	close(a1);
End.
