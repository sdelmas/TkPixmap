*** tk3.6-jp.OLD/tk.h	Sun May  1 21:41:59 1994
--- tk3.6-jp.NEW/tk.h	Fri Dec  2 14:18:17 1994
***************
*** 189,194 ****
--- 189,206 ----
  #endif /* KANJI */
  
  /*
+  * Ok... there are problems when you link Tk programs (libs)
+  * that where built with different versions of tk.h (one without
+  * TK_CONFIG_PIXMAP, and one with a TK_CONFIG_PIXMAP appended
+  * after TK_CONFIG_CUSTOM. As it seems that TK_CONFIG_PIXMAP
+  * can have a value beyond TK_CONFIG_END without causing trouble
+  * I switch back to this behaviour. In this special case (JP
+  * support) this may be not necessary, as TK_CONFIG_END is
+  * changed anyway... but I want to keep the code compatible.
+  */
+ #define TK_CONFIG_PIXMAP	30
+ 
+ /*
   * Macro to use to fill in "offset" fields of Tk_ConfigInfos.
   * Computes number of bytes from beginning of structure to a
   * given field.
***************
*** 516,521 ****
--- 528,538 ----
  			    unsigned int height));
  EXTERN void		Tk_DefineCursor _ANSI_ARGS_((Tk_Window window,
  			    Cursor cursor));
+ EXTERN int              Tk_DefinePixmap _ANSI_ARGS_((Tcl_Interp *interp,
+                             Tk_Uid name, Tk_Window tkwin, Pixmap pixmap,
+                             Pixmap clipMask, char *source,
+                             unsigned int width, unsigned int height,
+                             unsigned int depth, char *format));
  EXTERN void		Tk_DeleteAllBindings _ANSI_ARGS_((
  			    Tk_BindingTable bindingTable, ClientData object));
  EXTERN int		Tk_DeleteBinding _ANSI_ARGS_((Tcl_Interp *interp,
***************
*** 535,540 ****
--- 552,559 ----
  			    Atom target));
  EXTERN void		Tk_DeleteTimerHandler _ANSI_ARGS_((
  			    Tk_TimerToken token));
+ EXTERN int              Tk_DepthOfPixmap _ANSI_ARGS_((Display *display,
+                             Pixmap pixmap));
  EXTERN void		Tk_DestroyWindow _ANSI_ARGS_((Tk_Window tkwin));
  EXTERN char *		Tk_DisplayName _ANSI_ARGS_((Tk_Window tkwin));
  EXTERN int		Tk_DoOneEvent _ANSI_ARGS_((int flags));
***************
*** 569,574 ****
--- 588,595 ----
  EXTERN void		Tk_FreeGC _ANSI_ARGS_((Display *display, GC gc));
  EXTERN void		Tk_FreeOptions _ANSI_ARGS_((Tk_ConfigSpec *specs,
  			    char *widgRec, Display *display, int needFlags));
+ EXTERN void             Tk_FreePixmap _ANSI_ARGS_((Display *display,
+                             Pixmap bitmap));
  EXTERN void		Tk_GeometryRequest _ANSI_ARGS_((Tk_Window tkwin,
  			    int reqWidth,  int reqHeight));
  EXTERN Tk_3DBorder	Tk_Get3DBorder _ANSI_ARGS_((Tcl_Interp *interp,
***************
*** 614,619 ****
--- 635,648 ----
  			    char *className));
  EXTERN int		Tk_GetPixels _ANSI_ARGS_((Tcl_Interp *interp,
  			    Tk_Window tkwin, char *string, int *intPtr));
+ EXTERN Pixmap           Tk_GetPixmap _ANSI_ARGS_((Tcl_Interp *interp,
+                             Tk_Window tkwin, Tk_Uid string));
+ EXTERN Pixmap           Tk_GetPixmapClipMask _ANSI_ARGS_((Display *display,
+                             Pixmap pixmap));
+ EXTERN Pixmap           Tk_GetPixmapFromData _ANSI_ARGS_((Tcl_Interp *interp,
+                             Tk_Window tkwin, Tk_Uid name, char *source,
+                             unsigned int width, unsigned int height,
+                             unsigned int depth, char *format));
  EXTERN int		Tk_GetRelief _ANSI_ARGS_((Tcl_Interp *interp,
  			    char *name, int *reliefPtr));
  EXTERN void		Tk_GetRootCoords _ANSI_ARGS_ ((Tk_Window tkwin,
***************
*** 668,673 ****
--- 697,704 ----
  			    XFontStruct *fontStructPtr));
  EXTERN char *		Tk_NameOfJoinStyle _ANSI_ARGS_((int join));
  EXTERN char *		Tk_NameOfJustify _ANSI_ARGS_((Tk_Justify justify));
+ EXTERN char *           Tk_NameOfPixmap _ANSI_ARGS_((Display *display,
+                             Pixmap bitmap));
  EXTERN char *		Tk_NameOfRelief _ANSI_ARGS_((int relief));
  EXTERN Tk_Window	Tk_NameToWindow _ANSI_ARGS_((Tcl_Interp *interp,
  			    char *pathName, Tk_Window tkwin));
***************
*** 676,681 ****
--- 707,716 ----
  EXTERN int		Tk_ParseArgv _ANSI_ARGS_((Tcl_Interp *interp,
  			    Tk_Window tkwin, int *argcPtr, char **argv,
  			    Tk_ArgvInfo *argTable, int flags));
+ EXTERN int              Tk_PixmapExists _ANSI_ARGS_((Display *display,
+                             Pixmap pixmap));
+ EXTERN Pixmap           Tk_PixmapOfName _ANSI_ARGS_((Tk_Uid name,
+                             Tk_Window tkwin));
  EXTERN void		Tk_Preserve _ANSI_ARGS_((ClientData clientData));
  EXTERN int		Tk_RegisterInterp _ANSI_ARGS_((Tcl_Interp *interp,
  			    char *name, Tk_Window tkwin));
***************
*** 686,693 ****
--- 721,741 ----
  			    int aboveBelow, Tk_Window other));
  EXTERN Tk_RestrictProc *Tk_RestrictEvents _ANSI_ARGS_((Tk_RestrictProc *proc,
  			    char *arg, char **prevArgPtr));
+ EXTERN int              Tk_SavePixmap _ANSI_ARGS_((Tcl_Interp *interp,
+                             Tk_Window tkwin, char *fileName,
+                             Pixmap savePixmap, Pixmap clipMask,
+                             unsigned int width, unsigned int height,
+                             char *format));
  EXTERN void		Tk_SetBackgroundFromBorder _ANSI_ARGS_((
  			    Tk_Window tkwin, Tk_3DBorder border));
+ EXTERN int              Tk_CacheStatusOfPixmap _ANSI_ARGS_((
+ 		            Display *display, Pixmap pixmap));
+ EXTERN int              Tk_DefaultCacheStatus _ANSI_ARGS_(());
+ EXTERN void             Tk_SetCacheStatusOfPixmap _ANSI_ARGS_((
+ 		            Display *display, Pixmap pixmap,
+ 			    int status));
+ EXTERN void             Tk_SetDefaultCacheStatus _ANSI_ARGS_((
+ 			    int status));
  EXTERN void		Tk_SetClass _ANSI_ARGS_((Tk_Window tkwin,
  			    char *className));
  EXTERN void		Tk_SetColorModel _ANSI_ARGS_((Tk_Window tkwin,
***************
*** 715,722 ****
--- 763,775 ----
  EXTERN void		Tk_SizeOfBitmap _ANSI_ARGS_((Display *display,
  			    Pixmap bitmap, unsigned int *widthPtr,
  			    unsigned int *heightPtr));
+ EXTERN void             Tk_SizeOfPixmap _ANSI_ARGS_((Display *display,
+                             Pixmap bitmap, unsigned int *widthPtr,
+                             unsigned int *heightPtr));
  EXTERN void		Tk_Sleep _ANSI_ARGS_((int ms));
  EXTERN void		Tk_UndefineCursor _ANSI_ARGS_((Tk_Window window));
+ EXTERN int              Tk_UndefinePixmap _ANSI_ARGS_((Tcl_Interp *interp,
+                             Tk_Uid name, Tk_Window tkwin));
  EXTERN void		Tk_Ungrab _ANSI_ARGS_((Tk_Window tkwin));
  EXTERN void		Tk_UnmapWindow _ANSI_ARGS_((Tk_Window tkwin));
  #ifdef KANJI
***************
*** 786,791 ****
--- 839,846 ----
  			    Tcl_Interp *interp, int argc, char **argv));
  EXTERN int		Tk_PackCmd _ANSI_ARGS_((ClientData clientData,
  			    Tcl_Interp *interp, int argc, char **argv));
+ EXTERN int              Tk_PinfoCmd _ANSI_ARGS_((ClientData clientData,
+                             Tcl_Interp *interp, int argc, char **argv));
  EXTERN int		Tk_PlaceCmd _ANSI_ARGS_((ClientData clientData,
  			    Tcl_Interp *interp, int argc, char **argv));
  EXTERN int		Tk_RaiseCmd _ANSI_ARGS_((ClientData clientData,
***************
*** 810,814 ****
--- 865,873 ----
  			    Tcl_Interp *interp, int argc, char **argv));
  EXTERN int		Tk_WmCmd _ANSI_ARGS_((ClientData clientData,
  			    Tcl_Interp *interp, int argc, char **argv));
+ 
+ /* some tkPixmap prototypes */
+ EXTERN int              Pinfo_Init _ANSI_ARGS_((Tcl_Interp *interp));
+ EXTERN int              Uxpm_Init _ANSI_ARGS_((Tcl_Interp *interp));
  
  #endif /* _TK */
*** tk3.6-jp.OLD/tkBitmap.c	Wed Jan 12 14:25:46 1994
--- tk3.6-jp.NEW/tkBitmap.c	Wed Jan 12 14:25:16 1994
***************
*** 30,35 ****
--- 30,37 ----
  static char rcsid[] = "$Header: /user6/ouster/wish/RCS/tkBitmap.c,v 1.22 93/07/27 11:34:53 ouster Exp $ SPRITE (Berkeley)";
  #endif /* not lint */
  
+ #if 0
+ 
  #include "tkConfig.h"
  #include "tk.h"
  
***************
*** 555,557 ****
--- 557,562 ----
  	    warning_width, warning_height);
      Tcl_DeleteInterp(dummy);
  }
+ 
+ #endif
+ 
*** tk3.6-jp.OLD/tkButton.c	Sun May  1 21:41:29 1994
--- tk3.6-jp.NEW/tkButton.c	Sun May  1 22:13:47 1994
***************
*** 66,71 ****
--- 66,73 ----
  				 * of this variable. */
      Pixmap bitmap;		/* Bitmap to display or None.  If not None
  				 * then text and textVar are ignored. */
+     Pixmap clipMask;		/* Bitmap to specify the clipping mask
+ 				 * for transparent pixmaps, or None. */
  
      /*
       * Information used when displaying widget:
***************
*** 244,252 ****
  	(char *) NULL, 0, ALL_MASK},
      {TK_CONFIG_SYNONYM, "-bg", "background", (char *) NULL,
  	(char *) NULL, 0, ALL_MASK},
!     {TK_CONFIG_BITMAP, "-bitmap", "bitmap", "Bitmap",
  	DEF_BUTTON_BITMAP, Tk_Offset(Button, bitmap),
  	ALL_MASK|TK_CONFIG_NULL_OK},
      {TK_CONFIG_PIXELS, "-borderwidth", "borderWidth", "BorderWidth",
  	DEF_BUTTON_BORDER_WIDTH, Tk_Offset(Button, borderWidth), ALL_MASK},
      {TK_CONFIG_STRING, "-command", "command", "Command",
--- 246,257 ----
  	(char *) NULL, 0, ALL_MASK},
      {TK_CONFIG_SYNONYM, "-bg", "background", (char *) NULL,
  	(char *) NULL, 0, ALL_MASK},
!     {TK_CONFIG_PIXMAP, "-bitmap", "bitmap", "Bitmap",
  	DEF_BUTTON_BITMAP, Tk_Offset(Button, bitmap),
  	ALL_MASK|TK_CONFIG_NULL_OK},
+     {TK_CONFIG_BITMAP, "-mask", "mask", "Mask",
+ 	DEF_BUTTON_BITMAP, Tk_Offset(Button, clipMask),
+ 	ALL_MASK|TK_CONFIG_NULL_OK},
      {TK_CONFIG_PIXELS, "-borderwidth", "borderWidth", "BorderWidth",
  	DEF_BUTTON_BORDER_WIDTH, Tk_Offset(Button, borderWidth), ALL_MASK},
      {TK_CONFIG_STRING, "-command", "command", "Command",
***************
*** 444,449 ****
--- 449,455 ----
      butPtr->textLength = 0;
      butPtr->textVarName = NULL;
      butPtr->bitmap = None;
+     butPtr->clipMask = None;
      butPtr->state = tkNormalUid;
      butPtr->normalBorder = NULL;
      butPtr->activeBorder = NULL;
***************
*** 837,842 ****
--- 843,865 ----
      gcValues.foreground = butPtr->normalFg->pixel;
      gcValues.background = Tk_3DBorderColor(butPtr->normalBorder)->pixel;
  
+     if (butPtr->bitmap != None &&
+ 	Tk_GetPixmapClipMask(butPtr->display, butPtr->bitmap) != None) {
+         if (butPtr->clipMask != None) {
+ 	    Tk_FreePixmap(butPtr->display, butPtr->clipMask);
+         }
+         butPtr->clipMask =
+           Tk_GetPixmapClipMask(butPtr->display, butPtr->bitmap);
+     } else {
+       if (butPtr->bitmap == None ||
+ 	  !Tk_PixmapExists(butPtr->display, butPtr->clipMask)) {
+         if (butPtr->clipMask != None) {
+ 	  Tk_FreePixmap(butPtr->display, butPtr->clipMask);
+         }
+ 	butPtr->clipMask = None;
+       }
+     }
+     
      /*
       * Note: GraphicsExpose events are disabled in normalTextGC because it's
       * used to copy stuff from an off-screen pixmap onto the screen (we know
***************
*** 1095,1101 ****
      if (butPtr->bitmap != None) {
  	unsigned int width, height;
  
! 	Tk_SizeOfBitmap(butPtr->display, butPtr->bitmap, &width, &height);
  	switch (butPtr->anchor) {
  	    case TK_ANCHOR_NW: case TK_ANCHOR_W: case TK_ANCHOR_SW:
  		x = butPtr->borderWidth + butPtr->selectorSpace
--- 1118,1124 ----
      if (butPtr->bitmap != None) {
  	unsigned int width, height;
  
! 	Tk_SizeOfPixmap(butPtr->display, butPtr->bitmap, &width, &height);
  	switch (butPtr->anchor) {
  	    case TK_ANCHOR_NW: case TK_ANCHOR_W: case TK_ANCHOR_SW:
  		x = butPtr->borderWidth + butPtr->selectorSpace
***************
*** 1128,1140 ****
  	    x += 1;
  	    y += 1;
  	}
  #ifdef KANJI
! 	XCopyPlane(butPtr->display, butPtr->bitmap, pixmap,
! 		gc->fe[0].gc, 0, 0, width, height, x, y, 1);
  #else
! 	XCopyPlane(butPtr->display, butPtr->bitmap, pixmap,
! 		gc, 0, 0, width, height, x, y, 1);
  #endif /* KANJI */
  	y += height/2;
      } else {
  	switch (butPtr->anchor) {
--- 1151,1190 ----
  	    x += 1;
  	    y += 1;
  	}
+         if (butPtr->clipMask != None) {
+ #ifdef KANJI
+             XSetClipOrigin(butPtr->display, gc->fe[0].gc, x, y);
+             XSetClipMask(butPtr->display, gc->fe[0].gc, butPtr->clipMask);
+ #else
+             XSetClipOrigin(butPtr->display, gc, x, y);
+             XSetClipMask(butPtr->display, gc, butPtr->clipMask);
+ #endif
+         }
+         if (Tk_DepthOfPixmap(butPtr->display, butPtr->bitmap) == 1) {
+ #ifdef KANJI
+ 	  XCopyPlane(butPtr->display, butPtr->bitmap, pixmap,
+ 		     gc->fe[0].gc, 0, 0, width, height, x, y, 1);
+ #else
+ 	  XCopyPlane(butPtr->display, butPtr->bitmap, pixmap,
+ 		     gc, 0, 0, width, height, x, y, 1);
+ #endif /* KANJI */
+         } else {
  #ifdef KANJI
! 	  XCopyArea(butPtr->display, butPtr->bitmap, pixmap,
! 		    gc->fe[0].gc, 0, 0, width, height, x, y);
  #else
! 	  XCopyArea(butPtr->display, butPtr->bitmap, pixmap,
! 		    gc, 0, 0, width, height, x, y);
! 
  #endif /* KANJI */
+         }
+         if (butPtr->clipMask != None) {
+ #ifdef KANJI
+             XSetClipMask(butPtr->display, gc->fe[0].gc, None);
+ #else
+             XSetClipMask(butPtr->display, gc, None);
+ #endif
+         }
  	y += height/2;
      } else {
  	switch (butPtr->anchor) {
***************
*** 1343,1349 ****
  
      butPtr->selectorSpace = 0;
      if (butPtr->bitmap != None) {
! 	Tk_SizeOfBitmap(butPtr->display, butPtr->bitmap, &width, &height);
  	if (butPtr->width > 0) {
  	    width = butPtr->width;
  	}
--- 1393,1399 ----
  
      butPtr->selectorSpace = 0;
      if (butPtr->bitmap != None) {
!         Tk_SizeOfPixmap(butPtr->display, butPtr->bitmap, &width, &height);
  	if (butPtr->width > 0) {
  	    width = butPtr->width;
  	}
*** tk3.6-jp.OLD/tkCanvas.h	Wed Jan 12 14:25:49 1994
--- tk3.6-jp.NEW/tkCanvas.h	Wed Jan 12 14:25:19 1994
***************
*** 420,425 ****
--- 420,428 ----
  extern void		TkCanvPsPath _ANSI_ARGS_((Tcl_Interp *interp,
  			    double *coordPtr, int numPoints,
  			    Tk_PostscriptInfo *psInfoPtr));
+ extern int		TkCanvPsPixmap _ANSI_ARGS_((Tk_Canvas *canvasPtr,
+ 			    Tk_PostscriptInfo *psInfoPtr, Pixmap bitmap,
+                             double toX, double toY));
  extern int		TkCanvPsStipple _ANSI_ARGS_((Tk_Canvas *canvasPtr,
  			    Tk_PostscriptInfo *psInfoPtr, Pixmap bitmap,
  			    int filled));
*** tk3.6-jp.OLD/tkCanvas.c	Wed Jan 12 14:25:49 1994
--- tk3.6-jp.NEW/tkCanvas.c	Wed Jan 12 14:25:19 1994
***************
*** 223,228 ****
--- 223,232 ----
  			    XEvent *eventPtr));
  static void		RelinkItems _ANSI_ARGS_((Tk_Canvas *canvasPtr,
  			    char *tag, Tk_Item *prevPtr));
+ static int		SaveCanvas _ANSI_ARGS_((Tcl_Interp *interp,
+ 			    Tk_Canvas *canvasPtr, char *fileName, 
+ 			    char *format, int x, int y,
+ 			    unsigned int width, unsigned int height));
  static Tk_Item *	StartTagSearch _ANSI_ARGS_((Tk_Canvas *canvasPtr,
  			    char *tag, TagSearch *searchPtr));
  
***************
*** 1078,1083 ****
--- 1082,1107 ----
  	    }
  	}
  	RelinkItems(canvasPtr, argv[2], prevPtr);
+     } else if ((c == 's') && (strncmp(argv[1], "save", length) == 0)
+           && (length >= 3)) {
+         if (argc != 4 && argc != 8) {
+             Tcl_AppendResult(interp, "wrong # args: should be \"",
+                 argv[0], " save fileName format ?x y width height?\"",
+                 (char *) NULL);
+             goto error;
+         }
+         if (argc == 4) {
+             if (SaveCanvas(interp, canvasPtr, argv[2], argv[3], 0,
+ 	        0, 0, 0) != TCL_OK) {
+                 goto error;
+             }
+         } else {
+             if (SaveCanvas(interp, canvasPtr, argv[2], argv[3],
+ 	        atol(argv[4]), atol(argv[5]), atol(argv[6]),
+ 		atol(argv[7]))) {
+                 goto error;
+             }
+         }
      } else if ((c == 's') && (strncmp(argv[1], "scale", length) == 0)
  	    && (length >= 3)) {
  	double xOrigin, yOrigin, xScale, yScale;
***************
*** 1673,1678 ****
--- 1697,1909 ----
      if (canvasPtr->flags & UPDATE_SCROLLBARS) {
  	CanvasUpdateScrollbars(canvasPtr);
      }
+ }
+ 
+ /*
+  *--------------------------------------------------------------
+  *
+  * SaveCanvas --
+  *
+  *    This procedure saves the contents of a canvas window.
+  *
+  * Results:
+  *    The return value is a standard Tcl result.  If TCL_ERROR is
+  *    returned, then interp->result contains an error message.
+  *
+  * Side effects:
+  *    A pixmap is written to a file.
+  *
+  *--------------------------------------------------------------
+  */
+ 
+ static int
+ SaveCanvas(interp, canvasPtr, fileName, format, x, y, width, height)
+     Tcl_Interp *interp;               /* Used for error reporting. */
+     register Tk_Canvas *canvasPtr;    /* Information about widget */
+     char *fileName;             /* the output file name. */
+     char *format;               /* the output file format. */
+     int x;                      /* upper left x coordinate. */
+     int y;                      /* upper left y coordinate. */
+     unsigned int width;         /* width of pixmap area to save. */
+     unsigned int height;        /* height of pixmap area to save. */
+ {
+     register Tk_Window tkwin = canvasPtr->tkwin;
+     register Tk_Item *itemPtr;
+     Pixmap pixmap;
+     Pixmap savePixmap;
+     int screenX1, screenX2, screenY1, screenY2;
+ 
+     if (canvasPtr->tkwin == NULL) {
+ 	return TCL_OK;
+     }
+     if (!Tk_IsMapped(tkwin)) {
+ 	return TCL_OK;
+     }
+     if (!(fileName && *fileName)) {
+ 	Tcl_ResetResult(interp);
+ 	Tcl_AppendResult(interp, "no filename specified for canvas saving",
+ 	    (char *) NULL);
+ 	return TCL_ERROR;
+     }
+ 
+     /*
+      * Choose a new current item if that is needed (this could cause
+      * event handlers to be invoked).
+      */
+ 
+     while (canvasPtr->flags & REPICK_NEEDED) {
+ 	Tk_Preserve((ClientData) canvasPtr);
+ 	canvasPtr->flags &= ~REPICK_NEEDED;
+ 	PickCurrentItem(canvasPtr, &canvasPtr->pickEvent);
+ 	tkwin = canvasPtr->tkwin;
+ 	Tk_Release((ClientData) canvasPtr);
+ 	if (tkwin == NULL) {
+ 	    return TCL_OK;
+ 	}
+     }
+ 
+     if(x == 0 && y == 0 && width == 0 && height == 0) {
+         screenX1 = 0;
+         screenY1 = 0;
+         screenX2 = Tk_Width(tkwin);
+         screenY2 = Tk_Height(tkwin);
+         width = Tk_Width(tkwin);
+         height = Tk_Height(tkwin);
+     } else {
+         if(width != 0 && height != 0) {
+             screenX1 = x;
+             screenY1 = y;
+             screenX2 = x + width;
+             screenY2 = y + height;
+         } else {
+             Tcl_ResetResult(interp);
+             Tcl_AppendResult(interp,
+ 	        "no correct size specified for canvas saving",
+                 (char *) NULL);
+             return TCL_ERROR;
+         }
+     }
+ 
+     /*
+      * Redrawing is done in a temporary pixmap that is allocated
+      * here and freed at the end of the procedure.  All drawing
+      * is done to the pixmap, and the pixmap is copied to the
+      * screen at the end of the procedure. The temporary pixmap
+      * serves two purposes:
+      *
+      * 1. It provides a smoother visual effect (no clearing and
+      *    gradual redraw will be visible to users).
+      * 2. It allows us to redraw only the objects that overlap
+      *    the redraw area.  Otherwise incorrect results could
+      *	  occur from redrawing things that stick outside of
+      *	  the redraw area (we'd have to redraw everything in
+      *    order to make the overlaps look right).
+      *
+      * Some tricky points about the pixmap:
+      *
+      * 1. We only allocate a large enough pixmap to hold the
+      *    area that has to be redisplayed.  This saves time in
+      *    in the X server for large objects that cover much
+      *    more than the area being redisplayed:  only the area
+      *    of the pixmap will actually have to be redrawn.
+      * 2. The origin of the pixmap is adjusted to an even multiple
+      *    of 32 bits.  This is so that stipple patterns with a size
+      *    of 8 or 16 or 32 bits will always line up when information
+      *    is copied back to the screen.
+      * 3. Some X servers (e.g. the one for DECstations) have troubles
+      *    with characters that overlap an edge of the pixmap (on the
+      *    DEC servers, as of 8/18/92, such characters are drawn one
+      *    pixel too far to the right).  To handle this problem,
+      *    make the pixmap a bit larger than is absolutely needed
+      *    so that for normal-sized fonts the characters that ovelap
+      *    the edge of the pixmap will be outside the area we care
+      *    about.
+      */
+ 
+     canvasPtr->drawableXOrigin = (screenX1 - 30) & ~0x1f;
+     canvasPtr->drawableYOrigin = (screenY1 - 30) & ~0x1f;
+     pixmap = XCreatePixmap(Tk_Display(tkwin), Tk_WindowId(tkwin),
+ 	screenX2 + 30 - canvasPtr->drawableXOrigin,
+ 	screenY2 + 30 - canvasPtr->drawableYOrigin,
+ 	Tk_Depth(tkwin));
+     savePixmap = XCreatePixmap(Tk_Display(tkwin), Tk_WindowId(tkwin),
+         width, height, Tk_Depth(tkwin));
+ 
+     /*
+      * Clear the area to be redrawn.
+      */
+ 
+     XFillRectangle(Tk_Display(tkwin), pixmap, canvasPtr->pixmapGC,
+ 	    screenX1 - canvasPtr->drawableXOrigin,
+ 	    screenY1 - canvasPtr->drawableYOrigin,
+ 	    (unsigned int) (screenX2 - screenX1),
+ 	    (unsigned int) (screenY2 - screenY1));
+     XFillRectangle(Tk_Display(tkwin), savePixmap, canvasPtr->pixmapGC,
+             0, 0, width, height);
+ 
+     /*
+      * Scan through the item list, redrawing those items that need it.
+      * An item must be redraw if either (a) it intersects the smaller
+      * on-screen area or (b) it intersects the full canvas area and its
+      * type requests that it be redrawn always (e.g. so subwindows can
+      * be unmapped when they move off-screen).
+      */
+ 
+     for (itemPtr = canvasPtr->firstItemPtr; itemPtr != NULL;
+ 	    itemPtr = itemPtr->nextPtr) {
+ 	if ((itemPtr->x1 >= screenX2)
+ 		|| (itemPtr->y1 >= screenY2)
+ 		|| (itemPtr->x2 < screenX1)
+ 		|| (itemPtr->y2 < screenY1)) {
+ 	    if (!itemPtr->typePtr->alwaysRedraw
+ 		    || (itemPtr->x1 >= canvasPtr->redrawX2)
+ 		    || (itemPtr->y1 >= canvasPtr->redrawY2)
+ 		    || (itemPtr->x2 < canvasPtr->redrawX1)
+ 		    || (itemPtr->y2 < canvasPtr->redrawY1)) {
+ 		continue;
+ 	    }
+ 	}
+ 	(*itemPtr->typePtr->displayProc)(canvasPtr, itemPtr, pixmap);
+     }
+ 
+     /*
+      * Draw the window border.
+      */
+ 
+     if (canvasPtr->relief != TK_RELIEF_FLAT) {
+         Tk_Draw3DRectangle(Tk_Display(tkwin), pixmap,
+                 canvasPtr->bgBorder,
+                 canvasPtr->xOrigin - canvasPtr->drawableXOrigin,
+                 canvasPtr->yOrigin - canvasPtr->drawableYOrigin,
+                 Tk_Width(tkwin), Tk_Height(tkwin),
+                 canvasPtr->borderWidth, canvasPtr->relief);
+     }
+ 
+     /*
+      * Copy from the temporary pixmap to the screen, then free up
+      * the temporary pixmap.
+      */
+ 
+     XCopyArea(Tk_Display(tkwin), pixmap, savePixmap,
+ 	    canvasPtr->pixmapGC,
+ 	    screenX1 - canvasPtr->drawableXOrigin,
+ 	    screenY1 - canvasPtr->drawableYOrigin,
+ 	    screenX2 - screenX1, screenY2 - screenY1, 0, 0);
+ 
+     /*
+      * Save temporary pixmap.
+      */
+ 
+     if (Tk_SavePixmap(interp, tkwin, fileName, savePixmap,
+            (Pixmap) NULL, width, height, format) != TCL_OK) {
+         XFreePixmap(Tk_Display(tkwin), pixmap);
+         XFreePixmap(Tk_Display(tkwin), savePixmap);
+         return TCL_ERROR;
+     }
+     XFreePixmap(Tk_Display(tkwin), pixmap);
+     XFreePixmap(Tk_Display(tkwin), savePixmap);
+ 
+     return TCL_OK;
  }
  
  /*
*** tk3.6-jp.OLD/tkCanvBmap.c	Wed Jan 12 14:25:47 1994
--- tk3.6-jp.NEW/tkCanvBmap.c	Thu Jul 21 17:18:43 1994
***************
*** 45,50 ****
--- 45,52 ----
      Tk_Anchor anchor;		/* Where to anchor bitmap relative to
  				 * (x,y). */
      Pixmap bitmap;		/* Bitmap to display in window. */
+     Pixmap clipMask;		/* Bitmap to specify the clipping mask
+ 				 * for transparent pixmaps, or None. */
      XColor *fgColor;		/* Foreground color to use for bitmap. */
      XColor *bgColor;		/* Background color to use for bitmap. */
      GC gc;			/* Graphics context to use for drawing
***************
*** 60,67 ****
  	"center", Tk_Offset(BitmapItem, anchor), TK_CONFIG_DONT_SET_DEFAULT},
      {TK_CONFIG_COLOR, "-background", (char *) NULL, (char *) NULL,
  	(char *) NULL, Tk_Offset(BitmapItem, bgColor), TK_CONFIG_NULL_OK},
!     {TK_CONFIG_BITMAP, "-bitmap", (char *) NULL, (char *) NULL,
  	(char *) NULL, Tk_Offset(BitmapItem, bitmap), TK_CONFIG_NULL_OK},
      {TK_CONFIG_COLOR, "-foreground", (char *) NULL, (char *) NULL,
  	"black", Tk_Offset(BitmapItem, fgColor), 0},
      {TK_CONFIG_CUSTOM, "-tags", (char *) NULL, (char *) NULL,
--- 62,71 ----
  	"center", Tk_Offset(BitmapItem, anchor), TK_CONFIG_DONT_SET_DEFAULT},
      {TK_CONFIG_COLOR, "-background", (char *) NULL, (char *) NULL,
  	(char *) NULL, Tk_Offset(BitmapItem, bgColor), TK_CONFIG_NULL_OK},
!     {TK_CONFIG_PIXMAP, "-bitmap", (char *) NULL, (char *) NULL,
  	(char *) NULL, Tk_Offset(BitmapItem, bitmap), TK_CONFIG_NULL_OK},
+     {TK_CONFIG_BITMAP, "-mask", (char *) NULL, (char *) NULL,
+ 	(char *) NULL, Tk_Offset(BitmapItem, clipMask), TK_CONFIG_NULL_OK},
      {TK_CONFIG_COLOR, "-foreground", (char *) NULL, (char *) NULL,
  	"black", Tk_Offset(BitmapItem, fgColor), 0},
      {TK_CONFIG_CUSTOM, "-tags", (char *) NULL, (char *) NULL,
***************
*** 172,177 ****
--- 176,182 ----
  
      bmapPtr->anchor = TK_ANCHOR_CENTER;
      bmapPtr->bitmap = None;
+     bmapPtr->clipMask = None;
      bmapPtr->fgColor = NULL;
      bmapPtr->bgColor = NULL;
      bmapPtr->gc = None;
***************
*** 296,301 ****
--- 301,323 ----
      }
      bmapPtr->gc = newGC;
  
+     if (bmapPtr->bitmap != None &&
+ 	Tk_GetPixmapClipMask(canvasPtr->display, bmapPtr->bitmap) != None) {
+         if (bmapPtr->clipMask != None) {
+ 	    Tk_FreePixmap(canvasPtr->display, bmapPtr->clipMask);
+         }
+         bmapPtr->clipMask =
+ 	    Tk_GetPixmapClipMask(canvasPtr->display, bmapPtr->bitmap);
+     } else {
+       if (bmapPtr->bitmap == None ||
+ 	  !Tk_PixmapExists(canvasPtr->display, bmapPtr->clipMask)) {
+         if (bmapPtr->clipMask != None) {
+ 	  Tk_FreePixmap(canvasPtr->display, bmapPtr->clipMask);
+         }
+ 	bmapPtr->clipMask = None;
+       }
+     }
+     
      ComputeBitmapBbox(canvasPtr, bmapPtr);
  
      return TCL_OK;
***************
*** 326,332 ****
      register BitmapItem *bmapPtr = (BitmapItem *) itemPtr;
  
      if (bmapPtr->bitmap != None) {
! 	Tk_FreeBitmap(canvasPtr->display, bmapPtr->bitmap);
      }
      if (bmapPtr->fgColor != NULL) {
  	Tk_FreeColor(bmapPtr->fgColor);
--- 348,357 ----
      register BitmapItem *bmapPtr = (BitmapItem *) itemPtr;
  
      if (bmapPtr->bitmap != None) {
!         Tk_FreePixmap(canvasPtr->display, bmapPtr->bitmap);
!     }
!     if (bmapPtr->clipMask != None) {
! 	Tk_FreePixmap(canvasPtr->display, bmapPtr->clipMask);
      }
      if (bmapPtr->fgColor != NULL) {
  	Tk_FreeColor(bmapPtr->fgColor);
***************
*** 382,388 ****
       * Compute location and size of bitmap, using anchor information.
       */
  
!     Tk_SizeOfBitmap(canvasPtr->display, bmapPtr->bitmap, &width, &height);
      switch (bmapPtr->anchor) {
  	case TK_ANCHOR_N:
  	    x -= width/2;
--- 407,413 ----
       * Compute location and size of bitmap, using anchor information.
       */
  
!     Tk_SizeOfPixmap(canvasPtr->display, bmapPtr->bitmap, &width, &height);
      switch (bmapPtr->anchor) {
  	case TK_ANCHOR_N:
  	    x -= width/2;
***************
*** 454,465 ****
      register BitmapItem *bmapPtr = (BitmapItem *) itemPtr;
  
      if (bmapPtr->bitmap != None) {
! 	XCopyPlane(Tk_Display(canvasPtr->tkwin), bmapPtr->bitmap, drawable,
! 		bmapPtr->gc, 0, 0,
! 		(unsigned int) bmapPtr->header.x2 - bmapPtr->header.x1,
! 		(unsigned int) bmapPtr->header.y2 - bmapPtr->header.y1,
! 		bmapPtr->header.x1 - canvasPtr->drawableXOrigin,
! 		bmapPtr->header.y1 - canvasPtr->drawableYOrigin, 1);
      }
  }
  
--- 479,511 ----
      register BitmapItem *bmapPtr = (BitmapItem *) itemPtr;
  
      if (bmapPtr->bitmap != None) {
!         if (bmapPtr->clipMask != None) {
! 	    XSetClipOrigin(Tk_Display(canvasPtr->tkwin), bmapPtr->gc,
! 	        bmapPtr->header.x1 - canvasPtr->drawableXOrigin,
!                 bmapPtr->header.y1 - canvasPtr->drawableYOrigin);
!             XSetClipMask(Tk_Display(canvasPtr->tkwin), bmapPtr->gc,
! 	        bmapPtr->clipMask);
!         }              
!         if (Tk_DepthOfPixmap(Tk_Display(canvasPtr->tkwin),
! 			     bmapPtr->bitmap) == 1) {
!             XCopyPlane(Tk_Display(canvasPtr->tkwin), bmapPtr->bitmap,
!                 drawable, bmapPtr->gc, 0, 0,
!                 (unsigned int) bmapPtr->header.x2 - bmapPtr->header.x1,
!                 (unsigned int) bmapPtr->header.y2 - bmapPtr->header.y1,
!                 bmapPtr->header.x1 - canvasPtr->drawableXOrigin,
!                 bmapPtr->header.y1 - canvasPtr->drawableYOrigin, 1);
!         } else {
!             XCopyArea(Tk_Display(canvasPtr->tkwin), bmapPtr->bitmap,
!                 drawable, bmapPtr->gc, 0, 0,
!                 (unsigned int) bmapPtr->header.x2 - bmapPtr->header.x1,
!                 (unsigned int) bmapPtr->header.y2 - bmapPtr->header.y1,
!                 bmapPtr->header.x1 - canvasPtr->drawableXOrigin,
!                 bmapPtr->header.y1 - canvasPtr->drawableYOrigin);
!         }
!         if (bmapPtr->clipMask != None) {
!             XSetClipMask(Tk_Display(canvasPtr->tkwin), bmapPtr->gc,
! 	        None);
! 	}
      }
  }
  
***************
*** 518,524 ****
  	yDiff = 0;
      }
  
!     return hypot(xDiff, yDiff);
  }
  
  /*
--- 564,580 ----
  	yDiff = 0;
      }
  
!     if (xDiff == 0 && yDiff == 0 && bmapPtr->clipMask != None) {
!       int x = (int) (coordPtr[0] - x1 - 0.5);
!       int y = (int) (coordPtr[1] - y1 - 0.5);
!       XImage *image = XGetImage (canvasPtr->display, bmapPtr->clipMask,
! 				 x, y, 1, 1, AllPlanes, XYPixmap);
!       int pixel = XGetPixel (image, 0, 0);
!       XDestroyImage (image);
!       if (pixel == 0) return 5.0;
!     }
! 
!    return hypot(xDiff, yDiff);
  }
  
  /*
***************
*** 682,688 ****
  
      x = bmapPtr->x;
      y = TkCanvPsY(psInfoPtr, bmapPtr->y);
!     Tk_SizeOfBitmap(canvasPtr->display, bmapPtr->bitmap, &width, &height);
      switch (bmapPtr->anchor) {
  	case TK_ANCHOR_NW:			y -= height;		break;
  	case TK_ANCHOR_N:	x -= width/2.0; y -= height;		break;
--- 738,744 ----
  
      x = bmapPtr->x;
      y = TkCanvPsY(psInfoPtr, bmapPtr->y);
!     Tk_SizeOfPixmap(canvasPtr->display, bmapPtr->bitmap, &width, &height);
      switch (bmapPtr->anchor) {
  	case TK_ANCHOR_NW:			y -= height;		break;
  	case TK_ANCHOR_N:	x -= width/2.0; y -= height;		break;
***************
*** 718,730 ****
  	if (TkCanvPsColor(canvasPtr, psInfoPtr, bmapPtr->fgColor) != TCL_OK) {
  	    return TCL_ERROR;
  	}
! 	sprintf(buffer, "%.15g %.15g translate\n %d %d true matrix {\n",
! 		x, y, width, height);
! 	Tcl_AppendResult(canvasPtr->interp, buffer, (char *) NULL);
! 	if (TkCanvPsBitmap(canvasPtr, psInfoPtr, bmapPtr->bitmap) != TCL_OK) {
! 	    return TCL_ERROR;
! 	}
! 	Tcl_AppendResult(canvasPtr->interp, "\n} imagemask\n", (char *) NULL);
      }
      return TCL_OK;
  }
--- 774,796 ----
  	if (TkCanvPsColor(canvasPtr, psInfoPtr, bmapPtr->fgColor) != TCL_OK) {
  	    return TCL_ERROR;
  	}
!         if (Tk_DepthOfPixmap(canvasPtr->display, bmapPtr->bitmap) == 1) {
! 	  sprintf(buffer,"/buffer %d string def\n", 1);
! 	  Tcl_AppendResult(canvasPtr->interp, buffer,(char *)NULL);
!           sprintf(buffer, "%.15g %.15g translate\n%d %d true matrix ",
!                   x, y, width, height);
!           Tcl_AppendResult(canvasPtr->interp, buffer, (char *) NULL);
! 	  Tcl_AppendResult(canvasPtr->interp, "{ currentfile buffer readhexstring pop } imagemask\n",(char *)NULL);
!           if (TkCanvPsBitmap(canvasPtr, psInfoPtr,
!                              bmapPtr->bitmap) != TCL_OK) {
!             return TCL_ERROR;
!           }
!         } else {
!           if (TkCanvPsPixmap(canvasPtr, psInfoPtr,
!                              bmapPtr->bitmap, x, y) != TCL_OK) {
!             return TCL_ERROR;
!           }
!         }
      }
      return TCL_OK;
  }
*** tk3.6-jp.OLD/tkCanvPs.c	Wed Jan 12 14:25:48 1994
--- tk3.6-jp.NEW/tkCanvPs.c	Thu Jul 28 22:05:34 1994
***************
*** 935,942 ****
  
      Tk_SizeOfBitmap(canvasPtr->display, bitmap, &width, &height);
      imagePtr = XGetImage(Tk_Display(canvasPtr->tkwin), bitmap, 0, 0,
! 	    width, height, 1, XYPixmap);
!     Tcl_AppendResult(canvasPtr->interp, "<", (char *) NULL);
      mask = 0x80;
      value = 0;
      charsInLine = 0;
--- 935,941 ----
  
      Tk_SizeOfBitmap(canvasPtr->display, bitmap, &width, &height);
      imagePtr = XGetImage(Tk_Display(canvasPtr->tkwin), bitmap, 0, 0,
! 	      width, height, 1, XYPixmap);
      mask = 0x80;
      value = 0;
      charsInLine = 0;
***************
*** 964,972 ****
  	    mask = 0x80;
  	    value = 0;
  	    charsInLine += 2;
  	}
      }
!     Tcl_AppendResult(canvasPtr->interp, ">", (char *) NULL);
      XDestroyImage(imagePtr);
      return TCL_OK;
  }
--- 963,975 ----
  	    mask = 0x80;
  	    value = 0;
  	    charsInLine += 2;
+  	    if (charsInLine >= 60) {
+ 	        Tcl_AppendResult(canvasPtr->interp, "\n", (char *) NULL);
+ 	        charsInLine = 0;
+ 	    }
  	}
      }
!     Tcl_AppendResult(canvasPtr->interp, "\n", (char *) NULL);
      XDestroyImage(imagePtr);
      return TCL_OK;
  }
***************
*** 1016,1029 ****
      }
  
      Tk_SizeOfBitmap(canvasPtr->display, bitmap, &width, &height);
!     sprintf(string, "%d %d ", width, height);
      Tcl_AppendResult(canvasPtr->interp, string, (char *) NULL);
      if (TkCanvPsBitmap(canvasPtr, handle, bitmap) != TCL_OK) {
  	return TCL_ERROR;
      }
!     Tcl_AppendResult(canvasPtr->interp, filled ? " true" : " false",
  	    " StippleFill\n", (char *) NULL);
      return TCL_OK;
  }
  
  /*
--- 1019,1345 ----
      }
  
      Tk_SizeOfBitmap(canvasPtr->display, bitmap, &width, &height);
!     sprintf(string, "%d %d <", width, height);
      Tcl_AppendResult(canvasPtr->interp, string, (char *) NULL);
      if (TkCanvPsBitmap(canvasPtr, handle, bitmap) != TCL_OK) {
  	return TCL_ERROR;
      }
!     Tcl_AppendResult(canvasPtr->interp, filled ? "> true" : "> false",
  	    " StippleFill\n", (char *) NULL);
      return TCL_OK;
+ }
+ 
+ /*
+  *
+  * Name - get.hc
+  * Copyright (C) 1990-92 Bruce Schuchardt, Servio Corp.
+  *
+  * Description:  image grabbing functions for xgrabsc
+  * 
+  * makePSImage returns an XImage structure that contains the samples
+  * to be written.  If the input image is monochrome, its XImage structure
+  * will be returned.  Otherwise a new structure is allocated and returned.
+  */
+ 
+ XImage* makePSImage(canvasPtr, ximage, desiredDepth, depth, bpl, spb)
+     Tk_Canvas *canvasPtr;		/* Information about canvas. */
+     XImage* ximage;
+     int desiredDepth;  /* 0 = don't care */
+     int* depth;
+     int* bpl;
+     int* spb;
+ {
+   register unsigned char* ptr;
+   XImage* psimage;
+ 
+   /* use depth as the number of bits in output samples */
+   *depth = ximage->depth;
+   /* postscript only supports 1, 2, 4, or 8 */
+   if (*depth > 8) *depth = 8;     /* max postscript bits/sample */
+   if (*depth < 8 && *depth > 4) *depth = 8;
+   if (*depth == 3) *depth = 4;
+     
+   if (desiredDepth == 0) {
+     desiredDepth = *depth;
+   }
+   
+   *bpl = ((ximage->width * desiredDepth) + 7) / 8;
+ 
+   if (*depth == 1) {
+     /* Same image */
+     psimage = ximage;
+   } else {
+     /* colors have to be changed to luminescence */
+     ptr = (unsigned char *)malloc(ximage->height * *bpl);
+     psimage = XCreateImage(canvasPtr->display,
+ 		  DefaultVisualOfScreen(Tk_Screen(canvasPtr->tkwin)),
+                   desiredDepth, ZPixmap,
+                   0, ptr,
+                   ximage->width, ximage->height,
+                   8, *bpl);
+     if (!psimage) {
+       fprintf(stderr,
+ 	      "wish: could not create image for Postscript conversion\n");
+       exit(3);
+     }
+     /* force the bits_per_pixel to be what is needed */
+     psimage->bits_per_pixel = desiredDepth;
+   }
+ 
+   *spb = 8 / psimage->bits_per_pixel;    /* samples per byte */
+   *depth = desiredDepth;  /* The final resolution */
+   return psimage;
+ }
+ /*
+  *--------------------------------------------------------------
+  *
+  * TkCanvPsPixmap --
+  *
+  *	This procedure is called to output the contents of a
+  *	pixmap in proper image data format for Postscript (i.e.
+  *	data between angle brackets).
+  *
+  * Results:
+  *	Returns a standard Tcl return value.  If an error occurs
+  *	then an error message will be left in canvasPtr->interp->result.
+  *	If no error occurs, then additional Postscript will be
+  *	appended to canvasPtr->interp->result.
+  *
+  * Side effects:
+  *	None.
+  *
+  *--------------------------------------------------------------
+  */
+ 
+ int
+ TkCanvPsPixmap(canvasPtr, handle, bitmap, toX, toY)
+     Tk_Canvas *canvasPtr;		/* Information about canvas. */
+     Tk_PostscriptInfo *handle;		/* Information about Postscript being
+ 					 * generated. */
+     Pixmap bitmap;			/* Bitmap to use for stippling. */
+     double toX;                         /* translate X */
+     double toY;                         /* translate Y */
+ {
+   register unsigned char b, b2, *ptr;
+   PostscriptInfo *psInfoPtr = (PostscriptInfo *) handle;
+   unsigned int width, height;
+   XImage *imagePtr;
+   XImage *psimage;
+   int charsInLine = 0, i, x, y, value, mask, depth, bpl, spb;
+   long p;
+   char string[200];
+   int lshift, lmask;
+   int numCmaps, ncolors;
+   Colormap *cmaps, cmap;
+   XColor colors[256];
+   unsigned int red[256], green[256], blue[256];
+ 
+   if (psInfoPtr->prepass) {
+     return TCL_OK;
+   }
+ 
+   /* get the colormap info */
+ /*  cmaps = XListInstalledColormaps(canvasPtr->display,
+ 			          Tk_WindowId(canvasPtr->tkwin), &numCmaps);
+   if (numCmaps == 0) {
+     cmap = DefaultColormapOfScreen(Tk_Screen(canvasPtr->tkwin));
+   } else {
+     cmap = *cmaps;
+   }
+   XFree(cmaps); */
+   cmap=((TkWindow*)(canvasPtr->tkwin))->atts.colormap;
+ 
+   ncolors = CellsOfScreen(Tk_Screen(canvasPtr->tkwin));
+   /* this won't cut the mustard for DirectColor */
+   for (i = 0; i < ncolors; i++) {
+     colors[i].pixel = i;
+   }
+ 
+   XQueryColors(canvasPtr->display, cmap, colors, ncolors);
+   for (i = 0; i < ncolors; i++) {
+     red[i] = colors[i].red;
+     green[i] = colors[i].green;
+     blue[i] = colors[i].blue;
+   }
+ 
+   Tk_SizeOfPixmap(canvasPtr->display, bitmap, &width, &height);
+   if (psInfoPtr->colorLevel==0) {
+     imagePtr = XGetImage(Tk_Display(canvasPtr->tkwin), bitmap, 0, 0,
+ 			 width, height, 1, XYPixmap);
+ 
+     sprintf(string,"/buffer %d string def\n", 1);
+     Tcl_AppendResult(canvasPtr->interp, string, (char *) NULL);
+     sprintf(string, "%g %g translate\n", toX, toY);
+     Tcl_AppendResult(canvasPtr->interp, string, (char *) NULL);
+     sprintf(string, "%d %d true matrix ", width, height);
+     Tcl_AppendResult(canvasPtr->interp, string, (char *) NULL);
+     Tcl_AppendResult(canvasPtr->interp,
+ 		     "{ currentfile buffer readhexstring pop } imagemask\n",
+ 		     (char *)NULL);
+     
+     mask = 0x80;
+     value = 0;
+     charsInLine = 0;
+     for (y = 1; y <= height; y++) {
+       for (x = 0; x < width; x++) {
+ 	if (XGetPixel(imagePtr, x, height-y)) {
+ 	  value |= mask;
+ 	}
+ 	mask >>= 1;
+ 	if (mask == 0) {
+ 	  sprintf(string, "%02x", value);
+ 	  Tcl_AppendResult(canvasPtr->interp, string, (char *) NULL);
+ 	  mask = 0x80;
+ 	  value = 0;
+ 	  charsInLine += 2;
+ 	  if (charsInLine >= 60) {
+ 	    Tcl_AppendResult(canvasPtr->interp, "\n", (char *) NULL);
+ 	    charsInLine = 0;
+ 	  }
+ 	}
+       }
+       if (mask != 0x80) {
+ 	sprintf(string, "%02x", value);
+ 	Tcl_AppendResult(canvasPtr->interp, string, (char *) NULL);
+ 	mask = 0x80;
+ 	value = 0;
+ 	charsInLine += 2;
+ 	if (charsInLine >= 60) {
+ 	  Tcl_AppendResult(canvasPtr->interp, "\n", (char *) NULL);
+ 	  charsInLine = 0;
+ 	}
+       }
+     }
+     Tcl_AppendResult(canvasPtr->interp, "\n\n", (char *) NULL);
+   } else {
+     if (psInfoPtr->colorLevel==1) {
+       imagePtr = XGetImage(Tk_Display(canvasPtr->tkwin), bitmap, 0, 0,
+ 			   width, height, AllPlanes, ZPixmap);
+       psimage = makePSImage(canvasPtr, imagePtr, 0, &depth, &bpl, &spb);
+ 
+       if (depth > 1) {
+ 	/* translate colors into grays */
+ 	lshift = 16 - psimage->bits_per_pixel;
+ 	lmask  = (1 << psimage->bits_per_pixel) - 1;
+ 	for (y = 0; y < imagePtr->height; y++) {
+ 	  for (x = 0; x < imagePtr->width; x++) {
+ 	    p = XGetPixel(imagePtr, x, y);
+ 	    i = (0.30*(double) red[p]) +
+ 	      (0.59*(double) green[p]) +
+ 		(0.11*(double) blue[p]);
+ 	    i = (i >> lshift) & lmask;
+ 	    XPutPixel(psimage, x, y, i);
+ 	  }
+ 	}
+       }
+ 
+       sprintf(string,"/buffer %d string def\n", 1);
+       Tcl_AppendResult(canvasPtr->interp, string, (char *)NULL);
+       sprintf(string, "%g %g translate\n", toX, toY);
+       Tcl_AppendResult(canvasPtr->interp, string, (char *) NULL);
+       sprintf(string, "%d %d scale\n", width, height);
+       Tcl_AppendResult(canvasPtr->interp, string, (char *) NULL);
+       sprintf(string, "%d %d %d [%d 0 0 -%d 0 %d] ", width, height,
+ 	      Tk_DepthOfPixmap(canvasPtr->display, bitmap),
+ 	      width, height, height);
+       Tcl_AppendResult(canvasPtr->interp, string, (char *) NULL);
+       Tcl_AppendResult(canvasPtr->interp,
+ 		       "{ currentfile buffer readhexstring pop } image\n",
+ 		       (char *)NULL);
+       
+       for (y = 0; y < psimage->height; y++) {
+ 	for (x = 0,
+ 	     ptr = (unsigned char *) (psimage->data +
+ 				      (y * psimage->bytes_per_line));
+ 	     x < psimage->width;
+ 	     x += spb, ptr++) {
+ 	  b = *ptr;
+ 	  if (depth == 1 && psimage->bitmap_bit_order == LSBFirst) {
+ 	    /* swap the bits in a byte */
+ 	    b2 = 0;
+ 	    b2 |= (b & 0x01) << 7;
+ 	    b2 |= (b & 0x02) << 5;
+ 	    b2 |= (b & 0x04) << 3;
+ 	    b2 |= (b & 0x08) << 1;
+ 	    b2 |= (b & 0x10) >> 1;
+ 	    b2 |= (b & 0x20) >> 3;
+ 	    b2 |= (b & 0x40) >> 5;
+ 	    b2 |= (b & 0x80) >> 7;
+ 	    b = b2;
+ 	  }
+ 	  sprintf(string, "%02x", b);
+ 	  Tcl_AppendResult(canvasPtr->interp, string, (char *) NULL);
+ 	  charsInLine += 2;
+ 	  if (charsInLine >= 60) {
+ 	    Tcl_AppendResult(canvasPtr->interp, "\n", (char *) NULL);
+ 	    charsInLine = 0;
+ 	  }
+ 	}
+       }
+       
+       Tcl_AppendResult(canvasPtr->interp, "\n", (char *) NULL);
+       
+       if (psimage != imagePtr) {
+ 	free((char *) psimage->data);
+ 	free((char *) psimage);
+       }
+     } else {
+       imagePtr = XGetImage(Tk_Display(canvasPtr->tkwin), bitmap, 0, 0,
+ 			   width, height, AllPlanes, ZPixmap);
+       spb = 1;
+       
+       sprintf(string, "/buffer %d string def\n", 1);
+       Tcl_AppendResult(canvasPtr->interp, string, (char *) NULL);
+       sprintf(string, "%g %g translate\n", toX, toY);
+       Tcl_AppendResult(canvasPtr->interp, string, (char *) NULL);
+       sprintf(string, "%d %d scale\n", width, height);
+       Tcl_AppendResult(canvasPtr->interp, string, (char *) NULL);
+       sprintf(string, "/rgbmap {<");
+       Tcl_AppendResult(canvasPtr->interp, string, (char *) NULL);
+       for (x = 0; x < ncolors; x++) {
+ 	sprintf(string, "%02x%02x%02x%c",
+ 		(unsigned char)((red[x] >> 8) & 0xff),
+ 		(unsigned char)((green[x] >> 8) & 0xff),
+ 		(unsigned char)((blue[x] >> 8) & 0xff),
+ 		x < (ncolors - 1) ? '\n' : '>');
+ 	Tcl_AppendResult(canvasPtr->interp, string, (char *) NULL);
+       }
+       sprintf(string, "} def\n");
+       Tcl_AppendResult(canvasPtr->interp, string, (char *) NULL);
+       sprintf(string, "%d %d %d [%d 0 0 -%d 0 %d] ", width, height,
+ 	      Tk_DepthOfPixmap(canvasPtr->display, bitmap),
+ 	      width, height, height);
+       Tcl_AppendResult(canvasPtr->interp, string, (char *) NULL);
+       Tcl_AppendResult(canvasPtr->interp,
+ 		       "{ currentfile buffer readhexstring pop pop \n",
+ 		       (char *) NULL);
+       Tcl_AppendResult(canvasPtr->interp,
+ 		       "   rgbmap buffer 0 get 3 mul 3 getinterval\n",
+ 		       (char *) NULL);
+       Tcl_AppendResult(canvasPtr->interp, " }\n", (char *) NULL);
+       Tcl_AppendResult(canvasPtr->interp, " false 3 colorimage\n",
+ 		       (char *) NULL);
+       
+       for (y = 0; y < imagePtr->height; y++) {
+ 	for (x = 0, ptr = (unsigned char *) (imagePtr->data +
+ 					     (y * imagePtr->bytes_per_line));
+ 	     x < imagePtr->width;
+ 	     x += spb, ptr++) {
+ 	  b = *ptr;
+ 	  sprintf(string, "%02x", b & 0xFF);
+ 	  Tcl_AppendResult(canvasPtr->interp, string, (char *) NULL);
+ 	  charsInLine += 2;
+ 	  if (charsInLine >= 60) {
+ 	    Tcl_AppendResult(canvasPtr->interp, "\n", (char *) NULL);
+ 	    charsInLine = 0;
+ 	  }
+ 	}
+       }
+       Tcl_AppendResult(canvasPtr->interp, "\n", (char *) NULL);
+     }
+   }
+   XDestroyImage(imagePtr);
+   return TCL_OK;
  }
  
  /*
*** tk3.6-jp.OLD/tkConfig.c	Wed Jan 12 14:25:49 1994
--- tk3.6-jp.NEW/tkConfig.c	Wed Jan 12 14:25:19 1994
***************
*** 468,473 ****
--- 468,492 ----
  		*((Pixmap *) ptr) = new;
  		break;
  	    }
+             case TK_CONFIG_PIXMAP: {
+                 Pixmap new, old;
+ 
+                 if (nullValue) {
+                     new = None;
+                 } else {
+                     uid = valueIsUid ? (Tk_Uid) value : Tk_GetUid(value);
+                     new = Tk_GetPixmap(interp, tkwin, uid);
+                     if (new == None) {
+                         return TCL_ERROR;
+                     }
+                 }
+                 old = *((Pixmap *) ptr);
+                 if (old != None) {
+                     Tk_FreePixmap(Tk_Display(tkwin), old);
+                 }
+                 *((Pixmap *) ptr) = new;
+                 break;
+             }
  	    case TK_CONFIG_BORDER: {
  		Tk_3DBorder new, old;
  
***************
*** 774,779 ****
--- 793,805 ----
  	    }
  	    break;
  	}
+         case TK_CONFIG_PIXMAP: {
+             Pixmap pixmap = *((Pixmap *) ptr);
+             if (pixmap != None) {
+                 argv[4] = Tk_NameOfPixmap(Tk_Display(tkwin), pixmap);
+             }
+             break;
+         }
  	case TK_CONFIG_BORDER: {
  	    Tk_3DBorder border = *((Tk_3DBorder *) ptr);
  	    if (border != NULL) {
***************
*** 920,925 ****
--- 946,957 ----
  	    case TK_CONFIG_BITMAP:
  		if (*((Pixmap *) ptr) != None) {
  		    Tk_FreeBitmap(display, *((Pixmap *) ptr));
+ 		    *((Pixmap *) ptr) = None;
+ 		}
+ 		break;
+ 	    case TK_CONFIG_PIXMAP:
+ 		if (*((Pixmap *) ptr) != None) {
+ 		    Tk_FreePixmap(display, *((Pixmap *) ptr));
  		    *((Pixmap *) ptr) = None;
  		}
  		break;
*** tk3.6-jp.OLD/tkMenu.c	Wed Jan 12 14:25:50 1994
--- tk3.6-jp.NEW/tkMenu.c	Fri Jan 21 15:04:10 1994
***************
*** 60,71 ****
      int underline;		/* Index of character to underline. */
      Pixmap bitmap;		/* Bitmap to display in menu entry, or None.
  				 * If not None then label is ignored. */
  #ifdef KANJI
      wchar *accel;
  #else
      char *accel;		/* Accelerator string displayed at right
! 				 * of menu entry.  NULL means no such
! 				 * accelerator.  Malloc'ed. */
  #endif /* KANJI */
      int accelLength;		/* Number of non-NULL characters in
  				 * accelerator. */
--- 60,73 ----
      int underline;		/* Index of character to underline. */
      Pixmap bitmap;		/* Bitmap to display in menu entry, or None.
  				 * If not None then label is ignored. */
+     Pixmap clipMask;		/* Bitmap to specify the clipping mask
+ 				 * for transparent pixmaps, or None. */
  #ifdef KANJI
      wchar *accel;
  #else
      char *accel;		/* Accelerator string displayed at right
!   				 * of menu entry.  NULL means no such
!   				 * accelerator.  Malloc'ed. */
  #endif /* KANJI */
      int accelLength;		/* Number of non-NULL characters in
  				 * accelerator. */
***************
*** 192,201 ****
  	DEF_MENU_ENTRY_BG, Tk_Offset(MenuEntry, border),
  	COMMAND_MASK|CHECK_BUTTON_MASK|RADIO_BUTTON_MASK|CASCADE_MASK
  	|TK_CONFIG_NULL_OK},
!     {TK_CONFIG_BITMAP, "-bitmap", (char *) NULL, (char *) NULL,
  	DEF_MENU_ENTRY_BITMAP, Tk_Offset(MenuEntry, bitmap),
  	COMMAND_MASK|CHECK_BUTTON_MASK|RADIO_BUTTON_MASK|CASCADE_MASK
  	|TK_CONFIG_NULL_OK},
      {TK_CONFIG_STRING, "-command", (char *) NULL, (char *) NULL,
  	DEF_MENU_ENTRY_COMMAND, Tk_Offset(MenuEntry, command),
  	COMMAND_MASK|CHECK_BUTTON_MASK|RADIO_BUTTON_MASK|CASCADE_MASK
--- 194,207 ----
  	DEF_MENU_ENTRY_BG, Tk_Offset(MenuEntry, border),
  	COMMAND_MASK|CHECK_BUTTON_MASK|RADIO_BUTTON_MASK|CASCADE_MASK
  	|TK_CONFIG_NULL_OK},
!     {TK_CONFIG_PIXMAP, "-bitmap", (char *) NULL, (char *) NULL,
  	DEF_MENU_ENTRY_BITMAP, Tk_Offset(MenuEntry, bitmap),
  	COMMAND_MASK|CHECK_BUTTON_MASK|RADIO_BUTTON_MASK|CASCADE_MASK
  	|TK_CONFIG_NULL_OK},
+     {TK_CONFIG_BITMAP, "-mask", (char *) NULL, (char *) NULL,
+ 	DEF_MENU_ENTRY_BITMAP, Tk_Offset(MenuEntry, clipMask),
+ 	COMMAND_MASK|CHECK_BUTTON_MASK|RADIO_BUTTON_MASK|CASCADE_MASK
+ 	|TK_CONFIG_NULL_OK},
      {TK_CONFIG_STRING, "-command", (char *) NULL, (char *) NULL,
  	DEF_MENU_ENTRY_COMMAND, Tk_Offset(MenuEntry, command),
  	COMMAND_MASK|CHECK_BUTTON_MASK|RADIO_BUTTON_MASK|CASCADE_MASK
***************
*** 699,704 ****
--- 705,711 ----
  	mePtr->labelLength = 0;
  	mePtr->underline = -1;
  	mePtr->bitmap = None;
+ 	mePtr->clipMask = None;
  	mePtr->accel = NULL;
  	mePtr->accelLength = 0;
  	mePtr->state = tkNormalUid;
***************
*** 1444,1449 ****
--- 1451,1473 ----
  	}
      }
  
+     if (mePtr->bitmap != None &&
+ 	Tk_GetPixmapClipMask(menuPtr->display, mePtr->bitmap) != None) {
+         if (mePtr->clipMask != None) {
+ 	    Tk_FreePixmap(menuPtr->display, mePtr->clipMask);
+         }
+         mePtr->clipMask =
+             Tk_GetPixmapClipMask(menuPtr->display, mePtr->bitmap);
+     } else {
+       if (mePtr->bitmap == None ||
+ 	  !Tk_PixmapExists(menuPtr->display, mePtr->clipMask)) {
+         if (mePtr->clipMask != None) {
+ 	  Tk_FreePixmap(menuPtr->display, mePtr->clipMask);
+         }
+ 	mePtr->clipMask = None;
+       }
+     }
+     
  #ifdef KANJI
      if (mePtr->asciiFontPtr != NULL || mePtr->kanjiFontPtr != NULL) {
  	mePtr->fontPtr = Tk_GetFontSet(
***************
*** 1667,1673 ****
  	if (mePtr->bitmap != None) {
  	    unsigned int bitmapWidth, bitmapHeight;
  
! 	    Tk_SizeOfBitmap(menuPtr->display, mePtr->bitmap,
  		    &bitmapWidth, &bitmapHeight);
  	    mePtr->height = bitmapHeight;
  	    width = bitmapWidth;
--- 1691,1697 ----
  	if (mePtr->bitmap != None) {
  	    unsigned int bitmapWidth, bitmapHeight;
  
!             Tk_SizeOfPixmap(menuPtr->display, mePtr->bitmap,
  		    &bitmapWidth, &bitmapHeight);
  	    mePtr->height = bitmapHeight;
  	    width = bitmapWidth;
***************
*** 1877,1891 ****
  	if (mePtr->bitmap != None) {
  	    unsigned int width, height;
  
! 	    Tk_SizeOfBitmap(menuPtr->display, mePtr->bitmap, &width, &height);
! 	    XCopyPlane(menuPtr->display, mePtr->bitmap, Tk_WindowId(tkwin),
  #ifdef KANJI
  		    gc->fe[0].gc, 0, 0, width, height,
  #else
! 		    gc, 0, 0, width, height,
  #endif /* KANJI */
! 		    menuPtr->borderWidth + menuPtr->selectorSpace,
! 		    (int) (mePtr->y + (mePtr->height - height)/2), 1);
  	} else {
  	    baseline = mePtr->y + (mePtr->height + fontPtr->ascent
  		    - fontPtr->descent)/2;
--- 1901,1948 ----
  	if (mePtr->bitmap != None) {
  	    unsigned int width, height;
  
!             Tk_SizeOfPixmap(menuPtr->display, mePtr->bitmap, &width, &height);
! 	    if (mePtr->clipMask != None) {
! #ifdef KANJI
!                 XSetClipOrigin(menuPtr->display, gc->fe[0].gc,
!                     menuPtr->borderWidth + menuPtr->selectorSpace, 
!                     (int) (mePtr->y + (mePtr->height - height)/2));
!                 XSetClipMask(menuPtr->display, gc->fe[0].gc,
!                     mePtr->clipMask);
! #else
!                 XSetClipOrigin(menuPtr->display, gc,
!                     menuPtr->borderWidth + menuPtr->selectorSpace, 
!                     (int) (mePtr->y + (mePtr->height - height)/2));
!                 XSetClipMask(menuPtr->display, gc,
!                     mePtr->clipMask);
! #endif /* KANJI */
! 	    }
!             if (Tk_DepthOfPixmap(menuPtr->display, mePtr->bitmap) == 1) {
!                 XCopyPlane(menuPtr->display, mePtr->bitmap, Tk_WindowId(tkwin),
! #ifdef KANJI
! 		    gc->fe[0].gc, 0, 0, width, height,
! #else
!   		    gc, 0, 0, width, height,
! #endif /* KANJI */
!                     menuPtr->borderWidth + menuPtr->selectorSpace,
!                     (int) (mePtr->y + (mePtr->height - height)/2), 1);
!             } else {
!                 XCopyArea(menuPtr->display, mePtr->bitmap, Tk_WindowId(tkwin),
  #ifdef KANJI
  		    gc->fe[0].gc, 0, 0, width, height,
  #else
!   		    gc, 0, 0, width, height,
! #endif /* KANJI */
!                     menuPtr->borderWidth + menuPtr->selectorSpace, 
!                     (int) (mePtr->y + (mePtr->height - height)/2));
!             }
! 	    if (mePtr->clipMask != None) {
! #ifdef KANJI
!                 XSetClipMask(menuPtr->display, gc->fe[0].gc, None);
! #else
!                 XSetClipMask(menuPtr->display, gc, None);
  #endif /* KANJI */
! 	    }
  	} else {
  	    baseline = mePtr->y + (mePtr->height + fontPtr->ascent
  		    - fontPtr->descent)/2;
*** tk3.6-jp.OLD/tkMenubutton.c	Wed Jan 12 14:25:50 1994
--- tk3.6-jp.NEW/tkMenubutton.c	Fri Jan 21 15:04:49 1994
***************
*** 72,77 ****
--- 72,79 ----
      Pixmap bitmap;		/* Bitmap to display or None.  If not None
  				 * then text and textVar and underline
  				 * are ignored. */
+     Pixmap clipMask;		/* Bitmap to specify the clipping mask
+ 				 * for transparent pixmaps, or None. */
  
      /*
       * Information used when displaying widget:
***************
*** 187,195 ****
  	(char *) NULL, 0, 0},
      {TK_CONFIG_SYNONYM, "-bg", "background", (char *) NULL,
  	(char *) NULL, 0, 0},
!     {TK_CONFIG_BITMAP, "-bitmap", "bitmap", "Bitmap",
  	DEF_MENUBUTTON_BITMAP, Tk_Offset(MenuButton, bitmap),
  	TK_CONFIG_NULL_OK},
      {TK_CONFIG_PIXELS, "-borderwidth", "borderWidth", "BorderWidth",
  	DEF_MENUBUTTON_BORDER_WIDTH, Tk_Offset(MenuButton, borderWidth), 0},
      {TK_CONFIG_ACTIVE_CURSOR, "-cursor", "cursor", "Cursor",
--- 189,200 ----
  	(char *) NULL, 0, 0},
      {TK_CONFIG_SYNONYM, "-bg", "background", (char *) NULL,
  	(char *) NULL, 0, 0},
!     {TK_CONFIG_PIXMAP, "-bitmap", "bitmap", "Bitmap",
  	DEF_MENUBUTTON_BITMAP, Tk_Offset(MenuButton, bitmap),
  	TK_CONFIG_NULL_OK},
+     {TK_CONFIG_BITMAP, "-mask", "mask", "Mask",
+ 	DEF_MENUBUTTON_BITMAP, Tk_Offset(MenuButton, clipMask),
+ 	TK_CONFIG_NULL_OK},
      {TK_CONFIG_PIXELS, "-borderwidth", "borderWidth", "BorderWidth",
  	DEF_MENUBUTTON_BORDER_WIDTH, Tk_Offset(MenuButton, borderWidth), 0},
      {TK_CONFIG_ACTIVE_CURSOR, "-cursor", "cursor", "Cursor",
***************
*** 325,330 ****
--- 330,336 ----
      mbPtr->underline = -1;
      mbPtr->textVarName = NULL;
      mbPtr->bitmap = None;
+     mbPtr->clipMask = None;
      mbPtr->state = tkNormalUid;
      mbPtr->normalBorder = NULL;
      mbPtr->activeBorder = NULL;
***************
*** 623,629 ****
      gcValues.foreground = mbPtr->normalFg->pixel;
      gcValues.background = Tk_3DBorderColor(mbPtr->normalBorder)->pixel;
  
!     /*
       * Note: GraphicsExpose events are disabled in GC's because they're
       * used to copy stuff from an off-screen pixmap onto the screen (we know
       * that there's no problem with obscured areas).
--- 629,652 ----
      gcValues.foreground = mbPtr->normalFg->pixel;
      gcValues.background = Tk_3DBorderColor(mbPtr->normalBorder)->pixel;
  
!     if (mbPtr->bitmap != None &&
! 	Tk_GetPixmapClipMask(mbPtr->display, mbPtr->bitmap) != None) {
!         if (mbPtr->clipMask != None) {
! 	    Tk_FreePixmap(mbPtr->display, mbPtr->clipMask);
!         }
!         mbPtr->clipMask =
!             Tk_GetPixmapClipMask(mbPtr->display, mbPtr->bitmap);
!     } else {
!       if (mbPtr->bitmap == None ||
! 	  !Tk_PixmapExists(mbPtr->display, mbPtr->clipMask)) {
!         if (mbPtr->clipMask != None) {
! 	  Tk_FreePixmap(mbPtr->display, mbPtr->clipMask);
!         }
! 	mbPtr->clipMask = None;
!       }
!     }
!      
!    /*
       * Note: GraphicsExpose events are disabled in GC's because they're
       * used to copy stuff from an off-screen pixmap onto the screen (we know
       * that there's no problem with obscured areas).
***************
*** 835,841 ****
      if (mbPtr->bitmap != None) {
  	unsigned int width, height;
  
! 	Tk_SizeOfBitmap(mbPtr->display, mbPtr->bitmap, &width, &height);
  	switch (mbPtr->anchor) {
  	    case TK_ANCHOR_NW: case TK_ANCHOR_W: case TK_ANCHOR_SW:
  		x += mbPtr->borderWidth + mbPtr->padX;
--- 858,864 ----
      if (mbPtr->bitmap != None) {
  	unsigned int width, height;
  
!         Tk_SizeOfPixmap(mbPtr->display, mbPtr->bitmap, &width, &height);
  	switch (mbPtr->anchor) {
  	    case TK_ANCHOR_NW: case TK_ANCHOR_W: case TK_ANCHOR_SW:
  		x += mbPtr->borderWidth + mbPtr->padX;
***************
*** 860,865 ****
--- 883,900 ----
  			- height;
  		break;
  	}
+         if (mbPtr->clipMask != None) {
+ #ifdef KANJI
+             XSetClipOrigin(mbPtr->display, gc->fe[0].gc, x, y);
+             XSetClipMask(mbPtr->display, gc->fe[0].gc,
+ 		mbPtr->clipMask);
+ #else
+             XSetClipOrigin(mbPtr->display, gc, x, y);
+             XSetClipMask(mbPtr->display, gc,
+ 		mbPtr->clipMask);
+ #endif /* KANJI */
+ 	}
+         if (Tk_DepthOfPixmap(mbPtr->display, mbPtr->bitmap) == 1) {
  #ifdef KANJI
  	XCopyPlane(mbPtr->display, mbPtr->bitmap, pixmap,
  		gc->fe[0].gc, 0, 0, width, height, x, y, 1);
***************
*** 867,872 ****
--- 902,923 ----
  	XCopyPlane(mbPtr->display, mbPtr->bitmap, pixmap,
  		gc, 0, 0, width, height, x, y, 1);
  #endif /* KANJI */
+         } else {
+ #ifdef KANJI
+ 	  XCopyArea(mbPtr->display, mbPtr->bitmap, pixmap,
+ 		    gc->fe[0].gc, 0, 0, width, height, x, y);
+ #else
+ 	  XCopyArea(mbPtr->display, mbPtr->bitmap, pixmap,
+ 		    gc, 0, 0, width, height, x, y);
+ #endif /* KANJI */
+         }
+         if (mbPtr->clipMask != None) {
+ #ifdef KANJI
+             XSetClipMask(mbPtr->display, gc->fe[0].gc, None);
+ #else
+             XSetClipMask(mbPtr->display, gc, None);
+ #endif /* KANJI */
+         }
      } else {
  	switch (mbPtr->anchor) {
  	    case TK_ANCHOR_NW: case TK_ANCHOR_W: case TK_ANCHOR_SW:
***************
*** 1020,1026 ****
      unsigned int width, height;
  
      if (mbPtr->bitmap != None) {
! 	Tk_SizeOfBitmap(mbPtr->display, mbPtr->bitmap, &width, &height);
  	if (mbPtr->width > 0) {
  	    width = mbPtr->width;
  	}
--- 1071,1077 ----
      unsigned int width, height;
  
      if (mbPtr->bitmap != None) {
!         Tk_SizeOfPixmap(mbPtr->display, mbPtr->bitmap, &width, &height);
  	if (mbPtr->width > 0) {
  	    width = mbPtr->width;
  	}
*** tk3.6-jp.OLD/tkWm.c	Sat Aug  6 13:46:48 1994
--- tk3.6-jp.NEW/tkWm.c	Sat Aug  6 13:47:54 1994
***************
*** 983,989 ****
  	}
  	if (argc == 3) {
  	    if (wmPtr->hints.flags & IconPixmapHint) {
! 		interp->result = Tk_NameOfBitmap(winPtr->display,
  			wmPtr->hints.icon_pixmap);
  	    }
  	    return TCL_OK;
--- 983,989 ----
  	}
  	if (argc == 3) {
  	    if (wmPtr->hints.flags & IconPixmapHint) {
! 		interp->result = Tk_NameOfPixmap(winPtr->display,
  			wmPtr->hints.icon_pixmap);
  	    }
  	    return TCL_OK;
***************
*** 994,1000 ****
  	    }
  	    wmPtr->hints.flags &= ~IconPixmapHint;
  	} else {
! 	    pixmap = Tk_GetBitmap(interp, tkwin, Tk_GetUid(argv[3]));
  	    if (pixmap == None) {
  		return TCL_ERROR;
  	    }
--- 994,1000 ----
  	    }
  	    wmPtr->hints.flags &= ~IconPixmapHint;
  	} else {
! 	    pixmap = Tk_GetPixmap(interp, tkwin, Tk_GetUid(argv[3]));
  	    if (pixmap == None) {
  		return TCL_ERROR;
  	    }
*** tk3.6-jp.OLD/doc/button.n	Wed Jan 12 14:25:40 1994
--- tk3.6-jp.NEW/doc/button.n	Wed Jan 12 14:25:32 1994
***************
*** 33,42 ****
  .nf
  .ta 4c 8c 12c
  .VS
! \fBactiveBackground\fR	\fBbitmap\fR	\fBfont\fR	\fBrelief\fR
! \fBactiveForeground\fR	\fBborderWidth\fR	\fBforeground\fR	\fBtext\fR
! \fBanchor\fR	\fBcursor\fR	\fBpadX\fR	\fBtextVariable\fR
! \fBbackground\fR	\fBdisabledForeground\fR	\fBpadY\fR
  .VE
  .fi
  .LP
--- 33,42 ----
  .nf
  .ta 4c 8c 12c
  .VS
! \fBactiveBackground\fR	\fBbitmap\fR	\fBfont\fR	\fBpadY\fR
! \fBactiveForeground\fR	\fBborderWidth\fR	\fBforeground\fR	\fBrelief\fR
! \fBanchor\fR	\fBcursor\fR	\fBmask\fR	\fBtext\fR
! \fBbackground\fR	\fBdisabledForeground\fR	\fBpadX\fR	\fBtextVariable\fR
  .VE
  .fi
  .LP
*** tk3.6-jp.OLD/doc/canvas.n	Wed Jan 12 14:25:40 1994
--- tk3.6-jp.NEW/doc/canvas.n	Wed Jan 12 14:25:32 1994
***************
*** 744,749 ****
--- 744,759 ----
  as the destination location for the moved items.
  This command returns an empty string.
  .TP
+ \fIpathName \fBsave \fIfileName format \fR?x y width height?\fR
+ Save the contents of the canvas widget to a output file. The
+ type of the output file is defined with the \fIformat\fR option.
+ Currently only the formats \fIbitmap\fR and \fIxpm3\fR are
+ supported. The \fIfileName\fR specifies the output filename. If
+ no position (\fIx\fR, \fIy\fR) and size (\fIwidth\fR, \fIheight\fR)
+ are given the currently visible window is saved. By specifing a
+ position and size the given rectangle is saved.
+ This command returns an empty string.
+ .TP
  \fIpathName \fBscale \fItagOrId xOrigin yOrigin xScale yScale\fR
  Rescale all of the items given by \fItagOrId\fR in canvas coordinate
  space.
***************
*** 1011,1016 ****
--- 1021,1030 ----
  whose value is 1.
  \fIColor\fR may have any of the forms accepted by \fBTk_GetColor\fR and
  defaults to \fBblack\fR.
+ .TP
+ \fB\-mask \fImask\fR
+ Specifies the bitmap to use as the mask for the \fB-bitmap\fR
+ option.
  .TP
  \fB\-tags \fItagList\fR
  Specifies a set of tags to apply to the item.
*** tk3.6-jp.OLD/doc/checkbutton.n	Wed Jan 12 14:25:41 1994
--- tk3.6-jp.NEW/doc/checkbutton.n	Wed Jan 12 14:25:32 1994
***************
*** 33,42 ****
  .nf
  .ta 4c 8c 12c
  .VS
! \fBactiveBackground\fR	\fBbitmap\fR	\fBfont\fR	\fBrelief\fR
! \fBactiveForeground\fR	\fBborderWidth\fR	\fBforeground\fR	\fBtext\fR
! \fBanchor\fR	\fBcursor\fR	\fBpadX\fR	\fBtextVariable\fR
! \fBbackground\fR	\fBdisabledForeground\fR	\fBpadY\fR
  .VE
  .fi
  .LP
--- 33,42 ----
  .nf
  .ta 4c 8c 12c
  .VS
! \fBactiveBackground\fR	\fBbitmap\fR	\fBfont\fR	\fBpadY\fR
! \fBactiveForeground\fR	\fBborderWidth\fR	\fBforeground\fR	\fBrelief\fR
! \fBanchor\fR	\fBcursor\fR	\fBmask\fR	\fBtext\fR
! \fBbackground\fR	\fBdisabledForeground\fR	\fBpadX\fR	\fBtextVariable\fR
  .VE
  .fi
  .LP
*** tk3.6-jp.OLD/doc/menu.n	Wed Jan 12 14:25:41 1994
--- tk3.6-jp.NEW/doc/menu.n	Wed Jan 12 14:25:33 1994
***************
*** 89,95 ****
  Menu entries are displayed with up to three
  separate fields.  The main field is a label in the form of text or
  a bitmap, which is determined by the \fB\-label\fR or \fB\-bitmap\fR
! option for the entry.
  If the  \fB\-accelerator\fR option is specified for an entry then a second
  textual field is displayed to the right of the label.  The accelerator
  typically describes a keystroke sequence that may be typed in the
--- 89,98 ----
  Menu entries are displayed with up to three
  separate fields.  The main field is a label in the form of text or
  a bitmap, which is determined by the \fB\-label\fR or \fB\-bitmap\fR
! option for the entry. The bitmap displayed by the \fB-bitmap\fR option
! can be manipulated by the \fB-mask\fR option. This option contains a
! bitmap that specifies which dots from the original bitmap should actually
! be displayed.
  If the  \fB\-accelerator\fR option is specified for an entry then a second
  textual field is displayed to the right of the label.  The accelerator
  typically describes a keystroke sequence that may be typed in the
***************
*** 328,333 ****
--- 331,343 ----
  \fB\-label \fIvalue\fR
  Specifies a string to display as an identifying label in the menu
  entry.  Not available for separator entries.
+ .TP
+ \fB\-mask \fIvalue\fR
+ Specifies a bitmap to use as the mask for the bitmap specified with
+ the \fB-bitmap\fR option. Only the pixels that are set in the mask
+ are displayed. If the picture format itself supports masks (like
+ Xpm3), the mask is taken from the loaded picture. This option is not
+ available for separator entries.
  .TP
  \fB\-menu \fIvalue\fR
  Available only for cascade entries.  Specifies the path name of
*** tk3.6-jp.OLD/doc/menubutton.n	Wed Jan 12 14:25:41 1994
--- tk3.6-jp.NEW/doc/menubutton.n	Wed Jan 12 14:25:33 1994
***************
*** 33,42 ****
  .nf
  .VS
  .ta 4c 8c 12c
! \fBactiveBackground\fR	\fBbitmap\fR	\fBfont\fR	\fBrelief\fR
! \fBactiveForeground\fR	\fBborderWidth\fR	\fBforeground\fR	\fBtext\fR
! \fBanchor\fR	\fBcursor\fR	\fBpadX\fR	\fBtextVariable\fR
! \fBbackground\fR	\fBdisabledForeground\fR	\fBpadY\fR	\fBunderline\fR
  .VE
  .fi
  .LP
--- 33,43 ----
  .nf
  .VS
  .ta 4c 8c 12c
! \fBactiveBackground\fR	\fBborderwidth\fR	\fBmask\fR	\fBtextVariable\fR
! \fBactiveForeground\fR	\fBcursor\fR	\fBpadX\fR	\fBunderline\fR
! \fBanchor\fR	\fBdisabledForeground\fR	\fBpadY\fR
! \fBbackground\fR	\fBfont\fR	\fBrelief\fR
! \fBbitmap\fR	\fBforeground\fR	\fBtext\fR
  .VE
  .fi
  .LP
*** tk3.6-jp.OLD/doc/options.n	Wed Jan 12 14:25:41 1994
--- tk3.6-jp.NEW/doc/options.n	Wed Jan 12 14:25:33 1994
***************
*** 347,352 ****
--- 347,363 ----
  .VE
  .LP
  .nf
+ Name:	\fBmask\fR
+ Class:	\fBMask\fR
+ Command-Line Switch:	\fB\-mask\fR
+ .fi
+ .IP
+ Specifies a bitmap to use as the mask for the bitmap specified with
+ the \fB-bitmap\fR option. Only the pixels that are set in the mask
+ are displayed. If the picture format itself supports masks (like
+ Xpm3), the mask is taken from the loaded picture.
+ .LP
+ .nf
  Name:	\fBorient\fR
  Class:	\fBOrient\fR
  Command-Line Switch:	\fB\-orient\fR
*** tk3.6-jp.OLD/doc/radiobutton.n	Wed Jan 12 14:25:41 1994
--- tk3.6-jp.NEW/doc/radiobutton.n	Wed Jan 12 14:25:33 1994
***************
*** 33,42 ****
  .nf
  .ta 4c 8c 12c
  .VS
! \fBactiveBackground\fR	\fBbitmap\fR	\fBfont\fR	\fBrelief\fR
! \fBactiveForeground\fR	\fBborderWidth\fR	\fBforeground\fR	\fBtext\fR
! \fBanchor\fR	\fBcursor\fR	\fBpadX\fR	\fBtextVariable\fR
! \fBbackground\fR	\fBdisabledForeground\fR	\fBpadX\fR
  .VE
  .fi
  .LP
--- 33,42 ----
  .nf
  .ta 4c 8c 12c
  .VS
! \fBactiveBackground\fR	\fBbitmap\fR	\fBfont\fR	\fBpadY\fR
! \fBactiveForeground\fR	\fBborderWidth\fR	\fBforeground\fR	\fBrelief\fR
! \fBanchor\fR	\fBcursor\fR	\fBmask\fR	\fBtext\fR
! \fBbackground\fR	\fBdisabledForeground\fR	\fBpadX\fR	\fBtextVariable\fR
  .VE
  .fi
  .LP
