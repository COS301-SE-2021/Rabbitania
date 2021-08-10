import 'package:flutter/material.dart';

class SuccessBookingSnackBar extends StatelessWidget {
  Widget build(context) => SnackBar(
        content: Text('Booking created successfully'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            // TODO: impliment functionality to delete booking using this undo command
          },
        ),
      );
}
