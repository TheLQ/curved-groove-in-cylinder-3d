// simple longer peak
curve_slowed_peak = function(padding, angle, height)
padding + (
  height * (
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
