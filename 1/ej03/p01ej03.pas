{
* 3. Realizar un programa que presente un menú con opciones para:
a.
Crear un archivo de registros no ordenados de empleados y completarlo con
datos ingresados desde teclado. De cada empleado se registra: número de
empleado, apellido, nombre, edad y DNI. Algunos empleados se ingresan con
DNI 00. La carga finaliza cuando se ingresa el String ‘fin’ como apellido.
b.
Abrir el archivo anteriormente generado y
i.
Listar en pantalla los datos de empleados que tengan un nombre o apellido
determinado.
ii. Listar en pantalla los empleados de a uno por línea.
iii. Listar en pantalla empleados mayores de 70 años, próximos a jubilarse.
* 
NOTA: El nombre del archivo a crear o utilizar debe ser proporcionado por el usuario una
única vez.
* 
* }


program fod_p01ej03;

Type
	cadena20 = string[20];
	empleado = record
		apellido: cadena20;
		nombre: cadena20;
		nroEmpleado: integer;
		edad: integer;
		dni: integer;
	end;
	
	archivo = file of empleado;
	
	{no es necesario}
	lista = ^nodo;
	nodo = record
		dato: empleado;
		sig: lista;
	end;


procedure CrearArchivo(var arch:archivo);
	var
		e:empleado;
	begin
		rewrite(arch);
		writeln('-----------Escritura de archivo---------');
		writeln('---> Ingrese los datos del empleado, para finalizar ingrese el apellido "fin".');
		writeln('Apellido: ');
		readln(e.apellido);
		while(e.apellido <> 'fin') do begin
			write('Ingrese el nombre: '); readln(e.nombre);
			write('Ingrese el nro. de empleado: '); readln(e.nroEmpleado);
			write('Ingrese su edad: '); readln(e.edad);
			write('Ingrese su dni: '); readln(e.dni);
			
			write(arch,e);

			writeln('---> Ingrese los datos del empleado, para finalizar ingrese el apellido "fin".');
			writeln('Apellido: ');
			readln(e.apellido);			
		end;
		
		close(arch);
		writeln('--------------EscrituraFinalizada-------------');
		
	end;

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
				writeln('Opción incorrecta. Por favor, ingrese una opción válida.');
			end;
			
		end;
		
		writeln('--------------------------------------');
		writeln('¿Qué acción desea realizar a continuación?');
		writeln('Ingrese "a" para crear un nuevo archivo y cargar sus datos.');
		writeln('Ingrese "b" para consultar los registros del archivo.');
		writeln('Para salir ingrese 0.\n');
		write('Opción: ');
		readln(opcion);
		
		
	end;
	
	
	
	writeln('FIN DEL PROGRAMA');
	
End.
