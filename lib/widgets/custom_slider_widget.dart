import 'package:artiqr/utils/constants.dart';
import 'package:flutter/material.dart';

class CustomSliderWidget extends StatefulWidget {
  CustomSliderWidget({
    super.key,
    required this.title,
    required this.type,
  });
  String title;
  String type;

  @override
  State<CustomSliderWidget> createState() => _CustomSliderWidgetState();
}

class _CustomSliderWidgetState extends State<CustomSliderWidget> {
  double _scale = 0;
  @override
  void initState() {
    _scale = GetDefaultValue(widget.type);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${widget.title}',
              style: TextStyle(fontSize: 15),
            ),
            Text(
              GetSwitchValue(widget.type),
              style: TextStyle(fontSize: 15),
            ),
          ],
        ),
        Slider(
          value: _scale,
          min: 0,
          max: double.parse(QR_INFO['${widget.type}'].toString()),
          label: _scale.toStringAsFixed(2),
          onChanged: (double newValue) {
            setState(() {
              _scale = newValue;
              SetValueSwitchValue(widget.type, newValue);
            });
          },
        ),
      ],
    );
  }
}

String GetSwitchValue(String type) {
  switch (type) {
    case 'ControlnetConditioningScale':
      return QR_ControlnetConditioningScale.toStringAsFixed(2);
    case 'Strength':
      return QR_Strength.toStringAsFixed(2);
    case 'GuidanceScale':
      return QR_GuidanceScale.toStringAsFixed(2);
    default:
      return '0';
  }
}

void SetValueSwitchValue(String type, double value) {
  switch (type) {
    case 'ControlnetConditioningScale':
      QR_ControlnetConditioningScale = value;
      break;
    case 'Strength':
      QR_Strength = value;
      break;
    case 'GuidanceScale':
      QR_GuidanceScale = value;
      break;
  }
}

double GetDefaultValue(String type) {
  switch (type) {
    case 'ControlnetConditioningScale':
      return QR_ControlnetConditioningScale;
    case 'Strength':
      return QR_Strength;
    case 'GuidanceScale':
      return QR_GuidanceScale;
    default:
      return 0;
  }
}
