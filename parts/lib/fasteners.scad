// Fastener Library - Standard metric hole profiles
// Usage: include <lib/fasteners.scad>

/* --- Tolerances --- */
hole_clearance = 0.2;  // added to nominal diameter for clearance holes
insert_clearance = 0.1; // for heat-set insert cavities

/* --- M3 --- */
module m3_clearance_hole(depth=10) {
    cylinder(d=3.4, h=depth, center=false);
}

module m3_counterbore(depth=10, head_depth=3.2) {
    union() {
        cylinder(d=3.4, h=depth, center=false);
        cylinder(d=6.5, h=head_depth, center=false);
    }
}

module m3_countersink(depth=10) {
    union() {
        cylinder(d=3.4, h=depth, center=false);
        cylinder(d1=6.8, d2=3.4, h=2.0, center=false);
    }
}

module m3_heat_insert_cavity(depth=5.5) {
    // For M3 x 5mm brass heat-set inserts (typical OD ~4.6mm)
    cylinder(d=4.8, h=depth, center=false);
}

module m3_nut_trap(depth=2.6) {
    // M3 hex nut: 5.5mm across flats, 2.4mm thick
    cylinder(d=6.2, h=depth, $fn=6, center=false);
}

/* --- M4 --- */
module m4_clearance_hole(depth=10) {
    cylinder(d=4.5, h=depth, center=false);
}

module m4_counterbore(depth=10, head_depth=4.2) {
    union() {
        cylinder(d=4.5, h=depth, center=false);
        cylinder(d=8.0, h=head_depth, center=false);
    }
}

module m4_heat_insert_cavity(depth=7.0) {
    // For M4 x 6mm brass heat-set inserts (typical OD ~6.0mm)
    cylinder(d=6.2, h=depth, center=false);
}

module m4_nut_trap(depth=3.4) {
    // M4 hex nut: 7.0mm across flats, 3.2mm thick
    cylinder(d=7.7, h=depth, $fn=6, center=false);
}

/* --- M5 --- */
module m5_clearance_hole(depth=10) {
    cylinder(d=5.5, h=depth, center=false);
}

module m5_counterbore(depth=10, head_depth=5.2) {
    union() {
        cylinder(d=5.5, h=depth, center=false);
        cylinder(d=9.5, h=head_depth, center=false);
    }
}

module m5_nut_trap(depth=4.4) {
    // M5 hex nut: 8.0mm across flats, 4.0mm thick
    cylinder(d=8.8, h=depth, $fn=6, center=false);
}
