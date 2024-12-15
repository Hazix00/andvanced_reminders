import 'package:hive/hive.dart';

part 'reminder_item.g.dart';

@HiveType(typeId: 0)
class ReminderItem extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1, defaultValue: '')
  final String? title;

  ReminderItem({required this.id, this.title});
}
