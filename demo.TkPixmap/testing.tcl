wm maxsize . 1000 1000
button .b
pack .b
menubutton .m -menu .m.m
pack .m
menu .m.m
.m.m add command
canvas .c
pack .c
set itemId [.c create bitmap 100 100 -bitmap @example.xpm]
update

puts stdout "Testing: 1"
.b conf -bitmap @example.xpm
update
puts stdout "Testing: 2"
.b conf -bitmap ""
update
puts stdout "Testing: 3"
.b conf -bitmap @example.xpm
update
puts stdout "Testing: 4"
.b conf -bitmap @example_m.xpm
update
puts stdout "Testing: 5"
.b conf -bitmap @example.xpm
update
puts stdout "Testing: 6"
.b conf -bitmap @example_m.xpm
update
puts stdout "Testing: 7"
.b conf -bitmap @example_m.xpm
update
puts stdout "Testing: 8"
.b conf -bitmap @example_m.xpm
update
puts stdout "Testing: 9"
.b conf -bitmap @example.xpm
update

puts stdout "Testing: 10"
.m conf -bitmap @example.xpm
update
puts stdout "Testing: 11"
.m conf -bitmap ""
update
puts stdout "Testing: 12"
.m conf -bitmap @example.xpm
update
puts stdout "Testing: 13"
.m conf -bitmap @example_m.xpm
update
puts stdout "Testing: 14"
.m conf -bitmap @example.xpm
update
puts stdout "Testing: 15"
.m conf -bitmap @example_m.xpm
update
puts stdout "Testing: 16"
.m conf -bitmap @example_m.xpm
update
puts stdout "Testing: 17"
.m conf -bitmap @example_m.xpm
update
puts stdout "Testing: 18"
.m conf -bitmap @example.xpm
update

puts stdout "Testing: 19"
.m.m entryconf 0 -bitmap @example.xpm
update
puts stdout "Testing: 20"
.m.m entryconf 0 -bitmap ""
update
puts stdout "Testing: 21"
.m.m entryconf 0 -bitmap @example.xpm
update
puts stdout "Testing: 22"
.m.m entryconf 0 -bitmap @example_m.xpm
update
puts stdout "Testing: 23"
.m.m entryconf 0 -bitmap @example.xpm
update
puts stdout "Testing: 24"
.m.m entryconf 0 -bitmap @example_m.xpm
update
puts stdout "Testing: 25"
.m.m entryconf 0 -bitmap @example_m.xpm
update
puts stdout "Testing: 26"
.m.m entryconf 0 -bitmap @example_m.xpm
update
puts stdout "Testing: 27"
.m.m entryconf 0 -bitmap @example.xpm
update

puts stdout "Testing: 28"
.c itemconf $itemId -bitmap @example.xpm
update
puts stdout "Testing: 29"
.c itemconf $itemId -bitmap ""
update
puts stdout "Testing: 30"
.c itemconf $itemId -bitmap @example.xpm
update
puts stdout "Testing: 31"
.c itemconf $itemId -bitmap @example_m.xpm
update
puts stdout "Testing: 32"
.c itemconf $itemId -bitmap @example.xpm
update
puts stdout "Testing: 33"
.c itemconf $itemId -bitmap @example_m.xpm
update
puts stdout "Testing: 34"
.c itemconf $itemId -bitmap @example_m.xpm
update
puts stdout "Testing: 35"
.c itemconf $itemId -bitmap @example_m.xpm
update
puts stdout "Testing: 36"
.c itemconf $itemId -bitmap @example.xpm
update

# eof
