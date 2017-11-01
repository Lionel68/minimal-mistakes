---
title: Installing rJava in R>=3.0
wordpress_id: 208
categories:
- R and Stat
tags:
- rJava
- ubuntu
---

This is just a blog post for me to remember this hack that bother for some time, if it can help other people this is even better.

So for some time I had this issue with rJava when I was running:

install.packages("rJava")
.
.
configure: error: One or more Java configuration variables are not set.
Make sure R is configured with full Java support (including JDK). Run
R CMD javareconf
as root to add Java support to R.

So I could not install this much needed package, after some roaming over the internet I found this post: [http://stackoverflow.com/questions/17570586/unable-to-compile-jni-program-rjava](http://stackoverflow.com/questions/17570586/unable-to-compile-jni-program-rjava)   and this one:

[http://askubuntu.com/questions/175514/how-to-set-java-home-for-openjdk](http://http://askubuntu.com/questions/175514/how-to-set-java-home-for-openjdk)

And  so I followed their advice and this what I ended up doing in my terminal:

gksudo gedit /etc/environment %This open a new gedit window I added the line: JAVA_HOME ="/usr/lib/jdm/" %check that this is your path as well using cd and ls
Saved the file and to check if this worked:

echo JAVA_HOME

Then back in R you can run the usual install.packages() command and it completed successfully for me.




