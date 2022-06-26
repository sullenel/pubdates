VERSION = 0.1.0
BUILD = $(shell git rev-list --all --count)
flutter = (fvm flutter || flutter)

.PHONY: clean test generate-code watch-code run-linux run-macos run-windows build-linux build-macos build-windows

clean:
	@flutter clean
	@flutter packages get

test:
	@flutter analyze
	@flutter format --dry-run --set-exit-if-changed test lib
	@flutter test

_get-deps:
	@flutter packages get

_fix-generator:
	@echo "- applying a temporary fix, otherwise the build_runner does not work"
	mkdir -p .dart_tool/flutter_gen/ && echo 'name: flutter_gen' > .dart_tool/flutter_gen/pubspec.yaml

generate-code: _fix-generator
	@flutter pub run build_runner build --delete-conflicting-outputs

watch-code: _fix-generator
	@flutter pub run build_runner watch --delete-conflicting-outputs

run-macos: _get-deps generate-code
	@flutter run --release --device-id macos

build-macos: _get-deps generate-code
	@flutter build macos

run-linux: _get-deps generate-code
	@flutter run --release --device-id linux

build-linux: _get-deps generate-code
	@flutter build linux

run-windows: _get-deps generate-code
	@flutter run --release --device-id windows

build-windows: _get-deps generate-code
	@flutter build windows