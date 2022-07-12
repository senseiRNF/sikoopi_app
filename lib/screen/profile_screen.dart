import 'package:flutter/material.dart';
import 'package:sikoopi_app/miscellaneous/data_classes/user_classes.dart';
import 'package:sikoopi_app/miscellaneous/functions/global_dialog.dart';
import 'package:sikoopi_app/miscellaneous/variables/global_color.dart';
import 'package:sikoopi_app/miscellaneous/variables/global_string.dart';
import 'package:sikoopi_app/services/api/auth_services.dart';
import 'package:sikoopi_app/services/shared_preferences.dart';
import 'package:sikoopi_app/widgets/global_button.dart';
import 'package:sikoopi_app/widgets/global_input_field.dart';
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
  bool isEditMode = false;

  int? userId;

  TextEditingController nameTEC = TextEditingController();
  TextEditingController phoneTEC = TextEditingController();
  TextEditingController addressTEC = TextEditingController();

  String? email;
  String? role;

  @override
  void initState() {
    super.initState();

    initLoad();
  }

  void initLoad() async {
    await SharedPref().readAuthorization().then((result) {
      if(result != null) {
        setState(() {
          userId = result.id;
          nameTEC.text = result.username ?? 'Unknown Name';
          phoneTEC.text = result.phoneNo ?? 'Unknown Phone';
          addressTEC.text = result.address ?? 'Unknown Address';
          email = result.email ?? 'Unknown Email';
          role = result.role ?? 'user';
        });
      }
    });
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
                      child: ListView(
                        shrinkWrap: true,
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
                                content: isEditMode ?
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    GlobalTextfield(
                                      controller: nameTEC,
                                      title: 'Name',
                                    ),
                                    GlobalTextfield(
                                      controller: phoneTEC,
                                      title: 'Phone',
                                      inputType: TextInputType.phone,
                                    ),
                                    GlobalTextfield(
                                      controller: addressTEC,
                                      title: 'Address',
                                    ),
                                    GlobalElevatedButton(
                                      onPressed: () async {
                                        GlobalDialog(context: context, message: 'Update data, Are you sure?').optionDialog(() async {
                                          await AuthServices().updateUser(
                                            UserClasses(
                                              id: userId,
                                              username: nameTEC.text,
                                              phoneNo: phoneTEC.text,
                                              address: addressTEC.text,
                                            ),
                                          ).then((dioResult) {
                                            if(dioResult) {
                                              setState(() {
                                                isEditMode = !isEditMode;
                                              });
                                            }
                                          });
                                        }, () {

                                        });
                                      },
                                      title: 'Save Profile',
                                      titleColor: GlobalColor.defaultBlack,
                                      btnColor: GlobalColor.defaultWhite,
                                      padding: const GlobalPaddingClass(
                                        paddingTop: 20.0,
                                        paddingBottom: 10.0,
                                      ),
                                    ),
                                  ],
                                ) :
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    ProfilePhotoItem(
                                      name: nameTEC.text,
                                      phoneNo: phoneTEC.text,
                                    ),
                                    ProfileItem(
                                      iconPath: 'name_icon.png',
                                      title: nameTEC.text,
                                    ),
                                    ProfileItem(
                                      iconPath: 'phone_no_icon.png',
                                      title: phoneTEC.text,
                                    ),
                                    ProfileItem(
                                      iconPath: null,
                                      title: addressTEC.text,
                                    ),
                                    ProfileItem(
                                      iconPath: 'email_icon.png',
                                      title: email ?? 'Unknown Email',
                                    ),
                                    GlobalElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          isEditMode = !isEditMode;
                                        });
                                      },
                                      title: 'Edit Profile',
                                      titleColor: GlobalColor.defaultBlack,
                                      btnColor: GlobalColor.defaultWhite,
                                      padding: const GlobalPaddingClass(
                                        paddingBottom: 10.0,
                                      ),
                                    ),
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