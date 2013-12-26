include <3DRaux.scad>

top_ele();

module top(){
	difference(){
		linear_extrude(height=hTop)auxbase();
		translate([tTop,0,tTop-3])
			linear_extrude(height=hTop+sol)auxbase(tTop);
	}	
}


vLT=[tTop,dSlot,2.5,5,32.5];
module tslot_guide(){
	xts=dSlot+tTop+7;
	yts=2*dSlot;	
	intersection(){
		translate([0,-yts,0])
			cube([sumV(v=vLT,i=3),4*dSlot,hTop]);
		linear_extrude(height=hTop+sol)auxbase();
	}	
	translate([sumV(v=vLT,i=3),dBea-6,0])
		cube([tTop,12,hTop]);
	translate([sumV(v=vLT,i=3),-dBea-6,0])
		cube([tTop,12,hTop]);
	translate([sumV(v=vLT,i=3),-15,0])
		cube([vLT[4],30,tTop+1]);
	translate([sumV(v=vLT,i=4),-3,0])
		cube([sumX(vL,vAn,4)-sumV(v=vLT,i=4)-sol,6,tTop+1]);
}
module tslo_h(){
	if(slot_ty=="tslot"){
		difference(){	
			linear_extrude(height=hTop+3) ts20(v=[1,3]);
			translate([0,dSlot/2-3,-sol]) cube([6,6,hTop-15]);			
		}
	}
}
//Modulo para definir los agujero centrales
module cent_hole(h,t){
	translate([vgx,0,0])
	for(i=[4:5]){
		rotate([0,0,i*360/9])
			translate([vgx-sumV(v=vLM,i=4)-nemL,0,h])	
				rotate([0,-90,0])		
					cylinder(r=M4r,h=2*t);
	}
}

module endstop_sup(){
if(endstop_ty=="hall") hall_endstop();
}

module union_h(r=M3r,h=hTop/2){
	translate([24+4*dSlot/5,dBea+10,0])
		cylinder(r=r,h=h);
}

module top_ele_nh(){
	top();
	tslot_guide();
	union_h(r=2*M3r);
	mirror([0,1,0]) union_h(r=2*M3r);
	intersection(){
		translate([0,0,-sol])
			linear_extrude(height=hTop+2*sol) auxbase();
		translate([vgx,0,0])
			cylinder(r=vgx-sumV(v=vLM,i=4)-nemL,h=hTop);
	}	
}
module top_ele(){
	difference(){
		top_ele_nh();
		auxHole(num=2,tra=rCov/4,ra=M4r,hh=hTopHol);		
		auxHole(num=2,tra=3*rCov/4,ra=M4r,hh=hTopHol);
		auxHole(num=3,tra=lBos/4,ra=M4r,hh=hTopHol);
		auxHole(num=6,tra=rCov/4,ra=M4r,hh=hTopHol);
		auxHole(num=6,tra=3*rCov/4,ra=M4r,hh=hTopHol);
		translate([-sol,0,9]) rotate([0,90,0]) 
			cylinder(r=M5r,h=tTop+2*sol);		
		translate([tTop,-10,-2*sol]) tslo_h();
		translate([sumV(v=vLT,i=2),-dBea,-sol])
			cylinder(r=rRod,h=hTop+2*sol);
		translate([sumV(v=vLT,i=2),dBea,-sol])
			cylinder(r=rRod,h=hTop+2*sol);
		translate([sumV(v=vLT,i=2),-10,-2*sol])
			cube([16.5,20,hTop+4*sol]);
		translate([sumV(v=vLT,i=3)+tTop+sol,-dBea,hTop/2])
			rotate([0,-90,0])cylinder(r=M4r,h=tTop+rRod+2*sol);
		translate([sumV(v=vLT,i=3)+tTop+sol,dBea,hTop/2])
			rotate([0,-90,0])cylinder(r=M4r,h=tTop+rRod+2*sol);
		translate([sumV(v=vLT,i=2)+tTop+sol,-dBea-7/2,hTop/2-7])
			cube([4,7,hTop]);
		translate([sumV(v=vLT,i=2)+tTop+sol,dBea-7/2,hTop/2-7])
			cube([4,7,hTop]);
		translate([vgx,0,-5*sol])
			cylinder(r=vgx-sumV(v=vLM,i=4)-nemL-tTop,h=hTop+10*sol);
		cent_hole(h=(hTop+tTop)/2,t=tTop);
		translate([0,0,-sol])
			union_h(r=M3r,h=hTop/2+2*sol);
		translate([0,0,-sol])
			mirror([0,1,0]) union_h(r=M3r,h=hTop/2+2*sol);
	}
	if(endstop_ty=="hall")
		translate([sumV(v=vLT,i=2)+16.5,-28.3/2+sol,tTop+1])
			hall_endstop();
}

module hall_endstop(){
	x=21;
	y=28.3;
	z=9.1+6.95*cos(70);	
	difference(){
		cube([x,y,z]);
		translate([0,-sol,9.1]) rotate([0,-70,0])
			cube([3,y+2*sol,1]);
		translate([23.45,-sol,0]) rotate([0,20,0])
			cube([3,y+2*sol,z]);
		translate([1,-sol,z]) rotate([0,10,0])
			cube([x,y+2*sol,z]);
		translate([2,1-sol,z-2]) rotate([0,10,0])
			cube([x,y-2,z]);
		translate([5.5,4,2]) rotate([0,10,0])
			cylinder(r=M3r,h=z);
		translate([5.5,y-4,2]) rotate([0,10,0])
			cylinder(r=M3r,h=z);
	}

}

