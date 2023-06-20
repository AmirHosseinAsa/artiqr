import 'dart:convert';
import 'package:artiqr/commands/flask.dart';
import 'package:artiqr/commands/io_commands.dart';
import 'package:artiqr/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../widgets/custom_scaffold_message_widget.dart';

int timesRun = 0;
Future<String> generateQRCode(BuildContext context) async {
  String url = 'http://127.0.0.1:$portServ';

  var response = await http.post(
    Uri.parse(url),
    headers: {
      'prompt': promptTextFiledGenerateValue,
      'content': contentTextFiledGenerateValue,
      'guidance-scale': QR_GuidanceScale.toString(),
      'controlnet-condition-scale': QR_ControlnetConditioningScale.toString(),
      'strength': QR_Strength.toString(),
      'timesRun': timesRun.toString()
    },
  );

  switch (response.statusCode) {
    case 200:
      try {
        CustomScaffoldMessageWidget.show(
            context,
            'The file was saved successfully in: ' +
                appDownloadFolder.toString());
        var jsonResponse = json.decode(response.body);
        timesRun = 0;
        return jsonResponse;
      } catch (e) {
        return '';
      }
    case 403:
      CustomScaffoldMessageWidget.show(
          context, 'Error: Your prompt has been blocked');
      throw Exception('Error: Your prompt has been blocked');

    case 401:
      if (timesRun > 3) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: Queue is full! Please try again.'),
          ),
        );
        timesRun = 0;
        throw Exception('Error: Queue is full! Please try again.');
      } else {
        timesRun++;
        await shutdownServer();
        await startServer();
        await Future.delayed(Duration(milliseconds: 1500));
        return generateQRCode(context);
      }

    case 502:
      if (timesRun > 3) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: Queue is full! Please try again.'),
          ),
        );
        timesRun = 0;
        throw Exception('Error: Queue is full! Please try again.');
      } else {
        timesRun++;
        return generateQRCode(context);
      }

    default:
      CustomScaffoldMessageWidget.show(context,
          'Unknown error: Please refer to the "About" page for contact information to reach out to the developer for assistance.');
      throw Exception('Failed to fetch data from API');
  }
}
