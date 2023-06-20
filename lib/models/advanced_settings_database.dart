import 'package:artiqr/models/advanced_settings.dart';
import 'package:artiqr/utils/constants.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AdvancedSettingsDatabase {
  static var _settings = Hive.box<AdvancedSettings>('advancedSettings');

  static Future<void> InitilaizeAdvancedSettings() async {
    if (_settings.values.isEmpty) {
      _settings.put(
          0,
          AdvancedSettings(
              QR_ControlnetConditioningScale: QR_ControlnetConditioningScale,
              QR_Strength: QR_Strength,
              QR_GuidanceScale: QR_GuidanceScale,
              showAdvanceSettings: showAdvanceSettings));
    } else {
      QR_ControlnetConditioningScale =
          _settings.values.first.QR_ControlnetConditioningScale;
      QR_Strength = _settings.values.first.QR_Strength;
      QR_GuidanceScale = _settings.values.first.QR_GuidanceScale;
      showAdvanceSettings = _settings.values.first.showAdvanceSettings;
    }
  }

  static Future<void> update() async {
    _settings.put(
        0,
        AdvancedSettings(
            QR_ControlnetConditioningScale: QR_ControlnetConditioningScale,
            QR_Strength: QR_Strength,
            QR_GuidanceScale: QR_GuidanceScale,
            showAdvanceSettings: showAdvanceSettings));
  }
}
