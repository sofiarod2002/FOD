program ejer2;
const
	valor_alto = 9999;
type
	str = string[100];
	
	asistente = record
		nro : integer;
		apellido: str;
		nombre :str;
		dni : str;
		email: str;
		telefono: str;
	end;
	
	asistentes = file of asistente;

procedure leerAsistente (var a: asistente);
begin
	with a do begin
		readln (nro);
		readln (apellido);
		readln (nombre);
		readln (dni);
		readln (email);
		readln (telefono);
	end;
end;

procedure crearArchivo (var archivo: asistentes);
var
a: asistente;
begin
	leerAsistente (a);
	assign( archivo, 'asistentes' );
	rewrite( archivo );
	while (a.dni <> 'zzz') do begin
		write (archivo, a);
		leerAsistente (a);
	end;
	close (archivo);
end;

procedure leer (var archivo: asistentes ; var dato:asistente);
begin
	if (not eof(archivo)) then
		read (archivo,dato)
	else
		dato.nro:= valor_alto;
end;

procedure eliminarAsistentes (var archivo : asistentes);
var
	dato : asistente;
begin
	reset (archivo);
	leer (archivo, dato);
	while (dato.nro <> valor_alto) do begin
		if (dato.nro < 1000) then begin
			dato.nombre := '@' + dato.nombre;
			seek (archivo, filepos (archivo)-1);
			write (archivo, dato);
		leer (archivo, dato);
		end;
	close (archivo);
	end;
end;

var
	archivo: asistentes;
begin
	crearArchivo (archivo);
	eliminarAsistentes(archivo);
end.
