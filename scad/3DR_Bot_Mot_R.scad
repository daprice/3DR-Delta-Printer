//include <3DR_Bot_Mot_C.scad>
include <3DR_Bot_Mot.scad>
include <3DRAux2.scad>
//Uncomment
//bot_mot_r();

/*nemL=60;
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
//m2=(lhb*sin(165)/sqrt(2))/(vgx+cos(165)*lhb/sqrt(2)-sumV(v=vLM,i=4)-nemL);
m2=(lhb*sin(165)/sqrt(2))/(vgx+cos(165)*lhb/sqrt(2)-sumX(vL,vAn,i=5));
//Ecuation of the line through bed hole and nema length
//y=m2*m2*(x-sumV(v=vLM,i=4)-nemL)) 
module recta2(){	
	for(x=[30:10:200]){
		translate([x,m2*(x-sumX(vL,vAn,i=5))]) 
			sphere(r=1);
	}
}
//translate([0,0,hB+1 ])recta2();

puntX=(m*sumX(vL,vAn,1)-sumY(vL,vAn,1)-m2*(sumX(vL,vAn,i=5)))/(m-m2);
puntY=m2*(puntX-sumX(vL,vAn,i=5));*/

module bot_mot_r_wall(l){
	x=lCov;
	y=tBas;
	z=hB;
	l=l;
	intersection(){
		translate([0,0,-sol])
			linear_extrude(height=hB+2*sol) auxbase();
		translate([puntX+l*cos(30),puntY+l*sin(30),0])
			rotate([0,0,atan(m2)])
				cube([lCov,tBas,hB]);
	}
}

module bot_mot_r_nh(){
	bot_mot();
	//%bot_mot_r_wall(l=5);
	//%bot_mot_r_wall(l=5+5+0.9);
	side_wall(l=5+tBas/sin(30-atan(m2)),h=hB,t=tBas);

	intersection(){
		translate([0,0,-sol])
			linear_extrude(height=hB+2*sol) auxbase();
		translate([vgx,0,0])
			cylinder(r=vgx-sumV(v=vLM,i=4)-nemL,h=hB);
	}
}
module bot_mot_r(){
	l=5+tBas/sin(30-atan(m2))+sol;
	difference(){
		bot_mot_r_nh();

		translate([puntX+(l-0)*cos(30),puntY+l*sin(30),-3*sol])
			rotate([0,0,atan(m2)]) translate([-puntX,-lCov,0])
				cube([lCov+puntX/2,lCov,hBas+6*sol]);
		translate([vgx,0,-2*sol])
			cylinder(r=vgx-sumV(v=vLM,i=4)-nemL-tBas,h=hB+4*sol);
		side_hole(h=(hB+tBas)/2,t=tBas);	
		cent_hole(h=(hB+tBas)/2,t=tBas);	
	}
}

/*translate([0,15,0])rotate(-10)bot_mot_r();
translate([0,190,0]) mirror([0,1,0]) rotate(-10) bot_mot_r();
translate([-30,100,0]) bot_mot_c();
//mirror([0,1,0]) bot_mot_r();


