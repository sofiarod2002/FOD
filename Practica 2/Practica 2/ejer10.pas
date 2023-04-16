program ejer10;
const 
	valor_alto ='9999';
	dimF = 15;
type
	empleado = record
		departamento : string;
		division : string;
		nro : string;
		cat : integer;
		cant : integer;
	end;
	
	empleados = file of empleado;
	vector = array [1 .. dimF] of integer;


procedure generarVector (var txt : text; var v : vector);
var
	cat,precio: integer;
begin
	 while (not eof(txt)) do begin
		readln(txt, cat,precio);
		vector[cat]:= precio;
       	end;
end;

procedure leer (var archivo: empleados ; var dato:empleado);
begin
	if (not eof(archivo)) then
		read (archivo,dato)
	else
		dato.departamento:= valor_alto;
end;


var
	archivo: empleados;
	dato : empleado;
	totaldep,mondep,hordep,tothoras,totmon, importe: integer;
	dep,division : string;
	txt : text;
	vHoras: vector;
begin
	assign (txt, 'horas_extras.txt');
	generarVector (txt,vHoras);
	
	assign (archivo, 'empleados');
	reset (archivo);
	leer (archivo,dato);
	
	while (dato.departamento <> valor_alto) do begin
		writeln('Dato departamento: ', dato.departamento);
		dep := dato.departamento;
		mondep := 0;	hordep:=0;
		while  (dato.departamento <> valor_alto) and (dep = dato.departamento)do begin
			writeln ('Division');
			division := dato.division;
			tothoras:=0; totmon :=0;
			while (dato.departamento <> valor_alto) and (dep = dato.departamento) and (division = dato.division)do begin
				importe := vHoras[dato.cat] * dato.cant;
				writeln ('Numero de empleado: ', dato.nro);
				writeln ('Total de horas: ', dato.cant);
				writeln ('Importe a cobrar: ', importe);
				tothoras:= tothoras + dato.cant;
				totmon := totmon + importe;
				leer (archivo, dato);
			end;
			
			write('Division: ', division);
			mondep:= mondep + totmon;
			hordep:= hordep + tothoras;
			writeln ('Total horas por division: ', tothoras);
			writeln ('Total importe por divison',totmon)
		end;
		writeln('Total horas por departamento: ',hordep);
		writeln('M}Importe total departamento: ',mondep);
		
	end;
	close (archivo);
	end.
