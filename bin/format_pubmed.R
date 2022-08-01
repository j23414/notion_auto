#! /usr/bin/env Rscript
# Auth: Jennifer Chang
# Date: 2022/08/01

# === Args
input_csv = "csv-michaelwor-set.csv"
outfile = "output.csv"

args <- commandArgs(trailingOnly = TRUE)
if (length(args)==0) {
  stop("At least one argument must be supplied (input file).n", call. = FALSE)
} else if (length(args) == 1) {
  input_csv <- args[1]
} else if (length(args) == 2) {
  input_csv <- args[1]
  outfile <- args[2]
}

# === Libraries
library("tidyverse")
library("magrittr")

# === Main
input = readr::read_delim(input_csv, delim=",")

cout = input %>%
  mutate(
    Name=Title,
    pubmed=paste("https://pubmed.ncbi.nlm.nih.gov/",PMID,"/", sep=""),
    authors=Authors,
    Title=NULL,
    PMID=NULL,
    Authors=NULL,
    `First Author`=NULL,
    `Publication Year`=NULL,
    PMCID=NULL,
    `NIHMS ID`=NULL,
    DOI=NULL,
    Publish_Date=Citation %>% gsub(";.*","",.) %>% gsub(". doi.*","",.) %>% gsub(".*\\. ","",.) %>% gsub("-.*","",.) %>% gsub(":.*","",.),
    Publish_Date = case_when( str_length(Publish_Date) < 9 ~ paste(Publish_Date, " 1", sep=""),
                                     TRUE ~ Publish_Date),
    Publish_Date=lubridate::as_datetime(Publish_Date),
    Citation = NULL,
    `Journal/Book`=NULL,
    `Create Date`=NULL
  )

readr::write_delim(cout, outfile, delim=",")
