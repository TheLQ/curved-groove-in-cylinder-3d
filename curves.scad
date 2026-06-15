// simple longer peak
curve_slowed_peak = function(angle, height)
(
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
