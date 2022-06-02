import 'package:flutter/material.dart';

class GlobalPadding extends StatelessWidget {
  final GlobalPaddingClass? paddingClass;
  final Widget content;

  const GlobalPadding({
    Key? key,
    this.paddingClass,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: paddingClass != null ?
      EdgeInsets.fromLTRB(
        paddingClass!.paddingLeft != null ? paddingClass!.paddingLeft! : 0.0,
        paddingClass!.paddingTop != null ? paddingClass!.paddingTop! : 0.0,
        paddingClass!.paddingRight != null ? paddingClass!.paddingRight! : 0.0,
        paddingClass!.paddingBottom!= null ? paddingClass!.paddingBottom! : 0.0,
      ) : EdgeInsets.zero,
      child: content,
    );
  }
}

class GlobalPaddingClass {
  final double? paddingLeft;
  final double? paddingTop;
  final double? paddingRight;
  final double? paddingBottom;

  const GlobalPaddingClass({
    this.paddingLeft,
    this.paddingTop,
    this.paddingRight,
    this.paddingBottom,
  });
}