#!pixmap-wish -f
# Program: tkxpmview
# Tcl version: 6.7 (Tcl/Tk/XF)
# Tk version: 3.2
# XF version: 2.2
# AtFSid: $Header: tkxpmview.tcl[6.0] Wed Oct  5 22:22:19 1994 garfield@mydomain.de frozen $
#

# procedure to show window ShowWindow.

# Procedure: ShowWindow.
proc ShowWindow. { args} {
# xf ignore me 7

  # window manager configurations
  global tkVersion
  wm positionfrom . ""
  wm sizefrom . ""
  wm geometry . 600x400
  wm maxsize . 1000 1000
  wm minsize . 10 10
  wm title . {tkxpmview}


  # build widget .frame
  frame .frame \
    -borderwidth {2} \
    -relief {raised}

  # build widget .frame.scrollbar1
  scrollbar .frame.scrollbar1 \
    -command {.frame.canvas2 yview} \
    -relief {sunken}

  # build widget .frame.scrollbar3
  scrollbar .frame.scrollbar3 \
    -command {.frame.canvas2 xview} \
    -orient {horizontal} \
    -relief {sunken}

  # build widget .top0.frame.canvas2
  canvas .frame.canvas2 \
    -height {100} \
    -insertofftime {600} \
    -relief {sunken} \
    -scrollregion {0c 0c 20c 60c} \
    -width {295} \
    -xscrollcommand {.frame.scrollbar3 set} \
    -yscrollcommand {.frame.scrollbar1 set}
  bind .frame.canvas2 <Configure> {
    SetPictures 1}
  bind .frame.canvas2 <Button-1> {
    global fileNames
    global pictureCounter
    set selTag [lindex [%W gettags [%W find closest [%W canvasx %x] [%W canvasy %y]]] 0]
    if {"$selTag" != ""} {
      set pictureCounter [lsearch $fileNames $selTag]
      .frame1.name conf -text $selTag
    }}
  bind .frame.canvas2 <Double-Button-1> {
    global fileNames
    global pictureCounter
    set selTag [lindex [%W gettags [%W find closest [%W canvasx %x] [%W canvasy %y]]] 0]
    if {"$selTag" != ""} {
      .frame1.name conf -text $selTag
      QuitProgram
    }}

  # pack widget .frame
  pack .frame.scrollbar1 -side right -fill y
  pack .frame.canvas2 -side top -expand 1 -fill both
  pack .frame.scrollbar3 -side top -fill x 

  # build widget .top0.frame1
  frame .frame1 \
    -borderwidth {2} \
    -relief {raised}

  # build widget .frame1.exit
  button .frame1.exit \
    -command {QuitProgram} \
    -text {Exit}

  # build widget .frame1.previous
  button .frame1.previous \
    -command {PreviousPic} \
    -text {<<<<}

  # build widget .frame1.next
  button .frame1.next \
    -command {NextPic} \
    -text {>>>>}

  # build widget .frame1.name
  label .frame1.name \
    -ancho {w} \
    -relief sunken \
    -text {}

  # pack widget .frame1
  pack .frame1.exit -side left -padx 4 -pady 4
  pack .frame1.previous -side left -padx 4 -pady 4
  pack .frame1.next -side left -padx 4 -pady 4
  pack .frame1.name -side left -expand 1 -fill both -padx 4 -pady 4

  # pack widget .
  pack .frame1 -side bottom -fill both
  pack .frame -side top -expand 1 -fill both

  if {"[info procs XFSendXFCommand]" != ""} {
    catch "XFSendXFCommand XFBindWidgetTree ."
    after 2 "catch {XFSendXFCommand XFEditSetShowWindows}"
  }
}

# Procedure: IsAFile
proc IsAFile { fileName} {
# xf ignore me 5
##########
# Procedure: IsAFile
# Description: check if filename is a file (including symbolic links)
# Arguments: fileName - the filename to check
# Returns: 1 if its a file, otherwise 0
# Sideeffects: none
##########

  if {[file isfile $fileName]} {
    return 1
  } {
    catch "file type $fileName" fileType
    if {"$fileType" == "link"} {
      if {[catch "file readlink $fileName" linkName]} {
        return 0
      }
      catch "file type $linkName" fileType
      while {"$fileType" == "link"} {
        if {[catch "file readlink $linkName" linkName]} {
          return 0
        }
        catch "file type $linkName" fileType
      }
      return [file isfile $linkName]
    }
  }
  return 0
}

# Procedure: NextPic
proc NextPic {} {
  global fileNames
  global onePicture
  global pictureCounter
  
  if {$onePicture == 1} {
    if {$pictureCounter < [expr [llength $fileNames]-1]} {
      incr pictureCounter
    } {
      set pictureCounter 0
    }
    SetPictures
  }
}

# Procedure: PreviousPic
proc PreviousPic {} {
  global fileNames
  global onePicture
  global pictureCounter
  
  if {$onePicture == 1} {
    if {$pictureCounter > 0} {
      incr pictureCounter -1
    } {
      set pictureCounter [expr [llength $fileNames]-1]
    }
    SetPictures
  }
}

# Procedure: QuitProgram
proc QuitProgram {} {
  global server
  global targetInterpreter
  global targetVariable

  if {"[info commands ClientShutdown]" != ""} {
    wm withdraw .
  } {
    if {"$targetInterpreter" != ""} {
      catch "send \{$targetInterpreter\} set $targetVariable \{[lindex [.frame1.name conf -text] 4]\}"
    }
    set targetInterpreter ""
    set targetVariable ""
    if {$server} {
      wm withdraw .
    } {
      puts stdout [lindex [.frame1.name conf -text] 4]
      catch "destroy ."
      catch "exit 0"
    }
  }
}

# Procedure: SetPictures
proc SetPictures {{relayoutOnly 0}} {
  global fileNames
  global onePicture
  global pictureCounter
  
  if {$relayoutOnly} {
    set width [winfo width [Alias Pictures]]
    set xpos 10
    set ypos 10
    set maxWidth 0
    set maxHeight 0
    set tmpWidth 0
    set tmpHeight 0
    foreach tag [[Alias Pictures] find all] {
      set file [lindex [[Alias Pictures] itemconf $tag -tags] 4]
      set tmpWidth [pinfo width @$file]
      set tmpHeight [pinfo height @$file]
      [Alias Pictures] coords $tag $xpos $ypos
      if {$tmpWidth > $maxWidth} {
        set maxWidth $tmpWidth
      }
      if {$xpos+$tmpWidth+10 >= $width && $xpos > 10} {
        incr ypos [expr $maxHeight+10]
        set maxWidth 0
        set maxHeight 0
        set xpos 10
        [Alias Pictures] coords $tag $xpos $ypos
        incr xpos [expr $tmpWidth+10]
      } {
        incr xpos [expr $tmpWidth+10]
      }
      if {$tmpHeight > $maxHeight} {
        set maxHeight $tmpHeight
      }
    }
    set xfBBox [[Alias Pictures] bbox all]
    if {"[lindex $xfBBox 2]" != "" && "[lindex $xfBBox 3]" != ""} {
      [Alias Pictures] config -scrollregion "0c 0c [expr [lindex $xfBBox 2]+20] [expr [lindex $xfBBox 3]+20]"
    } {
      [Alias Pictures] config -scrollregion "0c 0c 20 20"
    }
    return
  }
  [Alias Pictures] delete all
  if {$onePicture == 1} {
    if {"[lindex $fileNames $pictureCounter]" != ""} {
      if {[catch "[Alias Pictures] create bitmap 10 10 -anchor nw -bitmap @[lindex $fileNames $pictureCounter]" canvasID]} {
        puts stderr "$canvasID"
      }
      [Alias Pictures] addtag "[lindex $fileNames $pictureCounter]" withtag $canvasID
    }
  } {
    set width [winfo width [Alias Pictures]]
    set xpos 10
    set ypos 10
    set maxWidth 0
    set tmpWidth 0
    set tmpHeight 0
    foreach file $fileNames {
      if {[catch "[Alias Pictures] create bitmap $xpos $ypos -anchor nw -bitmap @$file" canvasID]} {
        puts stderr "$canvasID"
      } {
        [Alias Pictures] addtag "$file" withtag $canvasID
      }
    }
  }
}

# Procedure: tkxpmviewShow
proc tkxpmviewShow {args} {
  global targetInterpreter
  global targetVariable

  if {[llength $args] != 2} {
    error "wrong number of arguments!"
  }

  set targetInterpreter [lindex $args 0]
  set targetVariable [lindex $args 1]
  wm deiconify .
}

# Procedure: tkxpmviewQuit
proc tkxpmviewQuit {} {
  global targetInterpreter
  global targetVariable

  set targetInterpreter ""
  set targetVariable ""
  QuitProgram
}

# Procedure: Alias
if {"[info procs Alias]" == ""} {
proc Alias { args} {
# xf ignore me 7
##########
# Procedure: Alias
# Description: establish an alias for a procedure
# Arguments: args - no argument means that a list of all aliases
#                   is returned. Otherwise the first parameter is
#                   the alias name, and the second parameter is
#                   the procedure that is aliased.
# Returns: nothing, the command that is bound to the alias or a
#          list of all aliases - command pairs. 
# Sideeffects: xfAliasList is updated, and the alias
#              proc is inserted
##########
  global xfAliasList

  set xfMakeProc 1
  set xfWithName 0
  set xfNoComplain 0
  set xfTmpArgs ""
  foreach xfElement $args {
    case $xfElement in {
      {-noproc*} {
        set xfMakeProc 0
      }
      {-nocom*} {
        set xfNoComplain 1
      }
      {-withn*} {
        set xfWithName 1
      }
      {default} {
        lappend xfTmpArgs $xfElement
      }
    }
  }
  if {[llength $xfTmpArgs] == 0} {
    if {[info exists xfAliasList]} {
      return $xfAliasList
    }
  } {
    if {[llength $xfTmpArgs] == 1} {
      if {[info exists xfAliasList]} {
        set xfTmpIndex [lsearch $xfAliasList "[lindex $xfTmpArgs 0] *"]
        if {$xfTmpIndex != -1} {
          return [lindex [lindex $xfAliasList $xfTmpIndex] 1]
        } {
          if {!$xfNoComplain} {
            error "Alias: unknown alias name: [lindex $xfTmpArgs 0]"
          }
        }
      } {
        if {!$xfNoComplain} {
          error "Alias: unknown alias name: [lindex $xfTmpArgs 0]"
        }
      }
    } {
      if {[llength $xfTmpArgs] == 2} {
        if {"[lindex $xfTmpArgs 1]" == ""} {
          if {[info exists xfAliasList]} {
            set xfTmpIndex [lsearch $xfAliasList "[lindex $xfTmpArgs 0] *"]
            if {$xfTmpIndex != -1} {
              catch "rename [lindex $args 0] \"\""
              set xfAliasList [lreplace $xfAliasList $xfTmpIndex $xfTmpIndex]
            } {
              if {!$xfNoComplain} {
                error "Alias: unknown alias name: [lindex $xfTmpArgs 0]"
              }
            }
          } {
            if {!$xfNoComplain} {
              error "Alias: unknown alias name: [lindex $xfTmpArgs 0]"
            }
          }
        } {
          if {"[lindex $xfTmpArgs 0]" == ""} {
            if {[info exists xfAliasList]} {
              set xfTmpIndex [lsearch $xfAliasList "* [lindex $xfTmpArgs 1]"]
              if {$xfTmpIndex != -1} {
                return [lindex [lindex $xfAliasList $xfTmpIndex] 0]
              } {
                if {!$xfNoComplain} {
                  error "Alias: no aliases for: [lindex $xfTmpArgs 1]"
                }
              }
            } {
              if {!$xfNoComplain} {
                error "Alias: no aliases for: [lindex $xfTmpArgs 1]"
              }
            }
          } {
            if {[info exists xfAliasList]} {
              catch "rename [lindex $args 0] \"\""
              set xfTmpIndex [lsearch $xfAliasList "[lindex $xfTmpArgs 0] *"]
              if {$xfTmpIndex != -1} {
                set xfAliasList [lreplace $xfAliasList $xfTmpIndex $xfTmpIndex]
              }
              set xfTmpIndex [lsearch $xfAliasList "* [lindex $xfTmpArgs 1]"]
              if {$xfTmpIndex != -1} {
                set xfAliasList [lreplace $xfAliasList $xfTmpIndex $xfTmpIndex]
              }
            }
            if {$xfMakeProc} {
              if {$xfWithName} {
                eval "proc [lindex $xfTmpArgs 0] {args} {# xf ignore me 4
return \[eval \"[lindex $xfTmpArgs 1] [lindex $xfTmpArgs 0] \$args\"\]}"
              } {
                eval "proc [lindex $xfTmpArgs 0] {args} {# xf ignore me 4
return \[eval \"[lindex $xfTmpArgs 1] \$args\"\]}"
              }
            }
            if {[info exists xfAliasList]} {
              set xfTmpIndex [lsearch $xfAliasList "[lindex $xfTmpArgs 0] *"]
              if {$xfTmpIndex != -1} {
                set xfAliasList [lreplace $xfAliasList $xfTmpIndex $xfTmpIndex "[lindex $xfTmpArgs 0] [lindex $xfTmpArgs 1]"]
              } {
                lappend xfAliasList "[lindex $xfTmpArgs 0] [lindex $xfTmpArgs 1]"
              }
            } {
              set xfAliasList ""
              lappend xfAliasList "[lindex $xfTmpArgs 0] [lindex $xfTmpArgs 1]"
            }
          }
        }
      } {
        error "Alias: wrong number or args: $xfTmpArgs"
      }
    }
  }
  return ""
}
}

# initialize global variables
global {fileName}
set {fileName} {tkxpm.xpm}
global {fileNames}
set {fileNames} {tkxpm.xpm}
global {onePicture}
set {onePicture} {0}
global {pictureCounter}
set {pictureCounter} {0}


# module load procedure
proc XFLocalIncludeModule {{moduleName ""}} {
  global env
  global xfLoadInfo
  global xfLoadPath
  global xfStatus

  foreach p [split $xfLoadPath :] {
    if {[file exists "$p/$moduleName"]} {
      if {![file readable "$p/$moduleName"]} {
        puts stderr "Cannot read $p/$moduleName (permission denied)"
        continue
      }
      if {$xfLoadInfo} {
        puts stdout "Loading $p/$moduleName..."
      }
      source "$p/$moduleName"
      return 1
    }
    # first see if we have a load command
    if {[info exists env(XF_VERSION_SHOW)]} {
      set xfCommand $env(XF_VERSION_SHOW)
      regsub -all {\$xfFileName} $xfCommand $p/$moduleName xfCommand
      if {$xfLoadInfo} {
        puts stdout "Loading $p/$moduleName...($xfCommand)"
      }
      if {[catch "$xfCommand" contents]} {
        continue
      } {
        eval $contents
        return 1
      }
    }
    # are we able to load versions from wish ?
    if {[catch "afbind $p/$moduleName" aso]} {
      # try to use xf version load command
      global xfVersion
      if {[info exists xfVersion(showDefault)]} {
        set xfCommand $xfVersion(showDefault)
      } {
	# our last hope
        set xfCommand "vcat -q $p/$moduleName"
      }
      regsub -all {\$xfFileName} $xfCommand $p/$moduleName xfCommand
      if {$xfLoadInfo} {
        puts stdout "Loading $p/$moduleName...($xfCommand)"
      }
      if {[catch "$xfCommand" contents]} {
        continue
      } {
        eval $contents
        return 1
      }
    } {
      # yes we can load versions directly
      if {[catch "$aso open r" inFile]} {
        puts stderr "Cannot open $p/[$aso attr af_bound] (permission denied)"
        continue
      }
      if {$xfLoadInfo} {
        puts stdout "Loading $p/[$aso attr af_bound]..."
      }
      if {[catch "read \{$inFile\}" contents]} {
        puts stderr "Cannot read $p/[$aso attr af_bound] (permission denied)"
        close $inFile
        continue
      }
      close $inFile
      eval $contents
      return 1
    }
  }
  puts stderr "Cannot load module $moduleName -- check your xf load path"
  catch "destroy ."
  catch "exit 0"
}

# application resource parsing procedure
proc XFLocalParseAppDefs {xfAppDefFile} {
  global xfAppDefaults

  # basically from: Michael Moore
  if {[file exists $xfAppDefFile] &&
      [file readable $xfAppDefFile] &&
      "[file type $xfAppDefFile]" == "link"} {
    catch "file type $xfAppDefFile" xfType
    while {"$xfType" == "link"} {
      if {[catch "file readlink $xfAppDefFile" xfAppDefFile]} {
        return
      }
      catch "file type $xfAppDefFile" xfType
    }
  }
  if {!("$xfAppDefFile" != "" &&
        [file exists $xfAppDefFile] &&
        [file readable $xfAppDefFile] &&
        "[file type $xfAppDefFile]" == "file")} {
    return
  }
  if {![catch "open $xfAppDefFile r" xfResult]} {
    set xfAppFileContents [read $xfResult]
    close $xfResult
    foreach line [split $xfAppFileContents "\n"] {
      # backup indicates how far to backup.  It applies to the
      # situation where a resource name ends in . and when it
      # ends in *.  In the second case you want to keep the *
      # in the widget name for pattern matching, but you want
      # to get rid of the . if it is the end of the name. 
      set backup -2  
      set line [string trim $line]
      if {[string index $line 0] == "#" || "$line" == ""} {
        # skip comments and empty lines
        continue
      }
      set list [split $line ":"]
      set resource [string trim [lindex $list 0]]
      set i [string last "." $resource]
      set j [string last "*" $resource]
      if {$j > $i} { 
        set i $j
        set backup -1
      }
      incr i
      set name [string range $resource $i end]
      incr i $backup
      set widname [string range $resource 0 $i]
      set value [string trim [lindex $list 1]]
      if {"$widname" != "" && "$widname" != "*"} {
        # insert the widget and resourcename to the application
        # defaults list.
        set xfAppDefaults($widname:[string tolower $name]) $value
      }
    }
  }
}

# application resource loading procedure
proc XFLocalLoadAppDefs {{xfClasses ""} {xfPriority "startupFile"} {xfAppDefFile ""}} {
  global env

  if {"$xfAppDefFile" == ""} {
    set xfFileList ""
    if {[info exists env(XUSERFILESEARCHPATH)]} {
      append xfFileList [split $env(XUSERFILESEARCHPATH) :]
    }
    if {[info exists env(XAPPLRESDIR)]} {
      append xfFileList [split $env(XAPPLRESDIR) :]
    }
    if {[info exists env(XFILESEARCHPATH)]} {
      append xfFileList [split $env(XFILESEARCHPATH) :]
    }
    append xfFileList " /usr/lib/X11/app-defaults"
    append xfFileList " /usr/X11/lib/X11/app-defaults"

    foreach xfCounter1 $xfClasses {
      foreach xfCounter2 $xfFileList {
        set xfPathName $xfCounter2
        if {[regsub -all "%N" "$xfPathName" "$xfCounter1" xfResult]} {
          set xfPathName $xfResult
        }
        if {[regsub -all "%T" "$xfPathName" "app-defaults" xfResult]} {
          set xfPathName $xfResult
        }
        if {[regsub -all "%S" "$xfPathName" "" xfResult]} {
          set xfPathName $xfResult
        }
        if {[regsub -all "%C" "$xfPathName" "" xfResult]} {
          set xfPathName $xfResult
        }
        if {[file exists $xfPathName] &&
            [file readable $xfPathName] &&
            ("[file type $xfPathName]" == "file" ||
             "[file type $xfPathName]" == "link")} {
          catch "option readfile $xfPathName $xfPriority"
          if {"[info commands XFParseAppDefs]" != ""} {
            XFParseAppDefs $xfPathName
          } {
            if {"[info commands XFLocalParseAppDefs]" != ""} {
              XFLocalParseAppDefs $xfPathName
            }
          }
        } {
          if {[file exists $xfCounter2/$xfCounter1] &&
              [file readable $xfCounter2/$xfCounter1] &&
              ("[file type $xfCounter2/$xfCounter1]" == "file" ||
               "[file type $xfCounter2/$xfCounter1]" == "link")} {
            catch "option readfile $xfCounter2/$xfCounter1 $xfPriority"
            if {"[info commands XFParseAppDefs]" != ""} {
              XFParseAppDefs $xfCounter2/$xfCounter1
            } {
              if {"[info commands XFLocalParseAppDefs]" != ""} {
                XFLocalParseAppDefs $xfCounter2/$xfCounter1
              }
            }
          }
        }
      }
    }
  } {
    # load a specific application defaults file
    if {[file exists $xfAppDefFile] &&
        [file readable $xfAppDefFile] &&
        ("[file type $xfAppDefFile]" == "file" ||
         "[file type $xfAppDefFile]" == "link")} {
      catch "option readfile $xfAppDefFile $xfPriority"
      if {"[info commands XFParseAppDefs]" != ""} {
        XFParseAppDefs $xfAppDefFile
      } {
        if {"[info commands XFLocalParseAppDefs]" != ""} {
          XFLocalParseAppDefs $xfAppDefFile
        }
      }
    }
  }
}

# application resource setting procedure
proc XFLocalSetAppDefs {{xfWidgetPath "."}} {
  global xfAppDefaults

  if {![info exists xfAppDefaults]} {
    return
  }
  foreach xfCounter [array names xfAppDefaults] {
    if {[string match "${xfWidgetPath}*" $xfCounter]} {
      set widname [string range $xfCounter 0 [expr [string first : $xfCounter]-1]]
      set name [string range $xfCounter [expr [string first : $xfCounter]+1] end]
      # Now lets see how many tcl commands match the name
      # pattern specified.
      set widlist [info command $widname]
      if {"$widlist" != ""} {
        foreach widget $widlist {
          # make sure this command is a widget.
          if {![catch "winfo id $widget"]} {
            catch "$widget configure -[string tolower $name] $xfAppDefaults($xfCounter)" 
          }
        }
      }
    }
  }
}


# startup source
# Procedure: StartupSrc
proc StartupSrc { args} {
  if {"[info commands pinfo]" == ""} {
    puts stderr "This wish does not support pixmaps!"
    catch "destroy ."
    catch "exit 1"
  }
}

# end source
# Procedure: EndSrc
proc EndSrc {} {
  global argc
  global argv
  global bitmapButtons
  global currentColor
  global currentHeight
  global currentWidth
  global fileName
  global fileNames
  global itemSize
  global onePicture
  global server
  global targetInterpreter
  global targetVariable
  global xfLoadPath
  global fsBox

  set itemSize 10
  set fsBox(path) [pwd]
  set bitmapButtons {}
  set fileName {}
  set fileNames {}
  set server 0
  set targetInterpreter ""
  set targetVariable ""
  set localCurrentWidth 10
  set localCurrentHeight 10

  for {set counter 0} {$counter < $argc} {incr counter 1} {
    case [string tolower [lindex $argv $counter]] in {
      {-onepicture} {
        set onePicture 1
      }
      {-multipicture} {
        set onePicture 0
      }
      {-server} {
        set server 1
      }
      {default} {
        append fileNames "[lindex $argv $counter] "
      }
    }
  }
  
  if {$server} {
    wm withdraw .
  }
  update idletask
  SetPictures
  SetPictures 1

  if {"[info commands ClientLogin]" != ""} {
    ClientLogin tkxpmview
  }
}

# call startup source
StartupSrc

# please do not modify the following
# variables. They are needed by xf.
global {xfAliasList}
set {xfAliasList} {{Pictures .frame.canvas2}}
global {xfModuleAutoLoadList}
global {xfModuleTopsList}
set {xfModuleTopsList(main.tcl)} {.}
global {xfModuleProcsList}
set {xfModuleProcsList(main.tcl)} {}
global {xfProductName}
set {xfProductName} {tkxpmview.tcl}
global {xfProductClass}
set {xfProductClass} {TkXpmView}
global {xfProgramName}
set {xfProgramName} {main.tcl}
global {xfProgramPath}
set {xfProgramPath} {/home/garfield/tmp/xf2.3-make/xfpixmap}
global {xfWmSetPosition}
set {xfWmSetPosition} {}
global {xfWmSetSize}
set {xfWmSetSize} {.}
global {xfAppDefToplevels}
set {xfAppDefToplevels} {}

# display/remove toplevel windows.
ShowWindow.

# load default bindings.
if {[info exists env(XF_BIND_FILE)] &&
    "[info procs XFShowHelp]" == ""} {
  source $env(XF_BIND_FILE)
}

# parse and apply application defaults.
XFLocalLoadAppDefs TkXpmView
XFLocalSetAppDefs

# call end source
EndSrc

# eof
#

