# SHELL

### aws 

```
brew install pick
echo "ssh \$(cat ~/.ssh/config | grep 'Host ' | awk '{ print \$2 }' | pick)" > /usr/local/bin/guessh
chmod u+x /usr/local/bin/guessh
```

### git

create branch, git add, confirm commit, put commit message, push

```
#!/bin/sh

publish(){
  read -p 'commit message: ' message
  git commit -m "$message"
  pr_title="test"
  git push -u origin $branch
  #git pull-request --title "$pr_title" --message "$pr_message" --target-branch "$branch"
}

read -p "Branch Name: " branch

git checkout -b $branch
git add .
git status
while true; do
    read -p "Do you wish to push this commit? [Y/n]" yn
    yn=${yn:-y}
    case $yn in
        [Yy]* ) publish; break;;
        []* ) publish; break;;
        [Nn]* ) exit;;
        * ) echo "$yn Please answer yes or no.";;
    esac
done
```
