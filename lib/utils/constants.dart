import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

const String AplicationName = "ARTIQR";
const Color background_container_generated_image = Color(0xff27272A);
const Color background_sidebar = Color(0xff18181B);
const Color backgroun_titlebar = Color.fromARGB(255, 20, 20, 20);
const Color sub_button_color =  Color.fromARGB(255, 139, 74, 243);

String promptTextFiledGenerateValue = '';
String contentTextFiledGenerateValue = '';

final spinkitPulse = SpinKitPulse(
  color: Colors.white,
  size: 180.0,
);
const String version = 'v1.0.0';
const String mailing =
    'mailto:amirhossein.asa.official@gmail.com?subject=[$AplicationName: (Ver: $version)]';

const String portServ = '7168';

Gradient gradientTheme = LinearGradient(colors: [
  Color.fromARGB(255, 56, 0, 146),
  Color.fromARGB(255, 94, 0, 245),
]);

Gradient reversedGradientTheme = LinearGradient(colors: [
  Color.fromARGB(255, 189, 148, 255),
  Color.fromARGB(255, 164, 109, 252),
]);

Gradient darkenGradientTheme = LinearGradient(colors: [
  Color.fromARGB(255, 56, 0, 146),
  Color.fromARGB(255, 94, 0, 245),
]);

showAlertDialog(
    BuildContext context, VoidCallback yes, VoidCallback no, String text) {
  Widget yesButton = TextButton(
    style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all(const Color.fromARGB(255, 163, 44, 35))),
    child: Text(
      "Yes",
      style: TextStyle(color: Colors.white),
    ),
    onPressed: yes,
  );
  Widget noButton = TextButton(
    style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all(Color.fromARGB(255, 146, 139, 139))),
    child: Text(
      "No",
      style: TextStyle(color: Colors.white),
    ),
    onPressed: no,
  );
  AlertDialog alert = AlertDialog(
    title: Text("$text"),
    alignment: Alignment.center,
    actions: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          yesButton,
          noButton,
        ],
      )
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

double QR_ControlnetConditioningScale = 1.1;
double QR_Strength = 0.9;
double QR_GuidanceScale = 7.5;
bool showAdvanceSettings = true;

var QR_INFO = {
  'ControlnetConditioningScale': '5',
  'Strength': '1',
  'GuidanceScale': '50'
};
