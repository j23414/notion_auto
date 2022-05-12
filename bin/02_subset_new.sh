#! /usr/bin/env bash

set -v

cat Requests.csv |\
    awk -F'https:' '{print $2}'|\
    awk -F',' '{print $1}' |\
    sort | \
    uniq |\
    grep -v "^github"|\
    grep -v "^$" > old.txt

echo "assignees,create_date,github_task,requester,status,Task_Name" > new_01.csv
grep -v -f old.txt 01_github_issues.txt | grep -v "^$" \ | tr ',' ' ' | tr '\t' ','  >> new_01.csv
cat new_01.csv| awk -F',' '{print $3}' | grep -v "^github" >> old.txt

echo "create_date,github_task,requester,status,Task_Name" > new_all.csv
grep -v -f old.txt all_01_github_issues.txt |grep -v "^$"| tr ',' ' ' | tr '\t' ','>> new_all.csv
