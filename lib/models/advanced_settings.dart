import 'package:hive/hive.dart';
part 'advanced_settings.g.dart';

@HiveType(typeId: 2)
class AdvancedSettings extends HiveObject {
  @HiveField(0)
  late double QR_ControlnetConditioningScale = 1.50;

  @HiveField(1)
  late double QR_Strength = 0.9;

  @HiveField(2)
  late double QR_GuidanceScale = 7.5;

  @HiveField(3)
  late bool showAdvanceSettings = true;

  AdvancedSettings(
      {required this.QR_ControlnetConditioningScale,
      required this.QR_Strength,
      required this.QR_GuidanceScale,
      required this.showAdvanceSettings});
}
