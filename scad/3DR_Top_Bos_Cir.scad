include <3DRAux.scad>
include <3DRAux2.scad>
//Uncomment
top_bos_cir();
vtr=0;

module cylh(re=4,ri=1.5,h=hT){
	difference(){
		cylinder(r=re,h=h);
		translate([0,0,-sol]) cylinder(r=ri,h=h+2*sol);
	}
}
module c_guide(vLEle=vLRamps,re=4,ri=M3r,h=hT){	
	translate([vgx,0,0])  {
		translate([vLEle[0][0],vLRamps[0][1],0])
			cylh(re=re,ri=ri,h=h);
		translate([vLEle[1][0],vLRamps[1][1],0])
			cylh(re=re,ri=ri,h=h);
		translate([vLEle[2][0],vLRamps[2][1],0])
			cylh(re=re,ri=ri,h=h);
		translate([vLEle[3][0],vLRamps[3][1],0])
			cylh(re=re,ri=ri,h=h);
	}	
}
module bolt(h){
	cylinder(r=M3nr/2,h=M3h,$fn=6);
	translate([0,0,M3h])
		cylinder(r=M3r,h=h);
}

module c_bolt(vLEle=vLRamps,h=hT){
	translate([vgx,0,0])  {
		translate([vLEle[0][0],vLRamps[0][1],0])
			bolt(h=h);
		translate([vLEle[1][0],vLRamps[1][1],0])
			bolt(h=h);
		translate([vLEle[2][0],vLRamps[2][1],0])
			bolt(h=h);
		translate([vLEle[3][0],vLRamps[3][1],0])
			bolt(h=h);
	}
}
module top_bos_cir_nh(){
	difference(){
		translate([vgx,0,0])
			cylinder(r=vgx-sumV(v=vLM,i=4)-nemL-tTop,h=hTop);
		translate([vgx,0,tTop])
			cylinder(r=vgx-sumV(v=vLM,i=4)-nemL-2*tTop,h=hTop);
	}
	if(elec_ty=="RAMPS")c_guide(h=hTop/2);
}
module top_bos_cir(){
	difference(){
		top_bos_cir_nh();
		cent_hole(h=(hTop+tTop)/2,t=tTop+5*sol);
		translate([0,0,-sol])
			if(elec_ty=="RAMPS") c_bolt(h=hTop/2+2*sol);
	}
}


