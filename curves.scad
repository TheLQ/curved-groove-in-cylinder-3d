// simple longer peak
function curve_slowed_peak(padding, angle, height, tunable_dwell) =
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
