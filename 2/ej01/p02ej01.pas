{Precondiciones  para el corte de control en ¿merge? de datos}
{Archivo inicial ordenado según el critero con el cual se quiere agrupar los datos
}

{1. Una empresa posee un archivo con información de los ingresos percibidos por diferentes
empleados en concepto de comisión, de cada uno de ellos se conoce: código de empleado,
nombre y monto de la comisión. La información del archivo se encuentra ordenada por
código de empleado y cada empleado puede aparecer más de una vez en el archivo de
comisiones.
Realice un procedimiento que reciba el archivo anteriormente descripto y lo compacte. En
consecuencia, deberá generar un nuevo archivo en el cual, cada empleado aparezca una
única vez con el valor total de sus comisiones.
NOTA: No se conoce a priori la cantidad de empleados. Además, el archivo debe ser
recorrido una única vez.}



program p02je01;

Const
	CODIGO_CORTE = -1;

Type
	cadena20 = string[20];
	comisionEmpleado  = record
		cod: integer;
		nombre: cadena20;
		monto: real;
	end;
	{Ordenado por cod de empleado}
	arch = file of comisionEmpleado;
	

procedure Leer(var aO:arch; var rL: comisionEmpleado);
	begin
		if (not eof(aO)) then
			read(aO,rL)
		else
			rL.cod:= CODIGO_CORTE;
	end;



procedure Compactar(var aO:arch; var aC:arch);
	var
		regLeer,regComp: comisionEmpleado;
	begin
		reset(aO); rewrite(aC);
		{usamos este procedure para poder leer antes y aún así entrar al while si terminamos el archivo}
		Leer(aO,regLeer);
		{mientras no terminé el archivo voy leyendo y hago la corte de control}
		while (regLeer.cod <> -1) do begin
			regComp.cod:= regLeer.cod;
			regComp.nombre:= regLeer.nombre;
			regComp.monto:= 0;
			{la segunda condición del corte de control es innecesaria en este caso}
			while ((regLeer.cod = regComp.cod) and (regLeer.cod <> -1)) do begin
				regComp.monto:= regComp.monto + regLeer.monto;	
				Leer(aO,regLeer);
			end;
			{actualizo el archivo Compactado con la suma}
			write(aC,regComp);
		end;
	end;


Var
	archOriginal, archCompactado : arch;
	nombreOrig: cadena20;
Begin
	write('Ingrese el nombre del archivo que quiere compactar: '); readln(nombreOrig);
	assign(archOriginal,nombreOrig);
	assign(archCompactado,'compactado');
	Compactar(archOriginal,archCompactado);
	close(archOriginal); close(archCompactado);
End.
