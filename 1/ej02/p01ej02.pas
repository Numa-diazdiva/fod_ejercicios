{
* 2. Realizar un algoritmo, que utilizando el archivo de números enteros no ordenados
creados en el ejercicio 1, informe por pantalla cantidad de números menores a 1500 y
el promedio de los números ingresados. El nombre del archivo a procesar debe ser
proporcionado por el usuario una única vez. Además, el algoritmo deberá listar el
contenido del archivo en pantalla.
* 
* }

program fod_p01ej02;

Type
	archivo = file of integer;
	cadena20 = string[20];

procedure recorrerImprimir(var archivoLogico: archivo; var cantMenores: integer);
	var
		num: integer;
	begin
		reset(archivoLogico);
		while (not eof(archivoLogico)) do begin
			read(archivoLogico, num);
			if (num > 1500) then begin
				writeln(num);
			end
			else begin
				writeln(num,' <---');
				cantMenores:= cantMenores + 1;
			end;
			
		end;
		
		close(archivoLogico);
		
	end;



Var
	archNombre: cadena20;
	arch: archivo;
	cantMenores: integer;
	
Begin
	cantMenores:= 0;
	write('Ingrese el nombre del archivo que desea leer: ');
	readln(archNombre);
	assign(arch, archNombre);
	
	writeln('------------IMPRESION DE VALORES -----------');
	recorrerImprimir(arch, cantMenores);
	
	writeln('----------------');
	writeln('La cantidad de numeros menores a 1500 es de: ', cantMenores);

End.
