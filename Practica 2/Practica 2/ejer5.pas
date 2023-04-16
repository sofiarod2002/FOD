program ejer5;
Uses sysutils;

const 
	valor_alto=9999;
	dimF = 50;
type 
	nacimiento = record
		nro: integer;
		nacimiento: string[10];
		nombre: string[30];
		apellido: string[30];
		direccion: string;
		matricula_medico: string;
		nombreyapellido_madre: string[60];
		nombreyapellido_padre: string[60];
		dni_madre: string;
		dni_padre: string;
	end;
	
	fallecimiento = record
		nro: integer;
		nombre: string[30];
		apellido: string[30];
		direccion: string;
		matricula_medicoN: string;
		fecha: string;
		hora: string;
		nombreyapellido_madre: string[60];
		nombreyapellido_padre: string[60];
		dni_madre: string;
		dni_padre: string;
		fallecio: boolean;
		matricula_medicoD: string;
	end;
	
	datos = record
		nac : nacimiento;
		matricula: string;
		fecha: string;
		hora: string;
		lugar: string;
	end;
	

	
	detalle_nacimiento = file of nacimiento;
	detalle_fallecimiento = file of fallecimiento;
	maestro = file of datos;
	vectorDetallesNacimiento = array[1 .. dimF] of detalle_nacimiento;
	vectorDetallesFallecimiento = array[1 .. dimF] of detalle_fallecimiento;
	vectorDatosN = array[1 .. dimF] of nacimiento;
	vectorDatosF = array[1 .. dimF] of fallecimiento;

	

procedure asignarDetallesNacimiento (var det : vectorDetallesNacimiento);
var
	i : integer;
begin
	for i:=1 to dimF do 
		assign(det[i], 'detalle nacimiento' + IntToStr(i));
end;

procedure resetTodosNacimiento(var v: vectorDetallesNacimiento);
var
	i: integer;
begin
		for i:= 1 to dimF do
			reset(v[i]);
end;
	
procedure closeTodosNacimiento(var v: vectorDetallesNacimiento);
var
	i: integer;
begin
		for i:= 1 to dimF do
			close(v[i]);
end;
	
procedure leerNacimiento (var archivo:detalle_nacimiento; var dato:nacimiento);
begin
	if (not eof(archivo)) then
		read (archivo,dato)
	else
		dato.nro:= valor_alto;
end;
//-------------------------------------------------------------------------------------------
procedure asignarDetallesFallecimiento (var det : vectorDetallesFallecimiento);
var
	i : integer;
begin
	for i:=1 to dimF do 
		assign(det[i], 'detalle fallecimiento' + IntToStr(i));
end;

procedure resetTodosFallecimiento(var v: vectorDetallesFallecimiento);
var
	i: integer;
begin
		for i:= 1 to dimF do
			reset(v[i]);
end;
	
procedure closeTodosFallecimiento(var v: vectorDetallesFallecimiento);
var
	i: integer;
begin
		for i:= 1 to dimF do
			close(v[i]);
end;
	
procedure leerFallecimiento (var archivo:detalle_fallecimiento; var dato:fallecimiento);
begin
	if (not eof(archivo)) then
		read (archivo,dato)
	else
		dato.nro:= valor_alto;
end;
//--------------------------------------------------------------------------------------
procedure minimoNacimiento (var vDet : vectorDetallesNacimiento;var  vDat: vectorDatosN;var regd : nacimiento);
var
	i, pos : integer;
begin
		regd.nro:= valor_alto;
		for i:= 1 to dimF do begin
			if (vDet[i].nro < regd.nro) then begin
				regd:= vDat[i];
				pos:= i;
			end;
		end;
		if(regd.nro <> valor_alto) then 
			leerNacimiento(vDet[pos], vDat[pos]);
end;

procedure minimoFallecimiento (var vDet : vectorDetallesFallecimiento; var vDat: vectorDatosF;var regd : fallecimiento);
var
	i, pos : integer;
begin
		regd.nro:= valor_alto;
		for i:= 1 to dimF do begin
			if (vDet[i].nro < regd.nro) then begin
				regd:= vDat[i];
				pos:= i;
			end;
		end;
		if(regd.nro <> valor_alto) then 
			leerFallecimiento(vDet[pos], vDat[pos]);
end;


//---------------------------------------------------------------------------------------------------
procedure guardarNacimiento (n: nacimiento;var d : datos);
begin
	with d do begin
		nac := n;
		matricula := '';
		fecha := '';
		hora:= '';
		lugar:= '';
	end;
	
end;

procedure guardarFallecimiento (f : fallecimiento; d : datos);
begin
	with d do begin
		matricula:= f.matricula_medicoD;
		fecha:= f.fecha;
		hora:= f.hora;
		lugar:= f.direccion;
	end;
end;


procedure merge (var mae: maestro; var detalleN: detalle_nacimiento; var detalleF: detalle_fallecimiento);
var
	regm: datos;
	regN: nacimiento;
	regF: fallecimiento;
	vDetallesN: vectorDetallesNacimiento;
	vDetallesF: vectorDetallesFallecimiento;
	vDatosN: vectorDatosN;
	vDatosF: vectorDatosF;
	i :integer;
begin
	rewrite (mae);
	resetTodosNacimiento (vDetallesN);
	resetTodosFallecimiento(vDetallesF);
	for i:=1 to dimF do begin
		leerNacimiento(vDetallesN[i], vDatosN[i]);
		leerFallecimiento(vDetallesF[i], vDatosF[i]);
	end;
	minimoNacimiento (vDetallesN,vDatosN,regN);
	minimoFallecimiento (vDetallesF,vDatosF,regF);
	while(regN.nro <> valor_alto) do begin
			if (regN.nro = regF.nro) then begin
				guardarNacimiento (regN, regm);
				guardarFallecimiento (regF, regm);
				minimoNacimiento (vDetallesN,vDatosN,regN);
				minimoFallecimiento (vDetallesF,vDatosF,regF);
			end else begin
				guardarNacimiento (regN, regm);
				minimoNacimiento (vDetallesN,vDatosN,regN);
			end;
			
			write(mae, regm);
	end;
	closeTodosNacimiento (vDetallesN);
	closeTodosFallecimiento(vDetallesF);
	close (mae);
end;

var
	mae: maestro;
	detN: detalle_nacimiento;
	detF: detalle_fallecimiento;
	vDetN: vectorDetallesNacimiento;
	vDetF: vectorDetallesFallecimiento;
{programa principal}
begin
assign (mae, 'maestro');
asignarDetallesNacimiento (vDetN);
asignarDetallesFallecimiento (vDetF);
merge (mae,detN,detF);
end.
