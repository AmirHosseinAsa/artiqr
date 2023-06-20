import 'dart:io';
import 'package:artiqr/models/advanced_settings.dart';
import 'package:artiqr/models/generate_image_record.dart';
import 'package:artiqr/utils/constants.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

Future<void> setupHive() async {
  final Directory _appDocDir = await getApplicationDocumentsDirectory();
  final Directory _appDocDirFolder =
      Directory(_appDocDir.path + '/' + AplicationName);
  if (!await _appDocDirFolder.exists()) {
    await _appDocDirFolder.create(recursive: true);
  }

  await Hive.initFlutter(_appDocDirFolder.path);
  Hive.registerAdapter(GenerateImageRecordAdapter());
  await Hive.openBox<GenerateImageRecord>('generatedResults');

  Hive.registerAdapter(AdvancedSettingsAdapter());
  await Hive.openBox<AdvancedSettings>('advancedSettings');
}
