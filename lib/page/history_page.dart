import 'package:artiqr/commands/flask.dart';
import 'package:artiqr/models/advanced_settings_database.dart';
import 'package:artiqr/utils/constants.dart';
import 'package:artiqr/widgets/custom_sidebar.dart';
import 'package:artiqr/widgets/custom_titlebar.dart';
import 'package:artiqr/widgets/result_container.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> with WindowListener {
  @override
  void onWindowClose() async {
    await AdvancedSettingsDatabase.update();
    await shutdownServer();
    Navigator.of(context).pop();
    windowManager.destroy();
  }

  @override
  void initState() {
    windowManager.addListener(this);
    windowManager.setPreventClose(true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background_container_generated_image,
      body: Column(
        children: [
          CustomTitleBar(),
          Expanded(
            child: Row(
              children: [
                CustomSideBar(),
                Expanded(
                  child: ClipRect(
                      child: ResultContainer(
                    showHistory: true,
                  )),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
