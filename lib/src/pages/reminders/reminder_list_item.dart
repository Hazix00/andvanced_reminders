import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/reminder_bloc.dart';
import '../../models/reminder_item.dart';
import 'reminder_item_details_view.dart';

class ReminderListItem extends StatelessWidget {
  const ReminderListItem({
    super.key,
    required this.item,
  });

  final ReminderItem item;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(item.title ?? 'Reminder ${item.id}'),
      leading: const CircleAvatar(
        // Display the Flutter Logo image asset.
        foregroundImage: AssetImage('assets/images/flutter_logo.png'),
      ),
      onTap: () {
        // Navigate to the details page. If the user leaves and returns to
        // the app after it has been killed while running in the
        // background, the navigation stack is restored.
        Navigator.restorablePushNamed(
          context,
          ReminderDetailsView.routeName,
        );
      },
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () {
          // Delete the reminder when the icon button is pressed.
          // The BlocProvider is used to access the ReminderBloc.
          context.read<ReminderBloc>().add(DeleteReminder(item.id));
        },
      ),
    );
  }
}
