---
layout: post
title: R Sendmail Tricks
date: 2021-10-27 11:00
---

One of the most useful things I've found to do with R is to make periodic checks of various things in my data environment.  This is particularly useful in places where 2 systems store the same data that _in theory_ should be kept in sync, but in practice exhibit drift for whatever reason.  It's easy to create a script that compares both systems and flags any discrepancies that are found. The trick then is what to do with those results?  What I show here is a way to email the results, either as a simple message, or as a message with an attachment, to several users.

## Simple Email Example

## Email with Attachment

## Final Thoughts

While extremely useful, there are some limitations to this approach.  The main one being that you need a sendmail server available that can actually send the message.  An additional one is that you can only specify one recipient for each of the _to:_ or _cc:_ types.



