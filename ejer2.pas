{Realizar un algoritmo que cree un archivo de números enteros no ordenados y permita
incorporar datos al archivo. Los números son ingresados desde teclado. El nombre del
archivo debe ser proporcionado por el usuario desde teclado. La carga finaliza cuando
se ingrese el número 30000, que no debe incorporarse al archivo.}

program ejer1;
type archivo = file of integer; {definición del tipo de dato para el archivo }
var arc_logico: archivo; {variable que define el nombre lógico del archivo}
arc_fisico: string[12]; {utilizada para obtener el nombre físico del archivo desde teclado}


procedure leer (var arc_logico: archivo );
var
	nro : integer;
begin
	write( 'Ingrese el nombre del archivo:' );
	read( arc_fisico ); { se obtiene el nombre del archivo}
	assign( arc_logico, arc_fisico );
	rewrite( arc_logico ); { se crea el archivo }
	writeln ( 'Ingrese un numero' );
	read( nro ); { se obtiene de teclado el primer valor }
	while nro <> 30000 do begin
		write( arc_logico, nro ); { se escribe en el archivo cada número }
		writeln ( 'Ingrese un numero' );
		read( nro );
	end;
end;


procedure recorrido(var arc_logico: archivo );
var nro, cant, suma: integer; { para leer elemento del archivo}
begin
cant:=0;	suma:=0;
reset( arc_logico ); {archivo ya creado, para operar debe abrirse como de lect/escr}
while not eof( arc_logico) do begin
read( arc_logico, nro ); {se obtiene elemento desde archivo }
if (nro <= 1500) then begin
		cant := cant + 1;
		suma:= suma + nro;
		writeln( nro ); {se presenta cada valor en pantalla}
	end;
end;
write( 'promedio', suma/cant ); 
close( arc_logico ); { se cierra el archivo abierto oportunamente con la instrucción rewrite }
end;

begin
leer (arc_logico);
recorrido (arc_logico);
end.
