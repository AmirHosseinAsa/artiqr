import 'package:artiqr/utils/constants.dart';
import 'package:artiqr/widgets/custom_sidebar.dart';
import 'package:artiqr/widgets/custom_titlebar.dart';
import 'package:artiqr/widgets/result_container.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

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
                      showHistory: false,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
