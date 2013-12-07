include <3DRaux.scad>

//Uncomment
//bed_sup_print();
//**How to calculate intersection point **/
//Slope of the line through points 1 and 2 of the base
m=(sumY(vL,vAn,2)-sumY(vL,vAn,1))/(sumX(vL,vAn,2)-sumX(vL,vAn,1));
//Ecuation of the line through points 1 and 2 of the base
//y=m*(x-sumX(vL,vAn,1))+sumY(vL,vAn,1)
//Perpendicular to the above, passing through a hole in the bed
//y=lhb/2-sqrt(3)*(x+lhb/2-vgx)
//Equating the y, I get the point x of intersection
px=(m*sumX(vL,vAn,2)-sumY(vL,vAn,2)+lhb/2-sqrt(3)*lhb/2+sqrt(3)*vgx)/(sqrt(3)+m);
//With the value of px, py is obtained
py=lhb/2-sqrt(3)*(px+lhb/2-vgx);

//**Data**//
//Distance between bed hole and intersection point
lInter=vModP([px,py],[vgx-lhb/2,lhb/2]);
//Support height
hSup=lInter+10;
//Support size length
lSup=2*hSup/sqrt(3);
vLSup=[lSup/2,lSup,lSup];
vAnSup=[0,120,240];

//Generating the support
module sup_poly(){
	points=[sumP(vLSup,vAnSup,0),sumP(vLSup,vAnSup,1),sumP(vLSup,vAnSup,2)];	
	polygon(points=points);
}
module bed_sup_h(lHol=12){
	translate([px-(lHol-sol)*cos(30),py-lHol*sin(30),tBedSup/2])
		rotate([-120,90,0]) cylinder(r=M5r,h=3*tBedSup);
	translate([px+(lHol+sol)*cos(30),py+lHol*sin(30),tBedSup/2])
		rotate([-120,90,0])	cylinder(r=M5r,h=3*tBedSup);
}
module bed_sup(){
	difference(){
		translate([px,py]) rotate(30)
			linear_extrude(height=tBedSup)sup_poly();
		translate([vgx-lhb/2,lhb/2,-sol])
			cylinder(r=M3r,h=tBedSup+2*sol);
		translate([vgx-lhb/2,lhb/2,-sol]) rotate(30)
			cylinder(r=M3nr/2,h=M3h,$fn=6);
		bed_sup_h();
		translate([0,0,-3*sol])
		linear_extrude(height=tBedSup+6*sol) auxbase();
	}
}

module bed_sup_print(){
translate([-vgx/2,-vgx/2+lSup])bed_sup();
mirror([0,1,0]) translate([-vgx/2,-vgx/2+lSup])bed_sup();
}





//**TESTING **//
/*
//Test para la recta perpendicular
module perp(){
	for(x=[vgx-lhb/2-0:2:vgx-lhb/2+30]){
		translate([x,lhb/2-sqrt(3)*(x+lhb/2-vgx),0]) sphere(r=1);
	}
}
//Test para la recta de la base
module recta(){	
	for(x=[sumX(vL,vAn,2)-50:2:sumX(vL,vAn,2)-10]){
		translate([x,m*(x-sumX(vL,vAn,1))+sumY(vL,vAn,1),0]) sphere(r=1);
		//echo(x,m*(x-sumX(vL,vAn,2))+sumY(vL,vAn,2));
	}
}
//color("orange") perp();
//color("white") recta();

translate([0,0,0])bot_mot();
module bed(){
	square([lhb,lhb],center=true);
}
color("green") translate([vgx,0,0]) bed();*/
