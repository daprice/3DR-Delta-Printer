include <3DRAux.scad>
use <lib/Printable_Cheapskate/src/carriage_arm_mount.scad>

rotate([180,0,0]) carriage_arm_mount(mount_w=16, arm_spacing=xJS, mount_hole_size=3);
