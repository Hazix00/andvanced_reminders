import 'package:flutter/material.dart';

/// Displays detailed information about a SampleItem.
class ReminderDetailsView extends StatelessWidget {
  const ReminderDetailsView({super.key});

  static const routeName = '/reminder_details';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reminder Details'),
      ),
      body: const Center(
        child: Text('More Information Here'),
      ),
    );
  }
}
