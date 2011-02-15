-- mealy.do
-- jesper josefsson
-- 110214
restart -f nowave
view signals wave
add wave x u q qinner qpinner clk reset
force x "01"
force reset 1 0, 0 80
force clk 0 0, 1 50 -repeat 100
run 100
force x "01" 0, "11" 100, "10" 200
run 300
force x "00" 
#01, 11
run 200
force x "00" 
#still 11
run 100
force x "11" 
# 10
run 100
force x "10"
run 100 
# should now be at 00
force x "00"
run 100
force x "01"
run 100 
# 00
force x "00"
run 100
force x "11"
run 100 
# 00
force x "00"
run 100
force x "10"
run 100 
# 00
force x "00"
run 200
force x "01"
run 100 
# 00
force x "00"
run 200
force x "10"
run 100 
# 00
force x "00"
run 200
force x "11"
run 100
force x "01"
run 100
force x "00"
run 200
force x "11"
run 100
force x "11"
run 100 
# 00
force x "00"
run 200
force x "11"
run 100
