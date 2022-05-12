#! /usr/bin/env Rscript

library(magrittr)
library(tidyverse)

data<-readr::read_delim(
  "01_github_issues.txt",
  col_names = c("assignees", "create_date", "github_task", "requester", "status", "Task_Name"), 
  delim="\t")

uniqMerge <- function(vc) {
  vc <- vc %>%
    na.omit(.) %>%
    unique(.) %>%
    paste(., collapse = ";", sep = "")
  if (grepl(",", vc)) {
    vc <- vc %>%
      stringr::str_split(., ";", simplify = T) %>%
      as.vector(.) %>%
      unique(.) %>%
      paste(., collapse = ";", sep = "")
  }
  return(vc)
}

cdata <- data %>%
  dplyr::group_by(github_task) %>%
  dplyr::summarize(
    assignees = assignees %>% uniqMerge(.),
    create_date = create_date %>% uniqMerge(.),
    requester = requester %>% uniqMerge(.),
    status = status %>% uniqMerge(.),
    Task_Name = Task_Name %>% uniqMerge(.)
  )

readr::write_delim(cdata, "02_processed.csv",delim=",")
