// shell_height 
// shell_radius - inner radius
// shell_wall - if < slot_depth, the cylinder is cut in half
// 
// slot_padding - offset from start of cylinder
// slot_range - range of the first wall of the groove
// thickness - between outside walls of slot
// slot_depth
// curve_function - function(angle, slot_range) -> groove_height 
// sweep_step - slices in 360 degrees
//
// tolerance required to remove remaining edges
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
      padding=slot_padding + (thickness / 2),
      radius=shell_radius - extra_shell - (thickness / 2),
      thickness=thickness,
      depth=slot_depth + (thickness / 2),
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
          slot_range=1,
        )
      )
      //  (hei > .5) ? [0, hei, hei] : [hei, hei, 240 / 255]
      [1 - (hei * 0.5), 18 / 255, (hei * 1)]
    )
      hull() {
        translate(
          [
            cos(angle) * radius,
            sin(angle) * radius,
            padding + curve_function(
              angle=angle,
              slot_range=slot_range,
            ),
          ]
        )
          rotate([0, 90, angle])
            cylinder(h=depth, r=thickness / 2);

        translate(
          [
            cos(angle + sweep_step) * radius,
            sin(angle + sweep_step) * radius,
            padding + curve_function(
              angle=angle + sweep_step,
              slot_range=slot_range,
            ),
          ]
        )
          rotate([0, 90, angle + sweep_step])
            cylinder(h=depth, r=thickness / 2);
      }
  }
}

// example https://www.desmos.com/calculator/w9jrdpvsmk
// sin(2x) + (1/s)sin(3(2x))
// y=\sin(\left(2x\right))+\frac{1}{s}\sin\left(3\left(2x\right)\right)

// s = depth of peaks
