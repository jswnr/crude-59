// --- config --- //
$fn     = 100;
stem_l  = 4;
stem_h  = 3.6;
stem_th = 1.1;
stem_tv = 1.3;
extra_h = 4;
cap_t   = 1;
// -------------- //

margin     = 0.1;
rod_hole_h = stem_h + 1;
rod_h      = rod_hole_h + extra_h;
rod_r      = (stem_l / 2) + margin + 1;
cap_lb     = 18;
cap_lt     = 14;
cavity_lb  = cap_lb - (2 * cap_t);
cavity_lt  = cap_lt - (2 * cap_t);
rib_t      = 0.5;
rib_lb     = cavity_lt + ((extra_h / rod_h) * (cavity_lb -cavity_lt));

module frustum(lb, lt, h) {
    linear_extrude(height = h, scale = lt / lb) {
        square([lb, lb], center = true);
    }
}

module rib() {
    translate([0, (rib_t / 2), extra_h + 0.5])
        rotate([90, 0, 0])
            linear_extrude(height = rib_t)
                polygon(points = [
                    [-(rib_lb / 2), 0],
                    [(rib_lb / 2), 0],
                    [(cavity_lt / 2), extra_h],
                    [-(cavity_lt / 2), extra_h]
                ]);
}

module rod_hole(stem_t) {
    translate([0, 0, (rod_hole_h / 2) - 0.01])
        cube([stem_l + (2 * margin),
              stem_t + (2 * margin),
              rod_hole_h],
              center = true
        );
}

union() {
    difference() {
        minkowski() {
            frustum(cavity_lb, cavity_lt, rod_h - 1);
            cylinder(r = cap_t, h = 1);
        }
        translate([0, 0, -0.01])
            frustum(cavity_lb, cavity_lt, rod_h);
    }

    difference() {
        union() {
            translate([0, 0, (rod_h / 2)])
                cylinder(r = rod_r, h = rod_h, center = true);
            
            rib();
            rotate([0, 0, 90])
                rib();
        }

        rod_hole(stem_tv);
        rotate([0, 0, 90])
            rod_hole(stem_th);
    }
}
