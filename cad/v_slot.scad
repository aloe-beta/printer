include <core.scad>

module v_slot_2020(width) {
    color("#c0c0c0")
    linear_extrude(width, center = true)
    difference() {
        minkowski() {
            polygon([[9.75,4.75],[8.45,3.45],[8.45,5.75],[6.46,5.75],[3.77,3.04],[3.77,-3.04],[6.46,-5.75],[8.45,-5.75],[8.45,-3.45],[9.75,-4.75],[9.75,-9.75],[4.75,-9.75],[3.45,-8.45],[5.75,-8.45],[5.75,-6.46],[3.04,-3.77],[-3.04,-3.77],[-5.75,-6.46],[-5.75,-8.45],[-3.45,-8.45],[-4.75,-9.75],[-9.75,-9.75],[-9.75,-4.75],[-8.45,-3.45],[-8.45,-5.75],[-6.46,-5.75],[-3.77,-3.04],[-3.77,3.04],[-6.46,5.75],[-8.45,5.75],[-8.45,3.45],[-9.75,4.75],[-9.75,9.75],[-4.75,9.75],[-3.45,8.45],[-5.75,8.45],[-5.75,6.46],[-3.04,3.77],[3.04,3.77],[5.75,6.46],[5.75,8.45],[3.45,8.45],[4.75,9.75],[9.75,9.75]]);
            circle(r=.25);
        }
        circle(d = 4.25);
    };
}

module v_slot_wheel() {
    color("#222")
    difference() {
        group() {
            translate(v = [0, 0, 3])
            cylinder(h = 2, d1 = 24, d2 = 20);
            cylinder(h = 6, d = 24, center = true);
            translate(v = [0, 0, -5])
            cylinder(h = 2, d1 = 20, d2 = 24);
        }
        cylinder(h = 11, d = 16, center = true);
        for (i = [4, -6])
        translate(v = [0, 0, i])
        cylinder(h = 2, d = 18);
    }
    for (a = [0, 180])
    rotate(a = a, v = [0, 1, 0])
    translate(v = [0, 0, -2.5])
    ball_bearing(BBF625);
}

module v_slot_m5_nut(eccentric = false) {
    color("#c0c0c0")
    if (eccentric) {
        difference() {
            group() {
                translate(v = [0, 0, -.275])
                linear_extrude(h = 7.85, center = true)
                polygon([[2.89,5],[-2.89,5],[-5.77,0],[-2.89,-5],[2.89,-5],[5.77,0]]);

                translate(v = [0, 0, -6.45])
                cylinder(d = 7.1, h = 2.25);

                translate(v = [0.77, 0, 3.65])
                cylinder(d = 7, h = 0.55);
            }
            translate(v = [0.77, 0, 0])
            cylinder(d = 5, h = 15, center = true);
        }
    } else {
        difference() {
            cylinder(d = 8, h = 8.4, center = true);
            cylinder(d = 5, h = 9, center = true);
        }
    }
}

module v_slot_wheel_assembly(h = 3, eccentric = false) {
    translate(v = [0, 0, -h - 13.4])
    rotate(a = 180, v = [1, 0, 0])
    screw(M5_dome_screw, 30);

    translate(v = [eccentric ? -0.77 : 0, 0, -9.2])
    v_slot_m5_nut(eccentric);

    v_slot_wheel();

    translate(v = [0, 0, 10.925])
    rotate(a = 180, v = [1, 0, 0])
    nut(M5_nut, nyloc = true);
}