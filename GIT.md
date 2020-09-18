git clone URL

### commit new change

```bash
git add. 
git commit -m "message"
git push
```

* a
* b

### update latest version

```bash
git pull
```

### git New Branch

```bash
git branch new_branch
git checkout new_branch
git push origin new_branch
```

### git merge/rebase to master branch

```bash
git rebase master ( recommand )
or
git merge master
```
http://gogojimmy.net/2012/01/21/how-to-use-git-2-basic-usage-and-worflow/

### Reset current branch

```bash
git reset --hard <tag/branch/commit id>
```

### Rebase and squash commit
(5 commit -> 1 commit)
```bash
git rebase -i HEAD~5
```

### undo commit but keep the change
```
    git reset --soft HEAD~1
```

### sync with remote repo
```
git fetch origin
git reset --hard origin/master
```

### change commit change author and committer
```
git filter-branch --env-filter '
if [ "$GIT_AUTHOR_EMAIL" = "old author email" ];
then
    GIT_AUTHOR_NAME="new name";
    GIT_AUTHOR_EMAIL="new email";
fi
if [ "$GIT_COMMITTER_EMAIL" = "old author email" ];
then
    GIT_COMMITTER_NAME="new name";
    GIT_COMMITTER_EMAIL="new email";
fi
' -- --all
```
