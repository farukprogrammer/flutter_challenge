# Localization

Localization library Flutter Goat UI Module

## Getting Started

You can add this to pubspec.yaml on your module

```yaml
dependencies:
  ...
  localization:
     path: <relative path to this repo>
```

## Usage

To genereate the string resource for your module you can run this command in your terminal.

To generate the string resource for your module you can follow this steps.

1. run `melos gen_locale` in your terminal
2. choose the package
3. Once it generated, you can update the string resource from `.arb` file
4. Re-run `melos gen_locale` to re-generate it
5. Add your `<ui_module_name>LocaleDelegate` to `localeDelegate` in main
6. Use locale in your app

    ```dart
    final locale = GoatLocale.of<<ui_module_name>Locale>(context);
    locale.resourceName
    ```

