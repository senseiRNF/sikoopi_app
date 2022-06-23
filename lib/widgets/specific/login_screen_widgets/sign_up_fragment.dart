import 'package:flutter/material.dart';
import 'package:sikoopi_app/miscellaneous/data_classes/user_classes.dart';
import 'package:sikoopi_app/miscellaneous/functions/global_dialog.dart';
import 'package:sikoopi_app/miscellaneous/functions/global_route.dart';
import 'package:sikoopi_app/miscellaneous/variables/global_color.dart';
import 'package:sikoopi_app/screen/home_screen.dart';
import 'package:sikoopi_app/services/local_db.dart';
import 'package:sikoopi_app/services/shared_preferences.dart';
import 'package:sikoopi_app/widgets/global_button.dart';
import 'package:sikoopi_app/widgets/global_input_field.dart';
import 'package:sikoopi_app/widgets/global_padding.dart';
import 'package:sikoopi_app/widgets/global_text.dart';

class SignUpFragment extends StatelessWidget {
  final TextEditingController nameTEC;
  final TextEditingController phoneTEC;
  final TextEditingController emailTEC;
  final TextEditingController addressTEC;
  final TextEditingController passTEC;
  final TextEditingController confPassTEC;

  const SignUpFragment({
    Key? key,
    required this.nameTEC,
    required this.phoneTEC,
    required this.emailTEC,
    required this.addressTEC,
    required this.passTEC,
    required this.confPassTEC,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        GlobalText(
          content: 'Sign Up',
          size: 30.0,
          color: GlobalColor.primaryColor,
          isBold: true,
          align: TextAlign.center,
          padding: const GlobalPaddingClass(
            paddingTop: 30.0,
          ),
        ),
        GlobalTextfield(
          controller: nameTEC,
          title: 'Name',
          padding: const GlobalPaddingClass(
            paddingLeft: 50.0,
            paddingRight: 50.0,
          ),
        ),
        GlobalTextfield(
          controller: phoneTEC,
          title: 'Phone',
          inputType: TextInputType.phone,
          padding: const GlobalPaddingClass(
            paddingLeft: 50.0,
            paddingRight: 50.0,
          ),
        ),
        GlobalTextfield(
          controller: addressTEC,
          title: 'Address',
          padding: const GlobalPaddingClass(
            paddingLeft: 50.0,
            paddingRight: 50.0,
          ),
        ),
        GlobalTextfield(
          controller: emailTEC,
          title: 'Email',
          inputType: TextInputType.emailAddress,
          padding: const GlobalPaddingClass(
            paddingLeft: 50.0,
            paddingRight: 50.0,
          ),
        ),
        GlobalPasswordField(
          controller: passTEC,
          title: 'Password',
          padding: const GlobalPaddingClass(
            paddingLeft: 50.0,
            paddingRight: 50.0,
          ),
        ),
        GlobalPasswordField(
          controller: confPassTEC,
          title: 'Confirm Password',
          padding: const GlobalPaddingClass(
            paddingLeft: 50.0,
            paddingRight: 50.0,
          ),
        ),
        GlobalElevatedButton(
          onPressed: () async {
            if(passTEC.text == confPassTEC.text) {
              if(nameTEC.text != '' && phoneTEC.text != '' && emailTEC.text != '') {
                await LocalDB().writeUser(
                  UserClasses(
                    username: nameTEC.text,
                    phoneNo: phoneTEC.text,
                    email: emailTEC.text,
                    address: addressTEC.text,
                    pass: passTEC.text,
                    role: 'user',
                  ),
                ).then((createResult) async {
                  if(createResult[0]) {
                    await SharedPref().writeAuthorization(
                      UserClasses(
                        id: createResult[1],
                        username: nameTEC.text,
                        phoneNo: phoneTEC.text,
                        email: emailTEC.text,
                        address: addressTEC.text,
                        role: 'user',
                      ),
                    ).then((authResult) {
                      if(authResult) {
                        GlobalRoute(context: context).replaceWith(const HomeScreen());
                      } else {
                        GlobalDialog(context: context, message: 'Failed to Register, please check all your data and then try again').okDialog(() {

                        });
                      }
                    });
                  } else {
                    GlobalDialog(context: context, message: 'Failed to Register, please check all your data and then try again').okDialog(() {

                    });
                  }
                });
              }
            } else {
              GlobalDialog(context: context, message: 'Failed to Register, please check all your data and then try again').okDialog(() {

              });
            }
          },
          title: 'Sign Up',
          titleSize: 18.0,
          btnColor: GlobalColor.accentColor,
          padding: const GlobalPaddingClass(
            paddingLeft: 40.0,
            paddingTop: 20.0,
            paddingRight: 40.0,
            paddingBottom: 20.0,
          ),
        ),
      ],
    );
  }
}