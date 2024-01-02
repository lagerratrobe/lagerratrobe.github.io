---
layout: post
title: Github PAT in Workbench	
date: 2024-01-02 11:00
tags:
  - tech
  - R_Hacks
---

I've written in the past about creating SSH keys to use with Github, but as with all things, new ideas and preferences come along and SSH keys are no longer the accepted way of managing access to GH.  The new, approved way of managing access to GH repos is via Personal Access Tokens or PATs.  Without going into what I think about this change, it's been important for me to find a way to work with PATs in Posit Workbench.

Below is one way of storing a PAT locally in Workbench and associating RStudio with it.  It's not the most ideal way of doing this, as the PAT is stored as plain text in your user home directory, but it does allow GH access without having to reset the PAT every session you start in Workbench.  The ideas for this were lifted from a variety of sources and as always, if you don't agree with this method - don't do it!


## TLDR:

__Step 1.__ Generate a classic PAT on Github and set whatever scope you want it to have, https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens#creating-a-personal-access-token-classic. Token will look something like this:
```
ghp_xxxxxXXXXXXXxxxxXXXXXXXXxxxxxxXXXXXXXX
```

__Step 2.__ Use the `git` utility from a bash term on Workbench to tell the "credential.helper" that you want to store the creds locally in a file. (Thanks Lisa!)

```
git config --global credential.helper 'store --file ~/.my-credentials'
```

__Step 3.__ In R, run `credentials::set_github_pat()`.  It will ask you to give your PAT, enter
```
ghp_xxxxxXXXXXXXxxxxXXXXXXXXxxxxxxXXXXXXXX
```

__Step 4.__ In bash, verify that the PAT has been set where it should be and that it's associated with the right account.

```
$ git config --global --edit

[user]
        email = foo@gmail.com
        name = foobar
[credential]
        helper = store --file ~/.my-credentials
```

...and if you look at the contents of `~/.my-credentials`, you should see your PAT stored there.

```
$ cat /home/randre/.my-credentials
https://PersonalAccessToken:ghp_xxxxxXXXXXXXxxxxXXXXXXXXxxxxxxXXXXXXXX@github.com
```

__Step 5.__ Set the access perms on the .my-credentials file to be less permissive

```
# Before
$ ll ~/.my-credentials
-rw-r--r--+  1 randre randre      80 Jan  2 14:33 .my-credentials

# After
$ chmod 600 .my-credentials 
randre@posit2:/data/RProjects/randre$ ll ~/.my-credentials
-rw-------+  1 randre randre      80 Jan  2 14:53 .my-credentials
```

__Step 6.__ Test that it all works from within RStudio.



