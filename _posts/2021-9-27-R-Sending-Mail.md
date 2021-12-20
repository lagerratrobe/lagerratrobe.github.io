---
layout: post
title: R Sendmail Tricks
date: 2021-10-27 11:00
tags:
  - R_Hacks
---

One of the most useful things I've found to do with R is to make periodic checks of various things in my data environment.  This is particularly useful in places where 2 systems store the same data that _in theory_ should be kept in sync, but in practice exhibit drift for whatever reason.  It's easy to create a script that compares both systems and flags any discrepancies that are found. The trick then is what to do with those results?  What I show here is a way to email the results, either as a simple message, or as a message with an attachment, to several users.

## Simple Email Example

```
1 # message text
2 token_status_msg <- sprintf("WARNING! - API token expires in %s days",
3                            days_to_expire)
4
5 # mail info
6    from <- "<REPORT_TOOL@fubar.com>" # optional value
7      to <- "<Royer@domain.com>"
8 subject <- "API token about to expire!"
9    body <- token_status_msg
10     cc <- "<SpecialCC@domain.com>"
11
12 # mail command
13 sendmail(from,
14         to,
15         subject,
16         body,
17         cc,
18         control=list(smtpServer= "mail.domain.com")
19 )
```

## Email with Attachment

```
1 # attachment
2 write.xlsx(bad_data, "bad_data.xlsx", overwrite = TRUE)
3
4 # message text
5 mail_message <- paste("The attached records are bad.",
6                      "This is an automated check, do not reply.",
7                      sep="\n\n")
8
9 # mail info
10       from <- sprintf("<REPORT_TOOL@fubar.com>")
11         to <- sprintf("<Royer@domain.com>")
12         cc <- sprintf("<SpecialCC@domain.com>")
13    subject <- "Bad Data Found"
14 attachment <- sendmailR::mime_part(x = "bad_data.xlsx")
16       body <- list(mail_message, attachment)
17
18 # mail command
19 sendmail(from,
20            to,
21            subject,
22            body,
23            cc,
24            control=list(smtpServer="mail.domain.com")
25 )
```

## Final Thoughts

While extremely useful, there are some limitations to this approach.  The main one being that you need a sendmail server available that can actually send the message.  An additional one is that you can only specify one recipient for each of the _to:_ or _cc:_ types.



