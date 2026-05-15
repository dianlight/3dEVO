// Assembly: X-Carriage Complete Assembly Preview
// Version: v1
// Description: Shows all layers assembled together with hotend ghost for visualization

/* --- Assembly Configuration --- */

// Render mode: "assembled", "exploded", "base_only", "plate_only", "duct_only"
render_mode = "assembled";

// Exploded view offset
explode_offset = 20;

// Which probe to show: "bltouch", "eddy", "none"
show_probe = "eddy";

// Show ghost hotend for reference
show_hotend_ghost = true;

// Show X-rods for context
show_rods = true;

/* --- Hotend Dimensions (for ghost) --- */
hotend_width = 30;
hotend_depth = 18;
hotend_heatsink_h = 42;
hotend_total_h = 61.6;

/* --- Axis Geometry --- */
rod_diameter = 8;
rod_spacing = 45;
rod_length = 100;   // just for visualization

/* --- Resolution --- */
$fn = $preview ? 24 : 64;

/* --- Position Offsets --- */
// Layer 1 (base) is at origin
base_pos = [0, 0, 0];

// Layer 2 (hotend plate) mounts to front face of base
plate_offset_assembled = [0, -13, 0];   // 13mm = base body_depth/2 + plate flush
plate_offset_exploded  = [0, -13 - explode_offset, 0];

// Layer 3 (fan duct) mounts to hotend plate
duct_offset_assembled = [0, -22, -10];  // relative to plate
duct_offset_exploded  = [0, -22 - explode_offset*2, -10];

// Probe offset (right side of plate)
probe_offset_assembled = [30, -13, -5];
probe_offset_exploded  = [30 + explode_offset, -13 - explode_offset, -5];

/* --- Assembly --- */

module ghost_hotend() {
    color("darkgray", 0.3) {
        // Heatsink (finned cylinder approximation)
        translate([0, 0, -hotend_heatsink_h/2])
            cube([hotend_width, hotend_depth, hotend_heatsink_h], center = true);
        // Heat break
        translate([0, 0, -hotend_heatsink_h - 5])
            cylinder(d = 8, h = 10, center = true);
        // Heater block
        translate([0, 0, -hotend_heatsink_h - 14])
            cube([16, 16, 12], center = true);
        // Nozzle
        translate([0, 0, -hotend_total_h + 3])
            cylinder(d1 = 1, d2 = 8, h = 6, center = true);
    }
}

module ghost_rods() {
    color("silver", 0.4) {
        translate([0, 0, rod_spacing/2])
            rotate([0, 90, 0])
                cylinder(d = rod_diameter, h = rod_length, center = true);
        translate([0, 0, -rod_spacing/2])
            rotate([0, 90, 0])
                cylinder(d = rod_diameter, h = rod_length, center = true);
    }
}

module ghost_fan() {
    color("black", 0.3)
        cube([30, 30, 10], center = true);
}

// Determine positions based on render mode
plate_pos = (render_mode == "exploded") ? plate_offset_exploded : plate_offset_assembled;
duct_pos = (render_mode == "exploded") ? duct_offset_exploded : duct_offset_assembled;
probe_pos = (render_mode == "exploded") ? probe_offset_exploded : probe_offset_assembled;

// Render assembly
if (render_mode != "plate_only" && render_mode != "duct_only") {
    // Layer 1: Carriage Base
    color("dimgray")
        translate(base_pos)
            import("x_carriage_base_v1.stl");
    // Fallback: if no STL, use source
    // use <x_carriage_base_v1.scad>
}

if (render_mode != "base_only" && render_mode != "duct_only") {
    // Layer 2: Hotend Plate
    color("darkslategray")
        translate(plate_pos)
            rotate([90, 0, 0])
                import("x_carriage_hotend_plate_v1.stl");
    // Fallback: use <x_carriage_hotend_plate_v1.scad>
}

if (render_mode != "base_only" && render_mode != "plate_only") {
    // Layer 3: Fan Duct
    color("white")
        translate(duct_pos)
            import("x_carriage_fan_duct_v1.stl");
    // Fallback: use <x_carriage_fan_duct_v1.scad>
}

// Probe adapter
if (show_probe == "bltouch") {
    color("orange")
        translate(probe_pos)
            import("x_carriage_probe_bltouch_v1.stl");
} else if (show_probe == "eddy") {
    color("green")
        translate(probe_pos)
            import("x_carriage_probe_eddy_v1.stl");
}

// Context elements
if (show_hotend_ghost) {
    translate(plate_pos + [0, -5, -hotend_heatsink_h/2 - 3])
        ghost_hotend();
}

if (show_rods) {
    ghost_rods();
}

// Assembly info (shown in console)
echo("=== X-Carriage Assembly v1 ===");
echo(str("Render mode: ", render_mode));
echo(str("Probe: ", show_probe));
echo("Layer 1: Carriage Base (rides on rods, holds belt)");
echo("Layer 2: Hotend Plate (mounts XCR3D 2IN1-S1)");
echo("Layer 3: Fan Duct (heatsink + part cooling)");
echo(str("Estimated total weight: ~110g + 43g hotend = 153g"));
