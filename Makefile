# --- IMPORTS ---

# Imports environment variables.
environment_vars ?= .env

include $(environment_vars)
export $(shell sed 's/=.*//' $(environment_vars))

# --- ARGUMENTS ---

override docker?=${CLI_USE_DOCKER}
override tag?=${DOCKER_IMAGE_TAG}
override platform?=${DOCKER_IMAGE_PLATFORM}
override config?=${SWIFT_BUILD_CONFIGURATION}
override clean?=${DOCKER_IMAGE_CLEAN}

# --- DEPENDENCIES ---

outdated: ## List the package dependencies that can be updated.
	@swift package update --dry-run

update: ## Update the package dependencies.
	@swift package update

# --- DEVELOPMENT ---

build: ## Build this package with Swift either locally or in a Docker image.
ifeq ($(docker),yes)
	@-docker run \
		--rm \
		--volume ${PWD}:${DOCKER_VOLUME_TARGET} \
		--workdir ${DOCKER_VOLUME_TARGET} \
		--platform ${platform} \
		${DOCKER_IMAGE_NAME}:${tag} \
		swift build --configuration ${config}
    ifeq ($(clean),yes)
		@docker rmi ${DOCKER_IMAGE_NAME}:${tag}
    endif
else
	@swift build --configuration ${config}
endif

# --- TESTING ---

test: ## Test this package with Swift either locally or in a Docker image.
ifeq ($(docker),yes)
	@-docker run \
		--rm \
		--volume ${PWD}:${DOCKER_VOLUME_TARGET} \
		--workdir ${DOCKER_VOLUME_TARGET} \
		--platform ${platform} \
		${DOCKER_IMAGE_NAME}:${tag} \
		swift test --configuration ${config}
    ifeq ($(clean),yes)
		@docker rmi ${DOCKER_IMAGE_NAME}:${tag}
    endif
else
	@swift test --configuration ${config}
endif

# --- DOCUMENTATION ---

preview-doc: ## Preview the documentation in Safari.
	@open -a safari $(DOCC_PREVIEW_URL)
	@swift package \
		--disable-sandbox \
		preview-documentation \
		--target $(SWIFT_TARGET_NAME)

generate-docs: generate-doc-xcode generate-doc-github ## Generate the documentation for Xcode and Github pages.

generate-doc-xcode:
	@swift package \
		--allow-writing-to-directory $(DOCC_XCODE_OUTPUT) \
		generate-documentation \
		--target $(SWIFT_TARGET_NAME) \
		--output-path $(DOCC_XCODE_OUTPUT)

generate-doc-github:
	@swift package \
		--allow-writing-to-directory $(DOCC_GITHUB_OUTPUT) \
		generate-documentation \
		--target $(SWIFT_TARGET_NAME) \
		--disable-indexing \
		--transform-for-static-hosting \
		--hosting-base-path $(DOCC_GITHUB_BASE_PATH) \
		--output-path $(DOCC_GITHUB_OUTPUT)

# --- HOUSE-KEEPING ---

clean: ## Clean the build artifacts.
	@swift package clean

reset: ## Reset the build folder.
	@swift package reset

flush-docs: ## Flush the documentation for Xcode and Github pages.
ifeq ("$(shell test -e ${DOCC_GITHUB_OUTPUT} && echo yes)","yes")
	@rm -rf ${DOCC_GITHUB_OUTPUT}
endif
ifeq ("$(shell test -e ${DOCC_XCODE_OUTPUT} && echo yes)","yes")
	@rm -rf ${DOCC_XCODE_OUTPUT}
endif

flush-images: ## Flush all outstanding Swift docker images.
	@docker images \
		--all | grep ${DOCKER_IMAGE_NAME} | awk '{print $$3}' | xargs docker rmi --force

# --- MISCELLANEOUS ---

xcode: ## Open this package in Xcode.
	@open -a Xcode Package.swift

# --- HELP ---

# Outputs the documentation for each of the defined tasks when `help` is called.
# Reference: https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.PHONY: help

help: ## Prints the written documentation for all the defined tasks.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help
