import 'package:artiqr/utils/constants.dart';
import 'package:artiqr/widgets/custom_slider_widget.dart';
import 'package:artiqr/widgets/generate_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomSideBar extends StatefulWidget {
  const CustomSideBar({super.key});

  @override
  State<CustomSideBar> createState() => _CustomSideBarState();
}

class _CustomSideBarState extends State<CustomSideBar> {
  final TextEditingController _contentTextEditingController =
      TextEditingController();
  final TextEditingController _promptTextEditingController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: background_sidebar,
      width: MediaQuery.of(context).size.width / 4.8,
      child: Container(
        margin: const EdgeInsets.all(15),
        child: Column(
          children: [
            if (ModalRoute.of(context)?.settings.name == '/') ...[
              TextFormField(
                keyboardType: TextInputType.multiline,
                controller: _contentTextEditingController,
                maxLines: null,
                minLines: 3,
                onChanged: (value) => contentTextFiledGenerateValue = value,
                autocorrect: true,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w500),
                cursorRadius: const Radius.circular(16.0),
                decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1.5, color: Colors.white38), //<-- SEE HERE
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: Colors.white),
                    ),
                    contentPadding: EdgeInsets.all(13),
                    hintStyle: TextStyle(color: Colors.white54),
                    hintMaxLines: 4,
                    hintText: 'QR Code Content (url,etc)'),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                keyboardType: TextInputType.multiline,
                controller: _promptTextEditingController,
                maxLines: null,
                minLines: 4,
                onChanged: (value) => promptTextFiledGenerateValue = value,
                autocorrect: true,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w500),
                cursorRadius: const Radius.circular(16.0),
                decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1.5, color: Colors.white38), //<-- SEE HERE
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: Colors.white),
                    ),
                    contentPadding: EdgeInsets.all(13),
                    hintStyle: TextStyle(color: Colors.white54),
                    hintMaxLines: 4,
                    hintText:
                        'Describe what you want to see (eg. gorgeous abandoned medieval mansion in a fairytale forest)'),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 37, 37, 37),
                  borderRadius: BorderRadius.circular(5),
                ),
                padding:
                    EdgeInsets.only(left: 10, right: 10, bottom: 5, top: 5),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Advanced Settings'),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              showAdvanceSettings = !showAdvanceSettings;
                            });
                          },
                          icon: Icon(
                            showAdvanceSettings
                                ? Icons.hide_source_rounded
                                : Icons.panorama_fish_eye,
                                color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    AnimatedContainer(
                      duration: Duration(milliseconds: 350),
                      curve: Curves.easeInOut,
                      height: showAdvanceSettings ? 300 : 0,
                      child: Visibility(
                        visible: showAdvanceSettings,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(height: 8),
                              Divider(
                                color: Color.fromARGB(255, 56, 56, 56),
                                thickness: 2.0,
                              ),
                              SizedBox(height: 15),
                              CustomSliderWidget(
                                title: 'Controlnet Conditioning Scale',
                                type: 'ControlnetConditioningScale',
                              ),
                              SizedBox(height: 15),
                              CustomSliderWidget(
                                title: 'Strength',
                                type: 'Strength',
                              ),
                              SizedBox(height: 15),
                              CustomSliderWidget(
                                title: 'Guidance Scale',
                                type: 'GuidanceScale',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              GenerateButtonWidget(),
            ] else if (ModalRoute.of(context)?.settings.name == '/history') ...[
              SizedBox(
                height: 15,
              ),
              // DeleteHistoryWidget(),
            ] else ...[
              Column(
                children: [
                  const ListTile(
                    title: Text('Version'),
                    subtitle: Text(version),
                  ),
                  ListTile(
                    onTap: () => launchUrl(Uri.parse(mailing)),
                    title: const Text('Contact Developer'),
                  ),
                ],
              )
            ],
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomButtomIconSelect(
                    context, '/', Icons.track_changes_outlined),
                CustomButtomIconSelect(context, '/history', Icons.history),
                CustomButtomIconSelect(context, '/about', Icons.info_outline),
              ],
            )
          ],
        ),
      ),
    );
  }
}

Widget CustomButtomIconSelect(
    BuildContext context, String path, IconData icon) {
  bool selected = ModalRoute.of(context)?.settings.name == path;
  return IconButton(
    onPressed: () {
      if (!selected && path != '/') {
        Navigator.pushNamed(context, path);
      } else if (!selected && path == '/') {
        Navigator.popUntil(context, ModalRoute.withName('/'));
      }
    },
    icon: Icon(
      icon,
      color: selected ? sub_button_color : Colors.white,
      size: selected ? 30 : 28,
    ),
  );
}
