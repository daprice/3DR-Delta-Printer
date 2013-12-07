//translate([-12.5,32.5,0])rotate([0,0,240])import("stl/3DR_Car.stl");
include <3DRAux.scad>
//Uncoment
//car();
module bearing_guide(){	
	translate([dBea,-rBea/3,0]){
		difference(){
			cylinder(r=rBea+tCar,h=hCar);					
			translate([-rBea-tCar,-5*rBea/3-1-sol,-sol])
				cube([2*(rBea+tCar),2*rBea+1,hCar+2*sol]);
		}
	}
}


module line_guide(){
	ang=15;
	l=lHall+1;
	hm=hHall-0.5;
	cube([dBea,tCar,hCar]);
	difference(){
		cube([tCar,l,hCar]);		
		translate([-sol,l,hm]) rotate([ang,0,0])
	 		cube([tCar+2*sol,(hCar-hm)*tan(ang)+sol,(hCar-hm)/cos(ang)+sol]);		
	}		
}

module joint_sup(){	
	x=dBea-tCar-rBea*cos(asin(1/3));
	angJS=asin(tCar/x);	
	x2=x*(1-cos(angJS));	
	z=11.5;	
	translate([tCar,tCar-sol,0]){
		difference(){
			cube([x,tCar,z]);
			translate([5*x/4-x2/2,3*tCar/2,-sol])
				cylinder(r=x/2,h=z+2*sol);
			translate([-x/4+x2/2,3*tCar/2,-sol])
				cylinder(r=x/2,h=z+2*sol);
			translate([-sol,tCar,z/2]) rotate([40,0,0])
				cube([x+2*sol,2*tCar,z]);
		}		
	}	
	if(joint_ty=="traxx"){		
		translate([x/4+tCar,2*tCar-sol,0]){
			cube([x/2,2*tCar,z/2]);
			translate([0,2*tCar,z/4]) rotate([0,90,0])
				cylinder(r=z/4,h=x/2);			
		}
	}
}

module car_zip(){
	difference(){
		cylinder(r=rBea+tCar+sol+1,h=hZip);
		translate([0,0,-sol])
			cylinder(r=rBea+tCar-tZip,h=hZip+2*sol);
	}
}

module car_nh(){
	bearing_guide();
	line_guide();
	if(joint_ty=="traxx")joint_sup();
	if(joint_ty=="mag")
		translate([0,0,hCar])
			mirror([0,0,1])joint_sup();
	
}

module carmid(){	
	x=dBea-tCar-rBea*cos(asin(1/3));
	angJS=asin(tCar/x);	
	x2=x*(1-cos(angJS));
	echo(x2);	
	difference(){
		car_nh();
		translate([dBea,-rBea/3,-sol])
			cylinder(r=rBea,h=hCar+2*sol);
		if(joint_ty=="traxx")
			translate([tCar-2*sol+x/4-x/30,7*tCar/2,3]) rotate([0,90,0])
				cylinder(r=1.5,h=x/2+x/15+2*sol);
		if(joint_ty=="mag")
			translate([x/2+tCar,2*tCar+sol+M3r*sin(40),hCar-M3r*1.2])
				rotate([130,0,0])
					cylinder(r=M3r,h=30);
		if(endstop_ty=="hall")
			translate([0,lHall-rHall,-sol])
				cylinder(r=rHall,h=hHall);
		translate([-sol,5,13.5]){
			cube([tCar+2*sol,2.5,2.5]);
			translate([0,4,0]) cube([tCar+2*sol,2.5,2.5]);
			translate([0,0,-5.5]) cube([tCar+2*sol,2.5,2.5]);
			translate([0,4,-5.5]) cube([tCar+2*sol,2.5,2.5]);
		}
		translate([dBea,-rBea/3,(hCar-hZip-lBea+2)/2])
			car_zip();
		translate([dBea,-rBea/3,(hCar-hZip+lBea-2)/2])
			car_zip();
	}
	translate([dBea-(rBea-tCar/2+tZip),-rBea/3+tCar,(hCar-lBea)/2-2])
		cube([2*(rBea-tCar/2+tZip),tCar,2]);
	translate([dBea-(rBea-tCar/2+tZip),-rBea/3+tCar,(hCar+lBea)/2])
		cube([2*(rBea-tCar/2+tZip),tCar,2]);	
}

module car(){
	carmid();
	mirror([1,0,0]) carmid();
}
