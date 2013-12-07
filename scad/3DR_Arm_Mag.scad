include <3DRAux.scad>

module top_joint(){
	difference(){
		cylinder(r=rMag+tJoint/3,h=hMag+rBall/3);
		translate([0,0,-sol])
			cylinder(r=rMag,h=hMag+2*sol);
		translate([0,0,hMag+0*rBall/3+rBall])
			sphere(r=rBall);
	}
}
module bot_joint(){
	difference(){
		cylinder(r=rMag+tJoint,h=hMag+rBall/3+tJoint);
		translate([0,0,tJoint])
			cylinder(r=rMag+tJoint/3+kJoint,h=hMag+rBall/3+tJoint);
		translate([0,0,-sol])
			cylinder(r=rArmRod,h=tJoint+2*sol);
	}
}
module arm_mag(){
	translate([rMag+tJoint+5,0,0])bot_joint();
	translate([-rMag-tJoint/3-5,0,0])top_joint();
}
arm_mag();