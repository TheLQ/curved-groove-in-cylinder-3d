include <wavy.scad>;
include <curves.scad>;

$vpt = [0, 0, 75];
$vpr = [45, 0, 45];
$vpd = 700;

is_prod = true;
sweep_step = is_prod ? 1 : 10;
$fn = is_prod ? 128 : 60;

wavey_grove(
  shell_height=150,
  shell_radius=25,
  // split
  shell_wall=80,
  // inner groove
  //  shell_wall = 10
  //
  slot_padding=5,
  slot_range=75,
  thickness=50,
  // split
  slot_depth=50,
  // inner groove
  //  slot_depth = 5,
  curve_function=curve_slowed_peak,
  sweep_step=sweep_step,
  //
  extra_shell=0.5,
  extra_slices=0.1,
);
