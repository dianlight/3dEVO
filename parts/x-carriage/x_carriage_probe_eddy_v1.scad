// Part: X-Carriage Probe Adapter - BIGTREETECH Eddy Duo
// Version: v1
// Process: 3D Print - PLA Black - Standard profile
// Description: Adapter bracket to mount BTT Eddy Duo on hotend plate probe slot

include <../lib/fasteners.scad>

/* --- Parameters --- */

// BTT Eddy Duo dimensions
eddy_pcb_diameter = 24;     // circular PCB
eddy_sensing_diameter = 20; // active sensing area
eddy_pcb_thickness = 1.6;
eddy_mount_spacing = 28;    // M3 mounting holes (on arms extending from PCB)
eddy_mount_bolt = 3;
eddy_total_height = 8;      // PCB + components + connector clearance above

// Required: sensing coil must be 1-3mm above bed at probe height
// Nozzle-to-probe-tip offset: probe surface should be ~2mm above nozzle tip
probe_z_offset = 2;         // probe face this many mm above nozzle tip

// Interface to hotend plate (2x M3 on right side, 18mm spacing)
plate_bolt_spacing = 18;
plate_bolt_size = 3;

// Bracket dimensions
bracket_width = 16;
bracket_height = 35;
bracket_thickness = 4;
arm_length = 22;            // horizontal reach to clear hotend body

/* --- Resolution --- */
$fn = $preview ? 32 : 128;

/* --- Modules --- */

module eddy_adapter() {
    difference() {
        union() {
            // Vertical mounting face (bolts to hotend plate)
            cube([bracket_thickness, bracket_width, bracket_height], center = true);

            // Horizontal arm extending to Eddy position
            translate([arm_length/2, 0, -bracket_height/2 + bracket_thickness/2])
                cube([arm_length + bracket_thickness, bracket_width, bracket_thickness], center = true);

            // Eddy mount ring (at end of arm, holds PCB from below)
            translate([arm_length, 0, -bracket_height/2 + bracket_thickness + eddy_total_height/2])
                cylinder(d = eddy_pcb_diameter + 6, h = eddy_total_height, center = true);
        }

        // Plate mounting holes (2x M3)
        translate([0, 0, 0]) {
            translate([0, 0, -plate_bolt_spacing/2])
                rotate([0, 90, 0])
                    cylinder(d = 3.4, h = bracket_thickness + 2, center = true);
            translate([0, 0,  plate_bolt_spacing/2])
                rotate([0, 90, 0])
                    cylinder(d = 3.4, h = bracket_thickness + 2, center = true);
        }

        // Eddy PCB pocket (circular recess to hold PCB)
        translate([arm_length, 0, -bracket_height/2 + bracket_thickness + eddy_total_height/2])
            cylinder(d = eddy_pcb_diameter + 0.5, h = eddy_pcb_thickness + 0.5, center = true);

        // Sensing area opening (below PCB - must be clear for eddy current)
        translate([arm_length, 0, -bracket_height/2])
            cylinder(d = eddy_sensing_diameter + 2, h = bracket_thickness + 2, center = true);

        // Eddy mounting screws (2x M3 on the PCB arms)
        translate([arm_length, 0, -bracket_height/2 + bracket_thickness + eddy_total_height/2]) {
            translate([0, -eddy_mount_spacing/2, 0])
                cylinder(d = 3.4, h = eddy_total_height + 2, center = true);
            translate([0,  eddy_mount_spacing/2, 0])
                cylinder(d = 3.4, h = eddy_total_height + 2, center = true);
        }

        // Cable exit slot
        translate([arm_length - eddy_pcb_diameter/2, 0, -bracket_height/2 + bracket_thickness + eddy_total_height])
            cube([8, 6, 4], center = true);
    }
}

/* --- Render --- */
eddy_adapter();
