import 'package:flutter/material.dart';

class GlobalRoute {
  final BuildContext context;

  const GlobalRoute({
    required this.context,
  });

  void moveTo(Widget target, Function callback) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext targetContext) => target,
      ),
    ).then((result) {
      callback(result);
    });
  }

  void replaceWith(Widget target) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (BuildContext targetContext) => target,
      ),
    );
  }

  void back(dynamic result) {
    Navigator.of(context).pop(result);
  }
}