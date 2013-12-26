include <3DRAux.scad>

eff_pla();

module eff_pla(){
	difference(){
		cylinder(r=REff,h=tPla);
		translate([0,0,-sol])cylinder(r=rEff,h=tPla+2*sol);
		for(i=[0:5]) rotate(60*i)
			translate([0,(REff+rEff)/2,-sol]) cylinder(r=M4r,h=tPla+2*sol);
	}
	for(i=[0:2]) rotate(120*i){		
			joint_rod();		
			mirror([1,0,0]) joint_rod();
		//circulo();
	}	
}


module joint_rod(){
	translate([txJR,-tyJR-yJR,0]) difference(){
		union(){
			translate([0,rJR,0])cube([xJR,yJR-rJR,tPla]);
			if(joint_ty=="traxx")intersection(){
				cube([xJR,yJR,tPla+2*sol]);
				translate([0,rJR,tPla/2]) rotate([0,90,0])
					cylinder(r=rJR,h=xJR);
			}
			if(joint_ty=="mag")translate([0,-tPla+rJR+sol,0])
				intersection(){
					cube([xJR,tPla,tPla]);
						translate([-sol,0,0])rotate([-45,0,0])
							 cube([xJR+2*sol,tPla*sin(45),tPla/sin(45)]);		
			}				
		}
		if(joint_ty=="traxx"){
			translate([-sol,rJR,tPla/2]) rotate([0,90,0])
				cylinder(r=M3r,h=xJR+2*sol);
		}
		if(joint_ty=="mag"){
			translate([xJR/2,tPla,-sol-M3r*sin(45)]) rotate([45,00,0])
				cylinder(r=M3r,h=tPla/sin(45)+2*sol);
		}
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
