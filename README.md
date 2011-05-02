This is a (really) simple bridge from git to rsync. I hacked it up to make it easier to give a distributed group of people easy access to our cachefly CDN account.

The idea is that all your files are in git repos, which can be easily shared and maintained between a group. How you handle this is up to you (we use gitolite).

From there, one central point watches for any changes and shoots all the files to cachefly via rsync. I have a user on my git machine that runs this script every 60 seconds. Not super elegant, but it's all local so it's not too inefficient.

All input is within the script, it's commented.

I hope it makes someone's life easier. It's worked great for me.
