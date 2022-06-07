import 'package:flutter/material.dart';
import 'package:sikoopi_app/miscellaneous/variables/global_color.dart';
import 'package:sikoopi_app/miscellaneous/variables/global_string.dart';
import 'package:sikoopi_app/widgets/global_button.dart';
import 'package:sikoopi_app/widgets/global_padding.dart';
import 'package:sikoopi_app/widgets/specific/profile_screen_widgets/profile_item.dart';
import 'package:sikoopi_app/widgets/specific/profile_screen_widgets/profile_photo_item.dart';
import 'package:sikoopi_app/widgets/specific/profile_screen_widgets/profile_screen_header.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreen createState() => _ProfileScreen();
}

class _ProfileScreen extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Image.asset(
                '${GlobalString.assetImagePath}/background_1.png',
                fit: BoxFit.fill,
              ),
            ),
            Column(
              children: [
                const ProfileScreenHeader(),
                Expanded(
                  child: GlobalPadding(
                    paddingClass: const GlobalPaddingClass(
                      paddingLeft: 20.0,
                      paddingRight: 20.0,
                      paddingBottom: 20.0,
                    ),
                    content: Card(
                      elevation: 10.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0,),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 30.0,
                          ),
                          ListView(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              GlobalPadding(
                                paddingClass: const GlobalPaddingClass(
                                  paddingLeft: 20.0,
                                  paddingRight: 20.0,
                                ),
                                content: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    const ProfilePhotoItem(
                                      urlPhoto: 'https://ami.animecharactersdatabase.com/uploads/chars/5457-1000260068.jpg',
                                      name: 'Rany Ashisa',
                                      phoneNo: '08126545664',
                                    ),
                                    const ProfileItem(
                                      iconPath: 'name_icon.png',
                                      title: 'Rany Ashisa',
                                    ),
                                    const ProfileItem(
                                      iconPath: 'phone_no_icon.png',
                                      title: '08126545664',
                                    ),
                                    const ProfileItem(
                                      iconPath: 'email_icon.png',
                                      title: 'ranyashiha@gmail.com',
                                    ),
                                    GlobalElevatedButton(
                                      onPressed: () {

                                      },
                                      title: GlobalString.editProfileText,
                                      titleColor: GlobalColor.defaultBlack,
                                      btnColor: GlobalColor.defaultWhite,
                                      padding: const GlobalPaddingClass(
                                        paddingBottom: 10.0,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}