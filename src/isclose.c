/*

  isclose.c

  $Revision: 1.2 $ $Date: 2016/10/15 06:50:24 $

  Determine whether a point has a neighbour closer than 'r'
  
  Data must be ordered by increasing x coordinate
*/

#include <R.h>

#undef TORUS

#undef ZCOORD

#define CLOSEFUN isXclose
#define CROSSFUN isXYclose
#include "isclose.h"
#undef CLOSEFUN
#undef CROSSFUN

#define ZCOORD

#define CLOSEFUN isX3close
#define CROSSFUN isXY3close
#include "isclose.h"
#undef CLOSEFUN
#undef CROSSFUN

#define TORUS

#undef ZCOORD

#define CLOSEFUN isXpclose
#define CROSSFUN isXYpclose
#include "isclose.h"
#undef CLOSEFUN
#undef CROSSFUN

#define ZCOORD

#define CLOSEFUN isX3pclose
#define CROSSFUN isXY3pclose
#include "isclose.h"
#undef CLOSEFUN
#undef CROSSFUN