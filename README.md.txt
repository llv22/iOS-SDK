1, synchronization from fork on github
https://help.github.com/articles/syncing-a-fork
http://share.ez.no/blogs/virgil-ciobanu/how-to-syncronize-your-github-fork-with-original-repository
Command lists:
	=> Setup
	1) git remote -v 
origin	git@github.com:llv22/iOS-SDK.git (fetch)
origin	git@github.com:llv22/iOS-SDK.git (push)
	2) git remote add upstream git@github.com:Estimote/iOS-SDK.git
	3) git remote -v
origin	git@github.com:llv22/iOS-SDK.git (fetch)
origin	git@github.com:llv22/iOS-SDK.git (push)
upstream	git@github.com:Estimote/iOS-SDK.git (fetch)
upstream	git@github.com:Estimote/iOS-SDK.git (push)

	=> Syncing
	1) git fetch upstream
From github.com:Estimote/iOS-SDK
 * [new branch]      gh-pages   -> upstream/gh-pages
 * [new branch]      master     -> upstream/master

	=> Merging