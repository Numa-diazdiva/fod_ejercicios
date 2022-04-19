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

Uses sysutils;

Const
	CANTSUC = 30;
	MAX = 32000;

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
	sucursales = array[1..CANTSUC] of archDetalle;
	
	posiciones = array [0..CANTSUC] of integer;
	
procedure AsignarAbrirDetalles(var suc:sucursales; var pos:posiciones);	
	var
		i:integer;
	begin
		for i:= 1 to CANTSUC do begin
			assign(suc[i], 'sucursal' + IntToStr(i));
			reset(suc[i]);
			pos[i]:= 0;
		end;
	end;

procedure Min(var suc:sucursales; var rD:productoDetalle; var pos:posiciones);
	var
		i, iMin:integer;
		aux:productoDetalle;
	begin
		rD.cod:= MAX;
		for i:= 1 to CANTSUC do begin
			seek(suc[i], pos[i]);
			if (not eof(suc[i])) then begin
				read(suc[i],aux);
				if (aux.cod < rD.cod) then begin
					rD:= aux;
					iMin:= i;
				end;
			end;
		end;
		pos[iMin]:= pos[iMin] + 1;
	end;
	
procedure ActualizarMaestro(var aM: archMaestro; rD:productoDetalle);
	var
		p:producto;
	begin
		{elijo sumar todo y luego actualizar par simplificar la modularización}
		read(aM,p);
		while(p.cod <> rD.cod) do begin
			read(aM,p);
		end;
		{salgo porque encontré el producto}
		p.stock:= p.stock - rD.cant;
		seek(aM, filepos(aM) - 1);
		write(aM,p);
	end;

procedure ProcesarSucursales(var aM: archMaestro; var suc: sucursales; var pos:posiciones);
	var
		rD,rDSuma:productoDetalle;
	begin
		reset(aM);
		Min(suc,rD,pos);
		while (rD.cod <> MAX) do begin
			rDSuma.cod:= rD.cod;
			rDSuma.cant:= 0;
			while (rDSuma.cod = rD.cod) do begin
				rDSuma.cant:= rDSuma.cant + rD.cant;
				Min(suc,rD,pos);
			end;
			ActualizarMaestro(aM,rDSuma);
		end;
		
		close(aM);
	end;
	
procedure AgregarProducto(p:producto; var bS: Text);
	begin
		writeln(bS, p.nombre, ', ', p.descripcion, ', ',p.stock, ', ', p.precio);
	end;

procedure ListarBajoStock(var aM:archMaestro; var bS:Text);
	var
		p:producto;
	begin
		reset(aM); rewrite(bS);
		while(not eof(aM)) do begin
			read(aM,p);
			if (p.stock < p.stockMin) then begin
				AgregarProducto(p,bS);
			end;
		end;
		close(aM);
		close(bS);
	end;

Var	
	maestro: archMaestro;
	suc: sucursales;
	pos: posiciones;
	nombreMaestro:cadena20;
	bajosStock:Text;
Begin
	write('Ingrese el nombre del archivo maestro con el que desea trabajar: '); readln(nombreMaestro);
	assign(maestro,nombreMaestro);
	AsignarAbrirDetalles(suc,pos);
	ProcesarSucursales(maestro,suc,pos);
	assign(bajosStock,'bajosStock.txt');
	ListarBajoStock(maestro,bajosStock);
End.
