// ignore_for_file: avoid_print

import 'dart:io';

void main(List<String> args) async {
  // Do not use debugPrint because this script don't want to be flutter dependent.
  // Flutter dependency can cause weird errors on scripts.
  print("Searching recursively for folders..");
  await Directory.current
      .list(recursive: true)
      .where((file) =>
          (file is File) &&
          !file.path.contains(".symlinks") &&
          file.path.endsWith("pubspec.yaml"))
      .forEach((file) async {
    final testDir = Directory('${file.parent.path}/test');
    final isExisted = await testDir.exists();
    if (!isExisted) {
      await testDir.create();
    }
    final content = await generateCoverageTestFileContent(file.parent);
    final output = StringBuffer();
    output.write(content);
    final coverageFile = File('${testDir.path}/coverage_test.dart');
    await coverageFile.writeAsString('$output');
  });
  print("Done!");
}

Future<String> generateCoverageTestFileContent(Directory projectFolder) async {
  final packageName = projectFolder.path.split("/").last;
  final libFolder = Directory('${projectFolder.path}/lib');
  print("Coverage for $packageName");

  String fileImports = "";
  final dartFiles = await libFolder
      .list(recursive: true)
      .where((file) =>
          (file is File) &&
          file.path.endsWith(".dart") &&
          !file.path.endsWith("generated_plugin_registrant.dart") &&
          !file.path.contains("/test_tool/") &&
          !(file.path.contains(".g.") || file.path.contains("/generated/")))
      .toList();
  dartFiles.whereType<File>().forEach((file) {
    final importPath = file.path.replaceAll(libFolder.path, '');
    fileImports += "import 'package:$packageName$importPath';\n";
  });

  return '''
/// *** GENERATED FILE - ANY CHANGES WOULD BE OBSOLETE ON NEXT GENERATION *** ///

/// Helper to test coverage for all project files
// ignore_for_file: unused_import
import 'package:flutter_test/flutter_test.dart';

$fileImports
void main() {
  test('placeholder', () {
    expect(1, 1);
  });
}
  ''';
}
