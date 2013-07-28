#!/bin/sh

# =============================================================================
# Scripts Variables General
# =============================================================================

export directorySystem=`pwd`
export directoryScripts=$directorySystem/../
export directoryApplications=$directorySystem/../applications

export systemMakeKpkg=`basename $0`
export systemGit=$directorySystem/systemGit.sh

export makeKpkgName=make-kpkg
export makeKpkgCommandClean=clean

# =============================================================================
# Scripts Variables Local
# =============================================================================

export makeName=make
export makeCommandClean=clean
export makeCommandMrproper=mrproper

# =============================================================================
# Script Functions
# =============================================================================

makeKpkgFunctionPre() {
	. $systemGit
	cd $repositoryLinuxKernelDirectory

	$makeName $makeCommandClean
	$makeName $makeCommandMrproper
	$makeKpkgName $makeKpkgCommandClean
}

makeKpkgFunctionClean() {
	$makeKpkgName $makeKpkgCommandClean
}

makeKpkgFunctionCompile() {
	cp /boot/config-`uname -r` .config
	CONCURRENCY_LEVEL=1 fakeroot $makeKpkgName --initrd --append-to-version=-`whoami` kernel_image kernel_headers
}

makeKpkgFunctionPost() {
	sudo dpkg -i $repositoryLinuxKernelDirectory/../linux*.deb
}

# =============================================================================
# Script Main
# =============================================================================

makeKpkgFunctionPre
makeKpkgFunctionClean
makeKpkgFunctionCompile
makeKpkgFunctionPost

# End of file
