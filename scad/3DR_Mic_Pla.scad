module mori(){
	translate([-33,-28.5,0]) 
		import("stl/3DR_Mic_Pla.stl");
}
//mori();
include <3DRAux.scad>
tPla=6.5;


module micpla(){
	difference(){
		cylinder(r=22.5,h=tPla);
		translate([0,0,-sol])cylinder(r=15,h=tPla+2*sol);
		for(i=[0:5]) rotate(60*i)
			translate([0,(22.5+15)/2,-sol]) cylinder(r=2,h=tPla+2*sol);
	}
	for(i=[0:2]) rotate(120*i){
		joint_rod();
		mirror([1,0,0]) joint_rod();
		circulo();
	}
	
}
module joint_rod(){
x=6.5;
y=11.5;
r=4.5;	
	translate([10.5-x/2,-17-y,0]) difference() {
		union(){
			translate([0,y/2,0])
				cube([x,y/2,tPla]);				
			intersection(){
				cube([x,y,tPla]);
				translate([0,r,tPla/2])  rotate([0,90,0])
					cylinder(r=r,h=x);
			}
		}
		translate([-sol,r,tPla/2]) rotate([0,90,0])
				cylinder(r=1.5,h=x+2*sol);
		
	}
}

module circulo(){
r=5;
y=15;
	translate([-r,22,0]){
		difference(){
			union(){
				translate([1*r/4,0,0])
					cube([3*r/2,2*r,tPla]);
				translate([r,2*r,0])
					cylinder(r=r,h=tPla);
			}
			translate([r,2*r,-sol])
				cylinder(r=1.5,h=tPla+2*sol);
		}
	}
}
//circulo();
micpla();