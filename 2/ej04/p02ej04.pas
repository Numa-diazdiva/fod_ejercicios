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

procedure AsignarDetalles(var aD:archDetalle);
	var
		i:integer;
	begin
		for i:= 1 to 5 do begin
			assign(aM[i], 'logMaq' + IntoStr(i));
			reset(aM[i]);
		end;
		
	end;

procedure Merge(var aM:archMaestro; var lD:detalleLan);
	var
	
	begin
		{Recordar merge múltiple, vamos buscando el min}
		
	end;

Var
	aM:archMaestro;
	lanD:detalleLan;
	nombreM, nombreD;
Begin
	write('Ingrese el nombre del archivo maestro: '); readln(nombreM);
	{voy a recibir en un procedure todos los archivos detalle y los voy}
	assign(aM,'/var/log'); reset(aM);
	AsignarDetalles(aD);
	Merge(aM,aD);
End.
