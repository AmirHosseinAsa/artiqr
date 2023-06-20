import 'package:artiqr/commands/flask.dart';
import 'package:artiqr/utils/constants.dart';
import 'package:artiqr/widgets/custom_sidebar.dart';
import 'package:artiqr/widgets/custom_titlebar.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> with WindowListener {
  @override
  void onWindowClose() async {
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
                  child: Container(
                    color: background_container_generated_image,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}