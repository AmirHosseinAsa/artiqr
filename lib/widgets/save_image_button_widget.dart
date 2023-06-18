import 'package:artiqr/commands/io_commands.dart';
import 'package:artiqr/utils/constants.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SaveImageButton extends StatefulWidget {
  SaveImageButton({super.key, required this.url});
  String url;
  @override
  State<SaveImageButton> createState() => _SaveImageButtonState();
}

class _SaveImageButtonState extends State<SaveImageButton> {
  bool isSaving = false;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        if (!isSaving) {
          isSaving = true;
          setState(() {});
          await downloadAndSaveFile(context, widget.url);
          isSaving = false;
          setState(() {});
        }
      },
      child: isSaving
          ? SizedBox(
              child: Center(child: CircularProgressIndicator()),
              height: 25.0,
              width: 25.0,
            )
          : Icon(Icons.save_alt),
      style: ButtonStyle(
        shape: MaterialStateProperty.all(CircleBorder()),
        padding: MaterialStateProperty.all(EdgeInsets.all(12)),
        backgroundColor:
            MaterialStateProperty.all(sub_button_color.withOpacity(0.9)),
        overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
          if (states.contains(MaterialState.pressed)) return Colors.blue;
        }),
      ),
    );
  }
}