include <3DRaux.scad>
lCov=160;

//Effector offset
//http://trains.socha.com/2013/10/3dr-simple-delta-printer-firmware.html
eff_of=(joint_ty=="mag"?
	vMod0(vP=[txJR+xJR/2,-tyJR-yJR+rJR-(tPla-M3r)*sin(45)]):
	vMod0(vP=[txJR+xJR,-tyJR-yJR+rJR]));
//Carriage offset
car_of=(joint_ty=="mag"?2*tCar+rBea/3:3.5*tCar+rBea/3);
//Offset total
tot_of=eff_of+car_of;
//Rod to rod distance
r2r=2*sqrt(pow(sumV(v=vLM,i=2)-sumX(vL,vAn,2)-3.95,2)
	+pow(dBea-sumY(vL,vAn,2)+6.84,2));
l=r2r*1.0;
ptv1=[sumV(v=vLM,i=2)+tot_of,0];
ptv2=[sumV(v=vLM,i=2)+(l+dBea)*cos(30)-tot_of*sin(30),(dBea+l)*sin(30)-tot_of*cos(30)];
dtv=vModP(v1=ptv1,v2=ptv2);
rImp=dtv/sqrt(3);
ang1=acos(lhb/(2*rImp));
ang2=90-2*ang1;
arImp=4*(rImp*lhb*sin(ang1)/2+PI*pow(rImp,2)*ang2/360);
echo("Rod to rod distance",r2r);
echo("Effector offset=",eff_of);
echo("Car offset=",car_of);
echo("Total offset=",tot_of);
echo("Total arm length",l);
echo("Printable radius",rImp);	
if(arImp>0)
	echo("Heated bed printable %",100*arImp/pow(lhb,2));
echo("Outer radius",lCov+lCov/6);