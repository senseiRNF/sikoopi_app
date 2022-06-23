import 'package:flutter/material.dart';
import 'package:sikoopi_app/miscellaneous/variables/global_color.dart';
import 'package:sikoopi_app/miscellaneous/variables/global_string.dart';
import 'package:sikoopi_app/widgets/global_padding.dart';
import 'package:sikoopi_app/widgets/global_text.dart';

class ProfileItem extends StatelessWidget {
  final String? iconPath;
  final String? title;

  const ProfileItem({
    Key? key,
    this.iconPath,
    this.title,
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
          iconPath != null ?
          Image.asset(
            '${GlobalString.assetImagePath}/$iconPath',
            width: 40.0,
            height: 30.0,
          ) :
          SizedBox(
            width: 40.0,
            height: 30.0,
            child: Icon(
              Icons.home_outlined,
              size: 30.0,
              color: GlobalColor.defaultBlack,
            ),
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