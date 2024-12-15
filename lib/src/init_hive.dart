import 'package:hive_flutter/hive_flutter.dart';
import 'models/reminder_item.dart';

Future<void> initHive() async {
  // Initialize Hive
  await Hive.initFlutter();

  // Register adapters here
  Hive.registerAdapter(ReminderItemAdapter());

  // Open a box
  var reminderBox = await Hive.openBox<ReminderItem>('reminders');

  // Check if there are no reminders and add three default reminders
  if (reminderBox.isEmpty) {
    for (var i = 1; i <= 3; i++) {
      reminderBox.add(ReminderItem(id: i, title: 'Default Reminder $i'));
    }
    // notify listeners
    reminderBox.listenable();
  }
}
