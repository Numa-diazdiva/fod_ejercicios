program fod_p02ej01;

{
* Una empresa posee un archivo con información de los ingresos percibidos por diferentes
empleados en concepto de comisión, de cada uno de ellos se conoce: código de empleado,
nombre y monto de la comisión. La información del archivo se encuentra ordenada por
código de empleado y cada empleado puede aparecer más de una vez en el archivo de
comisiones.
Realice un procedimiento que reciba el archivo anteriormente descripto y lo compacte. En
consecuencia, deberá generar un nuevo archivo en el cual, cada empleado aparezca una
única vez con el valor total de sus comisiones.
NOTA: No se conoce a priori la cantidad de empleados. Además, el archivo debe ser
recorrido una única vez.
* 
* }


Type
	cadena30 = string[30];
	regComision = record
		codE: integer;
		nombre: cadena30;
		monto: real;
	end;
	
	archivo = file of regComision;

procedure Merge(var arch:archivo; var archMerge:archivo);
	var
	
	begin
	
	
	end;


Var
	archNombre: cadena30;
	arch,archMerge: archivo;
	
	
Begin
	{La idea sería recorrerlo mientras not end of fail}
	{Hay que hacer un merge}
	write('Ingrese el nombre del archivo que desea abrir: '); readln(archNombre);
	assign(arch,archNombre);
	Merge(arch,archMerge);

End.
