{
* 4. Agregar al menú del programa del ejercicio 3, opciones para:
a.
Añadir una o más empleados al final del archivo con sus datos ingresados por
teclado.
b. Modificar edad a una o más empleados.
c. Exportar
el
contenido
del
archivo
a
un
archivo
de
texto
llamado
“todos_empleados.txt”.
d.
Exportar a un archivo de texto llamado: “faltaDNIEmpleado.txt”, los empleados
que no tengan cargado el DNI (DNI en 00).
NOTA: Las búsquedas deben realizarse por número de empleado.
* }



program fod_p01ej04;


Type
	cadena20 = string[20];
	empleado = record
		apellido: cadena20;
		nombre: cadena20;
		nroEmpleado: integer;
		edad: integer;
		dni: integer;
	end;
	
	empleadoDetalle = record
		nroEmpleado: integer;
		edad: integer;
	end;
	
	archivo = file of empleado;
	archDetalle = file of empleadoDetalle;

procedure LeerEmpleado(var e:empleado);
	begin
		writeln('---> Ingrese los datos del empleado, para finalizar ingrese el apellido "fin".');
		writeln('Apellido: ');
		readln(e.apellido);
		if (e.apellido <> 'fin') then begin
			write('Ingrese el nombre: '); readln(e.nombre);
			write('Ingrese el nro. de empleado: '); readln(e.nroEmpleado);
			write('Ingrese su edad: '); readln(e.edad);
			write('Ingrese su dni: '); readln(e.dni);
		end;
	end;


procedure CrearArchivo(var arch:archivo);
	var
		e:empleado;
	begin
		rewrite(arch);
		writeln('-----------Escritura de archivo---------');
		LeerEmpleado(e);
		while(e.apellido <> 'fin') do begin
			write(arch,e);
			LeerEmpleado(e);	
		end;
		
		close(arch);
		writeln('--------------EscrituraFinalizada-------------');
		
	end;

{------------------------------- impresión ---------------------------------}

procedure Imprimir(e: empleado);
	begin
		writeln('---------------Empleado nro: ', e.nroEmpleado);
		writeln('Nombre: ',e.nombre);
		writeln('Apellido: ', e.apellido);
		writeln('Edad: ', e.edad);
		writeln('DNI: ', e.dni);
	end;

{	ver cómo evitar repetir tanto código	}
procedure ImprimirNombreAp(var arch:archivo);
	var
		e: empleado;
		o: string[1];
		datoBuscar: cadena20;
	begin
		reset(arch);
		
		writeln('-----------------Impresión por nombre o apellido-----------------');
		writeln('Ingrese "n" o "a" según qué desee buscar, o cualquier otra cosa para salir: ');
		readln(o);
		
		if (o = 'a') then begin
			write('Ingrese el apellido a buscar: '); readln(datoBuscar);
			
			while (not eof(arch)) do begin
				read(arch, e);
				if (e.apellido  = datoBuscar) then begin
					Imprimir(e);
				end;
			end;
		end
		else begin
			if (o = 'n') then begin
				write('Ingrese el nombre a buscar: '); readln(datoBuscar);
				
				while (not eof(arch)) do begin
					read(arch, e);
					if (e.nombre  = datoBuscar) then begin
						Imprimir(e);
					end;
				end;
			end
			else begin
				writeln('Saliendo...');
			end;
		end;
		
		close(arch);
	end;
					
procedure ImprimirTodo(var arch:archivo);
	var
		e:empleado;
	begin
		reset(arch);
		writeln('----------------- Empleados -----------------');
		while (not eof(arch)) do begin
			read(arch,e);
			Imprimir(e);
		end;
		close(arch);
	end;

procedure ImprimirMayores(var arch:archivo);
	var
		e:empleado;
	begin
		reset(arch);
		writeln('------------------ Empleados mayores de 70 anios -----------------');
		while (not eof(arch)) do begin
			read(arch,e);
			if(e.edad > 70) then
				Imprimir(e);
		end;
		close(arch);
	end;


{---------------------------------------- PUNTO 4 -------------------------------}

procedure AgregarAlFinal(var aL:archivo);
	var
		e:empleado;
	begin
		{Abrimos el archivo y nos paramos sobre el final}
		reset(aL);
		seek(aL, filesize(aL));
		writeln('------------AGREGAR AL FINAL-----------');
		LeerEmpleado(e);
		while (e.apellido <> 'fin') do begin
			write(aL,e);
			LeerEmpleado(e);
		end;
		close(aL);
	end;
	


procedure CargarDetalles(var aD:archDetalle);
	var
		eD:empleadoDetalle;
	begin
		assign(aD, 'detalle');
		rewrite(aD);
		writeln('-----------------ACTUALIZACIóN DE EDAD ----------------');
		writeln('Ingrese el número de empleado cuya edad quiere actualizar. Para salir ingrese 0: ');
		readln(eD.nroEmpleado);
		while (eD.nroEmpleado <> 0) do begin
			write('Ingrese su edad: ');
			readln(eD.edad);
			write(aD,eD);
			
			write('Ingrese el número de empleado cuya edad quiere actualizar. Para salir ingrese 0: ');
			readln(eD.nroEmpleado);
		end;
		
		close(aD);	
	end;
	
	
	
procedure ActualizarMaestroDetalle(var aM:archivo);
	var
		aD:archDetalle;
		empM:empleado; empD:empleadoDetalle;
	begin
		CargarDetalles(aD);
		writeln('1');
		reset(aM); reset(aD);
		writeln('1.1');
		while(not eof(aD)) do begin
			read(aM,empM);
			read(aD,empD);
			writeln('2');
			while(empM.nroEmpleado <> empD.nroEmpleado) do begin
				read(aM,empM);
			end;
			empM.edad:= empD.edad;
			seek(aM, filepos(aM) - 1);
			write(aM, empM);
			{Confío en la condición de que estén ordenados bajo el mismo criterio. SIno podría volver acá al principio del maestro o implementar una búsqueda más eficiente}	
		end;
	end;



Var

	archivoNombre: cadena20;
	archivoLogico: archivo;
	opcion: string[1];
	
Begin
	write('Ingrese el nombre del archivo con el que desea trabajar: ');
	readln(archivoNombre);
	assign(archivoLogico,archivoNombre);
	
	writeln('¿Qué acción desea realizar a continuación?');
	writeln('Ingrese "a" para crear un nuevo archivo y cargar sus datos.');
	writeln('Ingrese "b" para consultar los registros del archivo.');
	writeln('Ingrese "c" para agregar uno o más empleados al final del archivo.');
	writeln('Ingrese "d" para actualizar la edad de uno o más empleados.');
	writeln('Para salir ingrese 0.');
	write('Opción: ');
	readln(opcion);
	
	while (opcion <> '0') do begin
		if (opcion = 'a') then begin
			CrearArchivo(archivoLogico);
		end
		else begin
			if (opcion = 'b')then begin
				writeln('--------Consulta de registros de archivo --------');
				writeln('Ingrese "1" para Listar en pantalla los datos de empleados que tengan un nombre o apellido determinado.');
				writeln('Ingrese "2" para listar los datos de los empleados por línea.');
				writeln('Ingrese "3" para listar en pantalla los empleados mayores de 70 años próximos a jubilarse.');
				writeln('Ingrese cualquier otro caracter para salir.');
				write('Opción: ');
				readln(opcion);
				case opcion of
					'1': ImprimirNombreAp(archivoLogico);
					'2': ImprimirTodo(archivoLogico);
					'3': ImprimirMayores(archivoLogico);
					else writeln('Saliendo.');
				end;
			end
			else begin
				if (opcion = 'c') then begin
					AgregarAlFinal(archivoLogico);
				end
				else
					if (opcion = 'd') then begin
						ActualizarMaestroDetalle(archivoLogico);
					end
					else
					writeln('Opción incorrecta. Por favor, ingrese una opción válida.');
			end;
			
		end;
		
		writeln('--------------------------------------');
		writeln('¿Qué acción desea realizar a continuación?');
		writeln('Ingrese "a" para crear un nuevo archivo y cargar sus datos.');
		writeln('Ingrese "b" para consultar los registros del archivo.');
		writeln('Ingrese "c" para agregar uno o más empleados al final del archivo.');
		writeln('Ingrese "d" para actualizar la edad de uno o más empleados.');
		writeln('Para salir ingrese 0.\n');
		write('Opción: ');
		readln(opcion);
		
		
	end;
	
	
	
	writeln('FIN DEL PROGRAMA');
	
End.
