{
3. Se cuenta con un archivo de productos de una cadena de venta de alimentos congelados.
De cada producto se almacena: código del producto, nombre, descripción, stock disponible,
stock mínimo y precio del producto.
Se recibe diariamente un archivo detalle de cada una de las 30 sucursales de la cadena. Se
debe realizar el procedimiento que recibe los 30 detalles y actualiza el stock del archivo
maestro. La información que se recibe en los detalles es: código de producto y cantidad
vendida. Además, se deberá informar en un archivo de texto: nombre de producto,
descripción, stock disponible y precio de aquellos productos que tengan stock disponible por
debajo del stock mínimo.
Nota: todos los archivos se encuentran ordenados por código de productos. En cada detalle
puede venir 0 o N registros de un determinado producto.
}

program p02ej03;

Const
	cantSuc = 20;

Type
	cadena20 = string[20];
	cadena100 = string[100];
	producto = record
		cod: integer;
		nombre: cadena20;
		descripcion: cadena100;
		stock: integer;
		stockMin: integer;
		precio: real;
	end;
	
	productoDetalle = record
		cod: integer;
		cant: integer;
	end;
	
	archMaestro = file of producto;
	archDetalle = file of productoDetalle;
	sucursales = array[0..cantSuc] of archDetalle;

procedure ProcesarSucursales(var aM: archMaestro; var aSuc: sucursales);
	var
		i:integer;
		n:cadena20;
	begin
		for i = 1 to cantSuc do begin
			n = 'sucursal' + i;
			assign(aSuc[i],n);
			reset(aSuc[i]);
		
	end;
	
	
	end;

Var	
	maestro: archMaestro;
	suc: sucursales;
	nombreMaestro:cadena20;
	i:integer;
Begin
	write('Ingrese el nombre del archivo maestro con el que desea trabajar: '); readln(nombreMaestro);
	assign(maestro,nombreMaestro);
	

	

End.
