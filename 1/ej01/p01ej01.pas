{
* 1. Realizar un algoritmo que cree un archivo de números enteros no ordenados y permita
incorporar datos al archivo. Los números son ingresados desde teclado. El nombre del
archivo debe ser proporcionado por el usuario desde teclado. La carga finaliza cuando
se ingrese el número 30000, que no debe incorporarse al archivo.
* }



program fod_p01ej01;

Const
	FINAL = 30000;
Type
	archivo = file of integer;
	cadena20 = string[20];

Var
	archNombre: cadena20;
	arch: archivo;
	num: integer;
Begin
	write('Ingrese un nombre para el archivo: ');
	readln(archNombre);
	assign(arch, archNombre);
	
	{creo el archivo lógico}
	rewrite(arch);
	writeln('-------------');
	write('Ingrese los números que desea almacenar en el archivo. Para salir ingrese el número 30000: ');
	readln(num);
	while (num <> FINAL) do begin
		write(arch,num);
		writeln('-------------');
		write('Ingrese los números que desea almacenar en el archivo. Para salir ingrese el número 30000: ');
		readln(num);
	
	end;
	
	close(arch);
	writeln('--------------------_> Escritura finalizada');
	


End.

