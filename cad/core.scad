include <NopSCADlib/utils/core/core.scad>
include <NopSCADlib/vitamins/extrusions.scad>
include <NopSCADlib/vitamins/extrusion_brackets.scad>
include <NopSCADlib/vitamins/washers.scad>
include <NopSCADlib/vitamins/nuts.scad>
include <NopSCADlib/vitamins/ball_bearings.scad>

width = 300;
height = 300;

s = 20; // Linear extrusion size. Changing will require reworking logic in various places.
frame_belt_clearance = s + 6.4;

// Carriage position
x = 50 * cos(360 * $t);
y = 50 * sin(360 * $t);

w2 = width / 2;
h2 = height / 2;
dx = width / 2 + s / 2;
dz = height / 2 - s / 2;