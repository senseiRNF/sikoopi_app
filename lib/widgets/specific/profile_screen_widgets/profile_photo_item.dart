import 'package:flutter/material.dart';
import 'package:sikoopi_app/miscellaneous/variables/global_color.dart';
import 'package:sikoopi_app/widgets/global_padding.dart';
import 'package:sikoopi_app/widgets/global_text.dart';

class ProfilePhotoItem extends StatelessWidget {
  final String? urlPhoto;
  final String? name;
  final String? phoneNo;

  const ProfilePhotoItem({
    Key? key,
    this.urlPhoto,
    this.name,
    this.phoneNo,
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
          Icon(
            Icons.account_circle,
            size: 80.0,
            color: GlobalColor.defaultBlue,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GlobalText(
                  content: name ?? ' - ',
                  size: 22.0,
                  isBold: true,
                  padding: const GlobalPaddingClass(
                    paddingLeft: 10.0,
                    paddingRight: 10.0,
                  ),
                ),
                GlobalText(
                  content: phoneNo ?? ' - ',
                  size: 16.0,
                  padding: const GlobalPaddingClass(
                    paddingLeft: 10.0,
                    paddingRight: 10.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}