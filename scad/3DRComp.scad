//include<3DR_Bot_Bos.scad>
include <3DRaux.scad>
//include<3DR_Bot_Mot.scad>
//lCov=150;
$fn=60;

rprin=(lCov+1*lCov/20)*0.72;
rOut=lCov+lCov/6;
strImp=str("Diametro del area de impresion = ",2*rprin);
strSiz=str("Diametro del circumradio = ",2*rOut);
echo(strImp);
echo(strSiz);

col=["green","white","red"];
module cBase(){
	for(i=[0,2]){}
	color(col[0]) translate([0,0,0]) botmot();
	color(col[1]) translate([vx,-vy,0]) rotate(120) botmot();
	color(col[2]) translate([vx,vy,0]) rotate(-120) botmot();
	
	translate([vgx,0,0])import ("Stlp/3DR_Bot_Bos.stl");
	translate([20+6,dBea,00]) cylinder(r=3,h=200);
	translate([20+6,-dBea,00]) cylinder(r=3,h=200);
}
module heabed(){
	lhb=209;
	difference(){	
		square([214,214],center=true);
		translate([lhb/2,lhb/2])circle(r=1.5);
		translate([lhb/2,-lhb/2])circle(r=1.5);
		translate([-lhb/2,lhb/2])circle(r=1.5);
		translate([-lhb/2,-lhb/2])circle(r=1.5);
		
	}
}
//heabed();
translate([-vgx,0,0]) rotate([0,0,0]) cBase();


tra=+0;
tang=120;
for(i=[0:0]){
translate([tra*cos(tang*i),tra*sin(tang*i),0]) rotate(tang*i)
	rotate(0)heabed();
}
%translate([0,0,-1])circle(r=rprin,$fn=fn);
//#circle(rOut);

//translate([0,0,-59])rotate([0,0,0])bot_bos();
//%translate([0,0,-1])circle(208,$fn=50);
module nem(){
	rotate([0,-90,0])translate([20,0,20])nema(n=17,l=40);
}
module botmot(){
	import ("Stlp/3DR_Bot_Mot.stl");
}

