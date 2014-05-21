include <3DRaux.scad>
use <nema.scad>
use <3DR_Bed_Sup.scad>
use <lib/MCAD/teardrop.scad>

bot_mot();

module botton(){
	difference(){
		linear_extrude(height=hB)auxbase();
		translate([tBas,0,tBas])
			linear_extrude(height=hB+sol)auxbase(tBas);
	}
}

module bslot_guide(){	
	intersection(){
		translate([-tBas,-dSlot/2-tBas,0])
			cube([dSlot+7+tBas,dSlot+tBas*2,hBas]);
		linear_extrude(height=hBas+sol)auxbase();
	}
}

module bslo_h(e=kSlot){
	if(slot_ty=="tslot"){
		difference(){	
			linear_extrude(height=hBas+3) ts20(v=[1,3],e=e);
			translate([0,dSlot/2-3+e/2,-sol])
				cube([6-e,6-e,hBas-38]);
			translate([dSlot/2+e*2,dSlot/2,0])
				linear_extrude(height=hBas-8) ts204(e=e);
		}
	}
}


//vLM=[tBas,dSlot,2.5,16.5,7,1.5,4];
module motor_guide(){
	translate([sumV(v=vLM,i=2),-dSlot/2-tBas,hBas-10])
		cube([vLM[3],dSlot+tBas*2,10]);
	translate([sumV(v=vLM,i=3),-23,0]) cube([vLM[4],46,hBas]);
	translate([sumV(v=vLM,i=4),-23,0]) cube([vLM[5],46,tBas+23]);
	translate([sumV(v=vLM,i=5),-23,0]) cube([vLM[6],46,tBas+4]);
	translate([sumV(v=vLM,i=6),-2,0]) 
		cube([sumX(vL,vAn,4)-sumV(v=vLM,i=6)-tBas/2,4,tBas+4]);
}

module brod_guide(r=rRod+2,h=hB,ang=-60){	
	inc=r;
	vLs=[r,r*sqrt(3)+inc/cos(30),2*(r*sqrt(3)+inc*tan(30)),r*sqrt(3)+inc/cos(30)];
	vAs=[60,150,270,30];	
	points=[sumP(vLs,vAs,0),sumP(vLs,vAs,1),sumP(vLs,vAs,2),sumP(vLs,vAs,3)];
	intersection(){
		linear_extrude(height=h) auxbase();
		translate([sumV(v=vLM,i=2),dBea,0]) rotate(ang) union(){
			linear_extrude(height=h) polygon(points=points);
			cylinder(r=r,h=h);
		}
	}			
}

module hbed_guide(r=M3r,h=hB){		
	translate([vgx,0,0]) for(i=[0:2]){	
		rotate(120*i) {
			translate([lhb/2,lhb/2,0])cylinder(r=r,h=h);
			translate([lhb/2,-lhb/2,0])cylinder(r=r,h=h);
			translate([-lhb/2,lhb/2,0])cylinder(r=r,h=h);
			translate([-lhb/2,-lhb/2,0])cylinder(r=r,h=h);
		}	
	}
}

module hbed_sup(r=M3r,h=tBas+4.5){	
	intersection(){
		linear_extrude(height=hB)auxbase();
		hbed_guide(r=r,h=h);
	}
}

module bot_mot_nh(){
	botton();
	bslot_guide();
	motor_guide();
	if(useRod) {
		brod_guide(r=lCov/27);
		mirror([0,1,0]) brod_guide(r=lCov/27);
	}
	if(hbed) hbed_sup(r=4,h=tBas+4.5);
}


module bot_mot(){
	difference(){
		bot_mot_nh();
		auxHole(num=2,tra=rCov/4,ra=M4r,hh=hBasHol);
		auxHole(num=2,tra=3*rCov/4,ra=M4r,hh=hBasHol);
		auxHole(num=3,tra=lBos/4,ra=M4r,hh=hBasHol);
		auxHole(num=6,tra=rCov/4,ra=M4r,hh=hBasHol);
		auxHole(num=6,tra=3*rCov/4,ra=M4r,hh=hBasHol);
		translate([sumV(v=vLM,i=3)-sol+5,0,30])
			teardrop(radius=15,length=10,angle=90);
		//translate([sumV(v=vLM,i=2)-2,0,30])rotate([0,90,0])
		translate([sumV(v=vLM,i=2)-1.5,0,30])rotate([0,90,0])
			cylinder(r=11,h=2+sol);
		translate([-sol-tBas,0,32]) rotate([0,90,0]) {
			cylinder(r=M5r,h=2*tBas+2*sol);
			cylinder(r=M5r + 4, h=3);
		}
		translate([tBas,-10,-2*sol])
			bslo_h(e=kSlot);
		
		if(useRod) {
			translate([sumV(v=vLM,i=2),-dBea,-sol])
				cylinder(r=rRod,h=hB-rRod);
			translate([sumV(v=vLM,i=2),dBea,-sol])
				cylinder(r=rRod,h=hB-rRod);
		}
		translate([sumV(v=vLM,i=2),-10,-sol])
			cube([vLM[3],20,tBas+2*sol]);
		translate([60+sol,0,31]) rotate([0,-90,0])
			nemcov(dc=-15.5,lh=60,num=[0,3]);
		translate([60+sol,0,31]) rotate([0,-90,0])
			nemcov(dc=-15.5,lh=10,num=[1,2]);
			//nemcov(dc=-15.5,lh=50);
		translate([sumV(v=vLM,i=2)-3,-4,hBas-8]) cube([27,8,6]);
		if(hbed) {
			translate([0,0,-sol]) hbed_guide(r=M3r,h=hB+2*sol);
			translate([-2*tBas*cos(120),-2*tBas*sin(120)]) bed_sup_h();
			mirror([0,1,0]) translate([-2*tBas*cos(120),-2*tBas*sin(120)])
				bed_sup_h();
		}
	}		
}









