#!/bin/sh

# =============================================================================
# Scripts Variables General
# =============================================================================

export systemGit=`basename $0`
export systemGitArgumentTree=$1

export gitName=git
export gitCommandClone=clone
export gitCommandPull=pull

export gitRepositoryName=""
export gitRepositoryAddress=""

# =============================================================================
# Scripts Variables Local
# =============================================================================

export repositoryUemacsName=uemacs
export repositoryUemacsAddress=git://git.kernel.org/pub/scm/editors/uemacs/uemacs.git

export repositoryLinuxKernelName=linux
export repositoryLinuxKernelAddress=git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git


# =============================================================================
# Script Functions
# =============================================================================

gitFunctionVerify() {
        repositoryName=$1
        test -d /home/`whoami`/$repositoryName
	if [ $? -eq 1 ]
	then
		echo "${systemGit}: Cannot find ${repositoryName} directory"
		return 1
	fi
}

gitFunctionClone() {
	repositoryAddress=$1
	cd /home/`whoami`/
	$gitName $gitCommandClone $repositoryAddress
}

gitFunctionPull() {
        repositoryName=$1
	cd /home/`whoami`/$repositoryName
	$gitName $gitCommandPull
}

# =============================================================================
# Script Main
# =============================================================================

if [ "$systemGitArgumentTree" = "uemacs" ]; then
	gitRepositoryName=$repositoryUemacsName
	gitRepositoryAddress=$repositoryUemacsAddress
elif [ "$systemGitArgumentTree" = "linuxkernel" ]; then
        gitRepositoryName=$repositoryLinuxKernelName
        gitRepositoryAddress=$repositoryLinuxKernelAddress
fi

gitFunctionVerify $gitRepositoryName

if [ $? -eq 0 ]
then
	echo "$systemGit: git repository found! now to update"
	gitFunctionPull $gitRepositoryName
else
	echo "$systemGit: git repository not found! now to clone"
	gitFunctionClone $gitRepositoryAddress
fi

# End of file
