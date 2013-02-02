/* 
 * tkAppInit.c --
 *
 *	Provides a default version of the Tcl_AppInit procedure for
 *	use in wish and similar Tk-based applications.
 *
 * Copyright (c) 1993 by Sven Delmas
 * All rights reserved.
 * See the file COPYRIGHT for the copyright notes.
 *
 *
 * Copyright (c) 1993 The Regents of the University of California.
 * All rights reserved.
 *
 * Permission is hereby granted, without written agreement and without
 * license or royalty fees, to use, copy, modify, and distribute this
 * software and its documentation for any purpose, provided that the
 * above copyright notice and the following two paragraphs appear in
 * all copies of this software.
 * 
 * IN NO EVENT SHALL THE UNIVERSITY OF CALIFORNIA BE LIABLE TO ANY PARTY FOR
 * DIRECT, INDIRECT, SPECIAL, INCIDENTAL, OR CONSEQUENTIAL DAMAGES ARISING OUT
 * OF THE USE OF THIS SOFTWARE AND ITS DOCUMENTATION, EVEN IF THE UNIVERSITY OF
 * CALIFORNIA HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 * THE UNIVERSITY OF CALIFORNIA SPECIFICALLY DISCLAIMS ANY WARRANTIES,
 * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY
 * AND FITNESS FOR A PARTICULAR PURPOSE.  THE SOFTWARE PROVIDED HEREUNDER IS
 * ON AN "AS IS" BASIS, AND THE UNIVERSITY OF CALIFORNIA HAS NO OBLIGATION TO
 * PROVIDE MAINTENANCE, SUPPORT, UPDATES, ENHANCEMENTS, OR MODIFICATIONS.
 */

#ifndef lint
static char *AtFSid = "$Header: pixmapDemo.c[6.0] Mon Jul 25 19:33:25 1994 garfield@mydomain.de frozen $";
#endif /* not lint */

#include "tcl.h"
#include "tk.h"

/*
 * This piece of code is required to make shared libs
 * run on SUN OS (at least I was told so :-).
 */
# if defined(SUN4)
extern int matherr();
int *tclDummyMathPtr = (int *) matherr;
#endif

/*
 * The following variable is a special hack that allows applications
 * to be linked using the procedure "main" from the Tk library.  The
 * variable generates a reference to "main", which causes main to
 * be brought in from the library (and all of Tk and Tcl with it).
 */

extern int main();
int *tclDummyMainPtr = (int *) main;

/*
 * pixmapDemo variables.
 */
int x, y;
Tk_Window myW;
GC myGC;
Pixmap myPixmap;

	/* ARGSUSED */
int
DotCmd(dummy, interp, argc, argv)
    ClientData dummy;			/* Not used. */
    Tcl_Interp *interp;			/* Current interpreter. */
    int argc;				/* Number of arguments. */
    char **argv;			/* Argument strings. */
{
    int x, y;

    if (argc != 3) {
	Tcl_AppendResult(interp, "wrong # args: should be \"", argv[0],
		" x y\"", (char *) NULL);
	return TCL_ERROR;
    }
    x = strtol(argv[1], (char **) NULL, 0);
    y = strtol(argv[2], (char **) NULL, 0);
    XDrawPoint(Tk_Display(myW), myPixmap,
	    myGC, x, y);
    return TCL_OK;
}

	/* ARGSUSED */
int
MovetoCmd(dummy, interp, argc, argv)
    ClientData dummy;			/* Not used. */
    Tcl_Interp *interp;			/* Current interpreter. */
    int argc;				/* Number of arguments. */
    char **argv;			/* Argument strings. */
{
  
    if (argc != 3) {
	Tcl_AppendResult(interp, "wrong # args: should be \"", argv[0],
		" x y\"", (char *) NULL);
	return TCL_ERROR;
    }
    x = strtol(argv[1], (char **) NULL, 0);
    y = strtol(argv[2], (char **) NULL, 0);
    return TCL_OK;
}

	/* ARGSUSED */
int
LinetoCmd(dummy, interp, argc, argv)
    ClientData dummy;			/* Not used. */
    Tcl_Interp *interp;			/* Current interpreter. */
    int argc;				/* Number of arguments. */
    char **argv;			/* Argument strings. */
{
    int newX, newY;

    if (argc != 3) {
	Tcl_AppendResult(interp, "wrong # args: should be \"", argv[0],
		" x y\"", (char *) NULL);
	return TCL_ERROR;
    }
    newX = strtol(argv[1], (char **) NULL, 0);
    newY = strtol(argv[2], (char **) NULL, 0);
    XDrawLine(Tk_Display(myW), myPixmap,
	    myGC, x, y, newX, newY);
    x = newX;
    y = newY;
    return TCL_OK;
}

void DefineAndGetPixmap( interp, lenx, leny)
    Tcl_Interp *interp;			/* Current interpreter. */
    int		lenx, leny;
{
    Tk_Uid pixname = Tk_GetUid("thepixmap");

    if ( Tk_DefinePixmap(interp, pixname, (Tk_Window) NULL,
	                 (Pixmap) NULL, (Pixmap) NULL, None,
			 lenx, leny, 0, "xpm3") != TCL_OK ) {
	fprintf(stderr, "Tk_DefinePixmap: %s\n", interp->result);
	exit(1);
    }
    if ( (myPixmap = Tk_GetPixmap(interp, myW, pixname)) == None ) {
	fprintf(stderr, "Tk_GetPixmap: %s\n", interp->result);
	exit(1);
    }
}

void UndefineAndFreePixmap( interp)
    Tcl_Interp *interp;			/* Current interpreter. */
{
    Tk_Uid pixname = Tk_GetUid("thepixmap");

    if ( Tk_UndefinePixmap(interp, pixname, myW) != TCL_OK ) {
	fprintf(stderr, "Tk_UndefinePixmap: %s\n", interp->result);
	exit(1);
    }
    Tk_FreePixmap(Tk_Display(myW), myPixmap);
}

	/* ARGSUSED */
int
PixresizeCmd(dummy, interp, argc, argv)
    ClientData dummy;			/* Not used. */
    Tcl_Interp *interp;			/* Current interpreter. */
    int argc;				/* Number of arguments. */
    char **argv;			/* Argument strings. */
{
    int	lenx, leny;

    if (argc != 3) {
	Tcl_AppendResult(interp, "wrong # args: should be \"", argv[0],
		" x y\"", (char *) NULL);
	return TCL_ERROR;
    }
    lenx = strtol(argv[1], (char **) NULL, 0);
    leny = strtol(argv[2], (char **) NULL, 0);
    UndefineAndFreePixmap(interp);
    DefineAndGetPixmap(interp, lenx, leny);

    return TCL_OK;
}

	/* ARGSUSED */
int
EraseCmd(dummy, interp, argc, argv)
    ClientData dummy;			/* Not used. */
    Tcl_Interp *interp;			/* Current interpreter. */
    int argc;				/* Number of arguments. */
    char **argv;			/* Argument strings. */
{
    unsigned int	lenx, leny;

    Tk_SizeOfPixmap( Tk_Display(myW), myPixmap, &lenx, &leny);
    XFillRectangle(Tk_Display(myW), myPixmap, myGC, 0,0, lenx, leny);
    return TCL_OK;
}

	/* ARGSUSED */
int
ForegroundCmd(dummy, interp, argc, argv)
    ClientData dummy;			/* Not used. */
    Tcl_Interp *interp;			/* Current interpreter. */
    int argc;				/* Number of arguments. */
    char **argv;			/* Argument strings. */
{
    static XColor *pColor;
    XGCValues gcvals;

    if (argc != 2) {
	Tcl_AppendResult(interp, "wrong # args: should be \"", argv[0],
		" color\"", (char *) NULL);
	return TCL_ERROR;
    }
    if ( pColor != NULL ) {
	Tk_FreeColor(pColor);
	pColor = NULL;
    }
    if ( (pColor = Tk_GetColor(interp, myW, (Colormap) NULL,
	                       Tk_GetUid(argv[1]))) == NULL )
	return TCL_ERROR;
    gcvals.foreground = pColor->pixel;
    XChangeGC(Tk_Display(myW), myGC, GCForeground, &gcvals);
    return TCL_OK;
}

	/* ARGSUSED */
int
BackgroundCmd(dummy, interp, argc, argv)
    ClientData dummy;			/* Not used. */
    Tcl_Interp *interp;			/* Current interpreter. */
    int argc;				/* Number of arguments. */
    char **argv;			/* Argument strings. */
{
    static XColor *pColor;
    XGCValues gcvals;

    if (argc != 2) {
	Tcl_AppendResult(interp, "wrong # args: should be \"", argv[0],
		" color\"", (char *) NULL);
	return TCL_ERROR;
    }
    if ( pColor != NULL ) {
	Tk_FreeColor(pColor);
	pColor = NULL;
    }
    if ( (pColor = Tk_GetColor(interp, myW, (Colormap) NULL,
                               Tk_GetUid(argv[1]))) == NULL )
	return TCL_ERROR;
    gcvals.background = pColor->pixel;
    XChangeGC(Tk_Display(myW), myGC, GCBackground, &gcvals);
    return TCL_OK;
}

/*
 *----------------------------------------------------------------------
 *
 * Tcl_AppInit --
 *
 *	This procedure performs application-specific initialization.
 *	Most applications, especially those that incorporate additional
 *	packages, will have their own version of this procedure.
 *
 * Results:
 *	Returns a standard Tcl completion code, and leaves an error
 *	message in interp->result if an error occurs.
 *
 * Side effects:
 *	Depends on the startup script.
 *
 *----------------------------------------------------------------------
 */

int
Tcl_AppInit(interp)
    Tcl_Interp *interp;		/* Interpreter for application. */
{
  Tk_Window main;
  XGCValues gcvals;
  Window rootWin;
  
  main = Tk_MainWindow(interp);

  /*
   * Call the init procedures for included packages.  Each call should
   * look like this:
   *
   * if (Mod_Init(interp) == TCL_ERROR) {
   *     return TCL_ERROR;
   * }
   *
   * where "Mod" is the name of the module.
   */
  
  if (Tcl_Init(interp) == TCL_ERROR) {
    return TCL_ERROR;
  }
  if (Tk_Init(interp) == TCL_ERROR) {
    return TCL_ERROR;
  }
  
  /*
   * Call Tcl_CreateCommand for application-specific commands, if
   * they weren't already created by the init procedures called above.
   */
    myW = main;
    rootWin = XDefaultRootWindow(Tk_Display(myW));
    myGC = XCreateGC(Tk_Display(myW), rootWin, 0, &gcvals);
    Tk_MakeWindowExist(myW);
    DefineAndGetPixmap(interp, 30, 20);
    Tcl_CreateCommand(interp, "dot", DotCmd, (ClientData) myW,
		      (void (*)()) NULL);
    Tcl_CreateCommand(interp, "lineto", LinetoCmd, (ClientData) myW,
		      (void (*)()) NULL);
    Tcl_CreateCommand(interp, "moveto", MovetoCmd, (ClientData) myW,
		      (void (*)()) NULL);
    Tcl_CreateCommand(interp, "foreground", ForegroundCmd,
		      (ClientData) myW, (void (*)()) NULL);
    Tcl_CreateCommand(interp, "background", BackgroundCmd,
		      (ClientData) myW, (void (*)()) NULL);
    Tcl_CreateCommand(interp, "erase", EraseCmd,
		      (ClientData) myW, (void (*)()) NULL);
    Tcl_CreateCommand(interp, "pixresize", PixresizeCmd,
			  (ClientData) myW, (void (*)()) NULL);
  
  /*
   * Specify a user-specific startup file to invoke if the application
   * is run interactively.  Typically the startup file is "~/.apprc"
   * where "app" is the name of the application.  If this line is deleted
   * then no user-specific startup file will be run under any conditions.
   */
  
  tcl_RcFileName = "../demo.TkPixmap/pixmapDemo.tcl";
  return TCL_OK;
}

/* eof */

