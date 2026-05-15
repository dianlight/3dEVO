// Part: X-Carriage Base (Layer 1) - CLAMSHELL
// Version: v3.1
// Process: 3D Print - PLA Black - Structural profile
// Print: NO SUPPORTS
//
// True clamshell split at bearing centerline.
// Single belt groove captures both runs of the closed-loop GT2 belt.
// Screws in the solid center zone between bearings.

include <../lib/fasteners.scad>
include <../lib/common.scad>

/* === PARAMETERS === */

// Rods
rod_d = 8;
rod_spacing = 45;
rod_cl = 0.15;

// Bearing: RJ4JP-01-08 (8mm ID, 15mm OD, 24mm L)
brg_od = 15;
brg_len = 24;
brg_cl = 0.1;
brg_bore = brg_od + brg_cl * 2;

// Walls
wall = 2.5;

// Width (X)
width = brg_len + wall * 2;  // 29mm

// Y layout: split at bearing center
rod_cy = brg_od / 2 + wall;  // 10mm from front face to rod center
front_y = rod_cy;             // front half depth = 10mm
back_y = brg_od / 2 + wall;  // back half depth = 10mm
total_y = front_y + back_y;   // 20mm assembled

// Belt (GT2 6mm closed loop - SINGLE groove for both runs)
// Both belt runs stack in one groove: teeth face opposite directions
belt_w = 6;
belt_t = 1.5;
belt_pitch = 2.0;
// Groove holds 2 belt thicknesses (both runs stacked)
groove_w = belt_w + 0.8;           // 6.8mm wide
groove_d = belt_t * 2 + 1.0;      // 4mm deep (2 belts + clearance)

// Alignment pins (back half → front half)
pin_d = 4;
pin_len = 4;
pin_cl = 0.15;
// Pins at center, flanking the belt groove
pin_pos = [
    [-width/2 + 6, 0],
    [ width/2 - 6, 0]
];

// M3 screws: in the SOLID CENTER between bearings
// Center zone Z range: from -rod_spacing/2 + brg_bore/2 to +rod_spacing/2 - brg_bore/2
// = from -14.9 to +14.9 (clear of bearing bores)
// Place screws well within this zone
screw_pos = [
    [-width/2 + 5,  12],   // upper-left (safely between bearing and center)
    [ width/2 - 5,  12],   // upper-right
    [-width/2 + 5, -12],   // lower-left
    [ width/2 - 5, -12]    // lower-right
];
screw_d = 3.4;
insert_d = 4.8;
insert_depth = 5;
csink_d = 6.2;
csink_depth = 2;

// Layer 2 interface (front face)
l2_x = 20;
l2_z = 30;

/* === Resolution === */
$fn = $preview ? 48 : 128;


/* ======================================== */
/* === FRONT HALF                        === */
/* ======================================== */

module front_half() {
    difference() {
        // --- SOLID ---
        hull() {
            translate([0, rod_cy, rod_spacing/2])
                rotate([0, 90, 0])
                    cylinder(d = brg_bore + wall * 2, h = width, center = true);
            translate([0, rod_cy, -rod_spacing/2])
                rotate([0, 90, 0])
                    cylinder(d = brg_bore + wall * 2, h = width, center = true);
        }

        // --- CUT: Everything behind split plane (Y > rod_cy) ---
        translate([0, rod_cy + 50, 0])
            cube([width + 10, 100, rod_spacing * 2], center = true);

        // --- CUT: Bearing half-bores ---
        translate([0, rod_cy, rod_spacing/2])
            rotate([0, 90, 0])
                cylinder(d = brg_bore, h = brg_len + 0.4, center = true);
        translate([0, rod_cy, -rod_spacing/2])
            rotate([0, 90, 0])
                cylinder(d = brg_bore, h = brg_len + 0.4, center = true);

        // --- CUT: Rod through-holes ---
        translate([0, rod_cy, rod_spacing/2])
            rotate([0, 90, 0])
                cylinder(d = rod_d + rod_cl * 2, h = width + 20, center = true);
        translate([0, rod_cy, -rod_spacing/2])
            rotate([0, 90, 0])
                cylinder(d = rod_d + rod_cl * 2, h = width + 20, center = true);

        // --- CUT: Single belt groove on split face (center, Z=0) ---
        translate([0, rod_cy - groove_d/2, 0])
            cube([width - 4, groove_d + 0.01, groove_w], center = true);

        // --- CUT: Pin holes (from split face INTO body, -Y direction) ---
        for (pos = pin_pos) {
            translate([pos[0], rod_cy + 0.01, pos[1]])
                rotate([90, 0, 0])
                    cylinder(d = pin_d + pin_cl * 2, h = pin_len + 0.5);
        }

        // --- CUT: M3 inserts (from split face INTO body, -Y direction) ---
        for (pos = screw_pos) {
            translate([pos[0], rod_cy + 0.01, pos[1]])
                rotate([90, 0, 0])
                    cylinder(d = insert_d, h = insert_depth + 0.3);
        }

        // --- CUT: Layer 2 inserts (front face) ---
        for (pos = [
            [-l2_x/2, -l2_z/2], [ l2_x/2, -l2_z/2],
            [-l2_x/2,  l2_z/2], [ l2_x/2,  l2_z/2]
        ]) {
            translate([pos[0], -0.1, pos[1]])
                rotate([-90, 0, 0])
                    cylinder(d = insert_d, h = insert_depth);
        }
    }

    // --- ADD: GT2 ridges on groove floor (grip first belt run) ---
    ridges = floor((width - 12) / belt_pitch);
    for (i = [0 : ridges - 1]) {
        xp = i * belt_pitch - (width - 12)/2 + belt_pitch/2;
        translate([xp, rod_cy - groove_d + 0.3, 0])
            cube([0.9, 0.65, groove_w - 1], center = true);
    }
}


/* ======================================== */
/* === BACK HALF                         === */
/* ======================================== */

module back_half() {
    // Local: inner face Y=0, outer face Y=back_y

    cap_h = rod_spacing + brg_bore + wall * 2;

    difference() {
        // --- SOLID ---
        hull() {
            translate([0, 0, rod_spacing/2])
                rotate([0, 90, 0])
                    cylinder(d = brg_bore + wall * 2, h = width, center = true);
            translate([0, 0, -rod_spacing/2])
                rotate([0, 90, 0])
                    cylinder(d = brg_bore + wall * 2, h = width, center = true);
        }

        // --- CUT: Everything in front of split plane (Y < 0) ---
        translate([0, -50, 0])
            cube([width + 10, 100, cap_h + 10], center = true);

        // --- CUT: Bearing half-bores ---
        translate([0, 0, rod_spacing/2])
            rotate([0, 90, 0])
                cylinder(d = brg_bore, h = brg_len + 0.4, center = true);
        translate([0, 0, -rod_spacing/2])
            rotate([0, 90, 0])
                cylinder(d = brg_bore, h = brg_len + 0.4, center = true);

        // --- CUT: Rod through-holes ---
        translate([0, 0, rod_spacing/2])
            rotate([0, 90, 0])
                cylinder(d = rod_d + rod_cl * 2, h = width + 20, center = true);
        translate([0, 0, -rod_spacing/2])
            rotate([0, 90, 0])
                cylinder(d = rod_d + rod_cl * 2, h = width + 20, center = true);

        // --- CUT: M3 screw through-holes + countersink ---
        for (pos = screw_pos) {
            translate([pos[0], -0.1, pos[1]])
                rotate([-90, 0, 0])
                    cylinder(d = screw_d, h = back_y + 2);
            // Countersink on outer face
            translate([pos[0], back_y - csink_depth, pos[1]])
                rotate([-90, 0, 0])
                    cylinder(d1 = screw_d, d2 = csink_d, h = csink_depth + 0.1);
        }

        // --- CUT: Belt side slots (loop passes left/right through groove) ---
        for (side = [-1, 1]) {
            translate([side * width/2, 0, 0])
                cube([wall + 2, groove_d + 1, groove_w + 1], center = true);
        }
    }

    // --- ADD: Alignment pins ---
    for (pos = pin_pos) {
        translate([pos[0], 0, pos[1]])
            rotate([90, 0, 0])
                cylinder(d = pin_d, h = pin_len);
    }

    // --- ADD: Belt pressure rib (pushes into groove, grips second belt run) ---
    translate([0, -(groove_d - 0.7)/2, 0])
        cube([width - 8, groove_d - 0.7, groove_w - 0.8], center = true);

    // --- ADD: GT2 ridges on rib face (grip second belt run) ---
    ridges = floor((width - 12) / belt_pitch);
    for (i = [0 : ridges - 1]) {
        xp = i * belt_pitch - (width - 12)/2 + belt_pitch/2;
        translate([xp, -(groove_d - 0.7) + 0.3, 0])
            cube([0.9, 0.65, groove_w - 1.5], center = true);
    }
}


/* ======================================== */
/* === RENDER                            === */
/* ======================================== */

render_part = "exploded";  // "assembly" | "exploded" | "front_half" | "back_half"

if (render_part == "assembly") {
    color("dimgray") front_half();
    color("steelblue") translate([0, rod_cy, 0]) back_half();
    %translate([0, rod_cy, rod_spacing/2])
        rotate([0, 90, 0]) cylinder(d = rod_d, h = 80, center = true);
    %translate([0, rod_cy, -rod_spacing/2])
        rotate([0, 90, 0]) cylinder(d = rod_d, h = 80, center = true);
}

if (render_part == "exploded") {
    color("dimgray") front_half();
    color("steelblue") translate([0, rod_cy + 15, 0]) back_half();
    %translate([0, rod_cy, rod_spacing/2])
        rotate([0, 90, 0]) cylinder(d = rod_d, h = 80, center = true);
    %translate([0, rod_cy, -rod_spacing/2])
        rotate([0, 90, 0]) cylinder(d = rod_d, h = 80, center = true);
}

if (render_part == "front_half") front_half();
if (render_part == "back_half") back_half();


// === NOTES ===
//
// SINGLE BELT GROOVE (Z=0, centered between bearings):
//   Both runs of the closed-loop GT2 belt stack in one groove.
//   Run 1: teeth face groove floor ridges (gripped by front half)
//   Run 2: teeth face rib ridges (gripped by back half)
//   Belt sandwich:
//     [groove floor + ridges] ← run1 teeth | run1 back | run2 back | run2 teeth → [rib + ridges]
//
// SCREW POSITIONS (Z = ±12mm):
//   Safely in the solid center zone between bearing bores.
//   Bearing bores end at Z = ±(rod_spacing/2 - brg_bore/2) = ±14.9mm
//   Screws at Z = ±12mm have ~3mm clearance from bore edge.
//
// ASSEMBLY:
//   1. Press 4x M3 inserts into front half split face
//   2. Press 4x M3 inserts into front half front face (Layer 2)
//   3. Drop bearings into front half cradles
//   4. Place on X-rods
//   5. Lay both GT2 belt runs into single groove (stacked, teeth out)
//   6. Place back half: pins locate, rib enters groove, bearing closes
//   7. 4x M3x12 countersunk screws from back → done
//
// PRINT (no supports):
//   Front half: front face on bed, split face UP → half-pipes open upward
//   Back half: outer face on bed, split face UP → pins/rib grow upward
