program ejer8;

type
	distribucion = record
		nombre: string;
		año: string;
		nro: integer;
		desarolladores: integer;
		descripcion: string;
	end;
	
	distribuciones = file of distribucion;
	
	function existeDistribucion (var archivo: distribuciones; dis : string): boolean
	var
		esta: boolean;
		d: distribucion;
	begin
		esta:=false;
		while (not eof (archivo)) do begin
			read (archivo,d);
			if (d.distribucion = dis) then
				esta := true;
		end;
		return esta;
	end;
	
	procedure altaDistribucion (var archivo: distribuciones);
	var 
		d,dis : distribucion;
	begin
		leerDistribucion (d);
		if !(existeDistribucion(archivo,d.nombre)) then begin
			reset (archivo);
			read (archivo, dis);
			pos := d.cod;
			if (pos <> 0) then begin
				seek (archivo, pos*-1);
				read (archivo, dis); // me guardo la novela borrada en nov
				seek (archivo,filepos(archivo)-1);
				write (archivo,d); // guardo la nueva novela en el archivo
				seek (archivo, 0);
				write (archivo, dis);  // guardo la novela borrada si hay otro espacio libre
			end else begin
				seek (archivo, filesize(archivo));
				write (archivo, d);
			end;
			close (archivo);
		end else 
			writeln ('Ya existe la distribucion');
		end;
	end;
	
	procedure bajaDistribucion (var archivo: distribuciones);
	var
		pos : integer;
		d: distribucion;
	begin
		reset (archivo);
		read (archivo, d);
		pos := d.cod;
		readln (nombre);
		if (existeDistribucion(archivo,nombre)) then begin
			while (d.nombre <> nombre) do 
				read(archivo, d);	
			d.codigo := pos;
			seek (archivo, filepos(archivo) -1);
			write(archivo, d);
			//guardo en la cabecera la pos del registro borrado
			seek (archivo, 0);
			d.codigo:=d.codigo*-1;
			write (archivo,d);
			close(archivo);
		end else
			writeln ('Distribucion no existente');
	end;
