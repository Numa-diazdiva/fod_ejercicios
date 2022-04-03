
{
7. Realizar un programa que permita:
a. Crear un archivo binario a partir de la información almacenada en un archivo de texto.
El nombre del archivo de texto es: “novelas.txt”
b. Abrir el archivo binario y permitir la actualización del mismo. Se debe poder agregar
una novela y modificar una existente. Las búsquedas se realizan por código de novela.
NOTA: La información en el archivo de texto consiste en: código
de novela,
nombre,género y precio de diferentes novelas argentinas. De cada novela se almacena la
información en dos líneas en el archivo de texto. La primera línea contendrá la siguiente
información: código novela, precio, y género, y la segunda línea almacenará el nombre
de la novela.

}




program fod_p01ej07;

Type
	cadena20 = string[20];
	novela = record
		cod: integer;
		precio: real;
		genero: cadena20;
		nombre: cadena20;
	end;
	
	novelaD = record
		cod:integer;
		precio:real;
	end;
	
	archivo = file of novela;
	archivoD = file of novelaD;



procedure ImprimirNovela(n: novela);
	begin
		writeln('Cod Novela: ', n.cod);
		writeln('Nombre: ', n.nombre);
		writeln('Precio: ', n.precio:6:2);
		writeln('Género: ', n.genero);
	end;

procedure CargarALB(var aB: archivo; var aT: Text);
	var
		n:novela;
	begin
		reset(aT);
		rewrite(aB);
		while(not eof(aT)) do begin
			readln(aT,n.cod, n.precio, n.genero);
			readln(aT,n.nombre);
			write(aB,n);
		end;
		close(aB);
		close(aT);
	end;

procedure ImprimirArchBin(var a:archivo);
	var
		n:novela;
	begin
		reset(a);
		while(not eof(a)) do begin
			writeln('-------------');
			read(a,n);
			ImprimirNovela(n);
		end;
		close(a);
	end;

{------------------EDICION-----------------}

procedure AgregarNovela(var a:archivo);
	var
		n:novela;
	begin
		reset(a);
		writeln('---- Agregar Novela al final del archivo -----');
		seek(a,filesize(a));
	
		writeln('Ingrese el código de la novela: '); readln(n.cod);
		writeln('Ingrese el título de la novela: '); readln(n.nombre);
		writeln('Ingrese el precio de la novela: '); readln(n.precio);
		writeln('Ingrese el género de la novela'); readln(n.genero);
		
		write(a,n);
		close(a);
	end;


procedure ActualizarMaestro(var a:archivo; var aD:archivoD);
	var
		datoM: novela;
		datoD: novelaD;
	begin
		{mientras no se terminó el archivo de detalles, recorro el archivo maestro comparando su contenido con el del detalle para actualizar}
		reset(a); reset(aD);
		while(not eof(aD)) do begin
			read(a,datoM);
			read(aD,datoD);
			while (datoD.cod <> datoM.cod) do begin
				read(a,datoM);
			end;
			datoM.precio:= datoD.precio;
			seek(a, filepos(a) - 1);
			write(a,datoM);
		end;
		close(a); close(aD);
	end;


procedure ModificarNovelas(var a: archivo);
	var
		aDetalle: archivoD;
		nDetalle: novelaD;
	begin
		assign(aDetalle,'archivoDetalle');
		rewrite(aDetalle);
		{como no había info sobre esto, elijo modificar el precio solamente}
		writeln('----------Modificar precio de novelas----------');
		writeln('Ingrese el cod de novela que desea modificar. Para salir ingrese 0.');	readln(nDetalle.cod);
		while (nDetalle.cod <> 0) do begin
			writeln('Ingrese el precio nuevo: '); readln(nDetalle.precio);
			write(aDetalle,nDetalle);
			writeln('Ingrese el cod de novela que desea modificar. Para salir ingrese 0.');	readln(nDetalle.cod);
		end;
		close(aDetalle);
		{con el detalle cargado, procedo a actualizar el otro}
		ActualizarMaestro(a,aDetalle);
		writeln('Actualización completada');
	end;


procedure ModificarAB(var a:archivo);
	var
		opcion: char;
	begin

		writeln('--------------------');
		writeln('Ingrese 1 para agregar una nueva novela al archivo. Ingrese 2 para modificar los datos de una modela existente.');
		writeln('Si desea salir, ingrese "z"');
		write('Su opción: '); readln(opcion);
		
		while (opcion <> 'z') do begin
			if (opcion = '1') then begin
				AgregarNovela(a);
			end
			else begin
				if (opcion = '2') then begin
					ModificarNovelas(a);
				end
				else
					writeln('Opción inválida, ingrese una opción válida.');
			end;
			
			writeln('Ingrese 1 para agregar una nueva novela al archivo.');
			writeln('Ingrese 2 para modificar los datos de una modela existente.');
			writeln('Si desea salir, ingrese "z"');
			write('Su opción: '); readln(opcion);
			
		end;

		
	end;



Var
	aLB: archivo;
	aTxt: Text;
	nombreALB: cadena20;
	opcion: char;
Begin
	writeln('Ingrese un nombre para el archivo binario:');
	readln(nombreALB);
	assign(aLB, nombreALB);
	assign(aTxt,'novelas.txt');
	
	writeln('Bienvenid. Qué desea hacer?');
	writeln('Ingrese a para crear un archivo binario a partir del archivo de texto.');
	writeln('Ingrese b para actualizar el archivo binario.');
	writeln('Ingrese c para imprimir el contenido del archivo binario.');
	writeln('Ingrese 0 para salir.');
	write('Su opción: '); readln(opcion);
	
	while (opcion <> '0') do begin
	
		writeln();
		case opcion of
			'a': CargarALB(aLB,aTxt);
			'b': ModificarAB(aLB);
			'c': ImprimirArchBin(aLB);
			else writeln('Opción incorrecta, ingrese una opción válida');
		end;
		
		writeln();
		writeln('*****************************************');
		writeln('¡Qué desea hacer ahora?');
		writeln('Ingrese a para crear un archivo binario a partir del archivo de texto.');
		writeln('Ingrese b para actualizar el archivo binario.');
		writeln('Ingrese c para imprimir el contenido del archivo binario.');
		writeln('Ingrese 0 para salir.');
		write('Su opción: '); readln(opcion);
			
		
	end; 
	
	
	
	
End.
