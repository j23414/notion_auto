#! /usr/bin/env bash

set -v

echo "" > 01_github_issues.txt

while read repo; do
    echo ${repo}
    gh api ${repo} --jq '.[] | select(.state == "open") | { html_url, title, created_at, state, "assignee" : .assignees[]["login"], "requester" : .user["login"] } | join("\t") ' >> 01_github_issues.txt
    sleep 1
done < repos.txt

# todo: could also pull PRs
