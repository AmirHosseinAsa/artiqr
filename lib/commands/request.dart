import 'dart:convert';
import 'package:artiqr/commands/flask.dart';
import 'package:artiqr/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../widgets/custom_scaffold_message_widget.dart';

Future<String> generateQRCode(BuildContext context) async {
  String url = 'http://127.0.0.1:$portServ';

  var response = await http.post(Uri.parse(url), headers: {
    'prompt': promptTextFiledGenerateValue,
    'content': contentTextFiledGenerateValue,
    'guidance-scale': QR_GuidanceScale.toString(),
    'controlnet-condition-scale': QR_ControlnetConditioningScale.toString(),
    'strength': QR_Strength.toString(),
  },);

  switch (response.statusCode) {
    case 200:
      try {
        var jsonResponse = json.decode(response.body);
        return jsonResponse;
      } catch (e) {
        return '';
      }
    case 403:
      CustomScaffoldMessageWidget.show(
          context, 'Error: Your prompt has been blocked');
      throw Exception('Error: Your prompt has been blocked');

    case 401:
      await shutdownServer();
      await startServer();
      await Future.delayed(Duration(milliseconds: 1500));
      return generateQRCode(context);

    case 500:
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: Try again'),
        ),
      );
      await shutdownServer();
      await startServer();
      throw Exception('Error: Try again');

    default:
      CustomScaffoldMessageWidget.show(context,
          'Unknown error: Please refer to the "About" page for contact information to reach out to the developer for assistance.');
      throw Exception('Failed to fetch data from API');
  }
}
