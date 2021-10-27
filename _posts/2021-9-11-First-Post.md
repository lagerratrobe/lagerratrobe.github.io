---
layout: post
title: New Jekyll-Based Blog Underway
date: 2021-9-11 11:00
---

I figure that it's always good to be a little behind the technical bleeding edge. It makes you seem like some sort of hipster luddite, or at least makes you feel like you're being fashionably late to the party.  Hence my late exploration of Jekyll, which was initially conceived by one of Github's founders back in [2008](https://tom.preston-werner.com/2008/11/17/blogging-like-a-hacker.html).  I'm only 13 years behind, but hey, better late than never.

Actually, I've had some sort of lame attempt at a Blog up in the past, but I always found the overhead of maintaining it to be more of a pain in the butt than it was worth.  Below was the latest attempt, using R-Studio to build and manage a website.  It worked, but I hated having to build the site every time I made a change.

![RStudio-website]({{ site.baseurl }}/images/R-based_blog.png)

I also tried out [Google's Blogspot](https://lagerratrobe.blogspot.com/) and got a few posts going in it, but it took more work than I wanted to commit to and it lacked the conceptual simplicity I was looking for.  We'll see how Jekyll does, but already I like what I'm seeing.

A few of my requirements for a Blog:

* Needs to be hosted as a Github "Page".  They're free and "just work"
* Needs to use Markdown
* Ideally, all I have to do is post content and some other magic tool takes care of formatting it for me
* No dependency on locally "building" the site after new posts are added or edits are made
* _Some_ degree of customization available for altering the basic layout of pages
* Ability to post updates from any machine that has Github access and a text editor

So far, it looks like Jekyll meets all of these requirements, but we'll see how it goes.  Thanks to [Barry Clark's](https://www.smashingmagazine.com/2014/08/build-blog-jekyll-github-pages/) post from 2014 for getting this going.

### Adding posts:

Simply add markdown docs into the site.  GitHub will automatically take care of building the Jekyll site and posting it in your github.io page.

```
.
├── 404.md
├── about.md
├── CNAME
├── _config.yml
├── images
├── _includes
├── index.html
├── _layouts
├── LICENSE
├── _posts
│   ├── 2021-9-11-Ebike-Conversion.md <-- Here
│   └── 2021-9-11-First-Post.md
├── README.md
├── _sass
└── style.scss
```

*IF* you want to preview the site locally, you'll have to install Jekyll locally as well and use it to serve the site.

```
$ sudo apt install ruby
$ sudo apt install ruby-dev
$ sudo gem install github-pages
$ cd $HOME/<git_acct>.github.io.git
$ jekyll serve --watch
...
  Server address: http://127.0.0.1:4000/
  Server running... press ctrl-c to stop.
```
