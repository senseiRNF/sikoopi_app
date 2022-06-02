import 'package:flutter/material.dart';
import 'package:sikoopi_app/miscellaneous/variables/global_color.dart';
import 'package:sikoopi_app/widgets/global_padding.dart';
import 'package:sikoopi_app/widgets/global_text.dart';

class GlobalElevatedButton extends StatelessWidget {
  final String title;
  final double? titleSize;
  final Color? titleColor;
  final Color? btnColor;
  final Function onPressed;
  final GlobalPaddingClass? padding;

  const GlobalElevatedButton({
    Key? key,
    required this.title,
    this.titleSize,
    this.titleColor,
    this.btnColor,
    required this.onPressed,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GlobalPadding(
      paddingClass: padding,
      content: ElevatedButton(
        onPressed: () => onPressed(),
        style: ElevatedButton.styleFrom(
          primary: btnColor ?? GlobalColor.primaryColor,
          elevation: 10.0,
        ),
        child: GlobalText(
          content: title,
          size: titleSize ?? 16.0,
          color: titleColor ?? GlobalColor.defaultWhite,
          padding: const GlobalPaddingClass(
            paddingLeft: 10.0,
            paddingTop: 10.0,
            paddingRight: 10.0,
            paddingBottom: 10.0,
          ),
        ),
      ),
    );
  }
}

class GlobalTextButton extends StatelessWidget {
  final String title;
  final double? titleSize;
  final Color? titleColor;
  final Function onPressed;
  final GlobalPaddingClass? padding;

  const GlobalTextButton({
    Key? key,
    required this.title,
    this.titleSize,
    this.titleColor,
    required this.onPressed,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GlobalPadding(
      paddingClass: padding,
      content: InkWell(
        onTap: () => onPressed(),
        child: GlobalText(
          content: title,
          size: titleSize ?? 16.0,
          color: titleColor ?? GlobalColor.accentColor,
          padding: const GlobalPaddingClass(
            paddingLeft: 10.0,
            paddingTop: 10.0,
            paddingRight: 10.0,
            paddingBottom: 10.0,
          ),
        ),
      ),
    );
  }
}