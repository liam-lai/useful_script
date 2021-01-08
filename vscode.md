# Auto Pull Request

1. Install plugin 'Github Pull Request and Issues' with *0.15.0* version 

2. Genereate a github token
Github -> Settings -> Developer Setting -> Personal Access tokens -> create a token with following permission

```
read:user, repo, user:email, write:discussion

```

3. VSCode Open User Setting Json

```
{
  "githubPullRequests.hosts": [
    {
      "host": "github.<my-company>.com",
      "token": "xxxx",          <------- genereate a token from github developer setting, permission: read:user, repo, user:email, write:discussion
      "username": "oauth"
    }
  ],
}
```

4. reopen vscode
