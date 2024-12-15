import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../bloc/reminder_bloc.dart';
import '../settings/settings_view.dart';
import '../../models/reminder_item.dart';
import 'reminder_list_item.dart';

/// Displays a list of SampleItems.
class RemindersListView extends StatelessWidget {
  const RemindersListView({
    super.key,
  });

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReminderBloc(Hive.box<ReminderItem>('reminders'))
        ..add(LoadReminders()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Reminders List'),
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                // Navigate to the settings page. If the user leaves and returns
                // to the app after it has been killed while running in the
                // background, the navigation stack is restored.
                Navigator.restorablePushNamed(context, SettingsView.routeName);
              },
            ),
          ],
        ),

        // To work with lists that may contain a large number of items, it’s best
        // to use the ListView.builder constructor.
        //
        // In contrast to the default ListView constructor, which requires
        // building all Widgets up front, the ListView.builder constructor lazily
        // builds Widgets as they’re scrolled into view.
        body: BlocBuilder<ReminderBloc, ReminderState>(
          // Providing a restorationId allows the ListView to restore the
          // scroll position when a user leaves and returns to the app after it
          // has been killed while running in the background.
          builder: (context, state) {
            if (state is RemindersLoaded) {
              return ListView.builder(
                restorationId: 'remindersListView',
                itemCount: state.reminders.length,
                itemBuilder: (context, index) {
                  final item = state.reminders[index];

                  return ReminderListItem(item: item);
                },
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
