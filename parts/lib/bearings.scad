// Bearing Library - Standard bearing housings and profiles
// Usage: include <lib/bearings.scad>

/* --- Tolerances --- */
bearing_press_fit = -0.05;  // negative = tighter than nominal
bearing_slip_fit = 0.1;

/* --- 608ZZ (Skateboard Bearing) --- */
// Dimensions: 8mm ID, 22mm OD, 7mm width
_608_id = 8;
_608_od = 22;
_608_w = 7;

module 608_cavity(fit="press") {
    clearance = (fit == "press") ? bearing_press_fit : bearing_slip_fit;
    cylinder(d=_608_od + clearance*2, h=_608_w, center=false);
}

module 608_housing(wall=3, fit="press") {
    clearance = (fit == "press") ? bearing_press_fit : bearing_slip_fit;
    difference() {
        cylinder(d=_608_od + clearance*2 + wall*2, h=_608_w, center=false);
        translate([0, 0, -0.01])
            cylinder(d=_608_od + clearance*2, h=_608_w + 0.02, center=false);
    }
}

// Visual representation for assembly previews
module 608_bearing() {
    color("silver")
    difference() {
        cylinder(d=_608_od, h=_608_w, center=false);
        translate([0, 0, -0.01])
            cylinder(d=_608_id, h=_608_w + 0.02, center=false);
    }
}

/* --- LM8UU Linear Bearing --- */
// Dimensions: 8mm shaft, 15mm OD, 24mm length
_lm8uu_id = 8;
_lm8uu_od = 15;
_lm8uu_len = 24;

module lm8uu_cavity(fit="press") {
    clearance = (fit == "press") ? bearing_press_fit : bearing_slip_fit;
    cylinder(d=_lm8uu_od + clearance*2, h=_lm8uu_len, center=false);
}

module lm8uu_clamp(wall=3, gap=1.5) {
    // Split clamp style housing for LM8UU
    clearance = bearing_slip_fit;
    od = _lm8uu_od + clearance*2;
    difference() {
        cylinder(d=od + wall*2, h=_lm8uu_len, center=false);
        translate([0, 0, -0.01])
            cylinder(d=od, h=_lm8uu_len + 0.02, center=false);
        // Clamp gap
        translate([od/2 - 1, -gap/2, -0.01])
            cube([wall+2, gap, _lm8uu_len + 0.02]);
    }
}

module lm8uu_bearing() {
    color("gray")
    difference() {
        cylinder(d=_lm8uu_od, h=_lm8uu_len, center=false);
        translate([0, 0, -0.01])
            cylinder(d=_lm8uu_id, h=_lm8uu_len + 0.02, center=false);
    }
}

/* --- Shaft Holder (for smooth rods) --- */
module shaft_holder(shaft_d=8, wall=4, base_h=4, bolt="m4") {
    od = shaft_d + wall*2;
    total_h = shaft_d/2 + wall + base_h;
    difference() {
        union() {
            // Base plate
            translate([-od/2 - 5, -od/2, 0])
                cube([od + 10, od, base_h]);
            // Clamp cylinder
            translate([0, 0, base_h])
                cylinder(d=od, h=shaft_d/2 + wall, center=false);
        }
        // Shaft hole
        translate([0, 0, base_h + shaft_d/2 + wall])
            rotate([0, 0, 0])
                translate([0, 0, -shaft_d])
                    cylinder(d=shaft_d + 0.1, h=shaft_d*2, center=false);
    }
}
