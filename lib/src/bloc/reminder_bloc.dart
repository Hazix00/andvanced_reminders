import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import '../models/reminder_item.dart';

// Define Reminder Events
abstract class ReminderEvent {}

class LoadReminders extends ReminderEvent {}

class AddReminder extends ReminderEvent {
  final ReminderItem reminder;

  AddReminder(this.reminder);
}

class UpdateReminder extends ReminderEvent {
  final ReminderItem reminder;

  UpdateReminder(this.reminder);
}

class DeleteReminder extends ReminderEvent {
  final int id;

  DeleteReminder(this.id);
}

// Define Reminder States
abstract class ReminderState {}

class RemindersLoaded extends ReminderState {
  final List<ReminderItem> reminders;

  RemindersLoaded(this.reminders);
}

class ReminderBloc extends Bloc<ReminderEvent, ReminderState> {
  final Box<ReminderItem> reminderBox;

  ReminderBloc(this.reminderBox) : super(RemindersLoaded([])) {
    on<LoadReminders>((event, emit) {
      final reminders = reminderBox.values.toList();
      emit(RemindersLoaded(reminders));
    });

    on<AddReminder>((event, emit) async {
      await reminderBox.add(event.reminder);
      final reminders = reminderBox.values.toList();
      emit(RemindersLoaded(reminders));
    });

    on<UpdateReminder>((event, emit) async {
      await event.reminder.save();
      final reminders = reminderBox.values.toList();
      emit(RemindersLoaded(reminders));
    });

    on<DeleteReminder>((event, emit) async {
      await reminderBox.delete(event.id);
      final reminders = reminderBox.values.toList();
      emit(RemindersLoaded(reminders));
    });
  }
}
