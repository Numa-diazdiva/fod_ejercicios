{
*  Se dispone de un archivo con información de los alumnos de la Facultad de Informática. Por
cada alumno se dispone de su código de alumno, apellido, nombre, cantidad de materias
(cursadas) aprobadas sin final y cantidad de materias con final aprobado. Además, se tiene
un archivo detalle con el código de alumno e información correspondiente a una materia
(esta información indica si aprobó la cursada o aprobó el final).
Todos los archivos están ordenados por código de alumno y en el archivo detalle puede
haber 0, 1 ó más registros por cada alumno del archivo maestro. Se pide realizar un
programa con opciones para:a. Actualizar el archivo maestro de la siguiente manera:
i.Si aprobó el final se incrementa en uno la cantidad de materias con final aprobado.
ii.Si aprobó la cursada se incrementa en uno la cantidad de materias aprobadas sin
final.
b. Listar en un archivo de texto los alumnos que tengan más de cuatro materias
con cursada aprobada pero no aprobaron el final. Deben listarse todos los campos.
NOTA: Para la actualización del inciso a) los archivos deben ser recorridos sólo una vez
* }

program p02ej02;

Type
	cadena20 = string[20];
	alumno = record
		cod:integer;
		apellido: cadena20;
		nombre: cadena20;
		matC: integer;
		matA: integer;
	end;
	{el ej no dice que puede llegar un registro que diga que no aprobo nada, no tendría mucho sentido en esta aplicación}
	alumnoD = record
		cod:integer;
		aproboFinal: boolean;
	end;
	
	archAlumn = file of alumno;
	archDet = file of alumnoD;
	
procedure LeerD(var aD: archDet; var rD: alumnoD);
	begin
		if (not eof(aD)) then
			read(aD,rD)
		else
			rD.cod:= -1;
	end;
	
procedure Merge(var aM: archAlumn; var aD: archDet);
	var
		rM:alumno;
		rD:alumnoD;
		codAct:integer;
	begin
		reset(aM); reset(aD);
		LeerD(aD,rD);
		while (rD.cod <> -1) do begin
			read(aM,rM);
			codAct:= rD.cod;
			{si es precondición que el arch maestro sí o sí contiene a los alumns del detalle, el primer chequeo no es necesario}
			while ((not eof(aM)) and (rM.cod <> rD.cod)) do begin
				read(aM, rM);
			end;
			{salgo porque encontré el código de alumn. Proceso los registros de materias con ese código}
			while (codAct = rD.cod) do begin
				if rd.aproboFinal then
					rM.matA:= rM.matA + 1
				else
					rM.matC:= rM.matC + 1;
				read(aD,rD);
			end;
			{actualizo el maestro}
			seek(aM,filepos(aM) -1);
			write(aM,rM);

		end;
		
		close(aM); close(aD)
	end;
	
	
procedure ImprimirAlumno(a:alumno);
	begin
		writeln('-----------');
		writeln('Nombre: ',a.nombre);
		writeln('Apellido: ',a.apellido);
		writeln('Código: ',a.cod);
		writeln('Cant. materias cursadas: ', a.matC);
		writeln('Cant. materias aprobadas: ', a.matA);
	end;
	
procedure Listar(var aM:archAlumn);
	var
		a:alumno;
	begin
		reset(aM);
		while (not eof(aM)) do begin
			read(aM,a);
			if (a.matC > 4) then
				ImprimirAlumno(a);
			
		end;
	end;
	
Var
	archMaestro: archAlumn;
	archDetalle: archDet;
	nombreM, nombreD: cadena20;
Begin
	write('Ingrese el nombre del archivo de alumns: '); readln(nombreM);
	write('Ingrese el nombre del archivo de materias: '); readln(nombreD);
	assign(archMaestro,nombreM); assign(archDetalle,nombreD);
	Merge(archMaestro,archDetalle);
	Listar(archMaestro);
End.
