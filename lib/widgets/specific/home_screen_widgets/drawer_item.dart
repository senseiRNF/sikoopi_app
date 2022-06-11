import 'package:flutter/material.dart';
import 'package:sikoopi_app/miscellaneous/variables/global_color.dart';
import 'package:sikoopi_app/miscellaneous/variables/global_string.dart';
import 'package:sikoopi_app/widgets/global_padding.dart';
import 'package:sikoopi_app/widgets/global_text.dart';

class DrawerItem extends StatelessWidget {
  final String iconPath;
  final String title;
  final Function onPressed;

  const DrawerItem({
    Key? key,
    required this.iconPath,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => onPressed(),
        child: GlobalPadding(
          paddingClass: const GlobalPaddingClass(
            paddingLeft: 20.0,
            paddingTop: 10.0,
            paddingRight: 20.0,
            paddingBottom: 10.0,
          ),
          content: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                '${GlobalString.assetImagePath}/$iconPath',
              ),
              Expanded(
                child: GlobalText(
                  content: title,
                  size: 20.0,
                  color: GlobalColor.defaultWhite,
                  padding: const GlobalPaddingClass(
                    paddingLeft: 20.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}