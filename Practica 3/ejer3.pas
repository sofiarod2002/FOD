program ejer3;
const
	valor_alto = 9999;
type
	str = string[100];
	
	novela = record
		cod : integer;
		genero: str;
		nombre :str;
		duracion : real;
		director: str;
		precio: real;
	end;
	
	novelas = file of novela;
	
	procedure leerNovela (var n : novela);
	begin
		with n do begin
			readln (cod);
			if (cod <> 0) then begin
			readln (genero);
			readln (nombre);
			readln (duracion);
			readln (director);
			readln (precio);
			end;
		end;
	end;
	
	procedure novela0 (var n : novela);
	begin
		with n do begin
			cod:=0;
			genero:='';
			nombre:='';
			duracion:=0;
			director:='';
			precio:=0;
			end;
	end;
	
	procedure crearArchivo (var archivo : novelas);
	var
		n: novela;
	begin
		assign( archivo, 'novelas' );
		rewrite(archivo);
		novela0 (n);
		write (archivo,n );
		leerNovela(n);
		while (n.cod <> 0) do begin
			write (archivo, n);
			leerNovela (n);
		end;
	close (archivo);
	end;
	
	procedure darAlta (var archivo : novelas);
	var
		n,nov : novela;
		pos : integer;
	begin
		leerNovela (n);
		reset (archivo);
		read (archivo, nov);
		pos := nov.cod;
		if (pos <> 0) then begin
			seek (archivo, pos*-1);
			read (archivo, nov); // me guardo la novela borrada en nov
			seek (archivo,filepos(archivo)-1);
			write (archivo,n); // guardo la nueva novela en el archivo
			seek (archivo, 0);
			write (archivo, nov);  // guardo la novela borrada si hay otro espacio libre
		end else begin
			seek (archivo, filesize(archivo));
			write (archivo, n);
		end;
		close (archivo);
	end;
	
	procedure leer (var archivo: novelas ; var dato:novela);
	begin
		if (not eof(archivo)) then
			read (archivo,dato)
		else
			dato.cod:= valor_alto;
	end;
	
	procedure modificarNovela (var archivo: novelas);
	var
		n: novela;
		codigo: integer;
	begin
		writeln ('Ingrese el codigo de la novela que quiere modificar');
		readln (codigo);
		reset (archivo);
		leer (archivo, n);
		while (n.cod <> valor_alto) or (n.cod <> codigo) do //preguntar si usar directamente not eof archivo
			leer(archivo, n);	
		if (n.cod = codigo) then begin
			with n do begin
				readln (genero);
				readln (nombre);
				readln (duracion);
				readln (director);
				readln (precio);
			end;
			seek (archivo, filepos(archivo)-1);
			write (archivo, n);	
		end;
		close (archivo);
	end;
	
	procedure eliminarNovela (var archivo : novelas);
	var
		codigo,pos: integer;
		n :novela;
	begin
		reset (archivo);
		writeln ('Codigo de la novela que quiere borrar');
		readln (codigo);
		leer (archivo, n);
		pos:= n.cod;
		while (n.cod <> valor_alto) or (n.cod <> codigo) do 
			leer(archivo, n);	
		if (n.cod = codigo) then begin
			//guardo en el registro a borrar el codigo de la cabecera 
			n.cod := pos;
			seek (archivo, filepos(archivo) -1);
			write(archivo, n);
			//guardo en la cabecera la pos del registro borrado
			seek (archivo, 0);
			n.cod:= n.cod*-1;
			write (archivo,n);
		end;
		close(archivo);
	end;
	
	procedure crearText (var archivo: novelas; var txt: text);
	var
		n : novela;

	begin
		rewrite(txt);
		assign (txt, 'novelas.txt');
		reset (archivo);
		read(archivo, n); 
		while (not eof(archivo)) do begin
			With n do begin
				writeln(txt, cod,precio,genero);
				writeln (txt, nombre); 
				read(archivo, n); 
				end;
			end;
			Close(archivo); 
			Close(txt); 
	end;
	
var
	archivo : novelas;
	opcion: integer;
	txt: text;
begin
	write('Ingrese el nombre del archivo: ');
	writeln ('0: finalizar | 1: Crear archivo| 2: Agregar novela al archivo | 3: Modificar una novela | 4: Eliminar una novela | 5: Crear txt de novelas');
	readln (opcion);
	while (opcion <> 0) do begin
		case opcion of
		1: crearArchivo (archivo);
		2: darAlta(archivo);
		3: modificarNovela (archivo);
		4: eliminarNovela (archivo);
		5: crearText(archivo, txt);
		end;
		writeln ('0: finalizar | 1: Crear archivo con txt | 2: Agregar novela al archivo | 3: Modificar una novela| 4: Eliminar una novela | 5: Crear txt de novelas');
		readln (opcion);
	end;
end.
