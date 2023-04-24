# --- IMPORTS ---

# Imports environment variables.
environment_vars ?= .env

include $(environment_vars)
export $(shell sed 's/=.*//' $(environment_vars))

# --- DOCUMENTATION ---

preview-doc: ## Previews the project documentation for web.
	@open -a safari $(SWIFT_DOC_PREVIEW_URL)
	@swift package \
		--disable-sandbox \
		preview-documentation \
		--target $(SWIFT_TARGET_NAME)

generate-docs: generate-doc-xcode generate-doc-github ## Generates the project documentation for Xcode and Github.

generate-doc-xcode:
	@echo Generating documentation for Xcode...
	@swift package \
		--allow-writing-to-directory $(SWIFT_DOC_XCODE_OUTPUT) \
		generate-documentation \
		--target $(SWIFT_TARGET_NAME) \
		--output-path $(SWIFT_DOC_XCODE_OUTPUT)

generate-doc-github:
	@echo Generating documentation for Github pages...
	@swift package \
		--allow-writing-to-directory $(SWIFT_DOC_GITHUB_OUTPUT) \
		generate-documentation \
		--target $(SWIFT_TARGET_NAME) \
		--disable-indexing \
		--transform-for-static-hosting \
		--hosting-base-path $(SWIFT_DOC_GITHUB_BASE_PATH) \
		--output-path $(SWIFT_DOC_GITHUB_OUTPUT)

clean-docs: ## Cleans up the generated documentation for Xcode and Github pages.
ifeq ("$(shell test -e ${SWIFT_DOC_GITHUB_OUTPUT} && echo yes)","yes")
	@echo Cleaning up the Github pages folder...
	@rm -rf ${SWIFT_DOC_GITHUB_OUTPUT}
endif
ifeq ("$(shell test -e ${SWIFT_DOC_XCODE_OUTPUT} && echo yes)","yes")
	@echo Cleaning up the Xcode documentation archive...
	@rm -rf ${SWIFT_DOC_XCODE_OUTPUT}
endif

# --- HELP ---

# Outputs the documentation for each of the defined tasks when `help` is called.
# Reference: https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.PHONY: help

help: ## Prints the written documentation for all the defined tasks.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help
