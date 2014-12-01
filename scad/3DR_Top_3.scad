include <3DRaux.scad>
use <3DR_Top_Ele.scad>

3DR_Top_Ext_Mount();

module 3DR_Top_Ext_Mount() {
	extruder_bolt_spacing = 32;

	difference() {
		union() {
			top_ele();
			translate([30,30,0]) rotate([0,0,36]) {
				cube([extruder_bolt_spacing + 10,10,hTop]);
			}
			mirror([0,1,0]) translate([30,30,0]) rotate([0,0,36]) {
				cube([extruder_bolt_spacing + 10,10,hTop]);
			}
		}
		translate([30,30,0]) rotate([0,0,36]) {
			rotate([90,0,0]) {
				translate([5,hTop/2,-6]) cylinder(d=5.2,h=15,center=true);
				translate([5+extruder_bolt_spacing,hTop/2,-6]) cylinder(d=5.2,h=15,center=true);
			}
		}
		mirror([0,1,0]) translate([30,30,0]) rotate([0,0,36]) {
			rotate([90,0,0]) {
				translate([5,hTop/2,-6]) cylinder(d=5.2,h=15,center=true);
				translate([5+extruder_bolt_spacing,hTop/2,-6]) cylinder(d=5.2,h=15,center=true);
			}
		}
	}
}
