// shell_height 
// shell_radius
// shell_wall
// 
// slot_padding - offset from start of cylinder
// slot_range - range of the first wall of the groove
// thickness
// slot_depth
// curve_function - (padding, angle, height, tunable_dwell)
// sweep_step - prod: 1 degree slices, dev: 10 degree slices
//
// todo: depending on size, required to remove all inside intersection
// extra_shell
// extra_slices
module wavey_grove(shell_height, shell_radius, shell_wall, slot_padding, slot_range, thickness, slot_depth, curve_function, sweep_step, extra_shell, extra_slices) {
  difference() {
    shell(
      height=shell_height,
      inner_radius=shell_radius,
      wall=shell_wall,
      extra=extra_slices,
    );
    wavey(
      padding=slot_padding,
      radius=shell_radius - extra_shell,
      thickness=thickness,
      depth=slot_depth,
      slot_range=slot_range,
      extra=extra_slices,
      curve_function=curve_function,
      sweep_step=sweep_step,
    );
  }
}

// The cylinder we cut the groove into
module shell(inner_radius, wall, height, extra) {
  difference() {
    cylinder(h=height, r=inner_radius + wall);
    // remove inner cylinder and leftover surface
    translate([0, 0, -extra])
      cylinder(h=height + (extra * 2), r=inner_radius);
  }
}

// Generate wave by hull-ing each slice (a 1-thick slab) of the cylinder
module wavey(
  padding,
  radius,
  thickness,
  depth,
  slot_range,
  curve_function,
  sweep_step,
  extra,
) {
  for (angle = [0:sweep_step:360]) {
    color(
      let (
        hei = curve_function(
          angle=angle,
          height=1,
        )
      ) (hei > .5) ? [0, hei, hei] : [hei, hei, 240 / 255]
    )
      hull() {
        translate(
          [
            cos(angle) * radius,
            sin(angle) * radius,
            padding + curve_function(
              angle=angle,
              height=slot_range,
            ),
          ]
        )
          rotate([0, 0, angle])
            linear_extrude(height=thickness)
              square([depth, extra]);

        translate(
          [
            cos(angle + sweep_step) * radius,
            sin(angle + sweep_step) * radius,
            padding + curve_function(
              angle=angle + sweep_step,
              height=slot_range,
            ),
          ]
        )
          rotate([0, 0, angle + sweep_step])
            linear_extrude(height=thickness)
              square([depth, extra]);
      }
  }
}

// example https://www.desmos.com/calculator/w9jrdpvsmk
// sin(2x) + (1/s)sin(3(2x))
// y=\sin(\left(2x\right))+\frac{1}{s}\sin\left(3\left(2x\right)\right)

// s = depth of peaks
