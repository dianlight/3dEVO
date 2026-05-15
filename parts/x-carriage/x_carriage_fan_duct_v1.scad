// Part: X-Carriage Fan Duct / Shroud (Layer 3)
// Version: v1
// Process: 3D Print - PLA White - Standard profile
// Description: Heatsink cooling fan mount + part cooling duct with bifurcated nozzle output

include <../lib/fasteners.scad>
include <../lib/common.scad>

/* --- Parameters --- */

// Fan dimensions (3010 = 30x30x10mm)
fan_size = 30;
fan_thickness = 10;
fan_screw_spacing = 24;     // M3 hole spacing on 3010 fan
fan_screw_dia = 3.2;        // clearance for M3 self-tap into plastic

// XCR3D heatsink geometry (for duct alignment)
heatsink_width = 30;
heatsink_depth = 18;        // fin direction
heatsink_height = 42;

// Nozzle position (relative to heatsink top)
nozzle_offset_z = -61.6;   // below heatsink top

// Part cooling duct
duct_outlet_width = 20;     // width of air stream at nozzle
duct_outlet_height = 3;     // thin slot for focused airflow
duct_wall = 1.5;            // thin walls for duct (printable)
duct_nozzle_gap = 3;        // distance from duct exit to nozzle tip

// Mounting
mount_bolt_spacing = 24;    // M2.5 to hotend plate
mount_thickness = 3;

// Shroud body
shroud_width = 40;          // slightly wider than heatsink for airflow
shroud_height = 50;         // covers heatsink + extends to nozzle level
shroud_depth = fan_thickness + heatsink_depth + 4; // fan + gap + heatsink

/* --- Resolution --- */
$fn = $preview ? 24 : 96;

/* --- Modules --- */

module fan_mount_plate() {
    // Flat plate with 4 corner holes for 3010 fan
    difference() {
        // Plate sized to fan
        translate([0, 0, 0])
            cube([fan_size + 4, fan_size + 4, mount_thickness], center = true);

        // Fan opening (circular)
        cylinder(d = 28, h = mount_thickness + 2, center = true);

        // Screw holes
        half = fan_screw_spacing / 2;
        for (x = [-half, half], y = [-half, half])
            translate([x, y, 0])
                cylinder(d = fan_screw_dia, h = mount_thickness + 2, center = true);
    }
}

module heatsink_fan_shroud() {
    // Channel that directs fan air onto heatsink fins
    difference() {
        // Outer shell
        hull() {
            // Fan side (back)
            translate([0, -shroud_depth/2 + mount_thickness, heatsink_height/4])
                cube([fan_size + 4, mount_thickness, heatsink_height/2], center = true);
            // Heatsink side (front) - narrows to match fin area
            translate([0, shroud_depth/2 - 2, heatsink_height/4])
                cube([heatsink_width + 2, 2, heatsink_height/2], center = true);
        }
        // Inner air channel
        hull() {
            translate([0, -shroud_depth/2 + mount_thickness + 1, heatsink_height/4])
                cube([fan_size - 2, 1, heatsink_height/2 - 4], center = true);
            translate([0, shroud_depth/2 - 3, heatsink_height/4])
                cube([heatsink_width - 2, 1, heatsink_height/2 - 4], center = true);
        }
    }
}

module part_cooling_duct_half() {
    // One side of bifurcated part cooling duct
    // Transitions from circular fan output to thin rectangular slot at nozzle
    hull() {
        // Inlet (from fan area, circular cross-section)
        translate([0, 0, 0])
            cylinder(d = 12, h = duct_wall);
        // Outlet (thin slot near nozzle)
        translate([0, shroud_depth/2 + 5, nozzle_offset_z + heatsink_height + duct_nozzle_gap])
            cube([duct_outlet_width/2, duct_wall, duct_outlet_height], center = true);
    }
}

module part_cooling_duct() {
    // Bifurcated duct: splits from single fan into two outlets flanking the nozzle
    difference() {
        union() {
            // Left duct arm
            translate([-duct_outlet_width/4, 0, 0])
                part_cooling_duct_half();
            // Right duct arm
            translate([ duct_outlet_width/4, 0, 0])
                part_cooling_duct_half();
            // Fan mount at top (for part cooling fan)
            translate([0, -shroud_depth/2, heatsink_height/2 + fan_size/2 + 5])
                rotate([90, 0, 0])
                    fan_mount_plate();
        }
        // Hollow out the ducts (inner channel)
        union() {
            translate([-duct_outlet_width/4, 0, 0])
                scale([0.85, 0.85, 1])
                    part_cooling_duct_half();
            translate([ duct_outlet_width/4, 0, 0])
                scale([0.85, 0.85, 1])
                    part_cooling_duct_half();
        }
    }
}

module mounting_tabs() {
    // Tabs with M2.5 holes to attach to hotend plate
    tab_w = 8;
    tab_h = 12;
    tab_t = mount_thickness;

    // Left tab
    translate([-shroud_width/2 + tab_w/2, -shroud_depth/2, heatsink_height/2]) {
        difference() {
            cube([tab_w, tab_t, tab_h], center = true);
            cylinder(d = 2.7, h = tab_t + 2, center = true);
        }
    }
    // Right tab
    translate([ shroud_width/2 - tab_w/2, -shroud_depth/2, heatsink_height/2]) {
        difference() {
            cube([tab_w, tab_t, tab_h], center = true);
            cylinder(d = 2.7, h = tab_t + 2, center = true);
        }
    }
}

module fan_duct_assembly() {
    // Heatsink fan mount (back face, blowing onto fins)
    translate([0, -shroud_depth/2, heatsink_height/4])
        rotate([90, 0, 0])
            fan_mount_plate();

    // Air channel from fan to heatsink
    heatsink_fan_shroud();

    // Mounting tabs
    mounting_tabs();
}

/* --- Render --- */
fan_duct_assembly();

// For visualization: uncomment to see fan and hotend ghost
// %translate([0, -shroud_depth/2 - fan_thickness/2, heatsink_height/4])
//     rotate([90, 0, 0])
//         cube([fan_size, fan_size, fan_thickness], center = true);
