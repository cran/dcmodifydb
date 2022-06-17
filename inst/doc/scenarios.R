## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)
library(dcmodify)
library(dcmodifydb)

## -----------------------------------------------------------------------------
m <- modifier( if (year < 25) year = year + 2000)

## -----------------------------------------------------------------------------
m <- modifier( if (year < 100){
  if (year > 25) {
    year = year + 1900
  } else {
    year = year + 2000
  }
})

## ---- results='asis', echo=FALSE----------------------------------------------
d <- data.frame(smokes=c(TRUE, FALSE), cigarettes=c(10,NA))
knitr::kable(d)

## ---- eval = FALSE------------------------------------------------------------
#  if (smokes ==  FALSE) cigarretes = 0

## ---- echo = FALSE, results='asis'--------------------------------------------
m <- modifier(if (smokes ==  FALSE) {
  cigarretes = 0
})
dc <- modify(d, m)
knitr::kable(dc)

## -----------------------------------------------------------------------------
m <- modifier( if (age < 12) income = 0)

## -----------------------------------------------------------------------------
m <- modifier(if (age > 67) {retired = TRUE} else {retired = FALSE})

## -----------------------------------------------------------------------------
m <- modifier( 
  if (age > 67) {
    retired = TRUE
    salary = 0 
  }
)

