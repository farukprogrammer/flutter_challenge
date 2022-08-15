# goat_flutter_challenge

XYZ Goat Flutter Challenge - Scenario B

## Getting Started

This project is a starting point for a Flutter application.

before started, you need to active melos

- dart pub global activate melos

melos is a great tools to support multiple package flutter app, wo we don't create a monolythic app
reference : https://medium.com/flutter-community/managing-multi-package-flutter-projects-with-melos-c8ce96fa7c82

to import all the dependency you need to run the following commands

- melos bs

## Run The Project with Flavor

In-order to run the project you need to select run configuration based on environment,
for example if you want to run on development environment, then you need to choose `development` run configuration.
If you want to run on staging environment, then you need to choose `staging` run configuration and so on.

This will help us easier to create custom app using product flavor.

## Generate locale in ui module

For generating locale just run the following commands :

  - melos gen_locale

And then choose the ui module that need to be generated.

After update the .arb files, you need to re-run `melos gen_locale` again

## How to use locale resource
You can get the locale by using:

  - final locale = GoatLocale.of<<ui_module_name>Locale>(context);

So using the same example the `ui_book` module, we can get it like so:

  - final locale = GoatLocale.of<BookLocale>(context);

And to get the resource you can directly use the locale and get the resource name

  - locale.resourceName



