# ===----------------------------------------------------------------------===
# 
# This source file is part of the AmiiboService open source project
# 
# Copyright (c) 2024-2025 Röck+Cöde VoF. and the AmiiboAPI project authors
# Licensed under the EUPL 1.2 or later.
# 
# See LICENSE for license information
# See CONTRIBUTORS for the list of AmiiboAPI project authors
# 
# ===----------------------------------------------------------------------===

# ENVIRONMENT VARIABLES

environment ?= .env

include $(environment)
export $(shell sed 's/=.*//' $(environment))

# IDE

open-in-xcode: ## Opens this package with Xcode
	@open -a Xcode Package.swift

open-in-vscode: ## Opens this package with Visual Studio Code
	@code .

# SWIFT PACKAGE MANAGER

package-build: ## Builds the project locally
	@swift build

package-clean: ## Deletes built SPM artifacts from the package
	@swift package clean

package-outdated: ## Lists the SPM package dependencies that can be updated
	@swift package update --dry-run

package-reset: ## Resets the complete SPM cache/build folder from the package
	@swift package reset

package-update: ## Updates the SPM package dependencies
	@swift package update

# HELP

# Output the documentation for each of the defined tasks when `help` is called.
# Reference: https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.PHONY: help

help: ## Prints the written documentation for all the defined tasks
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help
