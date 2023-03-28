{Realizar un algoritmo que cree un archivo de números enteros no ordenados y permita
incorporar datos al archivo. Los números son ingresados desde teclado. El nombre del
archivo debe ser proporcionado por el usuario desde teclado. La carga finaliza cuando
se ingrese el número 30000, que no debe incorporarse al archivo.}

program ejer1;
type archivo = file of integer; {definición del tipo de dato para el archivo }
var arc_logico: archivo; {variable que define el nombre lógico del archivo}
nro: integer; {nro será utilizada para obtener la información de teclado}
arc_fisico: string[12]; {utilizada para obtener el nombre físico del archivo desde teclado}

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
close( arc_logico ); { se cierra el archivo abierto oportunamente con la instrucción rewrite }
end.
