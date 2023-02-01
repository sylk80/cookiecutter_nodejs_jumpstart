#!/usr/bin/env bash

NEW_REPO_NAME=$1
TRUE=0
FALSE=1
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

source ${DIR}/postworks.sh

gh_authentication
gh_authentication_check
check_it_is_NOT_a_git_repository
create_the_repo
git_push_all