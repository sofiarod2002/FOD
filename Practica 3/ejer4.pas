program ejer4;
const
	valor_alto = 999;
type
	reg_flor = record
		nombre: String[45];
		codigo: integer;
	end;
	
	archivo_flores = file of reg_flor;
	
	procedure agregarFlor (var archivo: archivo_flores; nombre: string; codigo: integer);
	var
		f,fl: reg_flor;
	begin
		reset (archivo);
		read (archivo,fl);
		f.nombre:= nombre;
		f.codigo:= codigo;
		if (fl.codigo <> 0) then begin
			seek (archivo,codigo*-1);
			read (archivo,fl);
			seek (archivo, filepos (archivo)-1);
			write (archivo,f);
			seek (archivo,0);
			write (archivo,fl);
		end else begin
			seek (archivo, filesize(archivo));
			write (archivo,f);
		end;
		close(archivo); 
	end;

	procedure listarFlores (var archivo: archivo_flores);
	var
		f : reg_flor;
	begin
		reset (archivo);
		while (not eof (archivo)) do begin
			read (archivo, f);
			if (f.codigo > 0) then begin
				writeln (f.nombre);
				writeln (f.codigo);
			end;
		end;
		close(archivo); 
	end;
	
	procedure leer (var archivo: archivo_flores ; var dato:reg_flor);
	begin
		if (not eof(archivo)) then
			read (archivo,dato)
		else
			dato.codigo := valor_alto;
	end;
	
	procedure eliminarFlor (var archivo : archivo_flores; flor: reg_flor);
	var
		f,fl :reg_flor;
	begin
		reset (archivo);
		read(archivo, fl);
		seek (archivo, 0);
		leer (archivo, f);
		while (f.codigo <> valor_alto) or (f.codigo <> flor.codigo) do 
			leer(archivo, f);	
		if (f.codigo = flor.codigo) then begin
			//guardo en el registro a borrar el codigo de la cabecera 
			f.codigo := fl.codigo;
			seek (archivo, filepos(archivo) -1);
			write(archivo, f);
			//guardo en la cabecera la pos del registro borrado
			seek (archivo, 0);
			f.codigo:=f.codigo*-1;
			write (archivo,f);
		end;
		close(archivo);
	end;
	
	var
	archivo : archivo_flores;
	opcion,codigo: integer;
	nombre: string;
	f : reg_flor;
begin
	rewrite (archivo);
	assign (archivo, 'flores');
	f.nombre :='';
	f.codigo:=0;
	write (archivo,f);
	writeln ('0: finalizar | 1: Agregar una flor al archivo| 2: Listar flores | 3: Eliminar una flor');
	readln (opcion);
	while (opcion <> 0) do begin
		case opcion of
		1: begin
			readln (nombre); 
			readln (codigo);
			agregarFlor (archivo,nombre,codigo);
		end;
		2: listarFlores(archivo);
		3: begin
			 readln (f.nombre); 
			 readln (f.codigo); 
			 eliminarFlor (archivo, f);
		 end;
		end;
		writeln ('0: finalizar | 1: Crear archivo con txt | 2: Agregar novela al archivo | 3: Modificar una novela| 4: Eliminar una novela | 5: Crear txt de novelas');
		readln (opcion);
	end;
end.
