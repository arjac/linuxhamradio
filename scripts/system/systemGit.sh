#!/bin/sh

# =============================================================================
# Scripts Variables General
# =============================================================================

export directorySystem=`pwd`
export directoryScripts=$directorySystem/../
export directoryApplications=$directorySystem/../applications
export directoryRepositories=/home/`whoami`/reposgit

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
export repositoryUemacsDirectory=$directoryRepositories/$repositoryUemacsName
export repositoryUemacsAddress=git://git.kernel.org/pub/scm/editors/uemacs/uemacs.git

export repositoryLinuxKernelName=linux
export repositoryLinuxKernelDirectory=$directoryRepositories/$repositoryLinuxKernelName
export repositoryLinuxKernelAddress=git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git


# =============================================================================
# Script Functions
# =============================================================================

gitFunctionVerify() {
        repositoryDirectory=$1
        test -d $repositoryDirectory
	if [ $? -eq 1 ]
	then
		echo "${systemGit}: Cannot find ${repositoryDirectory} directory"
		return 1
	fi
}

gitFunctionClone() {
	repositoryAddress=$1
	mkdir -p $directoryRepositories
	cd $directoryRepositories
	$gitName $gitCommandClone $repositoryAddress
}

gitFunctionPull() {
        repositoryDirectory=$1
	cd $repositoryDirectory
	$gitName $gitCommandPull
}

# =============================================================================
# Script Main
# =============================================================================

if [ "$systemGitArgumentTree" = "uemacs" ]; then
	gitRepositoryDirectory=$repositoryUemacsDirectory
	gitRepositoryAddress=$repositoryUemacsAddress
elif [ "$systemGitArgumentTree" = "linuxkernel" ]; then
        gitRepositoryDirectory=$repositoryLinuxKernelDirectory
        gitRepositoryAddress=$repositoryLinuxKernelAddress
else
	echo "${systemGit}: Cannot find project to work with, wanna use our variables?"
	return 1
fi

gitFunctionVerify $gitRepositoryDirectory

if [ $? -eq 0 ]
then
	echo "$systemGit: git repository found! now to update"
	gitFunctionPull $gitRepositoryDirectory
else
	echo "$systemGit: git repository not found! now to clone"
	gitFunctionClone $gitRepositoryAddress
fi

# End of file
