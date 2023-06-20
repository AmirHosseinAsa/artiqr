import 'package:artiqr/models/generated_image_records_database%20copy.dart';
import 'package:artiqr/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClearHistoryWidget extends StatefulWidget {
  const ClearHistoryWidget({Key? key}) : super(key: key);

  @override
  _ClearHistoryWidgetState createState() => _ClearHistoryWidgetState();

  static final ValueNotifier<bool> valueNotifier = ValueNotifier<bool>(true);
}

class _ClearHistoryWidgetState extends State<ClearHistoryWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton.icon(
        onPressed: () {
          showAlertDialog(context, () {
            context.read<GeneratedImageRecordsDatabase>().clearHistory();
            Navigator.of(context).pop();
          }, () {
            Navigator.of(context).pop();
          }, 'Are you sure?');
        },
        style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(16.0),
            backgroundColor: Color.fromARGB(255, 158, 4, 4)),
        icon: const Icon(Icons.delete_forever),
        label: Text(
          'CLEAR',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}