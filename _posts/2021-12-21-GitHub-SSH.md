---
layout: post
title: GitHub SSH	
date: 2021-12-21 11:00
tags:
  - tech
---

I keep forgetting the steps to do this, so for my benefit, here are the steps to enable an SSH connection to GitHub.

## Basic GitHub Repo Cloning

```
1. Generate public ssh key
> ssh-keygen -t rsa

2. Display the contents of the new public ssh key
> cat ~/.ssh/id_rsa.pub

3. copy everything from "ssh-rsa" through end of email address

4. Add contents of rsa.pub into GitHub -> Settings -> SSH & GPG Keys

5. Clone the repo
> git clone git@gitlab.com:<repo>.git
```

## Getting a specific Branch

The steps above will get you a basic repo over to your machine.  However, if you want to change into a specific branch of that repo, you need to do the following.

```
1. Change into the newly created repo folder (when you enter the repo, 
it shows the branch you're in, which is "master" by default)

> cd <repo_name>
User@Machine MINGW64 ~/<repo_name> (master) 

2. Check to see what branches are available
$ git branch -av
* master                          59f116b Merge branch 'modify_algorithm' into 'master'
  remotes/origin/HEAD             -> origin/master
  remotes/origin/master           59f116b Merge branch 'modify_algorithm' into 'master'
  remotes/origin/modify_algorithm 6e20ea3 added data files
  remotes/origin/national_run     c035975 completed national run

3. Grab one of the branches
> git branch remotes/origin/national_run 

4. Change over to using the new branch
> git checkout remotes/origin/national_run
warning: refname 'remotes/origin/national_run' is ambiguous.
Switched to branch 'remotes/origin/national_run'

User@Machine MINGW64 ~/<repo_name> (remotes/origin/national_run) 
```

## Creating New Repo from Project Dir

Often, I've been working for a little while in a directory that now has a project structure and I'd like to push the whole mess up to Github in a new repo.

```
1. Create the new Repo in the online Github interface.  Create it without README or anything else.

2. On your local machine:

$ cd <PROJECT_DIR> (AZML_Workbench_Demo in this case)
$ git init

# Create a README.md

$ git add *
$ git commit -m "first commit"
$ git branch -M main
$ git remote add origin git@github.com:lagerratrobe/AZML_Workbench_Demo.git
$ git push -u origin main
```
