program ejer2;
const valoralto= '9999';
type 
	alumno = record
		cod : String[10];
		apellido: String[20];
		nombre: String[20];
		cant_materias: integer;
		cant_finales: integer;
	end;
	
	materias = record
		cod: String[10];
		fin: boolean;
		cursada: boolean;
	end;
	
	detalle = file of materias;
	maestro = file of alumno;
	
var
regm: alumno;
regd: materias;
mae1: maestro;
det1: detalle;
aux: String [10];

procedure leer (var archivo:detalle; var dato:materias);
begin
	if (not eof(archivo)) then
		read (archivo,dato)
	else
		dato.cod:= valoralto;
end;

procedure actualizarMaterias(var mae1: maestro; var det1: detalle);
var
	total_fin,total_materias: integer;
begin
	reset (mae1);
	reset (det1);
	read(mae1,regm);
	leer(det1,regd);

	{se procesan todos los registros del archivo detalle}
	while (regd.cod <> valoralto) do begin
		aux := regd.cod;
		total_fin := 0;
		total_materias := 0;
		{se totaliza la cantidad de finales y cursadas}
		while (aux = regd.cod ) do begin
			if (regd.fin) then
				total_fin:= total_fin+1;
			if (regd.cursada) then
				total_materias:= total_materias+1;
			leer(det1,regd);
		end;
		
		{verifico que hay que modificar algun archivo}
		if ((total_fin > 0) or (total_materias > 0)) then begin
			{se busca en el maestro el producto del detalle}
			while (regm.cod <> aux) do
				read (mae1,regm);
			{se modifican las notas}
			regm.cant_materias := regm.cant_materias + total_materias;
			regm.cant_finales := regm.cant_finales + total_fin;
			
			{se reubica el puntero en el maestro}
			seek (mae1, filepos(mae1)-1);
			{se actualiza el maestro}
			write(mae1,regm);
		end;
		{se avanza en el maestro}
		if (not eof (mae1)) then
			read(mae1,regm);
		end;
	close (det1);
	close (mae1);
end;

procedure exportarAlumnos (var alumnos: maestro);
var
	a: alumno;
	txt: text;
begin
	reset (alumnos);
	assign (txt, 'alumnos.txt');
	rewrite (txt);
	while not (eof (alumnos)) do begin
		read (alumnos,a);
		if (a.cant_materias - a.cant_finales >= 4) then begin 
			with a do begin
			writeln(txt, 'Nombre: ',nombre,' apellido: ',apellido,' codigo de alumno: ',cod);
			writeln (txt, ' cantidad de materias aprobadas sin final: ', cant_materias,' cantidad de finales: ',cant_finales);
			end;
		end;
	end;
		close (alumnos);
		close (txt);
end;
{programa principal}
begin
assign (mae1, 'maestro');
assign (det1, 'detalle');
actualizarMaterias (mae1,det1);
exportarAlumnos (mae1);
end.
