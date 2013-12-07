include <3DR_Top_Ele.scad>
include <3DRAux2.scad>
module top_ele_r_nh(){
	top_ele();
	//%bot_mot_r_wall(l=5);
	//%bot_mot_r_wall(l=5+5+0.9);
	side_wall(l=5+tTop/sin(30-atan(m2)),h=hTop,t=tTop);
	intersection(){
		translate([0,0,-sol])
			linear_extrude(height=hTop+2*sol) auxbase();
		translate([vgx,0,0])
			cylinder(r=vgx-sumV(v=vLM,i=4)-nemL,h=hTop);
	}
}
module top_ele_r(){
	l=5+tBas/sin(30-atan(m2))+sol;
	difference(){
		top_ele_r_nh();
		translate([puntX+(l-0)*cos(30),puntY+l*sin(30),-3*sol])
			rotate([0,0,atan(m2)]) translate([-puntX,-lCov,0])
				cube([lCov+puntX/2,lCov,hTop+6*sol]);
		translate([vgx,0,-2*sol])
			cylinder(r=vgx-sumV(v=vLM,i=4)-nemL-tTop,h=hTop+4*sol);
		side_hole(h=(hTop+tTop)/2,t=tTop);	
		cent_hole(h=(hTop+tTop)/2,t=tTop);	
	}
}
top_ele_r();