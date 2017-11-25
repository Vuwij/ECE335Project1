#setdep @previous@

set N @node@

proj_load  @plot@ CURVE_NAME($N)

cv_createDS IV($N) "CURVE_NAME($N) electrode_1 OuterVoltage" "CURVE_NAME($N) electrode_1 TotalCurrent" y
cv_setCurveAttr IV($N)  "IV" blue solid 2 circle 0 defcolor 1 defcolor

gr_setAxisAttr "X" "Voltage (V)" 20 0 5 black 1 15 0 1 lin
gr_setAxisAttr "Y" "Current (mA)" 20 0 0.5 black 1 15 0 1 lin
