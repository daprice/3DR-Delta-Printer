include <3DR_Bot_Mot.scad>
include <3DRAux2.scad>
//UnComment
//bot_mot_c();
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
puntY=m2*(puntX-sumX(vL,vAn,i=5));*/


module bot_mot_c_wall(l=5){	
	intersection(){
		translate([0,0,-sol])
			linear_extrude(height=hB+2*sol) auxbase();
		translate([puntX+l*cos(30),puntY+l*sin(30),0])
			rotate([0,0,atan(m2)])
				cube([lCov,tBas,hB]);
	}
}

module bot_mot_side_h(h){
	l2=tBas/sin(30-atan(m2))+sol;
	translate([puntX+l2*cos(30),puntY+l2*sin(30),h])
		rotate([-90,0,atan(m2)])  translate([2*lCov/12,0,-1-sol])
			cylinder(r=M5r,h=2*tBas+1);	
	translate([puntX+l2*cos(30),puntY+l2*sin(30),h])
		rotate([-90,0,atan(m2)])  translate([5*lCov/12,0,-1-sol])
			cylinder(r=M5r,h=3*tBas+1);
}

module bot_mot_c_h(h){
	translate([vgx,0,0]) rotate([0,0,360/18])
	for(i=[0:8]){
		rotate([0,0,i*360/9])
			translate([vgx-sumV(v=vLM,i=4)-nemL+0*tBas,0,h])	
				rotate([0,-90,0])		
					cylinder(r=3,h=30);
	}
}

module bot_mot_c_nh(){
	bot_mot();
	//bot_mot_c_wall();
	side_wall(h=hB,t=tBas);
	mirror([0,1,0])
		side_wall(h=hB,t=tBas);
	intersection(){
		translate([0,0,-sol])
			linear_extrude(height=hB+2*sol) auxbase();
		translate([vgx,0,0])
			cylinder(r=vgx-sumV(v=vLM,i=4)-nemL,h=hB);
	}
}

module bot_mot_c(){
	l=5+tBas/sin(30-atan(m2))+sol;
	l2=3+tBas/sin(30-atan(m2))+sol;
	k=-vArc[1];
	difference(){
		bot_mot_c_nh();
		translate([puntX+l*cos(30),puntY+l*sin(30),-5*sol])
			rotate([0,0,atan(m2)]) translate([k,0,0])
				cube([lCov,lCov/2+1,hB+10*sol]);
		mirror([0,1,0])
			translate([puntX+l*cos(30),puntY+l*sin(30),-5*sol])
				rotate([0,0,atan(m2)])  translate([k,0,0])
					cube([lCov,lCov/2+1,hB+10*sol]);
		translate([vgx,0,-5*sol])
			cylinder(r=vgx-sumV(v=vLM,i=4)-nemL-tBas,h=hB+10*sol);
		side_hole(h=(hB+tBas)/2,t=tBas);
		mirror([0,1,0])
			side_hole(h=(hB+tBas)/2,t=tBas);
		//bot_mot_c_h(h=(hB+tBas)/2);
		cent_hole(h=(hB+tBas)/2,t=tBas);
	
	}
}


bmcAng=120;
module aguBo(){
	translate([vgx,0,0]) for(i=[0:2]){	
		rotate(bmcAng) {
			translate([lhb/2,lhb/2,0])circle(r=3);
		}
	}
}

module aguB(){
//	translate([vgx-lhb*cos(30)/2,0,-1])

	translate([vgx+lhb/2,lhb/2,-4])
		cylinder(r=5.5,h=20);
}
//%aguB();
//#aguBo();
/*translate([vgx,0,0])color("green") circle(r=2);
translate([vgx+lhb/2,0,0])color("green") circle(r=2);
translate([vgx+lhb*cos(90)/2,lhb/2,0])color("green") circle(r=2);
translate([vgx+cos(bmcAng+45)*lhb/sqrt(2),sin(bmcAng+45)*lhb/sqrt(2),-1])
	color("green") circle(r=2);
//translate([sumV(v=vLM,i=4)+nemL,0,tBas+2]) cylinder(r=2,h=20);*/
