import 'package:artiqr/utils/constants.dart';
import 'package:path_provider_windows/path_provider_windows.dart';
import 'dart:io';
import 'package:url_launcher/url_launcher.dart';

String? appDownloadFolder = '';
Future<void> openDownloadFolder() async {
  final Directory _appDownloadDirFolder = Directory(appDownloadFolder!);
  if (!await _appDownloadDirFolder.exists()) {
    await _appDownloadDirFolder.create(recursive: true);
  }
  await launch('file://$appDownloadFolder');
}

Future<void> initializeDownloadPath() async {
  final PathProviderWindows provider = PathProviderWindows();
  appDownloadFolder = await provider.getDownloadsPath()! ;
  appDownloadFolder = appDownloadFolder!+  '/' + AplicationName;
}
