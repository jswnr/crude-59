/*
 * Copyright © 2026 Jakub Świniarski
 *
 * SPDX-License-Identifier: CERN-OHL-S-2.0
 */

$fn        = 100;
pcb_t      = 1.2;
insert_d   = 3.5;
thread_l   = 6;
extra_h    = 5;
case_t     = 2.5;
pcb_l      = 244;
pcb_w      = 92;
margin     = 0.5;
rod_hole_r = (insert_d - 0.2) / 2;
rod_h      = thread_l + 2;
rod_r      = rod_hole_r + 2;
rod_thin_r = 1.5;
gusset_l   = 3;
gusset_t   = 1;
wall_l     = 4 + margin;
wall_t     = 1.5;
wall_h_pos = [
    [0, 55.5],
    [pcb_l + (2 * margin) - wall_l, 55.5]
];
wall_v_pos = [
    [46, 0],
    [110, 0],
    [186, 0],
    [84, pcb_w + (2 * margin) - wall_l],
    [148, pcb_w + (2 * margin) - wall_l],
];
rod_pos = [
    [17.5, 17.5],
    [74.5, 17.5],
    [150.5, 17.5],
    [226.5, 17.5],
    [74.5, 55.5],
    [150.5, 55.5],
    [17.5, 74.5],
    [210.5, 67.5]
];
rod_thin_pos = [
    [36.5, 36.5],
    [112.5, 36.5],
    [188.5, 36.5],
    [55.5, 74.5],
    [112.5, 74.5],
    [169.5, 74.5]
];
usb_pos = [226, pcb_w, case_t + rod_h + pcb_t];
usb_size = [15, case_t + 10, extra_h + 10];

module box() {
    minkowski() {
        cube([
            pcb_l + (2 * margin),
            pcb_w + (2 * margin),
            case_t + rod_h + pcb_t + extra_h - 1
        ]);
        cylinder(r = case_t, h = 1);
    }
}

module cavity() {
    translate([0, 0, case_t])
        cube([
            pcb_l + (2 * margin),
            pcb_w + (2 * margin),
            rod_h + extra_h + 10
        ]);
    
    translate([(usb_pos[0] + margin) - (usb_size[0] / 2),
               (usb_pos[1] + margin),
               usb_pos[2]])
        cube(usb_size);
}

module gusset(rod_r, n) {
    triangle = [
        [0, 0],
        [rod_h, 0],
        [0, gusset_l]
    ];

    rotate([0, 0, 45 + (n * 90)])
        union() {
            translate([(gusset_t / 2), rod_r, 0])
                rotate([0, -90, 0])
                    linear_extrude(height = gusset_t)
                        polygon(points = triangle);
            translate([-(gusset_t / 2), 0, 0])
                cube([gusset_t, rod_r, rod_h]);
        }
}

module rod_support(rod_r) {
    for (n = [0:3]) {
        gusset(rod_r, n);
    }
}

module rod(x, y) {
    translate([x, y, case_t])
        difference() {
            union () {
                cylinder(r = rod_r, h = rod_h);
                rod_support(rod_r);
            }
            translate([0, 0, rod_h - rod_h + 0.01])
                cylinder(r = rod_hole_r, h = rod_h);
        }
}

module rod_thin(x, y) {
    translate([x, y, case_t])
        union() {
            cylinder(r = rod_thin_r, h = rod_h);
            rod_support(rod_thin_r);
        }
}

translate([-(pcb_l / 2), -(pcb_w / 2), 0])
    union() {
        difference() {
            box();
            cavity();
        }
        for (w = wall_h_pos) {
            translate([w[0], w[1] + margin, case_t])
                cube([wall_l, wall_t, rod_h]);
        }
        for (w = wall_v_pos) {
            translate([w[0] + margin, w[1], case_t])
                cube([wall_t, wall_l, rod_h]);
        }
        for (r = rod_pos) {
            rod(r[0] + margin, r[1] + margin);
        }
        for (r = rod_thin_pos) {
            rod_thin(r[0] + margin, r[1] + margin);
        }
    }
