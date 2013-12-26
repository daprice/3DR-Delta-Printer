include <3DRAux.scad>
//Uncomment one of them
arm_mag();
//top_joint();
//bot_joint();
rBall=dBall/2+kBall;
//0.8=wall thickness
module top_joint(){
	difference(){
		cylinder(r=rMag+0.8,h=hMag+rBall/3);
		translate([0,0,-sol])
			cylinder(r=rMag,h=hMag+2*sol);
		translate([0,0,hMag+0*rBall/3+rBall+0.1])
			sphere(r=rBall);
	}
}
module bot_joint(){
	difference(){
		cylinder(r=rMag+2*0.8+kJoint,h=hMag+rBall/3+tJoint);
		translate([0,0,tJoint])
			cylinder(r=rMag+0.8+kJoint,h=hMag+rBall/3+tJoint);
		translate([0,0,-sol])
			cylinder(r=rArmRod,h=tJoint+2*sol);
	}
}
module arm_mag(){
	translate([rMag+tJoint+5,0,0])bot_joint();
	translate([-rMag-tJoint/3-5,0,0]) top_joint();
}
