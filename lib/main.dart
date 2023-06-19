import 'package:artiqr/application.dart';
import 'package:artiqr/commands/flask.dart';
import 'package:artiqr/setup_hive.dart';
import 'package:artiqr/utils/constants.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';
import 'models/generated_image_records_database.dart';

void main() async {
  await setupHive();
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
    const initialSize = Size(800, 600);
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
