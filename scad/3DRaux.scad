//d entre torres=200
//Un lado l=85,el otro l=74
//include<3DR_Bot_Bos.scad>
include <3DR Configuration.scad>
include <polyLine.scad>
//Distances for motor in bas
vLM=[tBas,dSlot,2.5,16.5,7,1.5,4];


//num=num de punto de la base,tra=cantidad a trasladar desde el punto
//ra=radio del agujero, hh=altura
module auxHole(num=0,tra=0,ra=2,hh=16){
	translate([sumP(vL,vAn,num)[0]+tra*cos(vAn[num+1]),sumP(vL,vAn,num)[1]+tra*sin(vAn[num+1]),hh])
		rotate([vAn[num],270,0])translate([0,0,-sol])
			cylinder(r=ra,h=tBas+2*sol+5);
}

module auxRectHole(num=0,tra=0,w=2,h=2,hh=16){
	translate([sumP(vL,vAn,num)[0]+tra*cos(vAn[num+1]),sumP(vL,vAn,num)[1]+tra*sin(vAn[num+1]),hh])
		rotate([vAn[num],270,0])translate([0,0,-sol])
			cube([h,w,tBas+2*sol+5]);
}

vAn=[90,45,30,300,210,270,330,240,150,135];
vL=[dSl/2, dSl*sqrt(2), (lCov+lBos)/2, rCov, lBos/2-rp, rp, lBos/2-rp, rCov, (lCov+lBos)/2, dSl*sqrt(2)];
vArc= [1,4,0,0,0,0,0,4,1,3];
vDArc=[0,30,0,0,0,0,0,-30,0,0];

module auxbase(e=0){
	$fn=150;
	vLe=[vL[0]-e/tan(67.5),
		vL[1]-e/tan(67.5)-e/tan(82.5),
		vL[2]-e/tan(82.5)-e,
		vL[3]-2*e,
		vL[4]-e+e/tan(60),
		vL[5]+2*e/tan(60),
		vL[6]+e/tan(60)-e,
		vL[7]-2*e,
		vL[8]-e/tan(82.5)-e,
		vL[9]-e/tan(67.5)-e/tan(82.5)];
	
	
	
	//testPoints(vLen=vLe,vAng=vAn);
	points=[sumP(vLe,vAn,0),sumP(vLe,vAn,1),sumP(vLe,vAn,2),sumP(vLe,vAn,3),sumP(vLe,vAn,4),sumP(vLe,vAn,5),sumP(vLe,vAn,6),sumP(vLe,vAn,7),sumP(vLe,vAn,8),sumP(vLe,vAn,9)];
	if(rounded_b)polyL(p=points,vArc=vArc,dArc=vDArc);
	if(!rounded_b) polyL(p=points);
}
//auxbase();
module hue(e=4){
	$fn=150;
	difference(){
		auxbase();
		translate([e,0,0]) auxbase(e=e);
	}
}
//linear_extrude(height=5) hue();


vg=sumP(vL,vAn,3);
vgx=vg[0]+dSl*cos(30)/2;
vx=3*vgx*sin(30);
vy=vgx*cos(30);
//vp=sumP(vL,vAn,2);
//vx=vp[0]+(lCov+lBos)*0.5*cos(30)+dSl*sqrt(2)*cos(15)+dSl/2*cos(30);
//vy=vp[1]+(lCov+lBos)*0.5*sin(30)+dSl*sqrt(2)*sin(15)-dSl/2*sin(30);

/**TSLOT**/

module ts204(e=0){
	//e=alowance.If e>0 smaller, e<0 bigger
	vAt=[0,90,45,0,270,0,270];
	vLt=[4+e,
		3-e/tan(67.5),
		3*sqrt(2)-2*e/tan(67.5),
		1-e/tan(67.5)-e/tan(45),
		3,
		2+sol+e,
		3+sol-e];	
	//color("red")testPoints(vLen=vLt,vAng=vAt);
	pointsT=[sumP(vLt,vAt,0),sumP(vLt,vAt,1),sumP(vLt,vAt,2),sumP(vLt,vAt,3),sumP(vLt,vAt,4),sumP(vLt,vAt,5),sumP(vLt,vAt,6)];
	translate([-e,0,0]) {
		polygon(points=pointsT);
		mirror([0,1,0]) polygon(points=pointsT);
	}
}




module ts20(v=[0,1,2,3],e=0){
	//Vector for translate allowance
	vTrs=[[10+2*e,10],[10,10+2*e],[10-e,10],[10,10-e]];
	difference(){
		square([20+e,20+e]);
		//translate([10-e*0,10+e*2,0])
		for(i=v){			
			translate(vTrs[i])	rotate(90*i) ts204(e=e);
			//echo(vTrs[i]);
		}
	}
}

//v=0,x+2*e		v=1,y+2*e		v=2,x-e		v=3,y-e
/*ts20();
%translate([-0.5/2*1,-0.5/2*1])ts20(e=0.5);*/
//Distancia entre 2 puntos (modulo vector)
function vModP(v1,v2)=sqrt(pow(v2[0]-v1[0],2)+pow(v2[1]-v1[1],2));
function vMod0(vP=[0,0])=sqrt(pow(vP[0],2)+pow(vP[1],2));
function vAng(vP=[0,0])=acos(vP[0]/vMod(vP));
//echo(vAng(vP=[0,1]));
