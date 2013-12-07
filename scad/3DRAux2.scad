nemL=60;
//Slope of the line through points 1 and 2 of the base
m=(sumY(vL,vAn,2)-sumY(vL,vAn,1))/(sumX(vL,vAn,2)-sumX(vL,vAn,1));
//Ecuation of the line through points 1 and 2 of the base
//y=m*(x-sumX(vL,vAn,1))+sumY(vL,vAn,1)
module recta(){	
	for(x=[sumX(vL,vAn,1)-0:2:sumX(vL,vAn,1)+30]){
		translate([x,m*(x-sumX(vL,vAn,1))+sumY(vL,vAn,1),0]) sphere(r=1);
		//echo(x,m*(x-sumX(vL,vAn,2))+sumY(vL,vAn,2));
	}
}
//Slope of the line through bed hole and nema length
m2=(lhb*sin(165)/sqrt(2))/(vgx+cos(165)*lhb/sqrt(2)-sumX(vL,vAn,i=5));
//Ecuation of the line through bed hole and nema length
//y=m2*m2*(x-sumV(v=vLM,i=4)-nemL)) 
module recta2(){	
	for(x=[30:10:200]){
		translate([x,m2*(x-sumX(vL,vAn,i=5))]) 
			sphere(r=1);
	}
}

//Intersection points
puntX=(m*sumX(vL,vAn,1)-sumY(vL,vAn,1)-m2*(sumX(vL,vAn,i=5)))/(m-m2);
puntY=m2*(puntX-sumX(vL,vAn,i=5));

//Modulo para definir las paredes laterales
module side_wall(l=5,h,t){	
	intersection(){
		translate([0,0,-sol])
			linear_extrude(height=h+2*sol) auxbase();
		translate([puntX+l*cos(30),puntY+l*sin(30),0])
			rotate([0,0,atan(m2)])
				cube([lCov,t,h]);
	}
}

//Modulo para definir los agujeros laterales
module side_hole(h,t){
	l2=t/sin(30-atan(m2))+sol;
	translate([puntX+l2*cos(30),puntY+l2*sin(30),h])
		rotate([-90,0,atan(m2)])  translate([2*lCov/12,0,-1-sol])
			cylinder(r=M5r,h=2*t+1);	
	translate([puntX+l2*cos(30),puntY+l2*sin(30),h])
		rotate([-90,0,atan(m2)])  translate([5*lCov/12,0,-1-sol])
			cylinder(r=M5r,h=3*t+1);
}

//Modulo para definir los agujero centrales
module cent_hole(h,t){
	translate([vgx,0,0]) rotate([0,0,0*360/18])
	for(i=[0:8]){
		rotate([0,0,i*360/9])
			translate([vgx-sumV(v=vLM,i=4)-nemL,0,h])	
				rotate([0,-90,0])		
					cylinder(r=3,h=2*t);
	}
}
