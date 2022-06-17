## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ---- eval=FALSE--------------------------------------------------------------
#  install.packages("dcmodifydb")

## ----setup--------------------------------------------------------------------
library(dcmodify)
library(dcmodifydb)

## ---- echo=FALSE--------------------------------------------------------------
knitr::kable(person)

## -----------------------------------------------------------------------------
con <- DBI::dbConnect(RSQLite::SQLite(), ":memory:")
dplyr::copy_to(con, person)

## -----------------------------------------------------------------------------
person_tbl <- dplyr::tbl(con, "person")
person_tbl

## -----------------------------------------------------------------------------
library(dcmodify) # needed for modifying rules
library(dcmodifydb) # needed to translate the rules
modify_so( person_tbl
         , if (age < 16) income = 0
         , if (year < 25) year = year + 2000
         )

## -----------------------------------------------------------------------------
# separate rule set
m <- modifier( if (age < 16) income = 0
             , if (year < 25) year = year + 2000
             , if (cigarettes > 0 ) smokes = "yes"
             , if (smokes == "no") cigarettes = 0
             , ageclass <- if (age < 18) "child" else "adult"
             , gender <- switch( toupper(gender)
                               , "F" = "F"
                               , "V" = "F" # common mistake
                               , "M" = "M"
                               , "NB"
                               )
             )

## -----------------------------------------------------------------------------
print(m)

## -----------------------------------------------------------------------------
# modify a copy of the table
modify(person_tbl, m, copy = TRUE)

## ---- eval=FALSE--------------------------------------------------------------
#  export_yaml(m, "corrections.yml")

## ---- eval = FALSE------------------------------------------------------------
#  m <- modifier(.file = "corrections.yml")
#  modify(person_tbl, m, copy = TRUE)

## ---- echo = FALSE------------------------------------------------------------
m <- modifier(.file = system.file("db/corrections.yml", package="dcmodifydb"))
modify(person_tbl, m, copy = TRUE)

## ----dump, eval=FALSE---------------------------------------------------------
#  dump_sql(m, person_tbl, file = "corrections.sql")

## ---- eval=TRUE, echo=FALSE, results='asis'-----------------------------------
dump_sql(m, person_tbl)

