import 'package:flutter/material.dart';
import 'package:sikoopi_app/miscellaneous/variables/global_color.dart';
import 'package:sikoopi_app/widgets/global_padding.dart';

class GlobalText extends StatelessWidget {
  final String content;
  final double? size;
  final Color? color;
  final bool? isBold;
  final bool? isItalic;
  final TextAlign? align;
  final GlobalPaddingClass? padding;

  const GlobalText({
    Key? key,
    required this.content,
    this.size,
    this.color,
    this.isBold,
    this.isItalic,
    this.align,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GlobalPadding(
      paddingClass: padding,
      content: Text(
        content,
        style: TextStyle(
          fontSize: size ?? 14.0,
          color: color ?? GlobalColor.defaultBlack,
          fontWeight: isBold != null && isBold! ? FontWeight.bold : FontWeight.normal,
          fontStyle: isItalic != null && isItalic! ? FontStyle.italic : FontStyle.normal,
        ),
        textAlign: align ?? TextAlign.start,
      ),
    );
  }
}