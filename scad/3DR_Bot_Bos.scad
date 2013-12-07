//Centrado en 0,0
//translate([2,-5,28]) rotate(30)import("stl/3DR_Bot_Bos.stl");
//translate([-6.5,-32.5,0]) rotate(30)import("stl/3DR_Top_Bos.stl");
include<3DRAux.scad>
//Uncomment
bot_bos();

module bot_bos(){
	difference(){
		rotate(60) cylinder(r=rBos,h=hBas,$fn=3);
		for(i=[0:2]){
			rotate(120*i){				
				rotate(60) translate([lBos/2,-rp/2,-sol])
					cube([rp,rp,hBas+2*sol]);
				rotate([0,90,120])translate([hBasHol-hBas,-lBos/4,rBos/2-10+sol])
					cylinder(r=M4r,h=10);
				rotate(30)translate([lBos/4-M4n/2,rBos/2-8+sol,hBas-21]) 
					cube([M4n,M4h,22]);
			}
		}
		translate([0,0,hBas-18])cylinder(r=7.51,h=20,$fn=6);
		translate([0,0,-sol]) cylinder(r=4,h=hBas-hBasHol+2*sol);
	}
}
