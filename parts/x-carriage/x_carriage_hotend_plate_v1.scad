// Part: X-Carriage Hotend Plate (Layer 2)
// Version: v1
// Process: 3D Print - PLA Black - Structural profile
// Description: Mounts XCR3D 2IN1-S1 hotend, provides probe and ADXL345 attachment points

include <../lib/fasteners.scad>
include <../lib/common.scad>

/* --- Parameters --- */

// XCR3D 2IN1-S1 hotend dimensions
hotend_width = 30;          // X dimension
hotend_depth = 18;          // Y dimension (fin direction)
hotend_height_total = 61.6; // total height top to nozzle
hotend_heatsink_h = 42;     // heatsink portion height
hotend_mount_h_spacing = 24; // horizontal distance between M3 holes
hotend_mount_v_spacing = 35; // vertical distance between M3 holes
hotend_mount_bolt = 3;       // M3

// Interface to Layer 1 (carriage base)
interface_bolt_pattern = 35; // must match base
interface_bolt_size = 3;     // M3

// Probe mount (side attachment)
probe_mount_width = 16;
probe_mount_height = 30;
probe_dovetail_angle = 60;   // degrees for dovetail lock
probe_bolt_spacing = 18;     // M3 holes for probe adapter retention

// ADXL345 accelerometer mount
adxl_width = 14;
adxl_length = 21;
adxl_bolt_spacing_x = 10;   // M2.5 holes
adxl_bolt_spacing_y = 17;

// Plate dimensions
plate_width = 50;            // X - matches base width
plate_height = 55;           // Z - enough for hotend mount + probe slot
plate_thickness = 5;         // Y - structural thickness
plate_corner_r = 3;          // corner radius

/* --- Resolution --- */
$fn = $preview ? 32 : 128;

/* --- Modules --- */

module plate_body() {
    // Main plate shape
    linear_extrude(height = plate_thickness)
        offset(r = plate_corner_r)
            offset(delta = -plate_corner_r)
                square([plate_width, plate_height], center = true);
}

module interface_bolt_holes() {
    // 4x M3 through-holes to bolt into Layer 1 inserts
    half = interface_bolt_pattern / 2;
    positions = [
        [-half, -half],
        [ half, -half],
        [-half,  half],
        [ half,  half]
    ];
    for (pos = positions) {
        translate([pos[0], pos[1], -1])
            cylinder(d = 3.4, h = plate_thickness + 2);
    }
}

module hotend_mount_holes() {
    // 4x M3 through-holes matching XCR3D 24x35mm pattern
    hh = hotend_mount_h_spacing / 2;
    hv = hotend_mount_v_spacing / 2;
    positions = [
        [-hh, -hv],
        [ hh, -hv],
        [-hh,  hv],
        [ hh,  hv]
    ];
    for (pos = positions) {
        translate([pos[0], pos[1], -1])
            cylinder(d = 3.4, h = plate_thickness + 2);
    }
}

module hotend_clearance_pocket() {
    // Pocket on back side for hotend body to sit into (alignment + depth reduction)
    translate([0, 0, plate_thickness - 1.5])
        cube([hotend_width + 0.5, hotend_depth + 0.5, 2], center = true);
}

module probe_dovetail_slot() {
    // Dovetail slot on right side of plate for probe adapter
    translate([plate_width/2, 0, 0]) {
        // Dovetail profile extruded vertically
        linear_extrude(height = plate_thickness + 0.1)
            polygon([
                [0, -probe_mount_width/2],
                [4, -probe_mount_width/2 + 2],
                [4,  probe_mount_width/2 - 2],
                [0,  probe_mount_width/2]
            ]);
        // Retention screw hole (M3, horizontal through plate edge)
        translate([2, 0, plate_thickness/2])
            rotate([0, 0, 0])
                cylinder(d = 3.4, h = 10, center = true);
    }
}

module probe_screw_mount() {
    // Alternative: 2x M3 holes on right side for direct probe adapter bolting
    translate([plate_width/2 - 3, 0, 0]) {
        translate([0, -probe_bolt_spacing/2, -1])
            cylinder(d = 3.4, h = plate_thickness + 2);
        translate([0,  probe_bolt_spacing/2, -1])
            cylinder(d = 3.4, h = plate_thickness + 2);
    }
}

module adxl345_mount() {
    // 2x M2.5 holes on top edge for ADXL345 breakout board
    translate([0, plate_height/2 - 8, 0]) {
        translate([-adxl_bolt_spacing_x/2, 0, -1])
            cylinder(d = 2.7, h = plate_thickness + 2);
        translate([ adxl_bolt_spacing_x/2, 0, -1])
            cylinder(d = 2.7, h = plate_thickness + 2);
    }
}

module wire_routing_slot() {
    // Slot for cable pass-through (hotend wires, fan wires)
    translate([0, -plate_height/2 + 8, -1])
        hull() {
            translate([-8, 0, 0]) cylinder(d = 5, h = plate_thickness + 2);
            translate([ 8, 0, 0]) cylinder(d = 5, h = plate_thickness + 2);
        }
}

module hotend_plate() {
    difference() {
        union() {
            // Main plate body
            translate([0, 0, 0])
                plate_body();

            // Probe mount boss (extends to the right)
            translate([plate_width/2, 0, 0])
                linear_extrude(height = plate_thickness)
                    offset(r = 2)
                        offset(delta = -2)
                            square([10, probe_mount_height], center = true);
        }

        // Interface bolts (to Layer 1) - positioned at top portion of plate
        translate([0, plate_height/2 - interface_bolt_pattern/2 - 5, 0])
            interface_bolt_holes();

        // Hotend mount holes - centered on plate, offset down
        translate([0, -3, 0])
            hotend_mount_holes();

        // Hotend clearance pocket (back face alignment)
        translate([0, -3, 0])
            hotend_clearance_pocket();

        // Probe mounting holes (right side)
        probe_screw_mount();

        // ADXL345 mount (top)
        adxl345_mount();

        // Wire routing
        wire_routing_slot();

        // Weight reduction - corner pockets
        translate([-plate_width/2 + 6, -plate_height/2 + 6, -1])
            cylinder(d = 8, h = plate_thickness + 2);
        translate([ plate_width/2 - 6, -plate_height/2 + 6, -1])
            cylinder(d = 8, h = plate_thickness + 2);
    }
}

/* --- Render --- */
hotend_plate();
