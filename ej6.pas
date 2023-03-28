program ej5;
type
	celular = record
		codigo: string[8];
		stock_minimo: integer;
		stock_disponible: integer;
		precio: real;
		nombre: string[10];
		descripcion: string[100];
		marca: string[30];
	end;
	archivo_celular = file of celular;

var
	celulares: archivo_celular;
	nombre_fisico: string[12];
	
	
procedure crearArchivo (var celulares: archivo_celular; var carga_celulares: text);
var
	c : celular;
begin
	reset(carga_celulares);
	rewrite (celulares);
	 while (not eof(carga_celulares)) do begin
        With c do begin
			readln(carga_celulares, codigo,precio,marca);
			readln (carga_celulares,  stock_disponible,stock_minimo, descripcion); 
			readln (carga_celulares, nombre);
       		Write(celulares, c); {escribe binario}
       		end;
        end;
        Close(celulares); 
        Close(carga_celulares) {cierra los dos archivos} 
end;

procedure imprimirCelular (c: celular);
begin
	with c do 
		writeln ('Codigo:', codigo, ' Stock minimo: ',stock_minimo, ' Stock disponiblre: ', stock_disponible, ' descripcion: ', descripcion, ' marca:',marca, ' precio: ',precio);
end;


procedure listarPorStock(var celulares: archivo_celular);
var
	c : celular;
begin
	reset (celulares);
	while not eof(celulares) do begin
		read (celulares, c);
		if (c.stock_disponible < c.stock_minimo) then
			imprimirCelular (c);
	end;
end;

procedure buscarCelular(var celulares: archivo_celular);
var 
	c : celular;
	des: string;
begin
	reset (celulares);
	writeln ('Escriba descripcion por la que busca celulares');
	readln (des);
	while not eof (celulares) do begin
		read (celulares,c);
		if (c.descripcion = des) then 
			imprimirCelular (c)
	end;
	close (celulares);
end;

procedure exportarCelulares (var celulares: archivo_celular);
var
	c: celular;
	txt: text;
begin
	reset (celulares);
	assign (txt, 'Celulares.txt');
	rewrite (txt);
	while not (eof (celulares)) do begin
		read (celulares, c);
		with c do begin
			writeln(txt, 'Codigo: ',codigo,' precio: ',precio,' marca: ',marca);
			writeln (txt, ' stock disponiblre: ', stock_disponible,' stock minimo: ',stock_minimo,' desripcion: ', descripcion); 
			writeln (txt,' nombre: ', nombre);
		end;
	end;
		close (celulares);
		close (txt);
		
end;

//----------------------------------------------6

procedure leerCelular (var c : celular);
begin
	with c do begin
		writeln ('Ingrese codigo');
		readln (codigo);
		writeln ('Ingrse precio');
		readln (precio);
		writeln ('Ingrse marca');
		readln (marca);
		writeln ('Ingrese stock disponible');
		readln (stock_disponible);
		writeln ('Ingrese stock minimo');
		readln (stock_minimo);
		writeln ('Ingrse descripcion');
		readln (descripcion);
		writeln ('Ingrese nombre');
		readln (nombre);
	end;
end;

procedure agregarCelular (var celulares: archivo_celular);
var
c: celular;
begin
	reset (celulares);
	seek (celulares, filesize(celulares));
	leerCelular (c);
	write (celulares,c);
	close (celulares);
end;
		


procedure modificarStock (var celulares: archivo_celular);
var
	c: celular;
	nombre: string;
	stock: integer;
	sigo : boolean;
begin
	writeln ('Ingrese el nombre del celular que quiere modificar');
	readln (nombre);
	writeln ('Ingrese cantidad de stock');
	readln (stock);
	sigo:=false;
	reset (celulares);
	while (not eof(celulares) or not sigo) do begin
		read (celulares,c);
		if (c.nombre = nombre) then begin
			seek( celulares,filepos(celulares)-1);
			c.stock_disponible:= stock;
			write (celulares,c);
			sigo:= true;
		end;
	end;
	close (celulares);
end;

procedure exportarSinStock (var celulares: archivo_celular);
var
	c: celular;
	txt: text;
begin
	reset (celulares);
	assign (txt, 'SinStock.txt');
	rewrite (txt);
	while not (eof (celulares)) do begin
		read (celulares,c);
		if (c.stock_disponible = 0) then begin 
			with c do begin
			writeln(txt, 'Codigo: ',codigo,' precio: ',precio,' marca: ',marca);
			writeln (txt, ' stock disponiblre: ', stock_disponible,' stock minimo: ',stock_minimo,' desripcion: ', descripcion); 
			writeln (txt,' nombre: ', nombre);
			end;
		end;
	end;
		close (celulares);
		close (txt);
end;

var
	carga_celulares: text;
	opcion : integer;
begin
	write('Ingrese el nombre del archivo: ');
	readln(nombre_fisico);
	assign(celulares, nombre_fisico);
	assign(carga_Celulares, 'texto_celulares.txt');
	writeln ('Selecione una opcion 0: Finalizar | 1: Crear archivo | 2:Listar celulares que tengan un stock menor al stock mínimo | 3: Buscar celular por descripcion | 4 Crear texto | 5: Añadir un celular | 6: Modiciar stock | 7: Exportar archivos sin stock');
	readln (opcion);
	while (opcion <> 0) do begin
		case opcion of
		1: crearArchivo (celulares, carga_celulares);
		2: listarPorStock (celulares);
		3: buscarCelular (celulares);
		4: exportarCelulares (celulares);
		5: agregarCelular (celulares);
		6: modificarStock (celulares);
		7: exportarSinStock (celulares);
		end;
		writeln('--------------------------------------------------------------------------------');
		writeln ('Selecione una opcion 0: Finalizar | 1: Crear archivo | 2:Listar celulares que tengan un stock menor al stock mínimo | 3: Buscar celular por descripcion | 4 Crear texto | 5: Añadir un celular | 6: Modiciar stock | 7: Exportar archivos sin stock');
		readln (opcion);
	end;
end.
