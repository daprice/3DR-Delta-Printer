module wireTiedown(size=15) {
	leg(height=size/3 * 2);
	translate([size+8,0,0])
		mirrorLeg(height=size/3 * 2);
	translate([5, 4, size/3 * 2 - 2])
		cube([size+6, 4, 2]);


	module leg(height) {
		hull() {
			cube([8, 10, 0.000001]);
			translate([5, 4, height])
				cube([3, 4, 0.0000001]);
		}
	}

	module mirrorLeg(height) {
		translate([8,0,0])
			mirror([1,0,0])
				leg(height=height);
	}
}

module wireTiedownCentered(size=15) {
	translate([(-16 - size) / 2, -14 / 2, 0])
		wireTiedown(size=size);
}
