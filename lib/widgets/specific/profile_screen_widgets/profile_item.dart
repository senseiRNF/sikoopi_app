import 'package:flutter/material.dart';
import 'package:sikoopi_app/miscellaneous/variables/global_string.dart';
import 'package:sikoopi_app/widgets/global_padding.dart';
import 'package:sikoopi_app/widgets/global_text.dart';

class ProfileItem extends StatelessWidget {
  final String iconPath;
  final String? title;

  const ProfileItem({
    Key? key,
    required this.iconPath,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GlobalPadding(
      paddingClass: const GlobalPaddingClass(
        paddingTop: 10.0,
        paddingBottom: 10.0,
      ),
      content: Row(
        children: [
          Image.asset(
            '${GlobalString.assetImagePath}/$iconPath',
            width: 40.0,
            height: 30.0,
          ),
          Expanded(
            child: GlobalText(
              content: title ?? ' - ',
              size: 16.0,
              padding: const GlobalPaddingClass(
                paddingLeft: 10.0,
                paddingRight: 10.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}