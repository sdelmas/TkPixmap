#!/bin/wish


button .foo -bitmap thepixmap -command "puts stdout foo"
pack .foo -side top
button .goo -bitmap thepixmap -command "puts stdout goo"
pack .goo -side top

proc refresh w {
    $w conf -bitmap thepixmap
}

proc draw1 { } {
    erase
    foreground blue
    lineto 10 10
    foreground red
    lineto 10 15
}

proc draw2 { } {
    pixresize 40 60
    erase
    moveto 1 1
    foreground green
    lineto 30 30
    foreground yellow
    lineto 30 55
    foreground blue
    lineto 5 55
}

draw1; refresh .foo; refresh .goo
after 3000 "draw2; refresh .foo" 
