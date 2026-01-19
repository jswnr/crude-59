$fn = 100;
pcb_l        = 244;
pcb_w        = 92;
margin       = 0.5;
thick        = 2.5;
extra_h      = 5;
rod_h        = 10;
rod_r        = 3;
rod_thin_r   = 1.5;
hole_r       = 1.6 / 2;
screw_l      = 7;
round_r      = 2;
rod_pos = [
    [17.5, 17.5],
    [74.5, 17.5],
    [150.5, 17.5],
    [226.5, 17.5],
    [74.5, 55.5],
    [150.5, 55.5],
    [17.5, 74.5],
    [210.5, 67.5],
];
rod_thin_pos = [
    [169.5, 74.5],
    [112.5, 74.5],
    [55.5, 74.5],
    [188.5, 36.5],
    [112.5, 36.5],
    [36.5, 36.5]

];
usb_pos = [226, pcb_w, thick + rod_h];
usb_size = [15, thick + 3, extra_h];

module box() {
    minkowski() {
        cube([
            pcb_l + (2 * margin) + (2 * thick) - (2 * round_r),
            pcb_w + (2 * margin) + (2 * thick) - (2 * round_r),
            thick + rod_h + extra_h - 2
        ]);
        cylinder(r = round_r, h = 1);
    }
}

module cavity() {
    translate([0, 0, thick])
        cube([
            pcb_l + (2 * margin),
            pcb_w + (2 * margin),
            rod_h + extra_h
        ]);
    
    translate([(usb_pos[0] + margin) - (usb_size[0] / 2),
               (usb_pos[1] + margin),
               usb_pos[2]])
        cube(usb_size);
}

module rod(x, y) {
    translate([x, y, thick])
        difference() {
            cylinder(r = rod_r, h = rod_h);
            translate([0, 0, rod_h - screw_l + 0.1])
                cylinder(r = hole_r, h = screw_l);
        }
}

module rod_thin(x, y) {
    translate([x, y, thick])
        cylinder(r = rod_thin_r, h = rod_h);
}

translate([-(pcb_l / 2), -(pcb_w / 2), 0])
    union() {
        difference() {
            box();
            cavity();
        }
        for (r = rod_pos) {
            rod(r[0] + margin, r[1] + margin);
        }
        for (r = rod_thin_pos) {
            rod_thin(r[0] + margin, r[1] + margin);
        }
    }
