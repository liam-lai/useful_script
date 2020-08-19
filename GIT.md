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