import 'package:artiqr/models/generate_image_record.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class GeneratedImageRecordsDatabase extends ChangeNotifier {
  List<GenerateImageRecord> get GenerateImages =>
      _generatedImages.values.toList();

  var _generatedImages = Hive.box<GenerateImageRecord>('generatedResults');

  Future<void> getAllGeneratedImageRecords(bool onlyBrandNew) async {
    if (onlyBrandNew)
      _generatedImages.values.where((e) => e.isBrandNew == true).toList();
    _generatedImages.values.toList();
    notifyListeners();
  }

  Future<void> add(GenerateImageRecord record) async {
    await _generatedImages.add(record);
    notifyListeners();
  }

  Future<void> update(GenerateImageRecord record) async {
    record.save();
  }

  Future<void> updateMakeGenerating(GenerateImageRecord record) async {
    record.generating = true;
    record.save();
  }

  Future<void> makeAllBrandNewFalse() async {
    for (int i = 0; i < _generatedImages.values.length; i++) {
      final record = _generatedImages.getAt(i) as GenerateImageRecord;
      record.isBrandNew = false;
      await _generatedImages.putAt(i, record);
    }
    notifyListeners();
  }

  Future<void> remove(GenerateImageRecord record) async {
    record.delete();
    notifyListeners();
  }

  Future<void> removeRange(List<GenerateImageRecord> record) async {
    for (var re in record) {
      re.delete();
    }
  }

  Future<void> clearHistory() async {
    removeRange(
        _generatedImages.values.where((e) => e.isBrandNew == false).toList());
    notifyListeners();
  }
}