# Xcode 
APP_NAME := uikit2swiftui
APP_SCHEME := app
XCODEBUILD_DESTINATION := "platform=iOS Simulator,name=iPhone 13"

# aliases
mint-run := mint run

.PHONY: default
default: bootstrap

.PHONY: bootstrap
bootstrap:
	@scripts/setup.sh
	"$(MAKE)" build-xcodeproj
	"$(MAKE)" needle

.PHONY: build-xcodeproj
build-xcodeproj:
	$(mint-run) xcodegen

.PHONY: needle
needle:
	needle generate \
		app/DI/NeedleGenerated.swift \
		app \
		--header-doc .needle/copyright_header.txt

.PHONY: format
format:
	$(mint-run) swiftformat .

.PHONY: open
open:
	open $(APP_NAME).xcodeproj

# Build

.PHONY: build
build: build-xcodeproj
	@xcodebuild \
		-project ${APP_NAME}.xcodeproj \
		-scheme ${APP_SCHEME} \
		-sdk iphonesimulator \
		-destination ${XCODEBUILD_DESTINATION} \
		clean \
		build | $(mint-run) xcbeautify
