

include <3DRAux.scad>
include <3DRAux2.scad>
use <3DR_Bot_Mot.scad>

bot_mot_r();


module bot_mot_r_wall(l){
	x=lCov;
	y=tBas;
	z=hB;
	l=l;
	intersection(){
		translate([0,0,-sol])
			linear_extrude(height=hB+2*sol) auxbase();
		translate([puntX+l*cos(30),puntY+l*sin(30),0])
			rotate([0,0,atan(m2)])
				cube([lCov,tBas,hB]);
	}
}

module bot_mot_r_nh(){
	bot_mot();
	//%bot_mot_r_wall(l=5);
	//%bot_mot_r_wall(l=5+5+0.9);
	side_wall(l=5+tBas/sin(30-atan(m2)),h=hB,t=tBas);

	intersection(){
		translate([0,0,-sol])
			linear_extrude(height=hB+2*sol) auxbase();
		translate([vgx,0,0])
			cylinder(r=vgx-sumV(v=vLM,i=4)-nemL,h=hB);
	}
}
module bot_mot_r(){
	l=5+tBas/sin(30-atan(m2))+sol;
	difference(){
		bot_mot_r_nh();
		translate([puntX+(l-0)*cos(30),puntY+l*sin(30),-3*sol])
			rotate([0,0,atan(m2)]) translate([-puntX,-lCov,0])
				cube([lCov+puntX,lCov,hBas+6*sol]);
		translate([vgx,0,-2*sol])
			cylinder(r=vgx-sumV(v=vLM,i=4)-nemL-tBas,h=hB+4*sol);
		side_hole(h=(hB+tBas)/2,t=tBas);	
		cent_hole(h=(hB+tBas)/2,t=tBas,n=7);	
	}
}

/*translate([0,15,0])rotate(-10)bot_mot_r();
translate([0,190,0]) mirror([0,1,0]) rotate(-10) bot_mot_r();
translate([-30,100,0]) bot_mot_c();
//mirror([0,1,0]) bot_mot_r();


