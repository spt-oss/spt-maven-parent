#!/usr/bin/env bash

set -eu
set -o pipefail

function self::deploy() {
	
	local branch=${1}
	local password=${2}
	local version=${3:-}
	
	if [[ -n ${version} ]]; then
		
		mvn-release-prepare ${version}
		mvn-release-perform -P gpg -Darguments=-Dgpg.passphrase=${password}
		
		git-flow-release-finish ${branch}
		
	else
		
		mvn-deploy
	fi
}

{
	self::deploy ${@}
}
