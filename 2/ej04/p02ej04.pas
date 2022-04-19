{4. Suponga que trabaja en una oficina donde está montada una LAN (red local). La misma
fue construida sobre una topología de red que conecta 5 máquinas entre sí y todas las
máquinas se conectan con un servidor central. Semanalmente cada máquina genera un
archivo de logs informando las sesiones abiertas por cada usuario en cada terminal y por
cuánto tiempo estuvo abierta. Cada archivo detalle contiene los siguientes campos:
cod_usuario, fecha, tiempo_sesion. Debe realizar un procedimiento que reciba los archivos
detalle y genere un archivo maestro con los siguientes datos: cod_usuario, fecha,
tiempo_total_de_sesiones_abiertas.
Notas:
- Cada archivo detalle está ordenado por cod_usuario y fecha.
- Un usuario puede iniciar más de una sesión el mismo día en la misma o en diferentes
máquinas.
- El archivo maestro debe crearse en la siguiente ubicación física: /var/log}



program p02ej04;

Uses sysutils;

Const
	MAQUINAS = 5;
	VALORMAX = 32000;
Type
	tFecha = record
		dia: 1..31;
		mes: 1..12;
		anio: 2000..2040;
	end;
	
	sesiones = record
		cod_usuario: integer;
		fecha: tFecha;
		tiempo_total: real;
	end;
	
	sesionLog = record
		cod_usuario: integer;
		fecha: tFecha;
		tiempo_sesion: real;
	end;
	
	archMaestro = file of sesiones;
	archDetalle = file of sesionLog;
	
	detalleLan = array [1..5] of archDetalle;
	posiciones = array [1 .. MAQUINAS] of integer;

	//lectorLan = array [1..MAQUINAS] of sesionLog;
	
procedure InicializarFilePos(var pos:posiciones);
	var
		i:integer;
	begin
		for i:=1 to MAQUINAS do begin
			pos[i]:= 0;
		end;
	end;

procedure AsignarDetalles(var lD:detalleLan);
	var
		i:integer;
	begin
		for i:= 1 to MAQUINAS do begin
			assign(lD[i], 'logMaq' + IntToStr(i));
			reset(lD[i]);
		end;
		
	end;

procedure CerrarLan(lD:detalleLan);
	var
		i:integer;
	begin
		for i:= 1 to MAQUINAS do begin
			close(ld[i]);
		end;
	end;

procedure Min(var lD:detalleLan; var rD:sesionLog; var pos:posiciones);
	var
		aux:sesionLog;
		i,iMin:integer;
	begin
		iMin:= -1;
		rD.cod_usuario:= VALORMAX;
		{me posiciono donde tengo que leer en cada detalle}
		for i:= 1 to MAQUINAS do begin
			seek(lD[i],pos[i]);
			if (not eof(lD[i])) then begin
				read(lD[i], aux);
				if (aux.cod_usuario < rD.cod_usuario) then begin
					rD:= aux;
					iMin:= i;
				end;
			end;
		end;
		{Si me paso en estos índices. El seek queda en EOF o crashea?}
		pos[iMin]:= pos[iMin] + 1;
	end;
	


procedure Merge(var aM:archMaestro; var lD:detalleLan; var pos:posiciones);
	var
		regDet: sesionLog;
		regMas: sesiones;
	begin
		Min(lD,regDet,pos);
		while (regDet.cod_usuario <> VALORMAX) do begin
			regMas.tiempo_total:= 0;
			regMas.cod_usuario:= regDet.cod_usuario;
			regMas.fecha:= regDet.fecha;
			{LecturaMin1}
			while (regDet.cod_usuario = regMas.cod_usuario) do begin
				regMas.tiempo_total:= regMas.tiempo_total + regDet.tiempo_sesion;
				Min(lD,regDet,pos);
			end;
			write(aM, regMas);
		end;
		
	end;

Var
	aM:archMaestro;
	lanD:detalleLan;
	nombreM:string;
	pos:posiciones;
Begin
	InicializarFilePos(pos);
	write('Ingrese el nombre del archivo maestro: '); readln(nombreM);
	{voy a recibir en un procedure todos los archivos detalle y los voy}
	assign(aM,'/var/log'); rewrite(aM);
	AsignarDetalles(lanD);
	Merge(aM,lanD,pos);
	CerrarLan(lanD);
	close(aM);
End.

{La fecha me queda medio colgada, todos los logs son de distintas fechas, qué me guardo en el maestro?}
