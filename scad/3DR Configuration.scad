



					//**Nuts**//
//M3 thread radius
M3r=1.6;
//M3 height
M3h=2.4;
//M3 flats
M3n=5.5;
//M3 nut outer diameter
M3nr=M3n/cos(30);//6.01;


//Same as M3
M5r=2.6;
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
//mag or traxx
joint_ty="mag";

					//**Rod**//
//radius of the rod
rRod=3;

				//**Hall Endstop type**//
endstop_ty="hall";
//radius of magnet for hall detector
rHall=4;
//height of magnet for hall detector
hHall=5;
//Distance wich magnet is placed
lHall=14;

				//**Magnetic arm joints**//
//Magnet radius
rMag=4;
//Magnet height
hMag=10;
//Ball raduius
rBall=4.75;
//Joint thicknes
tJoint=3;
//Arm rod radius
rArmRod=3;
//Tolerance
kJoint=0.2;				


				//**Bearing**//
//bearing outer radius
rBea=5.9;
//bearing length
lBea=10;
//Horizontal distance between the center of to bearings
dBea=19+rBea;//15.6+rBea;

				//**Carriage**//
//Car height
hCar=18;
//Car thicness
tCar=(3<=rHall?rHall+0.5:3);

				//**Top & Botton**//
//Side length of the triangle 160 for heated bed 
lCov=160;
//Rounded
rounded_b=true;
//Total base height(base+slot_guide)
hBas=60;
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
lBos=lCov/2;
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
kSlot=0.1;

				//**Heat Bed **//
//Is present heated bed?
hbed=true;
//Center-to-center mounting holes
lhb=209;
//Bed support thickness
tBedSup=4*hB/5;

				//**Electronic**//
//Electronic type: RAMPS or TODO
elec_ty="RAMPS";
//Traslation for RAMPS
vtr=4.5;//4.5
//Coordinates of the holes for Ramps
vLRamps=[[13.97-108/2-vtr,2.54-53/2],[96.52-108/2-vtr,2.54-53/2],
			[15.24-108/2-vtr,50.8-53/2],[90.17-108/2-vtr,50.8-53/2]];

				//**Zip ties**//
hZip=3.5;
tZip=0.5;






