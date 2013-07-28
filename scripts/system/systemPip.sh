#!/bin/sh

# =============================================================================
# Scripts Variables General
# =============================================================================

export pipName=pip
export pipCommandInstall=install
export pipCommandUpgrade=--upgrade

# =============================================================================
# Scripts Variables Local
# =============================================================================

export packageDistribute=distribute
export packageFeedparser=feedparser

# =============================================================================
# Script Functions
# =============================================================================

aptgetFunctionUpgrade() {
	sudo $pipName $pipCommandUpgrade
}

aptgetFunctionInstall() {
	packageName=$@
	sudo $pipName $pipCommandInstall $packageName
}

# =============================================================================
# Script Main
# =============================================================================

aptgetFunctionInstall $packageDistribute
aptgetFunctionInstall $packageFeedparser

# End of file
