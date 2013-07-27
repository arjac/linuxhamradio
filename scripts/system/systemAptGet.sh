#!/bin/sh

# =============================================================================
# Scripts Variables General
# =============================================================================

export aptgetName=apt-get
export aptgetCommandUpdate=update
export aptgetCommandInstall=install

# =============================================================================
# Scripts Variables Local
# =============================================================================

export packageGit=git
export packageKernelPackage=kernel-package
export packageLibNCurses5=libncurses5
export packageLibNCursesDev=libncurses-dev

# =============================================================================
# Script Functions
# =============================================================================

aptgetFunctionUpdate() {
	sudo $aptgetName $aptgetCommandUpdate
}

aptgetFunctionInstall() {
	packageName=$1
	sudo $aptgetName $aptgetCommandInstall $packageName
}

# =============================================================================
# Script Main
# =============================================================================

aptgetFunctionUpdate

aptgetFunctionInstall $packageGit
aptgetFunctionInstall $packageKernelPackage
aptgetFunctionInstall $packageLibNCurses5
aptgetFunctionInstall $packageLibNCursesDev

# End of file
