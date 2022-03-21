VERSION = 0.1.0
BUILD = 1

.PHONY: clean test generate-code watch-code build-android distribute-android

clean:
	flutter clean
	flutter packages get

test:
	flutter analyze
	flutter format --dry-run --set-exit-if-changed test lib
	flutter test

generate-code:
	flutter pub run build_runner build --delete-conflicting-outputs

watch-code:
	flutter pub run build_runner watch --delete-conflicting-outputs

build-android: clean generate-code
	flutter build apk --split-per-abi --build-name $(VERSION) --build-number $(BUILD)

distribute-android: clean test build-android