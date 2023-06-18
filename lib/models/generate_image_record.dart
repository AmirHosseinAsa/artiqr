import 'package:hive/hive.dart';
part 'generate_image_record.g.dart';

@HiveType(typeId: 1)
class GenerateImageRecord extends HiveObject {
  @HiveField(0)
  late final String prompt;
  
  @HiveField(1)
  late final String content;

  @HiveField(2)
  late String? url;

  @HiveField(3)
  late bool generating = false;

  @HiveField(4)
  late DateTime? CreateDate = DateTime.now();

  @HiveField(5)
  late bool? isBrandNew = true;

  GenerateImageRecord({required this.prompt,required this.content});
}