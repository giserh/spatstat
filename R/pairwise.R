#
#
#    pairwise.S
#
#    $Revision: 1.11 $	$Date: 2018/03/15 07:37:41 $
#
#    Pairwise()    create a user-defined pairwise interaction process
#                 [an object of class 'interact']
#	
# -------------------------------------------------------------------
#	

Pairwise <- function(pot, name = "user-defined pairwise interaction process",
                     par = NULL, parnames=NULL,
                     printfun) {

  fop <- names(formals(pot))
  if(!identical(all.equal(fop, c("d", "par")), TRUE)
     && !identical(all.equal(fop, c("d", "tx", "tu", "par")), TRUE))
    stop(paste("Formal arguments of pair potential function",
               sQuote("pot"),
               "must be either (d, par) or (d, tx, tu, par)"))

  if(!is.null(parnames)) {
    stopifnot(is.character(parnames))
    if(is.null(par) || length(par) != length(parnames))
      stop("par does not match parnames")
  }
  if(missing(printfun))
    printfun <- function(self) {
           cat("Potential function:\n")
           print(self$pot)
           if(!is.null(parnames <- self$parnames)) {
             for(i in 1:length(parnames)) {
               cat(paste(parnames[i], ":\t"))
               pari <- self$par[[i]]
               if(is.numeric(pari) && length(pari) == 1)
                 cat(pari, "\n")
               else 
                 print(pari)
             }
           }
         }

  out <- 
  list(
         name     = name,
         creator  = "Pairwise",
         family   = pairwise.family,
         pot      = pot,
         par      = par,
         parnames = parnames,
         hasInf   = NA,
         init     = NULL,
         update   = function(self, ...){
           do.call(Pairwise,
                   resolve.defaults(list(...),
                                    list(pot=self$pot, name=self$name,
                                         par=self$par, parnames=self$parnames,
                                         printfun=self$print)))
         } , 
         print    = printfun,
         version  = versionstring.spatstat()
  )
  class(out) <- "interact"
  return(out)
}

Pairwise <- intermaker(Pairwise,
                       list(creator="Pairwise",
                            name="user-defined pairwise interaction process",
                            par=formals(Pairwise),
                            parnames=list("the potential",
                                "the name of the interaction",
                                "the list of parameters",
                                "a description of each parameter",
                                "an optional print function")))


