program ej7;
type
	novela = record
		codigo : string[8];
		nombre: string[20];
		genero: string[20];
		precio : real;
	end;
	
	archivo_novela = file of novela;
	
var
	novelas: archivo_novela;
	nombre_fisico: string[20];
	
procedure crearArchivo (var novelas: archivo_novela; var txt_novelas: text);
var
	n : novela;
begin
	reset(txt_novelas);
	rewrite (novelas);
	 while (not eof(txt_novelas)) do begin
        With n do begin
			readln(txt_novelas, codigo,precio,genero);
			readln (txt_novelas, nombre); 
       		Write(novelas, n); 
       		end;
        end;
        Close(novelas); 
        Close(txt_novelas); 
end;

procedure leerNovela (var n : novela);
begin
	with n do begin
		writeln ('Ingrese codigo');
		readln (codigo);
		writeln ('Ingrse precio');
		readln (precio);
		writeln ('Ingrese genero');
		readln (genero);
		writeln ('nombre');
		readln (nombre);
	end;

end;

procedure agregarNovela (var novelas: archivo_novela);
var
	n : novela;
begin
	reset (novelas);
	seek (novelas, filesize(novelas));
	leerNovela (n);
	write (novelas,n);
	close (novelas);
end;

procedure modificarNovela (var novelas : archivo_novela);
var
	n,nov: novela;
	sigo : boolean;
begin
	sigo:=false;
	writeln ('Ingrese los datos de la novela que quiere modificar');
	leerNovela(n);
	reset(novelas);
	while (not eof(novelas) or not sigo) do begin
		read (novelas, nov);
		if (nov.codigo = n.codigo) then begin
			seek( novelas,filepos(novelas)-1);
			write (novelas,n);
			sigo := true;
		end;
	end;
	close (novelas);
end;

var
	txt_novelas: text;
	opcion: integer;
begin
	write('Ingrese el nombre del archivo: ');
	readln(nombre_fisico);
	assign(novelas, nombre_fisico);
	assign(txt_novelas, 'novelas.txt');
	writeln ('0: finalizar | 1: Crear archivo con txt | 2: Agregar novela al archivo | 3: Modificar una novela');
	readln (opcion);
	while (opcion <> 0) do begin
		case opcion of
		1: crearArchivo (novelas,txt_novelas);
		2: agregarNovela(novelas);
		3: modificarNovela (novelas);
		end;
		writeln ('0: finalizar | 1: Crear archivo con txt | 2: Agregar novela al archivo | 3: Modificar una novela');
		readln (opcion);
	end;
end.
