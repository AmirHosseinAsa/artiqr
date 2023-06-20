import 'dart:io';

import 'package:artiqr/commands/io_commands.dart';
import 'package:artiqr/commands/request.dart';
import 'package:artiqr/models/generate_image_record.dart';
import 'package:artiqr/models/generated_image_records_database.dart';
import 'package:artiqr/utils/constants.dart';
import 'package:artiqr/widgets/custom_scaffold_message_widget.dart';
import 'package:artiqr/widgets/generate_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class RecordShowWidget extends StatefulWidget {
  RecordShowWidget({super.key, required this.generateImageRecord});
  GenerateImageRecord generateImageRecord;
  @override
  State<RecordShowWidget> createState() => _RecordShowWidgetState();
}

class _RecordShowWidgetState extends State<RecordShowWidget> {
  bool _isLoading = false;
  bool hasError = false;

  Future<void> _fetchResult() async {
    context
        .read<GeneratedImageRecordsDatabase>()
        .updateMakeGenerating(widget.generateImageRecord);

    setState(() {
      _isLoading = true;
    });
    try {
      widget.generateImageRecord.fileName = await generateQRCode(context);
    } catch (e) {
      print(e);
      setState(() {
        // TO DO REMOVE THIS INSTANCE
        hasError = true;
        context
            .read<GeneratedImageRecordsDatabase>()
            .remove(widget.generateImageRecord);
      });
    } finally {
      setState(() {
        _isLoading = false;
        if (!hasError) {
          context
              .read<GeneratedImageRecordsDatabase>()
              .update(widget.generateImageRecord);
        }
        GenerateButtonWidget.valueNotifier.value = true;
      });
    }
  }

  @override
  void initState() {
    if (!widget.generateImageRecord.generating) _fetchResult();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 51, 51, 51),
          borderRadius: BorderRadius.circular(10)),
      height: MediaQuery.of(context).size.height / 1.28,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  '${widget.generateImageRecord.content}  |  ${widget.generateImageRecord.prompt}',
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Visibility(
                visible: !_isLoading,
                child: IconButton(
                  onPressed: () async {
                    if (ModalRoute.of(context)?.settings.name != '/') {
                      context
                          .read<GeneratedImageRecordsDatabase>()
                          .remove(widget.generateImageRecord);
                    } else {
                      CustomScaffoldMessageWidget.show(context,
                          'Please wait until the generation is finished');
                    }
                  },
                  icon: Icon(
                    Icons.remove_circle_outline_sharp,
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 22,
          ),
          Expanded(
            child: Center(
              child: _isLoading
                  ? Container(
                      padding: EdgeInsets.all(50),
                      child: spinkitPulse,
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.file(
                          fit: BoxFit.fitHeight,
                          File(
                              '${appDownloadFolder!}/${widget.generateImageRecord.fileName}')),
                    ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
