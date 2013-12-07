include <3DR_Top_Ele.scad>
include <3DRAux2.scad>

module top_ele_c_wall(l=5){	
	intersection(){
		translate([0,0,-sol])
			linear_extrude(height=hTop+2*sol) auxbase();
		translate([puntX+l*cos(30),puntY+l*sin(30),0])
			rotate([0,0,atan(m2)])
				cube([lCov,tTop,hTop]);
	}
}

module top_ele_c_nh(){
	top_ele();
	top_ele_c_wall();
	mirror([0,1,0]) 	top_ele_c_wall();
	intersection(){
		translate([0,0,-sol])
			linear_extrude(height=hTop+2*sol) auxbase();
		translate([vgx,0,0])
			cylinder(r=vgx-sumV(v=vLM,i=4)-nemL,h=hTop);
	}
}
module top_ele_c(){
	l=5+tBas/sin(30-atan(m2))+sol;
	l2=3+tBas/sin(30-atan(m2))+sol;
	k=-vArc[1];
	difference(){
		top_ele_c_nh();
		translate([puntX+l*cos(30),puntY+l*sin(30),-5*sol])
			rotate([0,0,atan(m2)]) translate([k,0,0])
				cube([lCov,lCov/2+1,hTop+10*sol]);
		mirror([0,1,0])
			translate([puntX+l*cos(30),puntY+l*sin(30),-5*sol])
				rotate([0,0,atan(m2)])  translate([k,0,0])
					cube([lCov,lCov/2+1,hTop+10*sol]);
		translate([vgx,0,-5*sol])
			cylinder(r=vgx-sumV(v=vLM,i=4)-nemL-tBas,h=hTop+10*sol);
		side_hole(h=(hTop+tTop)/2,t=tTop);
		mirror([0,1,0])
			side_hole(h=(hTop+tTop)/2,t=tTop);
		cent_hole(h=(hTop+tTop)/2,t=tTop);

	}
}
top_ele_c();