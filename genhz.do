-- jesper josefsson
-- 110214
restart -f nowave
view signals wave
add wave count clk hz1 hz2
force clk '0' 0, '1' 500 ns -repeat 1000 ns
run 1000000ms
