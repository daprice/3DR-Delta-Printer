use <3DR Calculator.scad>
output();



					//**Nuts**//
//M3 thread radius
M3r=1.6;
//M3 height
M3h=2.5;
//M3 flats
M3n=5.5;
//M3 nut outer diameter
M3nr=M3n/cos(30);//6.01;

//Same as M3
M5r=2.7;
M5h=4;
M5n=8;
M5nr=M5n/cos(30);//8.76;

//Same as M3
M4r=2.1;
M4h=3.2;
M4n=7;
M4nr=M4n/cos(30);//7.66;



sol=0.01;
$fn=60;
//Joint type.Only mag or traxx
joint_ty="mag";

					//**Vertical Rod**//
//Whether to use vertical rods
useRod=false;
//radius of the rod
rRod=4.2;

				//**Hall Endstop type**//
//Endstop type.Only hall,nhall or mech
endstop_ty="mech";
//radius of magnet for hall detector
rHall=4.2;
//height of magnet for hall detector
hHall2=5;
//Distance wich magnet is placed
lHall=14;
//Endstop actuator radius
rEndAc=(endstop_ty=="hall"||endstop_ty=="nhall"?rHall:M3r);
hEndAc=(endstop_ty=="hall"||endstop_ty=="nhall"?hHall2:M3h*3);;




				//**Magnetic arm joints**//
//Magnet radius
rMag=9.525/2;
//Magnet height
hMag=9.525;
//Ball diameter
dBall=9.525;
//Ball tolerance
kBall=0.5;
//Joint thicknes
tJoint=3;
//Arm rod radius
rArmRod=3;
//Tolerance
kJoint=0.1;				


				//**Bearing**//
//bearing outer radius
rBea=6;
//bearing length
lBea=16;
//Horizontal distance between the center of to bearings
dBea=19+rBea;//15.6+rBea;

				//**Carriage**//
//Car height
hCar=lBea+3;
//Car thicness
tCar=(3<=rEndAc?rEndAc+1:3.5);
echo(tCar);
//Support width
xJS=dBea-tCar-rBea*cos(asin(1/3));
//Support height
z=11.5;
//Support constant,don´t modify
angJS=asin(tCar/xJS);	
xJS2=xJS*(1-cos(angJS));

	

				//**Top & Botton**//
//Side length of the triangle 160 for heated bed 
lCov=116;
//Rounded
rounded_b=true;
//Total base height(base+slot_guide)
hBas=65;
//Base height
hB=25;
//Height of the base holes
hBasHol=16;
//Base thicknesss
tBas=4.5;
//Total top height
hTop=20;
//Top height-electronic
hT=15;
//Top thickness
tTop=tBas;
//Height of the base holes
hTopHol=8;
//Circumradius
rCov=lCov/sqrt(3);
//Auxiliary dimension
dSl=lCov/6;

				//**Top&Botton Boss**//
//Side length of the triangle
lBos=lCov/2.5;
//Circumradius
rBos=lBos/sqrt(3);
//Auxiliary dimension
rp=2*lBos/3-rBos;

				//**Top Cover**//
//Top Cover height
hTCov=23;//22.5
//Top Cover thickness
tTCov=3;

				//**Spool**//
//Spool radius
rSpo=9;
//Big spool radius
rbSpo=11;

				//**Slots **//
//Slot side
dSlot=20;
//Slot type (tslot or squa)
slot_ty="tslot";
//Slot allowance
kSlot=0.4;

				//**Effector**//
//Effector thicknes
tPla=6.5;
//Outer radius
REff=22.5;
//Inner radius
rEff=15;
//Joint rod length in X axis
xJR=xJS/2;
//Joint rod length in Y axis
yJR=12;
//Joint rod radius
rJR=4.5;
//Traslation in X axis.Don`t modify
txJR=xJS/4+tCar;
//Traslation in Y axis.Don`t modify
tyJR=sqrt(+pow(REff,2)-pow((txJR+xJR),2));

				//**Heat Bed **//
//Is present heated bed?
hbed=true;
//Center-to-center mounting holes
lhb=128.6;//209
//Bed support thickness
tBedSup=4*hB/5;

				//**Electronic**//
//Electronic type: RAMPS or TODO
elec_ty="RAMPS";
//Traslation for holes
vtr=4.5;//4.5
//Coordinates of the holes for Ramps
vLRamps=[[13.97-108/2-vtr,2.54-53/2],[96.52-108/2-vtr,2.54-53/2],
			[15.24-108/2-vtr,50.8-53/2],[90.17-108/2-vtr,50.8-53/2]];
//Para definir los puntos px= x-ancho/2   py=y-alto/2
vLSav=[[3.81-99.7/2-vtr,3.81-64.77/2],[96.52-99.7/2-vtr,3.81-64.77/2],
		[3.81-99.7/2-vtr,60.96-64.77/2],[96.52-99.7/2-vtr,60.96-64.77/2]];
vLEle=(elec_ty=="RAMPS"?vLRamps:
		elec_ty=="SAV"?vLSav:[0,0]);


				//**Nema**//
//Nema length
nemL=60;

				//**Zip ties**//
//Zip height
hZip=3.5;
//Zip thickness
tZip=0.5;






