// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'advanced_settings.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AdvancedSettingsAdapter extends TypeAdapter<AdvancedSettings> {
  @override
  final int typeId = 2;

  @override
  AdvancedSettings read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AdvancedSettings(
      QR_ControlnetConditioningScale: fields[0] as double,
      QR_Strength: fields[1] as double,
      QR_GuidanceScale: fields[2] as double,
      showAdvanceSettings: fields[3] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, AdvancedSettings obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.QR_ControlnetConditioningScale)
      ..writeByte(1)
      ..write(obj.QR_Strength)
      ..writeByte(2)
      ..write(obj.QR_GuidanceScale)
      ..writeByte(3)
      ..write(obj.showAdvanceSettings);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AdvancedSettingsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
