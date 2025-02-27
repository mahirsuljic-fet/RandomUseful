===========
| SSH KEY |
===========

# Setup
https://gist.github.com/xirixiz/b6b0c6f4917ce17a90e00f9b60566278?permalink_comment_id=4190692

# Test SSH key
ssh -T git@github.com

# Use SSH key in current repository
git remote set-url origin git@github.com:USERNAME/REPOSITORY.git

# Markdown cheatsheet
https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet

============
| COMMANDS |
============

git init                        -> setup repository
git status                      -> see current repository status
git add FILES                   -> add files to repository (track existing)
git add --all                   -> add all non-tracker files to repository
git commit FILES -m "MESSAGE"   -> commit files with message
git push                        -> push commits 
git push origin BRANCH          -> push commits to branch BRANCH
git pull                        -> pull repository
git pull origin BRANCH          -> pull repository to branch BRANCH
git add remote origin URL       -> link local repository to remote repository
git branch                      -> list branches
git branch NAME                 -> make new branch
git branch -D NAME              -> remove branch
git checkout NAME               -> change branch
git log                         -> log of commits
git merge BRANCH                -> merge branch BRANCH with current branch
git clone URL                   -> clone repository from URL
