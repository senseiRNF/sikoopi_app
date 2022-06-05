import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sikoopi_app/miscellaneous/variables/global_color.dart';
import 'package:sikoopi_app/widgets/global_button.dart';
import 'package:sikoopi_app/widgets/global_input_field.dart';
import 'package:sikoopi_app/widgets/global_padding.dart';
import 'package:sikoopi_app/widgets/global_text.dart';

class SignUpFragment extends StatelessWidget {
  const SignUpFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController nameTEC = TextEditingController();
    TextEditingController phoneTEC = TextEditingController();
    TextEditingController emailTEC = TextEditingController();
    TextEditingController passTEC = TextEditingController();
    TextEditingController confPassTEC = TextEditingController();

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
          onPressed: () {
            log(emailTEC.text);
            log(passTEC.text);
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