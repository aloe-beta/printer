include <core.scad>
use <v_slot.scad>

module carriage() {
    // Y carriages
    translate(v = [0, y, 0])
    for (a = [0, 180]) {
        rotate(a = a, v = [0, 0, 1])
        translate(v = [-dx, 0, dz - frame_belt_clearance]) {
            v_slot_carriage();
            y_carriage_plate_assembly();
        }
    }

    // X rail and carriage
    translate(v = [0, y, dz]) {
        rotate(a = 90, v = [0, 1, 0])
        v_slot_2020(width);

        translate(v = [x, 0, 0])
        rotate(a = 90, v = [0, 0, 1])
        rotate(a = 270, v = [0, 1, 0]) {
            v_slot_carriage();
            v_slot_carriage_plate();
        }
    }
}

module v_slot_carriage() {
    rotate(a = 180, v = [1, 0, 0])
    for (i = [-1:1]) {
        translate(v = [(s + .6) * (2*abs(i)-1), i*s, 0])
        v_slot_wheel_assembly(eccentric = i == 0);
    }
}

module v_slot_carriage_plate() {
    x1 = s + .6;
    y1 = s;
    translate(v = [0, 0, 13.4])
    linear_extrude(h = 3)
    difference() {
        minkowski() {
            polygon([[x1, -y1], [-x1, 0], [x1, y1]]);
            circle(r = 12);
        }

        for (i = [-1, 1])
        translate(v = [x1, i*y1])
        circle(d = 5.1);

        translate(v = [-x1 - .77, 0])
        circle(d = 7.2);

        translate(v = [x1, 0])
        circle(d = 4);
    }
}

module y_carriage_plate() {
    x1 = s + .6;

    v_slot_carriage_plate();

    translate(v = [x1 - 1.5, 0, 16.4])
    linear_extrude(h = 4) {
        minkowski() {
            difference() {
                square(size = [25, 26], center = true);
                translate(v = [2.375, 0])
                square(size = [25, 22], center = true);
            }

            circle(r = 1);
        }
    }
}

module y_carriage_plate_assembly() {
    x1 = s + .6;

    y_carriage_plate();

    translate(v = [x1, 0, 13.4])
    rotate(a = 180, v = [1, 0, 0])
    screw(M4_cap_screw, 8);

    translate(v = [x1, 0, 18])
    sliding_t_nut(M4_sliding_t_nut);
}