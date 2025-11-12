include <core.scad>

bearing = LM8UU;
thickness = 3;

rod_dia = bearing_rod_dia(bearing);

stepper_pulley = GT2x20ob_pulley;
toothed_idler = GT2x20_toothed_idler;
plain_idler = GT2x20_plain_idler;

gantry_shaft_spacing = s/2 + rod_dia/2 + thickness;

stepper_offset = 11;
d_stepper = w2 - 21.15 - stepper_offset;
belt_width = 2 * d_stepper;
belt_length = width + s/2 - 21.15;

y_shaft_offset = dx - s - 2;

module carriage(sp = gantry_shaft_spacing) {

    // Y gantry
    for (i = [-1, 1]) {
        translate(v = [i * y_shaft_offset, 0, dz])
        rotate(a = 90, v = [1, 0, 0]) {
            rod(rod_dia, width);

            translate(v = [0, 0, -y]) {
                linear_bearing(bearing);

                rotate(a = 90 * (i+1), v = [0, 0, 1]) 
                gantry_joint_bracket();
            }
        }
    }

    // X gantry
    for (i = [-sp, sp])
    translate(v = [0, y, dz + i])
    rotate(a = 90, v = [0, 1, 0]) {
        rod(rod_dia, width);
        translate(v = [0, 0, x]) 
        linear_bearing(bearing);
    }
}

module gantry_joint_bracket(sp = gantry_shaft_spacing) {
    w1 = bearing_dia(bearing) + thickness*2;
    w2 = rod_dia + thickness*2;

    od = pulley_od(stepper_pulley);
    d1 = y_shaft_offset - d_stepper;
    w3 = d1 + w1/2 + od/2;

    difference() {
        group() {
            cylinder(h = bearing_length(bearing), d = w1, center = true);

            for (i = [-1, 1]) {
                translate(v = [-w1/2, i*sp, 0]) 
                rotate(a = 90, v = [0, 1, 0]) 
                cylinder(h = w3 + (i+1)/2*od, d = w2);

                translate(v = [d1 + (i+1)/2*od, i*sp, -i*od])
                rotate(a = 90, v = [1, 0, 0])
                cylinder(h = w2, d = od, center = true);

                translate(v = [d1 + (i+1)/2*od, i*sp, -i*od/2]) {
                    cube(size = [od, w2, od], center = true);
                }

                d2 = d1 + (i+1)/2*od;
                translate(v = [0, sp*i, 0]) 
                rotate(a = 90, v = [1, 0, 0]) 
                linear_extrude(height = thickness*2, center = true) 
                minkowski() {
                    polygon([[0, 0], [d2, 0], [d2, -i*od]]);
                    circle(d = thickness*2 + 4);
                }
            }

            cube(size = [w1, sp*2, w2], center = true);
        }
        cylinder(h = bearing_length(bearing) + 1, d = bearing_dia(bearing), center = true);

        for (i = [-1, 1]) {
            translate(v = [-w1/2 - .5, i*sp, 0]) 
            rotate(a = 90, v = [0, 1, 0]) 
            cylinder(h = w3 + od + 1, d = rod_dia);

            translate(v = [d1 + (i+1)/2*od, i*sp, -i*od])
            rotate(a = 90, v = [1, 0, 0])
            cylinder(h = w2 + 1, d = 4, center = true);
        }
    }

    for (i = [-1, 1]) {
        translate(v = [d1 + (i+1)/2*od, 4.625*i + 4.25, -i*od]) {
            rotate(a = 90, v = [1, 0, 0])
            pulley(i == 1 ? plain_idler : toothed_idler);

            translate(v = [0, -pulley_height(plain_idler)*(i+1)/2, 0]) 
            rotate(a = 90*i, v = [1, 0, 0]) {
                screw(M4_cap_screw, 30);

                translate(v = [0, 0, -pulley_height(plain_idler)-1])
                washer(M4_washer);

                translate(v = [0, 0, -pulley_height(plain_idler)-nut_thickness(M4_nut)-thickness*2-rod_dia-1.25])
                nut(M4_nut);
            }
        }
    }
}

module belts() {
    color("#444")
    translate(v = [-belt_width/2, -belt_length/2 - 21.15/2 - s/4, dz + 2.75 - belt_z_offset]) 
    coreXY(coreXY_GT2_20_20, [belt_width, belt_length], [x + w2 - 31.25, y + w2 + s/2], [0, pulley_od(stepper_pulley), 9.25]);

    translate(v = [0, 0, -belt_z_offset]) 
    for (i = [-1, 1]) {
        translate(v = [i * (d_stepper), d_stepper + stepper_offset, h2 - s])
        rotate(a = i*90, v = [0, 0, 1]) {
            NEMA(type = NEMA17_47, jst_connector = true);

            translate(v = [0, 0, 12.625 - 4.625*i]) 
            rotate(a = 90 + 90*i, v = [1, 0, 0]) 
            pulley_assembly(stepper_pulley);
        }

        translate(v = [i * (d_stepper), -dx, dz - s]) {
            belt_idler_assembly();
        }
    }
}

module belt_idler_assembly() {
    translate(v = [0, 0, 8.2]) 
    rotate(a = 180, v = [1, 0, 0]) 
    sliding_t_nut(M4_sliding_t_nut);

    translate(v = [0, 0, 31.5])
    screw(M4_cap_screw, 25);

    for (i = [10, 11.5])
    translate(v = [0, 0, i]) 
    washer(M6_washer);

    for (i = [13, 22.25])
    translate(v = [0, 0, i]) 
    washer(M4_washer);

    for (i = [13.75, 23])
    translate(v = [0, 0, i]) 
    pulley(toothed_idler);
}