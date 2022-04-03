import 'package:flutter/material.dart';

const defaultMessage = 'Are you sure? You want to delete this item?';

class ConfirmationDialog extends StatefulWidget {
  const ConfirmationDialog(
    {
      this.message = defaultMessage,
      this.cancelMessage = 'Cancel',
      this.confirmMessage = 'Confirm',
      required this.onConfirm,
      Key? key
    }
  ) : super(key: key);

  final String message;
  final String confirmMessage;
  final String cancelMessage;
  final void Function() onConfirm;

  @override
  State<ConfirmationDialog> createState() => _ConfirmationDialogState();
}

class _ConfirmationDialogState extends State<ConfirmationDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(widget.message),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(widget.cancelMessage),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.blue),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            widget.onConfirm();
            Navigator.pop(context);
          },
          child: Text(widget.confirmMessage),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.red),
          ),
        ),
      ],
    );
  }
}