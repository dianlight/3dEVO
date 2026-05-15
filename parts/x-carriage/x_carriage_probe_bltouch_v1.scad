// Part: X-Carriage Probe Adapter - BLTouch
// Version: v1
// Process: 3D Print - PLA Black - Standard profile
// Description: Adapter bracket to mount BLTouch on hotend plate probe slot

include <../lib/fasteners.scad>

/* --- Parameters --- */

// BLTouch dimensions
bltouch_body_width = 11.5;
bltouch_body_depth = 13;
bltouch_body_height = 37;   // including pin stroke
bltouch_mount_spacing = 18; // M3 holes center-to-center
bltouch_mount_bolt = 3;

// Nozzle offset (BLTouch probe tip relative to nozzle)
// X-offset depends on mounting side; adjust for your setup
probe_x_offset = 30;        // mm to the right of nozzle center
probe_y_offset = 0;         // in line with nozzle (Y)

// Interface to hotend plate (2x M3 on right side, 18mm spacing)
plate_bolt_spacing = 18;
plate_bolt_size = 3;

// Bracket dimensions
bracket_width = 16;
bracket_height = 40;
bracket_thickness = 4;
arm_length = 20;            // horizontal reach from plate to BLTouch center

/* --- Resolution --- */
$fn = $preview ? 32 : 128;

/* --- Modules --- */

module bltouch_adapter() {
    difference() {
        union() {
            // Vertical mounting face (bolts to hotend plate)
            translate([0, 0, 0])
                cube([bracket_thickness, bracket_width, bracket_height], center = true);

            // Horizontal arm extending to BLTouch position
            translate([arm_length/2, 0, bracket_height/2 - bracket_thickness/2])
                cube([arm_length + bracket_thickness, bracket_width, bracket_thickness], center = true);

            // BLTouch vertical mount tab (at end of arm)
            translate([arm_length, 0, bracket_height/2 - bracket_thickness - bltouch_body_height/4])
                cube([bracket_thickness, bracket_width, bltouch_body_height/2], center = true);
        }

        // Plate mounting holes (2x M3 vertical on mounting face)
        translate([0, 0, 0]) {
            translate([0, 0, -plate_bolt_spacing/2])
                rotate([0, 90, 0])
                    cylinder(d = 3.4, h = bracket_thickness + 2, center = true);
            translate([0, 0,  plate_bolt_spacing/2])
                rotate([0, 90, 0])
                    cylinder(d = 3.4, h = bracket_thickness + 2, center = true);
        }

        // BLTouch mounting holes (2x M3, 18mm spacing, on vertical end tab)
        translate([arm_length, 0, bracket_height/2 - bracket_thickness - bltouch_body_height/4]) {
            translate([0, -bltouch_mount_spacing/2, 0])
                rotate([0, 90, 0])
                    cylinder(d = 3.4, h = bracket_thickness + 2, center = true);
            translate([0,  bltouch_mount_spacing/2, 0])
                rotate([0, 90, 0])
                    cylinder(d = 3.4, h = bracket_thickness + 2, center = true);
        }

        // BLTouch body clearance hole (pin needs to extend below)
        translate([arm_length, 0, bracket_height/2 - bracket_thickness])
            cylinder(d = bltouch_body_width + 1, h = bracket_thickness + 2, center = true);
    }
}

/* --- Render --- */
bltouch_adapter();
