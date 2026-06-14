//$vpt = [0,0,0];
//$vpr = [45, 0, 45];
$vpd = 500;

is_prod = true;
sweep_step = is_prod ? 1 : 10;
$fn = is_prod ? 128 : 60;

wavey_grove(
    shell_height = 150,
    shell_radius = 25,
    
    extra_shell=0.5,
    extra_slices=0.1,
    
    // inner grove
//    shell_wall = 10,
//    slot_depth = 5,
    // 2 halves
    shell_wall = 80,
    slot_depth = 50,
    
    slot_padding = 5,
    slot_range = 75,
    thickness = 50,
); 

module wavey_grove(shell_height,shell_radius,shell_wall,slot_padding,slot_range,thickness,slot_depth,extra_shell,extra_slices) {
    difference() {
        shell(
            height=shell_height,
            inner_radius=shell_radius,
            wall=shell_wall,
            extra=extra_slices,
        );
        wavey(
            padding=slot_padding,
            radius=shell_radius-extra_shell,
            thickness=thickness,
            depth=slot_depth,
            slot_range=slot_range,
            extra=extra_slices,
        );
    }
}

// The cylinder we cut the groove into
module shell(inner_radius,wall,height,extra) {
    difference() {
        cylinder(h=height,r=inner_radius+wall);
        // remove inner cylinder and leftover surface
        translate([0,0,-extra]) 
            cylinder(h=height+(extra*2),r=inner_radius);
    }
}

// Grove for pin in slot mechanism
function magic_height(padding,angle,height,tunable_dwell) =
    padding + (height * (
        0.5  // move from center
        + (
            sin(angle - (tunable_dwell * 360 * sin(angle - 90)))
            / 2
        )
    ));

// Generate wave by hull-ing each slice (a 1-thick slab) of the cylinder
module wavey(
    // Initial height
    padding,
    // Inner radius
    radius,
    // slot thickness
    thickness,
    // slot depth
    depth,
    // 
    slot_range,
    extra
) {
    tunable_dwell = 0.1;
    for(angle=[0:sweep_step:360]) {
        hull() {
            translate([
               cos(angle) * radius,
               sin(angle) * radius,
               magic_height(
                   padding=padding,
                   angle=angle,
                   height=slot_range,
                   tunable_dwell=tunable_dwell,
               )
            ])
            rotate([0,0,angle])
            linear_extrude(height = thickness)
            square([depth,extra]);

            translate([
               cos(angle+sweep_step) * radius,
               sin(angle+sweep_step) * radius,
               magic_height(
                   padding=padding,
                   angle=angle+sweep_step,
                   height=slot_range,
                   tunable_dwell=tunable_dwell
               )
            ])
            rotate([0,0,angle+sweep_step])
            linear_extrude(height = thickness)
            square([depth,extra]);
        }
    }
}


// example https://www.desmos.com/calculator/w9jrdpvsmk
// sin(2x) + (1/s)sin(3(2x))
// y=\sin(\left(2x\right))+\frac{1}{s}\sin\left(3\left(2x\right)\right)

// s = depth of peaks