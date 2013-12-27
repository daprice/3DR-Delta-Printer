



					//**Tuercas**//
//Radio esparrago M3
M3r=1.6;
//Altura tuerca M3
M3h=2.4;
//Entrecaras M3
M3n=5.5;
//Radio externo tuerca M3
M3nr=M3n/cos(30);//6.01;

//Igual que M3
M5r=2.6;
M5h=4;
M5n=8;
M5nr=M5n/cos(30);//8.76;

//Igual que M4
M4r=2.1;
M4h=3.2;
M4n=7;
M4nr=M4n/cos(30);//7.66;


//Solape,evitar manifold.
sol=0.01;
//Numero de facetas de un circulo
$fn=60;
//Tipo de rotula.Solo "mag" o "traxx"
joint_ty="mag";

					//**Varilla vertical**//
//Radio de la varilla
rRod=4;

				//**Datos del final de carrera**//
//Tipo de final.Por ahora solo "hall"
endstop_ty="hall";
//Radio del iman para el detector hall
rHall=4.2;
//Altura del iman
hHall=5;
//Distancia a la que se coloca el iman en el carro
lHall=14;

				//**Rotulas magneticas**//
//Radio del iman
rMag=4.1;
//Altura del iman
hMag=10;
//Diametro de la bola
dBall=9.5;
//Tolerancia para la bola.Evitar rozamientos.
kBall=0.5;
//Grosor de la base del acople
tJoint=3;
//Radio de la varilla del brazo
rArmRod=3;
//Holgura entre piezas
kJoint=0.1;				
use <3DR Calculator.scad>
output();

				//**Rodamientos**//
//Radio externo del rodamiento
rBea=5.9;
//Longitud del rodamiento
lBea=14;
//Distancia entre centros de los rodamientos
dBea=19+rBea;//15.6+rBea;

				//**Carro vertical**//
//Altura del carro
hCar=18;
//Grosor del carro
tCar=(3<=rHall?rHall+1:3);
//Anchura del soporte de la rotula
xJS=dBea-tCar-rBea*cos(asin(1/3));
//Altura del soporte
z=11.5;
//Constantes,no modificar
angJS=asin(tCar/xJS);	
xJS2=xJS*(1-cos(angJS));	
	

				//**Base y tapa**//
//Lado del triangulo de la base.Para cama caliente 160, richrap 120
lCov=160;
//Redondeada?
rounded_b=true;
//Altura total de la base(base+soporte del t-slot)
hBas=60;
//Altura de la base
hB=25;
//Altura de los agujeros de la base
hBasHol=16;
//Grosor de la base
tBas=4.5;
//Altura total de la tapa
hTop=20;
//Altura a la que se aloja la electronica
hT=15;
//Grosor de la tapa
tTop=tBas;
//Altura de los agujeros de la tapa
hTopHol=8;
//Circumradio.Constante para calculos
rCov=lCov/sqrt(3);
//Dimension auxiliar
dSl=lCov/6;

				//**Acople piezas tapa y base*//
//Lado del triangulo
lBos=lCov/2;
//Circumradio.Constante para calculos
rBos=lBos/sqrt(3);
//Dimension auxiliar
rp=2*lBos/3-rBos;

				//**Cobertura superior**//
//Altura cobertura superior
hTCov=23;//22.5
//Grosor de la cobertura
tTCov=3;

				//**Carrete**//
//Radio de la polea
rSpo=9;
//Radio mayor de la polea
rbSpo=11;

				//**Slots **//
//Lado del slot
dSlot=20;
//Tipo de slot.Solo "tslot" (pronto "squa" y "round")
slot_ty="tslot";
//Tolerancia para el t-slot.
kSlot=0.2;

				//**Efector**//
//Grosor del efector
tPla=6.5;
//Radio externo
REff=22.5;
//Radio interno
rEff=15;
//Longitud del acople en el eje X
xJR=xJS/2;
//Longitud del acople en el eje Y
yJR=12;
//Radio del acople
rJR=4.5;
//Traslacion en el eje X.No modificar
txJR=xJS/4+tCar;
//Traslacion en el eje Y.No modificar
tyJR=sqrt(+pow(REff,2)-pow((txJR+xJR),2));

				//**Heat Bed **//
//¿Esta presente?
hbed=true;
//Distancia entre agujeros
lhb=209;//209
//Grosor del soporte para la cama caliente
tBedSup=4*hB/5;

				//**Electronica**//
//Tipo de electronica : RAMPS o TODO
elec_ty="RAMPS";
//Traslacion para RAMPS
vtr=4.5;//4.5
//Coordenadas de los agujeros de la RAMPS
vLRamps=[[13.97-108/2-vtr,2.54-53/2],[96.52-108/2-vtr,2.54-53/2],
			[15.24-108/2-vtr,50.8-53/2],[90.17-108/2-vtr,50.8-53/2]];

				//**Motores Nema**//
//Longitud del cuerpo del Nema
nemL=60;

				//**Bridas**//
//Altura de las bridas
hZip=3.5;
//Grosor de las bridas
tZip=0.5;






