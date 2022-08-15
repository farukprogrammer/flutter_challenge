// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:args/args.dart';

void main(List<String> args) async {
  final parser = ArgParser();
  const jsonDecoder = JsonCodec();
  var uiModuleName = '';

  parser.addOption(
    'ui',
    defaultsTo: '',
    callback: (value) => uiModuleName = value ?? '',
  );
  parser.parse(args);

  if (uiModuleName.isEmpty) {
    print('Locale: Error, please provide ui module name');
    exit(0);
  }

  // normalize ui module name.
  if (uiModuleName.contains('ui_')) {
    uiModuleName = uiModuleName.replaceFirst('ui_', '');
  }

  final file = File('lib/src/locale/${uiModuleName}_locale_template.arb');
  final isArbFileExist = await file.exists();

  if (!isArbFileExist) {
    _createArbFileTemplate(file);
  }

  final source = file.readAsStringSync();
  final Map<String, dynamic> data = jsonDecoder.decode(source);
  _updateLastGeneratedLocale(data, file);
  _generateLocaleClassTemplate(data, uiModuleName);
  _generateLocaleDelegateClassTemplate(uiModuleName);
  _generateLocaleResourceTemplate(data, uiModuleName);
  print('Locale: success to generate locale');

  exit(0);
}

void _createArbFileTemplate(File file) {
  final dateTime = DateTime.now().toIso8601String();
  String template = '''
{
  "@@last_modified": "$dateTime",
  "sample": {
    "default": "Hello"
  },
  "sampleWithArgument": {
    "default": "Hello %s"
  }
}
''';
  final output = StringBuffer();
  output.write(template);
  file.createSync(recursive: true);
  file.writeAsStringSync('$output');
}

void _updateLastGeneratedLocale(Map<String, dynamic> data, File file) {
  data['@@last_modified'] = DateTime.now().toIso8601String();
  const encoder = JsonEncoder.withIndent("  ");
  file.writeAsStringSync(encoder.convert(data));
}

String _provideStringGetterTemplate(Map<String, dynamic> data) {
  var stringGetterTemplate = '\n';
  data.forEach(
    (parentKey, parentValue) {
      if (parentValue is Map<String, dynamic>) {
        var totalArgs = 0;
        var dynamicStringValue = '';
        var argsValue = '';
        final splitValue = parentValue['default'].split(' ');

        for (var value in splitValue) {
          if (value.contains('%s')) totalArgs++;
        }

        for (int i = 0; i < totalArgs; i++) {
          dynamicStringValue += 'dynamic s$i';
          argsValue += 's$i';
          if (i < totalArgs - 1) {
            dynamicStringValue += ', ';
            argsValue += ', ';
          }
        }

        if (dynamicStringValue.isNotEmpty && argsValue.isNotEmpty) {
          stringGetterTemplate += '''
  String $parentKey($dynamicStringValue) {
    return resource.get('$parentKey', args: [$argsValue]);
  }
  ''';
        } else {
          stringGetterTemplate += '''
  String get $parentKey {
    return resource.get('$parentKey');
  }
  ''';
        }
        stringGetterTemplate += '\n';
      }
    },
  );

  return stringGetterTemplate;
}

String _provideResourceLocaleTemplate(Map<String, dynamic> data) {
  var template = '';

  data.forEach(
    (parentKey, parentValue) {
      if (!parentKey.contains('@@')) {
        if (parentValue is Map<String, dynamic>) {
          template += '\n';
          template += '    ';
          template += '\'$parentKey\': {';
          template += '\n';
          parentValue.forEach(
            (childKey, childValue) {
              template += '      ';
              template += '\'$childKey\': \'$childValue\',';
              template += '\n';
            },
          );
          template += '    ';
          template += '''},''';
        }
      }
    },
  );
  template += '\n';
  template += '  ';

  return template;
}

void _generateLocaleClassTemplate(
  Map<String, dynamic> data,
  String uiModuleName,
) {
  String template = '''
// DON'T EDIT THE CODE.
// This code generated by lib localization.
import 'package:localization/localization.dart';
import 'package:ui_$uiModuleName/src/locale/${uiModuleName}_locale_resource.dart';

class ${_camelCase(uiModuleName)}Locale extends GoatLocale {
  ${_camelCase(uiModuleName)}Locale([String? languageCode]) : super(languageCode);
  ${_provideStringGetterTemplate(data)}  @override
  LocaleResource get resource {
    return ${_camelCase(uiModuleName)}LocaleResource(languageCode);
  }
}
''';

  final output = StringBuffer();
  final outputFile = File('lib/src/locale/${uiModuleName}_locale.dart');
  output.write(template);
  outputFile.writeAsStringSync('$output');
  output.clear();
}

void _generateLocaleDelegateClassTemplate(String uiModuleName) {
  String template = '''
// DON'T EDIT THE CODE.
// This code generated by lib localization.
import 'package:flutter/material.dart';
import 'package:ui_$uiModuleName/src/locale/${uiModuleName}_locale.dart';

class ${_camelCase(uiModuleName)}LocaleDelegate extends LocalizationsDelegate<${_camelCase(uiModuleName)}Locale> {
  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<${_camelCase(uiModuleName)}Locale> load(Locale locale) async {
    return ${_camelCase(uiModuleName)}Locale(locale.languageCode);
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<${_camelCase(uiModuleName)}Locale> old) => false;
}
''';

  final output = StringBuffer();
  final outputFile = File(
    'lib/src/locale/${uiModuleName}_locale_delegate.dart',
  );
  output.write(template);
  outputFile.writeAsStringSync('$output');
  output.clear();
}

void _generateLocaleResourceTemplate(
  Map<String, dynamic> data,
  String uiModuleName,
) {
  String template = '''
// DON'T EDIT THE CODE.
// This code generated by lib localization.
import 'package:localization/localization.dart';

class ${_camelCase(uiModuleName)}LocaleResource extends LocaleResource {
  ${_camelCase(uiModuleName)}LocaleResource(String? languageCode) : super(languageCode);
  
  @override
  Map<String, Map<String, String>> get data => {${_provideResourceLocaleTemplate(data)}};
}
''';

  final output = StringBuffer();
  final outputFile = File(
    'lib/src/locale/${uiModuleName}_locale_resource.dart',
  );
  output.write(template);
  outputFile.writeAsStringSync('$output');
  output.clear();
}

String _camelCase(String name) {
  if (name.isEmpty) return '';
  final names = name.split('_');
  var camelName = '';
  for (String text in names) {
    camelName += text[0].toUpperCase() + text.substring(1);
  }
  return camelName;
}
