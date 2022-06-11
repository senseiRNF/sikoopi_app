import 'package:flutter/material.dart';
import 'package:sikoopi_app/miscellaneous/functions/global_route.dart';

class GlobalDialog {
  final BuildContext context;
  final String message;

  const GlobalDialog({
    required this.context,
    required this.message,
  });

  void okDialog(Function callback) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text(
            'Attention',
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text(
                  message,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                GlobalRoute(context: context).back(null);
              },
              child: const Text(
                'OK',
              ),
            ),
          ],
        );
      },
    ).then((_) {
      callback();
    });
  }

  void optionDialog(Function yes, Function no) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text(
            'Attention',
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text(
                  message,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                GlobalRoute(context: context).back(false);
              },
              child: const Text(
                'No',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                GlobalRoute(context: context).back(true);
              },
              child: const Text(
                'Yes',
              ),
            ),
          ],
        );
      },
    ).then((result) {
      if(result != null) {
        if(result) {
          yes();
        } else {
          no();
        }
      }
    });
  }
}