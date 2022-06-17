## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)
library(dcmodify)
library(dcmodifydb)

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

