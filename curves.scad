// simple longer peak
// y=0.5+\left(\frac{\sin\left(x-\left(0.1\ \cdot\ \pi\ \cdot\ \sin\left(x-90\right)\right)\right)}{2}\right)
curve_slowed_peak = function(angle, slot_range)
(
  slot_range * (
    0.5 // move from center
    + (
      sin(
        angle - (
          0.1 // dwell
          * 360 * sin(angle - 90)
        )
      ) / 2
    )
  )
);

// simple continous wave
curve_simple_sin = function(angle, slot_range)
slot_range * (
  0.5 + sin(angle) / 2
);

// simple continous wave
curve_strange = function(angle, slot_range)
slot_range * (
  0.5 + sin(8 * angle) / 2
);

// simpler longer peak opposite curve
// todo: I don't know how else to do this besides working derivative on paper
