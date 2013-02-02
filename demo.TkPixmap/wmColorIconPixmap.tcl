# this code is based upon the code posted by:
# kennykb@dssv01.crd.ge.com (Kevin B. Kenny)
#
# AtFSid: $Header: wmColorIconPixmap.tcl[6.0] Sat Jul 30 17:16:05 1994 garfield@mydomain.de frozen $
#
# For testing please set this variable to 1
set testing 0

proc wm_color_iconpixmap {pathName pixmapName} {
  # the icon window name
  set number 0
  foreach counter [winfo children .] {
    if {[string match .xfIconToplevel* $counter]} {
      if {[string range $counter 15 end] > $number} {
        set number [string range $counter 15 end]
      }
    }
  }
  incr number
  set toplevelName .xfIconToplevel$number

  # create the icon window
  toplevel $toplevelName -borderwidth 0
  # create pixmap area
  label $toplevelName.xfpixmap -borderwidth 0 -bitmap $pixmapName
  # create label area. If your window manager correctly adds
  # a label, you can remove the labelcreation and pack command.
#  label $toplevelName.xflabel -borderwidth 0 -text [wm iconname $pathName]
  # show pixmap area
#  pack $toplevelName.xflabel -side bottom -fill both
  pack $toplevelName.xfpixmap -side top -fill both -expand 1

  # hide the icon window
  wm withdraw $toplevelName
  # update
  update idletask
  # set geometry
  wm geometry $toplevelName [winfo reqwidth $toplevelName]x[winfo reqheight $toplevelName]
  # register the wm stuff
  wm iconwindow $pathName $toplevelName
  # update again
  update
}

# testing
if {$testing} {
  wm maxsize . 1000 1000
  wm geometry . 100x100
  wm iconname . Testname1
  wm_color_iconpixmap . @example.gif
  toplevel .t1
  wm maxsize .t1 1000 1000
  wm geometry .t1 100x100
  wm iconname .t1 Testname2
  wm_color_iconpixmap .t1 @example.gif
  toplevel .t2
  wm maxsize .t2 1000 1000
  wm geometry .t2 100x100
  wm iconname .t2 Testname3
  wm_color_iconpixmap .t2 @example.gif
}

# eof
