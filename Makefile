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
	
# DOCUMENTATION

doc-generate: doc-generate-xcode doc-generate-github ## Generates the library documentation for both Github and Xcode

doc-generate-github: ## Generates the library documentation for Github
	@swift package \
		--allow-writing-to-directory $(DOCC_GITHUB_OUTPUT) \
		generate-documentation \
		$(DOCC_CATALOG_PATH) \
		--target $(SPM_LIBRARY_TARGET) \
		--disable-indexing \
		--transform-for-static-hosting \
		--hosting-base-path $(DOCC_GITHUB_BASE_PATH) \
		--output-path $(DOCC_GITHUB_OUTPUT)

doc-generate-xcode: ## Generates the library documentation for Xcode
	@swift package \
		--allow-writing-to-directory $(DOCC_XCODE_OUTPUT) \
		generate-documentation \
		$(DOCC_CATALOG_PATH) \
		--target $(SPM_LIBRARY_TARGET) \
		--output-path $(DOCC_XCODE_OUTPUT)

doc-preview: ## Previews the library documentation in Safari
	@open -a safari $(DOCC_PREVIEW_URL)
	@swift package \
		--disable-sandbox \
		preview-documentation \
		$(DOCC_CATALOG_PATH) \
		--target $(SPM_LIBRARY_TARGET)

# IDE

open-in-xcode: ## Opens this package with Xcode
	@open -a Xcode Package.swift

open-in-vscode: ## Opens this package with Visual Studio Code
	@code .

# HELP

# Output the documentation for each of the defined tasks when `help` is called.
# Reference: https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.PHONY: help

help: ## Prints the written documentation for all the defined tasks
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help
