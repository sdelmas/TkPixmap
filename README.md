The TkPixmap extension

Copyright (c) 1993 by Sven Delmas
All rights reserved.
See the file COPYRIGHT for the copyright notes.

Changes:
--------
        - Tk 3.2 support has been removed. Use
          the previous TkPixmap release for Tk 3.2
        - Enhanced configuration
        - Support for shared libs
        - The file uxpm.c is more portable now
        - Enhanced postscript support
        - Some minor bug fixes


What is TkPixmap ?
------------------
This patch allows you to use standard (monochrome) bitmaps
and (color) pixmaps in other formats (like Xpm3 or gif). You
can specify a clip mask for the bitmaps. As an additional
feature, there is a new command to manipulate bitmap data
named pinfo(n). The new command uxpm(n) can be used to draw
into a pixmap. It is possible to save the contents of a
canvas to a file in one of the supported formats (if this
format can be saved, which is right now only possible with
Xpm3). This patch also contains the patch (tk-pixmap.tar.Z)
posted by Kennard (kennard@ohm.berkeley.edu) in a slightly
modified form. Take a look at the notes below, or at the
source to see the changes.

If someone has interesting (small, powerful and bug-free ;-)
pixmap loading routines, please send them to me. It should
be easy to add them to the patch, although I would recommend
to use only Xpm3 in your new wish (turn off the gif support
by removing -DUSE_GIF in the Makefile). It is easy to
transform gif pictures (or any other format) to Xpm3 with
the pbmplus package (part of the X11 contrib tape). So,
instead of making your wish executable big, use only the
Xpm3 format and compress (gzip) the pictures (if you have
not much disk space). Xpm3 is the most powerful format, as
it provides a save command, and it is an Ascii format which
allows manipulation of pixmaps via Tcl.


Preloaded Pixmaps:
------------------
This distribution contains some Xpm3 pixmaps that are
embedded into the library to make them permanently available
(like the bitmaps that are available). If you don't want
them, take a look at the section that describes the
configuration. The pixmaps are taken (derived) from the
icon package AIcons (available at export.lcs.mit.edu)
published by Anthony Thyssen (anthony@cit.gu.edu.au).

The preloaded pixmaps in the files have been converted to a
special format. This was done with the Tcl script
"./pixmaps/XpmConvert.tcl". It is necessary to do this as
the Tk_DefinePixmap function expects a Tcl list with the
Xpm3 definition. 


Color window manager icons:
---------------------------
This release patches the "wm iconbitmap" command. So, it
should be possible to use color icons simply by calling 
this command with the correct pixmap. 

In case this does not work I wrote the procedure named
wm_color_iconpixmap (based upon the code posted by Kevin B.
Kenny), which can be found in the file "wmColorIconPixmap.tcl".
This procedure gets two arguments. First the pathname of the
toplevel which gets the color pixmap icon, and the second
parameter is the pixmap name to attach. With this procedure,
it is possible to use a pixmap as icon picture. Till now, I
have not found many window managers that support this
procedure. But as there are some (like fvwm), I believe that
this is rather a problem of the window manager than of Tk or
my procedure. Under most window managers, you will get a
color icon, but this icon will not respond to any mouse event.


Lightweight plotting to canvas:
-------------------------------
Thanks to Martin L. Smith for contributing his plotting command.
The command is a set of extensions that support plotting,
clearing, and copying of user-defined pixmaps.  The pixmaps can
be displayed by posting them to a canvas. The command is named
"uxpm".


Color handling in TkPixmap:
---------------------------
One important issue is the handling of colors in TkPixmap.
Loaded pixmaps use the default colormap. This is important
and should be considered when you are writing your own
loading routines. If a pixmap requires more colors than the
ones available in the colormap, the loading routines try to
use already allocated colors. If you use pictures with many
colors, it is important that the pixmap is loaded after Tk
has allocated all colors it needs. While the pixmap loading
routines try to reuse already allocated colors, Tk does not
do that and changes to the monochrome model when there is no
free color cell available (which is the case after loading
pictures with many colors... at least at my 256 color
station :-).

The reason for using the default colormap is quite simple...
I do not understand what happens when I try to establish a
private colormap. It seems that Tk ignores this private
colormap and still uses the default colormap which causes
garbled colors. Sorry, but I have no time to investigate
that in detail, and as a future release of Tk will hopefully
contain support for color pixmaps, I leave this problem to
John Ousterhout (sorry, John ;-)

To add support for private colormaps, you should take a look
at the package TkPC which was posted by Rainer Kliese 
(stester@ag4.ruhr-uni-bochum.de). This package gives access to
the colormap handling. You can also use the colorfocus
extension that comes with the photo widget which was posted
by Paul Mackerras (paulus@cs.anu.edu.au).


Pixmap extension:
-----------------
You can use the color pixmaps in buttons, menus and
wherever the -bitmap option is used. Pixmaps can have a
clip mask to specify which pixels are set and which ones are
not. This clip mask is either defined in the picture itself
(Xpm3), or by using the new -mask option. 

Access to the pixmaps from the Tcl command level is provided
with a new command named pinfo(n). The changes to Tk are on a
very low level, so that every program (widget) that uses the
standard Tk routines to handle the -bitmap resource can now
use bitmaps and pixmaps.

To save the contents of a canvas widget, use the new canvas
command "save". You have to specify the filename and the
format, and you can optionally specify a region to save
(x,y, width and height).  Ahh, and before you ask... it is
not possible to read a pixmap (i.e. Xpm3) file, and create a
canvas structure from this information. All you can do is to
use this pixmap file as a bitmap in a canvas item of the
type bitmap.

To use the pixmap extension in your own C programs, the only
change that is necessary is the renaming of the used
tkBitmap.c functions to those defined in tkPixmap.c. I do
not guarantee that this patch works, but it works for me, so
it should work for you as well :-).


User defined Pixmaps:
---------------------
The included files also contain an extension to Tk for
support of user defined pixmaps. This extension allows the
program to draw on a pixmap (using Xlib calls), and to have
that pixmap displayed by a Tk button, menu, menubutton or
canvas pixmap. This extension is from Kennard
(kennard@ohm.berkeley.edu). To see it in action, you can
build a small demo program that uses the C-interface to
TkPixmap (take a look into the building instructions below).

The version of tkPixmap.c has been extended to support
pixmaps (color bitmaps). The primary function is
Tk_DefinePixmap(). Most functions have been modified to
support the concept of depth, and the new function
Tk_DepthOfPixmap() has been defined. The pixmap can be
allocated by the the user and specified when calling
Tk_DefinePixmap(), or its creation can be deferred until
Tk_GetPixmap() is called. In the latter case, the bitmap
will initially have random data.

The function Tk_UndefinePixmap() is provided. This allows a
given name to be re-used over the lifetime of the
application. This is particularly useful when the pixmap is
not global, but widget-specific, and needs to be removed
when the widget dies. 

There are some complications concerning the ability to
undefine a pixmap. The application may still have the bitmap
in use when it is undefined, thus the pixmap can't be freed
until the final call to Tk_FreePixmap() (which makes sense,
of course). However, to prevent the now undefined bitmap
from being referred to, we must remove it from the name
table. A consequence of this is that the pixmap's true name
is then no longer available via Tk_NameOfPixmap(). If this
is a serious problem, it can be solved by storing the name
in the TkBitmap structure.

Note:   There is some confusion in some places about whether
        the name should use "bitmap" or "pixmap". I'm
        tempted to use pixmap everywhere, since that's the
        X11 concept.
Note:   This code currently supports multiple pixmaps of the
        same "name" on different displays.  This really
        should be changed to be on a per-screen basis, not
        per-display. Many displays have two screens: a mono
        and an 8-bit one; these require different pixmaps
        since the depth is different.
Note:   Widgets that use bitmaps are unaffected by this
        support for pixmaps. That means, no errors will
        occur if a widget expecting a bitmap gets a pixmap
        instead. Also, the pre-existing API to this module
        has not changed; only new functions have been added.
        To fully support pixmaps, widgets should add one
        if-clause and an XCopyArea() call; see the patches
        included.
Note:   The big size of this patch is a result of the Xpm3
        package, which is now included into the distribution
        (or in other words... the Xpm3 package contains a
        small patch for Tk ;-). I was asked to include the
        Xpm3 package, to make the installation easier, to
        prevent YOU (the user) from searching for this
        package in different locations and to prevent
        version conflicts with newer (or older) versions of
        Xpm3. So... it's now part of the patch. I hope it's
        ok and makes life easier for you :-).


Compressing pictures:
---------------------
The Xpm3 and the gif loading routines both allow the loading
of compressed and gziped files. The extensions for gziped
files must be ".gz".


Kanji support:
--------------
You can use tkPixmap3.6-jp.pat to apply the pixmap support
to a Kanji Tk source tree. To build a new wish with
Kanji support, call ./configure with the -with-kanji 
parameter. The Kanji Tk source is searched in the
directory ../tk3.6-jp (or ../tk3.6jp) relative to
the TkPixmap directory. Of course, you will also
need a Kanji Tcl which is searched in ../tcl7.3-jp
(or ../tcl7.3jp). This version of TkPixmap requires
the tk3.6jp-patch.gz and tk3.6jp-update1.gz patches.


Compatibility notes:
--------------------
The changes of the original Tk distribution affect all
occurrences of XCopyPlane(), Tk_GetBitmap(),
Tk_FreeBitmap(), Tk_SizeOfBitmap(), Tk_DefinePixmap(),
Tk_GetBitmapFromData(), Tk_NameOfBitmap() in the files:
tkMenu.c, tkMenubutton.c, tkButton.c, tkCanvBmap.c,
tkConfig.c and tk.h.

The main part of the additional features is implemented in
tkPixmap.c which is an adapted version of tkBitmap.c. The
patches for the other files only add the ability to display
color pixmaps to the standard widgets. In tkPixmap.c, there
exists a new data structure, named GraphicTypes, where all
supported graphic types are entered. To add a new graphic
type, add the function names to this data structure, and
write the interface routines (take a look at the code to see
what these routines look like).

The Xpm3 distribution that comes with this patch is a subset
of the original Xpm3 distribution. If you have a publically
installed correct version of the Xpm3 library, this library
will be used automatically.

I cannot guarantee that the changes will work in every case,
but I think they are so small, that in the worst case you
just don't get a color pixmap but no core or program
termination.


Requirements:
-------------
        - The Tk-3.6 package (or newer ?!).

        - The Xpm 3.4b package from GROUPE BULL
          (BULL Research FRANCE -- Koala Project).
          This package is part of the TkPimxap 
          distribution. The library is also available at:
            avahi.inria.fr (pub/xpm/xpm3...), or
            export.lcs.mit.edu


Calling configure:
------------------
When you call ./configure in the temporary TkPixmap
build directory (see below, several additional
parameters allow the selection of new packages etc..
Several packages allow the setting of additional 
subparameters. Setting one of these subparameters
means that all default settings for the subparameters
are ignored. So you have to list all required
subparameters by hand. Most parameters are directly
mapped to compiler options, so the configuration can
also be adapted by changing the Makefile directly. The
configuration reads the file "config.init", where the
several default settings are defined. The current
parameters are stored in the file "config.local". This
file can be used by calling ./configure with
-with-config-local.

IMPORTANT!!!!
If you call ./configure with new parameters (compared to
a previous call of ./configure), you should call "make
clean" before you build the new wish.

        -with-config-local (default=off)
                Call ./configure with the parameters
                of the last ./configure call.

        -with-nogcc (default=off)
                This disables the usage of gcc, irrespective
                of the existance of gcc.

        -with-tklibrary=pathName (default=/usr/local/tk...)
                This specifies a new TK_LIBRARY path.
                The new Tk library searches for the
                Tk library files in this directory.

        -with-tkpixmap (default=on)
                This adds the TkPixmap extension to
                the wish. There are several 
                subparameters for this parameter:

                -with-tkpixmap-pinfo (default=on)
                        adds the pinfo(n) command to the
                        interpreter
                -with-tkpixmap-uxpm (default=on)
                        adds the uxpm(n) command to the
                        interpreter
                -with-tkpixmap-pixmaps (default=on)
                        includes the predefined pixmaps
                        into the code
                -with-tkpixmap-xpm (default=on)
                        adds support of Xpm3 pixmaps. This
                        requires the Xpm3 library.
                -with-tkpixmap-localxpm (default=off)
                        causes the use of the local Xpm3
                        library. Otherwise, a globally 
                        installed Xpm3 library is used, if
                        there is any.
                -with-tkpixmap-gif (default=on)
                        adds support of gif pictures. This
                        support is restricted to the reading
                        of gif pictures. Saving and the
                        other commands available for Xpm3 are
                        not supported for gif pictures. If
                        someone has the required routines,
                        please send them to me.
                -with-tkpixmap-raw256 (default=off)
                        adds support of raw 256x256 pixmaps
                -with-tkpixmap-dps (default=off)
                        adds support for dps on a server that
                        supports display postscript

        -with-tksteal (default=off)
                This adds the TkSteal extension to
                the wish.

        -with-tkmegawidget (default=off)
                This adds the TkMegaWidget extension to
                the wish. There are several 
                subparameters for this parameter:

                -with-tkmegawidget-des (default=off)
                        adds the DES encryption library
                        to the TkMegaWidget.
                -with-tkmegawidget-localdes (default=off)
                        causes the use of the local des
                        library. Otherwise, a globally 
                        installed des library is used, if
                        there is any.

        -with-kanji (default=off)
                This allows the building of a Kanji
                wish. You have to provide the already
                patched Tk source tree under the name
                ../tk3.6-jp (or ../tk3.6jp) and the
                patched Tcl source tree under the name
                ../tcl7.3-jp (or ../tcl7.3jp).

        -with-tkicon (default=off)
                This adds the TkIcon extension to
                the wish.

        -with-tkmobal (default=off)
                This adds the TkMobal extension to
                the wish.

        -with-blt (default=off)
                This adds the BLT extension to the
                wish. Adding this feature makes it
                necessary to build and install the
                BLT package before you build this
                package. If there is no globally
                installed library, configure looks
                in the directory ../blt for a local
                copy.

        -with-itcl (default=off)
                This adds the itcl extension to the
                wish. Adding this feature makes it
                necessary to build and install the
                itcl package before you build this
                package. If there is no globally
                installed library, configure looks
                in the directory ../itcl for a local
                copy.

        -with-expect (default=off)
                This adds the expect extension to the
                wish. Adding this feature makes it
                necessary to build and install the
                expect package before you build this
                package. If there is no globally
                installed library, configure looks
                in the directory ../expect for a local
                copy.

        -with-tclX (default=off)
                This adds the TclX extension to the
                wish. Adding this feature makes it
                necessary to build and install the
                extended Tcl package before you build
                this package. If there is no globally
                installed library, configure looks
                in the directory ../tclX for a local
                copy.

        -with-tcldp (default=off)
                This adds the Tcl-DP package to the
                wish. Adding this feature makes it
                necessary to build and install the
                tcl-dp package before you build this
                package. If there is no globally
                installed library, configure looks
                in the directory ../tcl-dp for a local
                copy.

        -with-tclload (default=off)
                This adds the dynamic loading package to
                the wish. Adding this feature makes it
                necessary to build the shells package
                before you build this package. The shells
                package must be located in the same
                directory as the other extension packages
                under the name "shells".

        -with-noshlib (default=off)
                Even if the system supports shared
                libraries, don't build them.


Building a patched wish:
------------------------
         1) Please take a look into the "Portability"
            section at the bottom first. The installation
            may require a special handling for your system.

         2) Unpack the Tk distribution. Build the Tk
            distribution as described in the Tk README. If
            your system supports shared libraries, and
            you want to use them, you should build the
            Tcl and the Tk distribution with the
            tcltk_shlib package published by Xiaokun Zhu.

         3) Unpack the TkPixmap distribution in the same
            directory where you have unpacked the Tk
            distribution.

         4) The resulting directory structure will look
            about like that:

            .../
               |
               +-- tcl7.3
               |
               +-- tk3.6
               |
               +-- TkPixmap
               |
               +-- TkSteal
               |
               ....

            Now change into the new TkPixmap directory.

         5) Configure the distribution by running ./configure.
            And do all the things you usually do to get a
            working Tk. To select certain additional 
            packages and perform other changes of the new
            wish, you can call ./configure with several
            parameters. Take a look into the configure
            section above for a detailed list. Certain
            extensions have to be built and installed before
            you can use them. You should take care that the
            TK_LIBRARY path is valid. This means that you
            either use the path from a previous Tk
            installation, or you create the new path, and
            copy all Tk library files to that directory.

         6) If you have selected Xpm3 support (default), the
            libxpm library is built automatically if necessary.
            If there is a globally installed Xpm3 library,
            this one will be used (specify 
            -with-tkpixmap-localxpm to force the usage of the
            local Xpm3 library). The Makefile is created
            automatically when you call the toplevel ./configure.
            If you have problems with this Makefile creation, you
            can also manually call:
        
                xmkmf; make.

            The library is not installed. This can be done
            manually.

         7) A new libtk will be built, as there are some
            minor problems with certain packages (especially
            with tcl-DP). This libtk is totally compatible with
            the previous libtk (the static and the shared
            version). So, I decided to install the library
            under the same name. If you do not want this,
            change the TK_LIB_NAME in the toplevel Makefile
            (go to 9)).

         8) Build the new wish (to build a new wish with
            a manually adapted Makefile, go to 9)). This
            will copy the required files to the local
            directory. Then these files are patched (the 
            protocol can be found in the files *.patch.out).
            The new local libtk and the required local
            extension libraries are built. Finally the new
            wish is linked. If your system supports shared
            libraries, they will be generated automatically.
            As the position of shared libraries is usually
            very critical, the libraries are automatically 
            installed in the final library directory when
            they are built. This makes it necessary that you 
            have write permission for that directory. To
            build the new wish, type:

                make

            Now go to 10) to continue the installation.

         9) If you want to change the toplevel Makefile
            manually (usually this is not required), first,
            you have to call:

                make prepare

            Adapt the Makefile to your personal needs. Now
            you can build the new wish (don't call "make"
            as you would normally do (see 8)), but call:

                make wish
        
        10) You can now install everything by typing this:

                make install

            This will install the new wish, the new library
            files and the new doc. By default, the library
            files are placed in the TK_LIBRARY directory.

        11) You can now look at what the pixmap extension by
            kennard@ohm.berkeley.edu can do for you by
            typing:

                make pixmapDemo

        12) You can now look at what TkPixmap can do for you
            by typing:

                cd demo.TkPixmap
                ../wish/pixmap-wish -f example.tcl

            and:
 
                cd demo.TkPixmap
                ../wish/pixmap-wish -f uxpmtest.tcl

        13) You can also run a short test on the pixmap
            extension by typing:

                cd demo.TkPixmap
                ../wish/pixmap-wish -f testing.tcl

        14) After that, you should test the new installed
            wish. If everything works fine, you can remove
            the temporary build directories.

        15) To prevent problems, please don't use this directory
            structure for totally different configurations. The
            subdirectories may contain newly copied files that
            are not removed automatically when you reconfigure
            the distribution. So you will end up in a totally
            corrupted distribution (especially the libtk directory
            will be corrupted, and will create libtk.a versions
            that cannot work). So, if you decide to reconfigure
            this package, and to drop certain packages from the
            new wish, please delete the current directorytree.
            Use a newly unpacked distribution to prevent trouble.


Installing tkxpmview:
---------------------
The package contains a small program named tkxpmview. This
program gets a list of picture filenames and displays them
in a window. With the option -onepicture, the user can
switch to a mode displaying one picture at a time. The
program is installed automatically. It may be necessary to
change the wish name and path at the beginning of the 
installed file named "tkxpmview".


Documentation:
--------------
The manual pages for some widgets contain the reference to
the new -mask option. The documentation of the canvas widget
now contains a description of the new save command. The new
Tk commands pinfo(n) and uxpm(n) have a manual page, and the
manual page GetPixmap contains all newly defined pixmap
commands.


Portability:
------------
General:
        - If you get an error message about an undefined
          symbol ___main, you have built your Tk libraries
          with gcc and the TkSteal code with cc. Please
          use the same compiler for both packages.

        - If the widgets do not work as expected under the
          new wish, maybe you have forgotten to adapt the
          TK_LIBRARY path in the Makefile, or you have not
          created the new TK_LIBRARY path with all Tk
          library files.

        - Patching on a 14 character limited file system may
          cause problems. The filename tkMenubutton.c is
          too long to be handled correctly. In this case,
          rename the file to a shorter name and replace this
          name in the patch file before you call make. Don't
          forget to rename the file to tkMenubutton.c after
          applying the patch.

        - If you have installed the Tcl/Tk related libraries
          in non standard directories (i.e. directories that
          are not automatically searched by the linker), you
          have to set the environment variable LD_LIBRARY_PATH
          to contain these additional directories.

        - If you get the message "Creating archive file
          '..../libtk/libtk.a'" or a list of undefined
          symbols starting with "_Tk_", the libtk creation
          is not working correctly. Please make sure that
          there is a file "../tk3.6/libtk.a". Then you
          should check whether the command:
            "ar r libtk.a *.o"
          works on your system (in the libtk subdirectory).
          To do this, please copy the ../tk3.6/libtk.a file
          manually to the libtk subdirectory, and change to 
          that subdirectory. After calling the ar command as
          described above please check the contents of the
          library (and the size). If the library only
          contains the local .o files, you may have to adapt
          the ar command in libtk/Makefile.in and rerun the
          configuration and the building (after calling "make
          clean"). Or you did not call "make prepare" before
          you called "make wish".

OSF:
        - It seems that the command "sed" (which is used by GNU's
          configure package) accepts no long commandline strings
          (at least not long enough for this configure program).
          The error message you get will look about like this:

                "Too many commands, last: s%@srcdir@%.%g"

          Please install the GNU sed package, and use this "sed"
          command (make sure the new sed is found before the
          original sed).

Extended Tcl:
        - If you build the wish with extended Tcl, you have
          to set the TCL_LIBRARY path to the extended Tcl
          library path before you call the new wish.

BLT:
        - If you use the shared version of the BLT library,
          it can happen that configure reports that it
          cannot find the BLT library. This is caused by
          error messages that the c compiler produces 
          because references to the Tcl/Tk libraries cannot
          be resolved. This problem is caused by the fact
          that there is no -ltcl and -ltk in the creation
          command for the shared BLT library. You should
          either rename the shared BLT library while
          configure is running, or add a "has_global_blt=1"
          after the call of AV_HAVE_LIBRARY(BLT, ...) in
          the file configure.in. After that, run autoconf
          (assuming you have installed GNU autoconf on your
          system).


Availability:
-------------
The TkPixmap distribution file is named TkPixmap3.6?.tar.gz
or TkPixmap3.6?.tar.Z. The ? represents the current version.
TkPixmap is available via anonymous ftp at:
        ftp.aud.alcatel.com:        tcl/extensions/
        ftp.ibp.fr:                pub/tcl/contrib/extensions/
        nic.funet.fi:                pub/languages/tcl/extensions/
        syd.dit.csiro.au:       pub/tk/contrib/extensions/
        ftp.cs.tu-berlin.de:        pub/tcl/contrib/extensions/

To get a copy of it, just type the following:

        ftp ftp.cs.tu-berlin.de
        bin
        cd pub/tcl/contrib/extensions
        get TkPixmap3.6?.tar.gz

To get a copy via ftpmail, just send the following mail to:

              mail-server@cs.tu-berlin.de

To get a help message, send the following body:

        send HELP
        end

To retrieve TkPixmap, send the following body:

        send pub/tcl/contrib/extensions/TkPixmap3.6?.tar.gz
        end


Feedback (Author):
------------------
Sven Delmas
sven@ignoranceisbliss.com
