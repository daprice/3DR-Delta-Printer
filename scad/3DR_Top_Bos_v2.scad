include <3DRAux.scad>
include <3DRAux2.scad>

//If bot_mot_v2 num_h=7,bot_mot_v3 num_h=8
num_h=7;
top_bos_cir();
vtr=0;

module cylh(re=4,ri=1.5,h=hT){
	difference(){
		cylinder(r=re,h=h);
		translate([0,0,-sol]) cylinder(r=ri,h=h+2*sol);
	}
}
module c_guide(re=4,ri=M3r,h=hT){	
	translate([vgx,0,0]) for(i=[0:len(vLEle)-1]) {
		translate([vLEle[i][0],vLEle[i][1],0])
			cylh(re=re,ri=ri,h=h);		
	}	
}
module bolt(h){
	cylinder(r=M3nr/2,h=M3h,$fn=6);
	translate([0,0,M3h])
		cylinder(r=M3r,h=h);
}

module c_bolt(h=hT){
	translate([vgx,0,0]) for(i=[0:len(vLEle)-1]) {
		translate([vLEle[i][0],vLEle[i][1],0])
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
	c_guide(h=2*hTop/3);
}
module top_bos_cir(){
	difference(){
		top_bos_cir_nh();
		cent_hole(h=(hTop+tTop)/2,t=tTop+5*sol,n=num_h);
		translate([0,0,-sol])
			c_bolt(h=hTop/2+2*sol+4);
	}
}


