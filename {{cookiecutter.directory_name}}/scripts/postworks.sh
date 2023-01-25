#!/usr/bin/env bash
#GTH is the github token required to authenticate to git, must be present in the environment
#GIT_ORG is the github organization / user name where the repository should be created

function check_for_errors () {
  check_return_code $1 "$2" "$3"
  [[ $1 -ne 0  ]] && exit 1
}

function check_it_is_NOT_a_git_repository () {
  [ -d .git ] && echo " " || return
  echo "💥 FATAL ERROR! The directory is alredy a Git repository!"
  exit 1
}

function gh_authentication_check () {
  echo " "
  echo "🔐 GH login check..."
  gh auth status
  if [ $? -ne 0 ]; then 
    gh auth login --with-token ${GHT}
  fi
}

function create_the_repo () {
  echo " "
  echo "⚙️  creating the repository"
  gh repo create ${GIT_ORG}/$NEW_REPO_NAME --public --confirm
  check_for_errors $? "☑️  Repository cloned correctly"  "💥 GitHub client 🙀 terminated with an unexpected exit code..." 
}

function git_push_all () {
  echo " "
  echo "🔏 time to write and lock the updates into GitHub."
  git add --all
  git commit -m "chore: tuned the template to the new repo"
  check_for_errors $? "☑️  All the tuned files added to git." "💥 something went wrong during the commit into git..." 
  
  git push --set-upstream origin main
  check_for_errors $? "☑️  everything is committed into GitHub." "💥 pushing the files into GitHub raised a critical error..." 
}

