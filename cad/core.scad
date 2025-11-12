include <NopSCADlib/utils/core/core.scad>
include <NopSCADlib/vitamins/extrusions.scad>
include <NopSCADlib/vitamins/extrusion_brackets.scad>
include <NopSCADlib/vitamins/washers.scad>
include <NopSCADlib/vitamins/nuts.scad>
include <NopSCADlib/vitamins/ball_bearings.scad>

include <NopSCADlib/vitamins/linear_bearings.scad>
include <NopSCADlib/vitamins/rod.scad>

include <NopSCADlib/vitamins/pulleys.scad>
include <NopSCADlib/vitamins/stepper_motors.scad>
include <NopSCADlib/utils/core_xy.scad>

width = 400;
height = 400;

s = 20; // Linear extrusion size. Changing will require reworking logic in various places.

// Carriage position
x = 128 * cos(360 * $t);
y = 128 * sin(360 * $t);

w2 = width / 2;
h2 = height / 2;
dx = w2 + s / 2;
dz = h2 - s / 2;

belt_z_offset = 2.75;