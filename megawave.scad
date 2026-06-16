include <wavy.scad>;
include <curves.scad>;

$vpt = [0, 0, 50];
$vpr = [45, 0, 45];
$vpd = 800;

is_prod = false;
sweep_step = is_prod ? 1 : 10;
$fn = is_prod ? 128 : 60;

wavey_grove(
  shell_height=150,
  shell_radius=20,
  // set >slot_depth to join top/bottom
  shell_wall=100,
  //
  slot_padding=5,
  slot_range=75,
  thickness=50,
  slot_depth=101,
  curve_function=curve_slowed_peak,
  sweep_step=sweep_step,
  //
  extra_shell=0.5,
  extra_slices=0.1,
);
