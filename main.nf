#! /usr/bin/env nextflow

nextflow.enable.dsl=2

process fetch_github_issues {
  publishDir "results", mode: 'copy'
  output: path("01_github_issues.txt")
  script:
  """
  #! /usr/bin/env bash
  wget https://raw.githubusercontent.com/j23414/notion_auto/main/bin/repos.txt
  01_fetch_github_issues.sh
  """
}

process subset_new {
  publishDir "results", mode: 'copy'
  input: path(requests_csv) // currently hardcoded, could be generalized
  output: path("new_all.csv")
  script:
  """
  #! /usr/bin/env bash
  02_subset_new.sh
  """
}

workflow {
  issues_ch = fetch_github_issues()

  if(params.requests_csv) {
    issues_ch
    | combine(channel.fromPath(params.requests_csv))
    | subset_new
  }
}