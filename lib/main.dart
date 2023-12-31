import 'package:artiqr/application.dart';
import 'package:artiqr/commands/flask.dart';
import 'package:artiqr/models/advanced_settings_database.dart';
import 'package:artiqr/models/generated_image_records_database%20copy.dart';
import 'package:artiqr/setup_hive.dart';
import 'package:artiqr/utils/constants.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';
import 'package:artiqr/commands/io_commands.dart';

void main() async {
  await setupHive();
  await initializeDownloadPath();
  await AdvancedSettingsDatabase.InitilaizeAdvancedSettings();
  await WindowManager.instance.ensureInitialized();
  await WidgetsFlutterBinding.ensureInitialized();
  await configureServer();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GeneratedImageRecordsDatabase()),
      ],
      child: const Application(),
    ),
  );

  doWhenWindowReady(() {
    final win = appWindow;
    const initialSize = Size(1100, 900);
    win.minSize = initialSize;
    win.alignment = Alignment.center;
    win.title = AplicationName;
    win.maximize();
    win.show();
  });
}

Future<void> configureServer() async {
  await WidgetsFlutterBinding.ensureInitialized();
  if (!await checkWebsiteStatus()) {
    await startServer();
  } else {
    await shutdownServer();
    await startServer();
  }
}
