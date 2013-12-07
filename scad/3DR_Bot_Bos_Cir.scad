include <3DRAux.scad>
include <3DRAux2.scad>

module bot_bos_cir(){
	difference(){
		translate([vgx,0,0])
			cylinder(r=vgx-sumV(v=vLM,i=4)-nemL-tBas,h=hB);
		translate([vgx,0,tBas])
			cylinder(r=vgx-sumV(v=vLM,i=4)-nemL-2*tBas,h=hB);
		cent_hole(h=(hB+tBas)/2,t=tBas+5*sol);
	}
}
bot_bos_cir();
