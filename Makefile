VERSION = 0.1.0
BUILD = $(shell git rev-list --all --count)

.PHONY: clean test generate-code watch-code

clean:
	flutter clean
	flutter packages get

test:
	flutter analyze
	flutter format --dry-run --set-exit-if-changed test lib
	flutter test

_fix-generator:
	@echo "a temporary fix, otherwise the build_runner does not work"
	mkdir -p .dart_tool/flutter_gen/ && echo 'name: flutter_gen' > .dart_tool/flutter_gen/pubspec.yaml

generate-code: _fix-generator
	flutter pub run build_runner build --delete-conflicting-outputs

watch-code: _fix-generator
	flutter pub run build_runner watch --delete-conflicting-outputs
