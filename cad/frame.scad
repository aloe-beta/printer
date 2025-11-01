include <core.scad>
use <v_slot.scad>

module frame() {
    // Vertical extrusion
    for (i = [0, 90, 180, 270]) {
        rotate(a = i, v = [0, 0, 1]) 
        translate(v = [dx, dx, 0]) 
        v_slot_2020(width);
    }

    // Horizontal extrusion and brackets
    for (a = [0, 90, 180, 270]) {
        for (i = [1, -1]) {
            o = i == 1 && a % 180 == 0 ? frame_belt_clearance : 0;

            rotate(a = a, v = [0, 0, 1]) {
                translate(v = [dx, 0, i * dz - o]) 
                rotate(a = 90, v = [1, 0, 0]) 
                v_slot_2020(width);

                for (j = [1, -1]) {
                    translate(v = [dx, j * w2, i * h2 - i*s - o]) 
                    rotate(a = 90 * i, v = [0, 1, 0]) 
                    rotate(a = 90 + 90 * j, v = [1, 0, 0]) 
                    extrusion_corner_bracket_assembly(type = E20_corner_bracket);
                }
            }
        }
    }
}