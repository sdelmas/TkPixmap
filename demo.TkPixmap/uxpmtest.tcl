#
#	make a strip chart
#
#	turning on cyclePixmaps causes two create/destroy cycles each
#	iteration.  I tried running this for a while and tracking the
#	applications memory usage.  didn't see a leak but it really
#	should go overnight.
#
set seed [pid]

uxpm create chart 800 200 8 xpm3
uxpm clear chart -fill white

frame .cf -borderwidth 10
canvas .cf.chart -width 800 -height 200
.cf.chart create bitmap 0 0 -bitmap chart -anchor nw -tag strip
pack .cf.chart -side top
pack .cf -side top

frame .bf
pack .bf -side top
button .bf.run -text "Run" -command {set running 1}
pack .bf.run -side top
button .bf.stop -text "Stop" -command {set running 0}
pack .bf.stop -side top
button .bf.quit -text Quit -command {exit 0}
pack .bf.quit -side top

proc newY {} {
  if {"[info commands random]" == ""} {
    # random number algorithm derived from Lehmer's linear
    # congruence method, taken from Sedgewick's book.
    #
    global seed 

    set m [expr 1<<28]
    set b {}
    append b [string range $m 0 5] 821
    set seed [expr {($seed * $b + 1) % $m}]
    return [expr $seed%100]
  } {
    return [int [expr "[random 1000] * 0.2"]]
  }
}

proc stepChart {} {
    global shiftX lastY cyclePixmaps

    uxpm copy chart $shiftX 0 798 200 chart 0 0
    uxpm rectangle chart 798 0 2 200 -fill green
    set nextY [newY]
    uxpm line chart 798 $lastY 799 $nextY -fill red
    set lastY $nextY
    .cf.chart delete strip
    if {$cyclePixmaps} {
	uxpm create temp 800 200 8 xpm3
	uxpm copy chart 0 0 800 200 temp 0 0
	uxpm destroy chart
	uxpm create chart 800 200 8 xpm3
	uxpm copy temp 0 0 800 200 chart 0 0
	uxpm destroy temp
    }
    .cf.chart create bitmap 0 0 -bitmap chart -anchor nw -tag strip
}

proc runChart {} {
    global dtMs running lastY
    while {1} {
	if {$running} stepChart
	update
	after $dtMs
    }
}

set lastY 100
set shiftX 2
set plotX 789
set dtMs 2000
set running 0
set cyclePixmaps 1

after 100 runChart

