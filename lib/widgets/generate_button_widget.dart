import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animate_gradient/animate_gradient.dart';
import '../commands/request.dart';
import '../models/generate_image_record.dart';
import '../models/generated_image_records_database.dart';
import '../utils/constants.dart';
import 'custom_scaffold_message_widget.dart';

class GenerateButtonWidget extends StatefulWidget {
  const GenerateButtonWidget({Key? key}) : super(key: key);

  @override
  _GenerateButtonWidgetState createState() => _GenerateButtonWidgetState();

  static final ValueNotifier<bool> valueNotifier = ValueNotifier<bool>(true);
}

class _GenerateButtonWidgetState extends State<GenerateButtonWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  void initiateAnimation() {
    _controller = (AnimationController(
      vsync: this,
      duration: Duration(seconds: 10),
    )..repeat(reverse: false));
  }

  @override
  void initState() {
    initiateAnimation();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onSubmit() async {
    if (ModalRoute.of(context)?.settings.name != '/') {
      Navigator.pushNamed(context, '/');
    }
    if (promptTextFiledGenerateValue != '' &&
        GenerateButtonWidget.valueNotifier.value &&
        contentTextFiledGenerateValue != '') {
      promptTextFiledGenerateValue = promptTextFiledGenerateValue.trim();
      contentTextFiledGenerateValue = contentTextFiledGenerateValue.trim();
      contentTextFiledGenerateValue =
          contentTextFiledGenerateValue[0].toUpperCase() +
              contentTextFiledGenerateValue.substring(1);

      promptTextFiledGenerateValue =
          promptTextFiledGenerateValue[0].toUpperCase() +
              promptTextFiledGenerateValue.substring(1);

      context.read<GeneratedImageRecordsDatabase>().add(GenerateImageRecord(
          prompt: promptTextFiledGenerateValue,
          content: contentTextFiledGenerateValue));
      GenerateButtonWidget.valueNotifier.value = false;
    } else if (contentTextFiledGenerateValue == '') {
      CustomScaffoldMessageWidget.show(context, 'Please enter youre Content');
    } else if (promptTextFiledGenerateValue == '') {
      CustomScaffoldMessageWidget.show(context, 'Please enter youre Prompt');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: GenerateButtonWidget.valueNotifier,
      builder: (BuildContext context, bool value, Widget? child) {
        return SizedBox(
          width: double.infinity,
          height: 50,
          child: value
              ? AnimateGradient(
                  primaryBegin: Alignment.topRight,
                  primaryEnd: Alignment.topLeft,
                  secondaryBegin: Alignment.bottomLeft,
                  secondaryEnd: Alignment.bottomRight,
                  primaryColors: const [
                    Color.fromARGB(255, 94, 0, 245),
                    Color.fromARGB(255, 133, 64, 243),
                    Color.fromARGB(255, 94, 0, 245),
                  ],
                  secondaryColors: const [
                    Color.fromARGB(255, 94, 0, 245),
              Color.fromARGB(255, 133, 64, 243),
                    Color.fromARGB(255, 94, 0, 245),
                  ],
                  controller: _controller,
                  child: ElevatedButton.icon(
                    onPressed: value ? _onSubmit : null,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(16.0),
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                    ),
                    icon: const Icon(
                      Icons.track_changes_outlined,
                      color: Colors.white,
                    ),
                    label: Text(
                      'GENERATE',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              : ElevatedButton.icon(
                  onPressed: value ? _onSubmit : null,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(16.0),
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ),
                  icon: Container(
                    width: 24,
                    height: 24,
                    padding: const EdgeInsets.all(2.0),
                    child: const CircularProgressIndicator(
                      color: const Color.fromARGB(255, 179, 179, 179),
                      strokeWidth: 3,
                    ),
                  ),
                  label: Text(
                    'GENERATING',
                    style: TextStyle(
                        color: const Color.fromARGB(255, 179, 179, 179)),
                  ),
                ),
        );
      },
    );
  }
}
