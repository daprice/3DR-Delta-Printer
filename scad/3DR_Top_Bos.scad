//Centrado en 0,0
//translate([2,-5,28]) rotate(30)import("stl/3DR_Bot_Bos.stl");
//translate([-6.5,-32.5,0]) rotate(30)import("stl/3DR_Top_Bos.stl");
include <3DRAux.scad>
//Uncomment
top_bos();

module top_bos(){
	difference(){
		rotate(60) cylinder(r=rBos,h=hT,$fn=3);
		for(i=[0:2]){
			rotate(120*i){				
				rotate(60) translate([lBos/2,-rp/2,-sol])
					cube([rp,rp,hT+2*sol]);
				rotate([0,90,0])translate([-hTopHol,lBos/4,rBos/2-10+sol]) 									cylinder(r=M4r,h=10);				
				translate([lBos/4-M4n/2,rBos/2-5.4+sol,hTopHol-M4n/2]) 
					cube([M4h,M4n,hT-hTopHol+sol+M4n]);
			}
		}
		translate([0,0,hT-8])cylinder(r=7.51,h=10+sol,$fn=6);
		translate([0,0,-sol]) cylinder(r=4,h=hTop-hTopHol+2*sol);
	}
}




