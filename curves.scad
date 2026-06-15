// simple longer peak
// y=0.5+\left(\frac{\sin\left(x-\left(0.1\ \cdot\ \pi\ \cdot\ \sin\left(x-90\right)\right)\right)}{2}\right)
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
