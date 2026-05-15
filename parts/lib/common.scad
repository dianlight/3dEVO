// Common Geometry Helpers
// Usage: include <lib/common.scad>

// Rounded rectangle (2D profile, extrude as needed)
module rounded_rect(size, radius) {
    offset(r=radius)
        offset(delta=-radius)
            square(size, center=true);
}

// Rounded box (3D)
module rounded_box(size, radius) {
    hull() {
        for (x = [-1, 1], y = [-1, 1], z = [-1, 1])
            translate([
                x * (size[0]/2 - radius),
                y * (size[1]/2 - radius),
                z * (size[2]/2 - radius)
            ])
            sphere(r=radius);
    }
}

// Slot profile (elongated hole)
module slot(length, width, depth=10) {
    hull() {
        translate([-length/2 + width/2, 0, 0])
            cylinder(d=width, h=depth, center=false);
        translate([length/2 - width/2, 0, 0])
            cylinder(d=width, h=depth, center=false);
    }
}

// Fillet along X axis (use with difference for internal fillets)
module fillet(r, length) {
    translate([0, 0, -0.01])
    difference() {
        cube([length, r+0.01, r+0.01]);
        translate([0, r, r])
            rotate([0, 90, 0])
                cylinder(r=r, h=length, $fn=32);
    }
}

// Chamfer edge helper (triangular cross-section extruded along X)
module chamfer(size, length) {
    linear_extrude(height=length)
        polygon([[0,0], [size,0], [0,size]]);
}

// Mirror with copy (keeps original + mirrored)
module mirror_copy(axis) {
    children();
    mirror(axis) children();
}

// Ring / tube
module ring(od, id, h) {
    difference() {
        cylinder(d=od, h=h, center=false);
        translate([0, 0, -0.01])
            cylinder(d=id, h=h+0.02, center=false);
    }
}
