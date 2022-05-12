#! /usr/bin/env bash

set -v

echo "" > all_01_github_issues.txt

while read repo; do
    echo ${repo}
    gh api ${repo} --jq '.[] | select(.state == "open") | { html_url, title, created_at, state, "requester" : .user["login"] } | join("\t") ' >> all_01_github_issues.txt
    sleep 1
done < repos.txt

# todo: could also pull PRs
