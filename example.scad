include <wavy.scad>;
include <curves.scad>;

$vpt = [100, 0, 110];
$vpr = [45, 0, 45];
$vpd = 925;

is_prod = true;
sweep_step = is_prod ? 1 : 10;
$fn = is_prod ? 128 : 60;

translate([0, 200, 0])
  rotate([0, 0, 90])
    wavey(
      padding=0,
      slot_range=75,
      radius=75,
      thickness=50,
      depth=10,
      curve_function=curve_simple_sin,
      sweep_step=sweep_step,
      //
      extra=0.1,
    );

translate([0, 0, 0])
  rotate([0, 0, 0])
    wavey_grove(
      shell_height=150,
      shell_radius=50,
      shell_wall=20,
      //
      slot_padding=5,
      slot_range=75,
      thickness=50,
      slot_depth=50,
      curve_function=curve_simple_sin,
      sweep_step=sweep_step,
      //
      extra_shell=0.5,
      extra_slices=0.1,
    );

translate([200, 0, 0])
  rotate([0, 0, 90])
    wavey_grove(
      shell_height=150,
      shell_radius=50,
      shell_wall=20,
      //
      slot_padding=5,
      slot_range=75,
      thickness=200, // extra thick to remove top
      slot_depth=50,
      curve_function=curve_simple_sin,
      sweep_step=sweep_step,
      //
      extra_shell=0.5,
      extra_slices=0.1,
    );

// lol
translate([-55, 55, 140])
  rotate([0, 0, 90])
    wavey_grove(
      shell_height=70,
      shell_radius=30,
      shell_wall=20,
      //
      slot_padding=5,
      slot_range=40,
      thickness=30,
      slot_depth=30,
      curve_function=curve_strange,
      sweep_step=sweep_step,
      //
      extra_shell=0.5,
      extra_slices=0.1,
    );
