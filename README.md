
## Getting Started
 The purpose of this project is to scan barcodes using the camera and find the desired product.

Mobile client using flutter and mvvm, clean architecture

Flutter version 3.24.0
Dart version 3.5.0


## Adding String Resource
1. Add all translations with the same key into `assets/strings/[language-code].json` files
2. add same key with same order into `lib/resources/strings/[language-code].dart`

## Adding new page
1. Create a new page in `lib/view` folder
2. Add the page to `lib/router/router.dart`

## Adding a new service
1. Implement service
2. Add `@lazySingleton` annotation to class
3. Watch build runner for dependency generation.
```
./scripts/buildRunner.sh
```
