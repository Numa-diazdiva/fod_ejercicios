{5. Realizar un programa para una tienda de celulares, que presente un menú con
opciones para:
a.
Crear un archivo de registros no ordenados de celulares y cargarlo con datos
ingresados desde un archivo de texto denominado “celulares.txt”. Los registros
correspondientes a los celulares, deben contener: código de celular, el nombre,
descripcion, marca, precio, stock mínimo y el stock disponible.
b.
Listar en pantalla los datos de aquellos celulares que tengan un stock menor al
stock mínimo.
c.
Listar en pantalla los celulares del archivo cuya descripción contenga una
cadena de caracteres proporcionada por el usuario.
d.
Exportar el archivo creado en el inciso a) a un archivo de texto denominado
“celulares.txt” con todos los celulares del mismo.
NOTA 1: El nombre del archivo binario de celulares debe ser proporcionado por el usuario
una única vez.
NOTA 2: El archivo de carga debe editarse de manera que cada celular se especifique en
tres líneas consecutivas: en la primera se especifica: código de celular, el precio y
marca, en la segunda el stock disponible, stock mínimo y la descripción y en la tercera
nombre en ese orden. Cada celular se carga leyendo tres líneas del archivo
“celulares.txt”.}


{1. se carga desde celulares.txt
*2. procesar listando los del stock tuki
*3. mostrar lo especificado
*4. exportar nuevamente el archivo}

Type
	cadena15 = string[15];
	cadena100 = string[100];
	celular = record
		cod: integer;
		nombre: cadena15;
		descripcion: cadena100;
		marca: cadena15;
		precio: real;
		stockMin: integer;
		stock: integer;
	end;
	
	arch = file of celular;

procedure ImprimirCelular(c:celular);
	begin
		writeln('--------Celular: ', c.nombre);
		writeln('->Código: ', c.cod);
		writeln('->Descripción: ', c.descripcion);
		writeln('->Marca: ', c.marca);
		writeln('->precio: ', c.precio);
		writeln('->stock mínimo: ', c.stockMin);
		writeln('->stock actual: ', c.stock);
	end;

procedure CrearArchBinario(var aLB: arch; var archTxt: Text);
	var
		c: celular;
	begin

		reset(archTxt);
		rewrite(aLB);
		while(not eof(archTxt)) do begin
			{voy leyendo y almacenando en los campos de "c". Tener en cuenta que los espacios separa por defecto, creo.}
					writeln('debug0');
			readln(archTxt, c.nombre, c.cod, c.precio, c.marca); {acrego el nombre porque no figura en la consigna}
			writeln('debug1');
			readln(archTxt, c.stockMin, c.stock);
			writeln('debug2');
			readln(archTxt, c.descripcion);
			writeln('debug3');
			write(aLB,c);
		end;
		close(aLB);
		close(archTxt);
		
		writeln('----------ARCHIVO BINARIO CREADO Y CARGADO -------------');
	end;




procedure ListarBajoStock(var aLB: arch);
	var
		c:celular;
	begin
		reset(aLB);
		while(not eof(aLB)) do begin
			read(aLB,c);
			if (c.stock < c.stockMin) then
				ImprimirCelular(c);
		end;
		close(aLB);
		
	end;
	
procedure ListarConDesc(var aLB: arch);
	var
		c:celular;
	begin
		reset(aLB);
		while(not eof(aLB)) do begin
			read(aLB,c);
			if (c.descripcion <> '') then
				ImprimirCelular(c);
		end;
		close(aLB);
	end;

procedure SobreescribirArchTxt(var archLogBin:arch; var archTexto:Text);
	var
		c:celular;
	begin
		reset(archLogBin);
		rewrite(archTexto);
		while(not eof(archLogBin)) do begin
			read(archLogBin,c);
			writeln(archTexto, c.nombre, ' ', c.cod,' ',c.precio, ' ', c.marca);
			writeln(archTexto, c.stockMin, ' ', c.stock);
			writeln(archTexto, c.descripcion);
		end;
	
	end;

Var
	archLogBin: arch;
	archTexto: Text;
	nombreBin: cadena15;
	opcion: char;
Begin
	writeln('Ingresá el nombre del archivo con el que querés trabajar. Tenés 15 caracteres.');
	readln(nombreBin);
	assign(archLogBin,nombreBin);
	assign(archTexto,'celulares.txt');
	
	writeln;
	writeln('¿Que deseas hacer a continuación?');
	writeln('a. Crear archivo binario y cargarlo con archivo de texto ("celulares.txt").');
	writeln('b. Listar en pantalla aquellos celulares que tienen un stock inferior al mínimo.');
	writeln('c. Listar en pantalla aquellos celulares que poseen descripción.');
	writeln('d. Volver a escribir el archivo "celulares.txt" con el contenido del archivo binario generado.');
	writeln('Para salir, ingrese "0".');
	readln(opcion);
	
	while (opcion <> '0') do begin
		case opcion of 
			'a': CrearArchBinario(archLogBin,archTexto);
			'b': ListarBajoStock(archLogBIn);
			'c': ListarConDesc(archLogBin);
			'd': SobreescribirArchTxt(archLogBin,archTexto);
			else
				writeln('Opción incorrecta, ingrese una opción válida');
		end;
		writeln;
		writeln('¿Que deseas hacer a continuación?');
		writeln('a. Crear archivo binario y cargarlo con archivo de texto ("celulares.txt").');
		writeln('b. Listar en pantalla aquellos celulares que tienen un stock inferior al mínimo.');
		writeln('c. Listar en pantalla aquellos celulares que poseen descripción.');
		writeln('d. Volver a escribir el archivo "celulares.txt" con el contenido del archivo binario generado.');
		writeln('Para salir, ingrese "0".');
		readln(opcion);
	end;
End.
