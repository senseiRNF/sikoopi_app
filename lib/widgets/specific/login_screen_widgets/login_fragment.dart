import 'package:flutter/material.dart';
import 'package:sikoopi_app/miscellaneous/functions/global_route.dart';
import 'package:sikoopi_app/miscellaneous/variables/global_color.dart';
import 'package:sikoopi_app/screen/home_screen.dart';
import 'package:sikoopi_app/widgets/global_button.dart';
import 'package:sikoopi_app/widgets/global_input_field.dart';
import 'package:sikoopi_app/widgets/global_padding.dart';
import 'package:sikoopi_app/widgets/global_text.dart';

class LoginFragment extends StatelessWidget {
  const LoginFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController emailTEC = TextEditingController();
    TextEditingController passTEC = TextEditingController();

    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        GlobalText(
          content: 'Login',
          size: 30.0,
          color: GlobalColor.primaryColor,
          isBold: true,
          align: TextAlign.center,
          padding: const GlobalPaddingClass(
            paddingTop: 30.0,
          ),
        ),
        GlobalTextfield(
          controller: emailTEC,
          title: 'Email',
          inputType: TextInputType.emailAddress,
          padding: const GlobalPaddingClass(
            paddingLeft: 50.0,
            paddingTop: 10.0,
            paddingRight: 50.0,
            paddingBottom: 10.0,
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
        GlobalTextButton(
          onPressed: () {

          },
          title: 'Forgot Password?',
          titleColor: GlobalColor.defaultRed,
          padding: const GlobalPaddingClass(
            paddingLeft: 40.0,
            paddingTop: 10.0,
            paddingRight: 40.0,
            paddingBottom: 10.0,
          ),
        ),
        GlobalElevatedButton(
          onPressed: () {
            GlobalRoute(context: context).replaceWith(const HomeScreen());
          },
          title: 'Login',
          titleSize: 18.0,
          btnColor: GlobalColor.accentColor,
          padding: const GlobalPaddingClass(
            paddingLeft: 40.0,
            paddingTop: 10.0,
            paddingRight: 40.0,
            paddingBottom: 10.0,
          ),
        ),
      ],
    );
  }
}