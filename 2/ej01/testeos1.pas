
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
	assign(a1,'aEmpleadosPrueba1');
	rewrite(a1);
	writeln('Ingrese cod: '); readln(r1.cod);
	writeln('Ingrese nom: '); readln(r1.nombre);
	writeln('Ingrese monto: '); readln(r1.monto);
	while (r1.cod <> -1) do begin
		write(a1,r1);
		writeln('Ingrese cod: '); readln(r1.cod);
		writeln('Ingrese nom: '); readln(r1.nombre);
		writeln('Ingrese monto: '); readln(r1.monto);	
	end;
	
	close(a1);
End.
