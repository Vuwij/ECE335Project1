#setdep @previous@

set N @node@

proj_load  @plot@ CURVE_NAME($N)

cv_createDS IV($N) "CURVE_NAME($N) electrode_2 OuterVoltage" "CURVE_NAME($N) electrode_2 TotalCurrent" y
cv_setCurveAttr IV($N)  "IV" blue solid 2 circle 0 defcolor 1 defcolor

gr_setAxisAttr "X" "Voltage (V)" 20 -10 0 black 1 15 0 1 lin
gr_setAxisAttr "Y" "Current (mA)" 20 -0.1 0.1 black 1 15 0 1 lin
