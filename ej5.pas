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
	
	
procedure crearArchivo (var txt : text; var celulares: archivo_celular; var carga_celulares: text);
var
	c : celular;
begin
	reset(carga_celulares);
	rewrite (celulares);
	 while (not eof(carga_celulares)) do begin
        With c do begin
			ReadLn(carga_celulares, codigo,precio,marca);
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

var
	txt,carga_celulares: text;
	opcion : integer;
begin
	write('Ingrese el nombre del archivo: ');
	readln(nombre_fisico);
	assign(celulares, nombre_fisico);
	writeln ('Selecione una opcion 1: Crear archivo | 2:Listar celulares que tengan un stock menor al stock mínimo | 3: Buscar celular por descripcion | 4 Crear texto');
	readln (opcion);
	case opcion of
	1: crearArchivo (txt,celulares, carga_celulares);
	2: listarPorStock (celulares);
	3: buscarCelular (celulares);
	4: exportarCelulares (celulares);
	end;
end.
