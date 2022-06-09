import 'package:flutter/material.dart';
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
          SizedBox(
            width: 80.0,
            height: 80.0,
            child: Image.network(
              urlPhoto ?? '',
              loadingBuilder: (BuildContext imgContext, Widget child, ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) {
                  return Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(
                          urlPhoto ?? '',
                        ),
                      )
                    ),
                  );
                }
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              },
              errorBuilder: (BuildContext errContext, obj, stackTrace) {
                return const Center(
                  child: Icon(
                    Icons.account_circle,
                    size: 60.0,
                  ),
                );
              },
            ),
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