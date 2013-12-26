function sumV(v,i,s=0) = (i==s ? v[i] : v[i] + sumV(v,i-1,s));
function sumX(vL,vA,i,s=0)= (i==s ? vL[i]*cos(vA[i]) : vL[i]*cos(vA[i]) + sumX(vL,vA,i-1,s));
function sumY(vL,vA,i,s=0)= (i==s ? vL[i]*sin(vA[i]) : vL[i]*sin(vA[i]) + sumY(vL,vA,i-1,s));
function sumP(vL,vA,i)=[sumX(vL,vA,i),sumY(vL,vA,i)];
function vMod(v1,v2=[0,0])=sqrt(pow(v2[0]-v1[0],2)+pow(v2[1]-v1[1],2));
function vAng(vP=[0,0])=acos(vP[0]/vMod(vP));
function vAng2(v1,v2=[0,0])=acos((v2[0]-v1[0])/vMod(v1,v2));
function vAng3(v1,v2=[1,0])=acos((v2[0]*v1[0]+v2[1]*v1[1])/(vMod(v1)*vMod(v2)));
function AngVsX(v)=v[0]/vMod(v);
function AngVsY(v)=v[1]/vMod(v);
function Vec(p1,p2)=[p2[0]-p1[0],p2[1]-p1[1]];
function AngV(v)=(AngVsX(v)>0
				? AngVsY(v)>0 ? acos(AngVsX(v)) : -acos(AngVsX(v))+360
				: AngVsY(v)>0 ? acos(AngVsX(v)) : -acos(AngVsX(v))+360 );


module testPoints(vLen,vAng){
	for(i=[0:len(vLen)-1]){
		translate([sumP(vLen,vAng,i)[0],sumP(vLen,vAng,i)[1]]) circle(1);
	}
}

//testPoints(vLen=vLTest,vAng=vAnTest);
$fn=100;



module polyL(p,vArc,dArc){		
	difference(){
		union(){
			polygon(points=p);
			for(i=[0:len(p)-1]) if(vArc[i]>0){
			//for(i=[7:7]) if(vArc[i]>0){
				if (i<len(p)-1)assign(p1=p[i],p2=p[i+1]){	
					addArc(p1=p1,p2=p2,l=vMod(p1,p2),h=vArc[i],d=dArc[i]);		
				}		
				if (i==len(p)-1)assign(p1=p[i],p2=p[0]){
					addArc(p1=p1,p2=p2,l=vMod(p1,p2),h=vArc[i],d=dArc[i]);
				}		
			}
		}
		for(i=[0:len(p)-1]) if(vArc[i]<0){		
			if (i<len(p)-1)assign(p1=p[i],p2=p[i+1]){	
				delArc(p1=p1,p2=p2,l=vMod(p1,p2),h=-vArc[i],d=dArc[i]);
			}		
			if (i==len(p)-1)assign(p1=p[i],p2=p[0]){
				delArc(p1=p1,p2=p2,l=vMod(p1,p2),h=-vArc[i],d=dArc[i]);
			}		
		}		
	}	
}

module addArc(p1,p2,l,h,d){
	d2=(d!=undef?d:0);	
	l2=l+abs(d2);
	rArc=l2*l2/(8*h)+h/2;
	angArc=2*asin(l2/(2*rArc));
	cX=p1[0]+rArc*cos(angArc/2);
	cY=p1[1]+rArc*sin(angArc/2);
	vec=[p2[0]-p1[0],p2[1]-p1[1]];	
	ang=AngV(Vec(p1,p2));
	angP1=AngV(Vec([0,0],p1));
	angP2=AngV(Vec([0,0],p2));
	ccw=(angP1>angP2||ang==270?0:1);
	s=(ccw==0?
		(ang>90&&ang<=270?0.01:-0.01):
		(ang>90&&ang<=270?-0.01:0.01));	
	translate([p1[0]+l*cos(ang)/2,s+p1[1]+l*sin(ang)/2]){	
		rotate([0,0,-ccw*180+ang]){
			intersection(){
				translate([-l/2,0]) square([l,h]);				
				translate([d2/2,h-rArc]) circle(r=rArc);				
			}
		}
	}	
}

module delArc(p1,p2,l,h,d){
	d2=(d!=undef?d:0);	
	l2=l+d2;
	rArc=l2*l2/(8*h)+h/2;
	//rArc=l*l/(8*h)+h/2;
	angArc=2*asin(l2/(2*rArc));
	cX=p1[0]+rArc*cos(angArc/2);
	cY=p1[1]+rArc*sin(angArc/2);
	vec=[p2[0]-p1[0],p2[1]-p1[1]];	
	ang=AngV(Vec(p1,p2));
	angP1=AngV(Vec([0,0],p1));
	angP2=AngV(Vec([0,0],p2));
	ccw=(angP1>angP2||ang==270?-1:0);
	s=(ccw==-1?
		(ang>90&&ang<=270?-0.01:0.01):
		(ang>90&&ang<=270?0.01:-0.01));
	translate([p1[0]+l2*cos(ang)/2,p1[1]+l2*sin(ang)/2+2*s]){
		rotate([0,0,ang+180*ccw]){
			intersection(){
				translate([-l2/2,0]) square([l2,h]);
				translate([0,h-rArc]) circle(r=rArc);
			}
		}
	}
}

/*		//EJEMPLO//
lCov=160;
rCov=lCov/sqrt(3);
dSl=lCov/6;
lBos=lCov/2;
rBos=lBos/sqrt(3);
rp=2*lBos/3-rBos;

//Longitud de los lados del poligono
vL=[dSl/2, dSl*sqrt(2), (lCov+lBos)/2, rCov, lBos/2-rp, rp, lBos/2-rp, rCov, (lCov+lBos)/2, dSl*sqrt(2)];
//Angulos del poligono
vAn=[90,45,30,300,210,270,330,240,150,135];
//Vector con las alturas de los casquetes
vR=[ 1 , 0,  -5, 0, 0, 0, -10, 5, 1, 5];
vDR=[0 , 0, -5];//, 0, 0, 0,   0, 0, 0, 0];

//Modulo para el poligono.Parametro:
//e=espesor de la pared,cuantos mm menor sera el poligono
module tbase(e=0){
	//Nuevo vector de longitudes,teniendo en cuenta el espesor
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
	//Si se quiere testar los puntos,descomentar
	//testPoints(vLen=vLe,vAng=vAn);
	//Como ya he comentado,OpenScad no permite vectores dinamicos
	points=[sumP(vLe,vAn,0),sumP(vLe,vAn,1),sumP(vLe,vAn,2),sumP(vLe,vAn,3),sumP(vLe,vAn,4),sumP(vLe,vAn,5),sumP(vLe,vAn,6),sumP(vLe,vAn,7),sumP(vLe,vAn,8),sumP(vLe,vAn,9)];
	//Llamada a polyL
	polyL(p=points,vArc=vR,dArc=vDR);
	
}

//Creacion del poligono con un espesor de pared=t
module dif(t){
	$fn=150;
	difference(){
		tbase();
		translate([t,0,0]) tbase(t);
	}
}
//Extrusion del poligono,altura 25
//linear_extrude(height=25)dif(t=2);*/



