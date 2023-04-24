program ejer1;

procedure borrar (var archivo: archivo_empleado);
var
	dato, dato_nuevo : empleado;
begin 
	reset (archivo);
	seek (archivo, filezise (archivo)-1);
	read(archivo, dato_nuevo);
	
	writeln ('Ingrse el numero de empleado que quiere borrar');
	readln (nro);
	seek (archivo, 0);
	leer (archivo, dato)
	while (nro <> dato.nro) and (dato.nro <> valor_alto) begin
		leer (archivo,dato);
	end;
	if (nro = dato.nro) then begin
		seek (archivo,filepos(arch)-1); 
		write (archivo,dato_nuevo);
		seek (archivo, filesize(archivo)-1);
		truncate (archivo);
	end;
	close (archivo);
end;
