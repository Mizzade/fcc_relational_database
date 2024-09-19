# Git

### Commands

#### status
- git status: See status of the working tree.
---
#### log
- git log: Check commit history.
- git log --oneline: More readable version of `git log`.
- git add `<file_name>`: Add a file to the staging area.
- git log -1: view last commit.
- igt log -`<number>`: View the last `<number>` of commits, e.g. git log -5 shows the last 5 commits.
---
#### add
- git add `<file_name>`: Add `<file_name>` to staging area.
- git add .: Add all files to staging.
---
#### commit
- git commit -m "`<message>`": Commit all changes in the staging area. The `-m` flag allows to pass in a message that is added to this commit and can be seen in the git history when calling `git log`.
- git diff: See the difference between the working tree and the last commit in that branch.
---
#### branch
- git branch: See the current branches in your repo.
- git branch -d `<branch_name>`: Delete the branch `<branch_name>`.
- git barnch  `<branch_name>`: Create a new branch `<branch_name>`.
---
#### checkout
- git checkout `<branch_name>`: Switch to the branch `<branch_name>`.
- git checkout -b `<branch_name>`: Create and switch to the new branch `<branch_name>`
---
#### merge
- git merge `<branch_name>`: Merge the changes of `<branch_name>` into the current branch.
---
#### rebase
- git rebase `<branch_name>`: Rebase this branch with `<branch_name>`.
- git rebase --continue: After adding all changes to the staging area, continue with the rebase.
- git rebase --interactive HEAD~2: Enter the interactive mode of git rebase. HEAD~2 means you will have a chance to change the last two commits.
- git rebase -i -root: `--root` means that the rebase will go back to your very first commit.
---
#### stash
- git stash: Put your changes aside.
- git stash list: View all stashed items.
- git stash pop: Remove the most recent stash and apply it to the working tree.
- git stash show: View a condensed version of the changes in the **latest** stash.
- git stash show -p: Wie the full changes. `-p` stands for "patch". (Like git diff, but for the stash.)
- git stash apply: Apply the latest stash to the working tree without deleting it from the list of stashed items.
- git stash drop: drop the latest stashed item
- git stash drop stash@{#}: drop the n-th stashed item.
---
#### reset
- git reset HEAD~1: Go to the commit before the current HEAD commit. This is "mixed" reset and will put the changes from the commit you undid in your working tree.
- git reset: Removes a commit and also removes it from the git history.
- git reset --soft HEAD~1: Removes the last commit but does not add the changes to the working tree.
- git reset --hard HEAD~1: Removes the last commit but adds the change to staging and to the working tree.
---
#### revert
- git revert: Remove a commit  without losing it in the git history.
- git revert HEAD: Revert the most recent commit.

---


### Further concepts

#### HEAD
- `HEAD` is a reference to the last commit you just made.

#### Stash
- `stash@{0}` is the most recent stash
- Select a specific stash by it's number, e.g. stash@{#} where `#` is the number of the stashed item.

#### Interactive Rebase
- p, pick: use the commit as it were
- d, drop: remove commit
- r, reword: Use commit, but edit the commit message
- s, squash: use commit, but meld into previous commit
