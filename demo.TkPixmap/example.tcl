#!/usr/local/bin/X11/wish -f
# Program: tkxpmview
# Tcl version: 6.7 (Tcl/Tk/XF)
# Tk version: 3.2
# XF version: 2.2
# AtFSid: $Header: example.tcl[11.0] Wed Oct  5 22:22:18 1994 garfield@mydomain.de frozen $
#

# module inclusion


# initialize global variables
proc InitGlobals {} {
  global symbolicName
  set {symbolicName(root)} {.}
  global moduleList
  set {moduleList(example.tcl)} {}
}


# procedure to show window .
proc ShowWindow. {args} {

  # Window manager configurations
  wm title . {example}
  wm geometry . +39+181
  wm positionfrom . user
  wm sizefrom . program
  wm maxsize . 1152 900
  wm minsize . 0 0

  # build widget .frame0
  frame .frame0
  .frame0 configure \
    -borderwidth {2}\
    -relief {raised}


  # build widget .frame0.button10
  button .frame0.button10
  .frame0.button10 configure \
    -text {Save (complete, Xpm3)} \
    -command {.frame2.canvas10 save example1.xpm xpm3}


  # build widget .frame0.button11
  button .frame0.button11
  .frame0.button11 configure \
    -text {Save (rect, Xpm3)} \
    -command {.frame2.canvas10 save example2.xpm xpm3 100 100 100 100}


  # build widget .frame0.button12
  button .frame0.button12
  .frame0.button12 configure \
    -text {Save (rect, Xpm3)} \
    -command {.frame2.canvas10 save example3.xpm xpm3 -30 -30 100 100}


  # build widget .frame0.button9
  button .frame0.button9
  .frame0.button9 configure \
    -text {Quit} \
    -command {destroy .}


  # build widget .frame0.button4
  button .frame0.button4
  .frame0.button4 configure \
    -bitmap {gray50}\
    -text {button4}


  # build widget .frame0.button5
  button .frame0.button5
  .frame0.button5 configure \
    -bitmap {@example_p.bm}\
    -mask {@example_m.bm}\
    -text {button5}


  # build widget .frame0.button1
  button .frame0.button1
  .frame0.button1 configure \
    -bitmap {@example.xpm}\
    -text {button1}


  # build widget .frame0.button2
  button .frame0.button2
  .frame0.button2 configure \
    -bitmap {@example_m.xpm}\
    -text {button2}


  # build widget .frame0.button0
  button .frame0.button0
  .frame0.button0 configure \
    -bitmap {@example_p.xpm}\
    -text {button0}


  # pack widget .frame0
  pack .frame0.button4 -side left
  pack .frame0.button5 -side left
  pack .frame0.button0 -side left
  pack .frame0.button1 -side left
  pack .frame0.button2 -side left
  pack .frame0.button10 -side left
  pack .frame0.button11 -side left
  pack .frame0.button12 -side left
  pack .frame0.button9 -side left 


  # build widget .frame1
  frame .frame1
  .frame1 configure \
    -borderwidth {2}\
    -relief {raised}


  # build widget .frame1.menubutton7
  menubutton .frame1.menubutton7
  .frame1.menubutton7 configure \
    -bitmap {gray50}\
    -menu {.frame1.menubutton7.m}\
    -text {menubutton7}


  # build widget .frame1.menubutton7.m
  menu .frame1.menubutton7.m
  .frame1.menubutton7.m configure 

  # Menu widget code
  .frame1.menubutton7.m add command\
  -bitmap {gray50}\
  -label {sabber}

  # build widget .frame1.menubutton8
  menubutton .frame1.menubutton8
  .frame1.menubutton8 configure \
    -bitmap {@example_p.bm}\
    -menu {.frame1.menubutton8.m}\
    -text {menubutton8}

  # build widget .frame1.menubutton8.m
  menu .frame1.menubutton8.m
  .frame1.menubutton8.m configure 

  # Menu widget code
  .frame1.menubutton8.m add command\
  -bitmap {@example_p.bm}\
  -label {sabber}

  # build widget .frame1.menubutton1
  menubutton .frame1.menubutton1
  .frame1.menubutton1 configure \
    -bitmap {@example_p.xpm}\
    -menu {.frame1.menubutton1.m}\
    -text {menubutton1}

  # build widget .frame1.menubutton1.m
  menu .frame1.menubutton1.m
  .frame1.menubutton1.m configure 

  # Menu widget code
  .frame1.menubutton1.m add command\
  -bitmap {@example_p.xpm}\
  -label {sabber}

  # build widget .frame1.menubutton2
  menubutton .frame1.menubutton2
  .frame1.menubutton2 configure \
    -bitmap {@example_m.xpm}\
    -menu {.frame1.menubutton2.m}\
    -text {menubutton2}

  # build widget .frame1.menubutton2.m
  menu .frame1.menubutton2.m
  .frame1.menubutton2.m configure 

  # Menu widget code
  .frame1.menubutton2.m add command\
  -bitmap {@example_m.xpm}\
  -label {sabber}

  # build widget .frame1.button13
  button .frame1.button13
  .frame1.button13 configure \
    -text {Save (PS, mono)} \
    -command {.frame2.canvas10 postscript -colormode mono -file example4.ps}


  # build widget .frame1.button14
  button .frame1.button14
  .frame1.button14 configure \
    -text {Save (PS, gray)} \
    -command {.frame2.canvas10 postscript -colormode gray -file example5.ps}


  # build widget .frame1.button15
  button .frame1.button15
  .frame1.button15 configure \
    -text {Save (PS, color)} \
    -command {.frame2.canvas10 postscript -colormode color -file example6.ps}


  # pack widget .frame1
  pack .frame1.menubutton7 -side left
  pack .frame1.menubutton8 -side left
  pack .frame1.menubutton1 -side left
  pack .frame1.menubutton2 -side left
  pack .frame1.button13 -side left
  pack .frame1.button14 -side left
  pack .frame1.button15 -side left


  # build widget .frame5
  frame .frame5
  .frame5 configure \
    -borderwidth {2}\
    -relief {raised}


  # build widget .frame5.button10
  button .frame5.button10
  .frame5.button10 configure \
    -text {Formats} \
    -command {
      puts stdout "all: [pinfo formats]"
      puts stdout "get: [pinfo formats get]"
      puts stdout "put: [pinfo formats put]"
      puts stdout "toascii: [pinfo formats toascii]"
      puts stdout "topixmap: [pinfo formats topixmap]"}

  # build widget .frame5.button0
  button .frame5.button0
  .frame5.button0 configure \
    -text {Names} \
    -command {puts stdout [pinfo names]}


  # build widget .frame5.button11
  button .frame5.button11
  .frame5.button11 configure \
    -text {Size} \
    -command {
      puts stdout "width:[pinfo width @example.xpm]"
      puts stdout "height:[pinfo height @example.xpm]"
      puts stdout "depth:[pinfo depth @example.xpm]"}


  # build widget .frame5.button1
  button .frame5.button1
  .frame5.button1 configure \
    -text {Data} \
    -command {puts stdout [pinfo data @example.xpm xpm3]}


  # build widget .frame5.button2
  button .frame5.button2
  .frame5.button2 configure \
    -text {Define} \
    -command {
      puts stdout "pre names: [pinfo names]"
      pinfo define newPixmap [pinfo data @example.xpm xpm3]
      .frame5.button2 conf -bitmap newPixmap
      puts stdout "after names: [pinfo names]"}


  # build widget .frame5.button3
  button .frame5.button3
  .frame5.button3 configure \
    -text {Clipmask} \
    -command {
      puts stdout "pixmapid: [pinfo get @example_m.xpm]"
      puts stdout "clipmaskid: [pinfo clipmaskid @example_m.xpm]"
      puts stdout "clipmaskdata: [pinfo clipmaskdata @example_m.xpm]"
      puts stdout "pixmapid: [pinfo get @example_m.xpm]"
      puts stdout "clipmaskid: [pinfo clipmaskid @example_m.xpm]"
      puts stdout "clipmaskdata: [pinfo clipmaskdata @example_m.xpm]"}


  # build widget .frame5.button4
  button .frame5.button4
  .frame5.button4 configure \
    -text {Undefine} \
    -command {
      puts stdout "pre names: [pinfo names]"
      if {[lsearch [pinfo names] newPixmap] == -1} {
        pinfo define newPixmap [pinfo data @example.xpm xpm3]
      }
      puts stdout "removing: [pinfo get newPixmap]"
      pinfo undefine newPixmap
      puts stdout "after names: [pinfo names]"}


  # pack widget .frame5
  pack .frame5.button10 -side left
  pack .frame5.button0 -side left
  pack .frame5.button11 -side left
  pack .frame5.button1 -side left
  pack .frame5.button2 -side left
  pack .frame5.button3 -side left
  pack .frame5.button4 -side left


  # build widget .frame9
  frame .frame9
  .frame9 configure \
    -borderwidth {2}\
    -relief {raised}


  # build widget .frame9.label0
  label .frame9.label0
  .frame9.label0 configure \
    -text {Predefined pixmaps:}


  # build widget .frame9.label1
  label .frame9.label1
  catch ".frame9.label1 configure -bitmap bomb.xpm"


  # build widget .frame9.label2
  label .frame9.label2
  catch ".frame9.label2 configure -bitmap exclaim.xpm"


  # build widget .frame9.label3
  label .frame9.label3
  catch ".frame9.label3 configure -bitmap exit.xpm"


  # build widget .frame9.label4
  label .frame9.label4
  catch ".frame9.label4 configure -bitmap hourglass.xpm"


  # build widget .frame9.label5
  label .frame9.label5
  catch ".frame9.label5 configure -bitmap info.xpm"


  # build widget .frame9.label6
  label .frame9.label6
  catch ".frame9.label6 configure -bitmap no_entry.xpm"


  # build widget .frame9.label7
  label .frame9.label7
  catch ".frame9.label7 configure -bitmap preserver.xpm"


  # build widget .frame9.label8
  label .frame9.label8
  catch ".frame9.label8 configure -bitmap question.xpm"


  # build widget .frame9.label9
  label .frame9.label9
  catch ".frame9.label9 configure -bitmap stop.xpm"


  # build widget .frame9.label10
  label .frame9.label10
  catch ".frame9.label10 configure -bitmap tick.xpm"


  # pack widget .frame9
  pack .frame9.label0 -side left
  pack .frame9.label1 -side left
  pack .frame9.label2 -side left
  pack .frame9.label3 -side left
  pack .frame9.label4 -side left
  pack .frame9.label5 -side left
  pack .frame9.label6 -side left
  pack .frame9.label7 -side left
  pack .frame9.label8 -side left
  pack .frame9.label9 -side left
  pack .frame9.label10 -side left


  # build widget .frame2
  frame .frame2
  .frame2 configure \
    -borderwidth {2}\
    -relief {raised}


  # build widget .frame2.canvas10
  canvas .frame2.canvas10
  .frame2.canvas10 configure \
    -borderwidth {0}\
    -confine {true}\
    -height {237}\
    -relief {raised}\
    -width {277}\
    -xscrollcommand {NoFunction}\
    -yscrollcommand {NoFunction}


  # build canvas items .frame2.canvas10
  .frame2.canvas10 addtag {sabber} withtag [.frame2.canvas10 create bitmap 170 100]
  .frame2.canvas10 itemconfigure {sabber}\
    -bitmap {@example_p.bm}\
    -tags {sabber} 
  .frame2.canvas10 addtag {sabber2} withtag [.frame2.canvas10 create bitmap 100 100]
  .frame2.canvas10 itemconfigure {sabber2}\
    -bitmap {gray50}\
    -tags {sabber2} 
  .frame2.canvas10 addtag {sabber1} withtag [.frame2.canvas10 create bitmap 50 100]
  .frame2.canvas10 itemconfigure {sabber1}\
    -bitmap {@example_p.xpm}\
    -tags {sabber1} 
  .frame2.canvas10 addtag {sabber5} withtag [.frame2.canvas10 create bitmap 60 100]
  .frame2.canvas10 itemconfigure {sabber5}\
    -bitmap {@example_m.xpm}\
    -tags {sabber5} 
  .frame2.canvas10 addtag {kkkk} withtag [.frame2.canvas10 create oval 10 10 70 70]
  .frame2.canvas10 itemconfigure {kkkk}\
    -fill {red}\
    -stipple {@example_p.bm}\
    -tags {kkkk} 
  .frame2.canvas10 addtag {llll} withtag [.frame2.canvas10 create oval 170 170 200 200]
  .frame2.canvas10 itemconfigure {llll}\
    -fill {red}\
    -stipple {gray50}\
    -tags {llll} 
  .frame2.canvas10 addtag {gif} withtag [.frame2.canvas10 create bitmap 290 170]
  .frame2.canvas10 itemconfigure {gif}\
    -bitmap {@example.gif}\
    -tags {gif} 
  .frame2.canvas10 addtag {mask} withtag [.frame2.canvas10 create bitmap 200 170]
  .frame2.canvas10 itemconfigure {mask}\
    -bitmap {@example_p.bm}\
    -mask {@example_m.bm}

  # pack widget .frame2
  pack .frame2.canvas10 -side left -expand 1 -fill both 

  # pack widget .
  pack .frame0 -side top -fill x
  pack .frame1 -side top -fill x
  pack .frame5 -side top -fill x
  pack .frame9 -side top -fill x
  pack .frame2 -side top -expand 1 -fill both

  if {[string length [info commands .XFEdit]] > 0} {
    XFEditSetShowWindows
    XFMiscBindWidgetTree .frame2
  }
}


# User defined procedures


# Internal procedures


# Procedure: MenuPopupAdd
if {[string length [info procs MenuPopupAdd]] == 0} {
proc MenuPopupAdd { xfW xfButton xfMenu} {

  if {[catch "bind $xfW \"<ButtonPress-$xfButton>\"                 \"$xfMenu post %X %Y\"" xfResult] != 0} {
    XFError "$xfResult"
    return
  }
  # we need these to counteract the effects of passive grabs :-(
  if {[catch "bind $xfW \"<ButtonRelease-$xfButton>\"                 \"$xfMenu invoke active; $xfMenu unpost\"" xfResult] != 0} {
    XFError "$xfResult"
    return
  }
  if {[catch "bind $xfW \"<B$xfButton-Motion>\"                 \"MenuPopupHandle $xfMenu %W %X %Y\"" xfResult] != 0} {
    XFError "$xfResult"
    return
  }
}
}


# Procedure: MenuPopupHandle
if {[string length [info procs MenuPopupHandle]] == 0} {
proc MenuPopupHandle { xfMenu xfW xfX xfY} {

 if {[winfo ismapped $xfMenu]} {
   set xfPopMinX [winfo rootx $xfMenu]
   set xfPopMaxX [expr "$xfPopMinX + [winfo width $xfMenu]"]
   if {($xfX >= $xfPopMinX) &&  ($xfX <= $xfPopMaxX)} {
     $xfMenu activate @[expr "$xfY - [winfo rooty $xfMenu]"]
   } {
     $xfMenu activate none}
   }
}
}


# Procedure: NoFunction
if {[string length [info procs NoFunction]] == 0} {
proc NoFunction { args} {

}
}


# Procedure: SymbolicName
if {[string length [info procs SymbolicName]] == 0} {
proc SymbolicName { {xfName ""}} {
  global symbolicName

  if {[string length $xfName] > 0} {
    set xfArrayName ""
    append xfArrayName symbolicName ( $xfName )
    if {[catch "set \"$xfArrayName\"" xfValue] == 0} {
      return $xfValue
    } {
      if {[string length [info commands XFError]] > 0} {
        XFError "Unknown symbolic name:\n$xfName"
      } {
        puts stderr "XF error: unknown symbolic name:\n$xfName"
      }
    }
  }
  return ""
}
}


# initialize global variables
# remove this call if there are problems at startup
InitGlobals


# stuff to display and remove toplevel windows
# call the procedures to create the toplevels.
ShowWindow.



# eof
#
