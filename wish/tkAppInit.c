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
static char *AtFSid = "$Header: tkAppInit.c[1.0] Mon Jul 25 19:50:52 1994 garfield@mydomain.de accessed $";
#endif /* not lint */

#if defined(TK_EXTENDED)
#include "tclExtend.h"
#else
#include "tcl.h"
#endif
#include "tk.h"
#include <math.h>

#if defined(USE_XACCESS)
#include "tkXAccess.h"
#endif

#if defined(USE_MEGAWIDGET)
#include "tkMegaWidget.h"
#endif

#if defined(USE_LOAD)
Tcl_CmdProc Tcl_LoadCmd;
#endif

/*
 * This piece of code is required to make shared libs
 * run on SUN OS (at least I was told so :-).
 */
#if defined(SUN4) || (defined(DOMAIN) && defined(SING))
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

#if defined(USE_FSCALE)
extern int Tk_FScaleCmd _ANSI_ARGS_((ClientData clientData,
				     Tcl_Interp *interp, int argc,
				     char **argv));
#endif

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
  
#if defined(TK_EXTENDED)
  if(TclX_Init(interp) == TCL_ERROR)
    return TCL_ERROR;
  if(TkX_Init(interp) == TCL_ERROR)
    return TCL_ERROR;
#else
  if (Tcl_Init(interp) == TCL_ERROR)
    return TCL_ERROR;
  if (Tk_Init(interp) == TCL_ERROR)
    return TCL_ERROR;
#endif

#if defined(USE_LOAD)
  Tcl_CreateCommand(interp, "load", Tcl_LoadCmd,
		    (ClientData) NULL, (Tcl_CmdDeleteProc *) NULL);
#else

#if defined(USE_TCL_DP)
  if (Tdp_Init(interp) == TCL_ERROR) {
    return TCL_ERROR;
  }
#endif
  
#if defined(USE_BLT)
  if (Blt_Init(interp) == TCL_ERROR)
    return TCL_ERROR;
#endif

#if defined(USE_ITCL)
  if (Itcl_Init(interp) == TCL_ERROR) {
    return TCL_ERROR;
  }
#endif

#if defined(USE_EXPECT)
  if (Exp_Init(interp) == TCL_ERROR) {
    return TCL_ERROR;
  }
#endif

#if defined(USE_XACCESS)
  if (TkSteal_Init(interp) == TCL_ERROR)
    return TCL_ERROR;
#endif

#if defined(USE_MEGAWIDGET)
  if (TkMegaWidget_Init(interp) == TCL_ERROR)
    return TCL_ERROR;
#endif

#if defined(USE_PINFO)
    if (Pinfo_Init(interp) == TCL_ERROR)
      return TCL_ERROR;
#endif

#if defined(USE_UXPM)
    if (Uxpm_Init(interp) == TCL_ERROR)
      return TCL_ERROR;
#endif

#if defined(USE_MOBAL)
  if (TkMobalExt_Init(interp) == TCL_ERROR)
    return TCL_ERROR;
#endif

#if defined(USE_XF)
  if (TkXFExt_Init(interp) == TCL_ERROR)
    return TCL_ERROR;
#endif
#endif

  /*
   * Call Tcl_CreateCommand for application-specific commands, if
   * they weren't already created by the init procedures called above.
   */
  
#if defined(USE_FSCALE)
  Tcl_CreateCommand(interp, "fscale", Tk_FScaleCmd, (ClientData) main,
		    (void (*)()) NULL);
#endif

  /*
   * Specify a user-specific startup file to invoke if the application
   * is run interactively.  Typically the startup file is "~/.apprc"
   * where "app" is the name of the application.  If this line is deleted
   * then no user-specific startup file will be run under any conditions.
   */
  
  tcl_RcFileName = "~/.wishrc";
  return TCL_OK;
}

/* eof */

