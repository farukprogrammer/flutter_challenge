# Goat Flutter Challenge

XYZ Goat Flutter Challenge - Scenario B

## Demo

https://user-images.githubusercontent.com/9499570/185303810-6d4f8707-567d-4a37-93aa-04b39152f844.mp4

## Prequisite

- Flutter SDK : v3.0.5
- Dart SDK: v2.17.6

## How to Build

### 1. before started, you need to active melos.
open terminal and run this command:

````shell
dart pub global activate melos
````
melos is a great tools to support multiple package flutter app, wo we don't create a monolythic app.

reference : https://medium.com/flutter-community/managing-multi-package-flutter-projects-with-melos-c8ce96fa7c82

### 2. Dowload all dependency library using - melos bs
to download all the dependency you need to run the following commands, 
this command will run `flutter pub get` for all modules. 
Doing that will be problematic because this project is contains multiple modules.

Fortunately, melos has easier way to do that.

open terminal and run this command:

````shell
melos bs
````
### 3. Run The Project with Flavor

In-order to run the project you need to select run configuration based on environment.

For example if you want to run on `development` environment, then you need to choose `development` run configuration.
If you want to run on staging environment, then you need to choose `staging` run configuration and so on.

In the project there are already included configuration for `Android Studio`, and it will be detected automatically.

But, if you want to run using terminal, the command is :


```shell
flutter run --flavor development -t lib/src/main_development.dart
```





