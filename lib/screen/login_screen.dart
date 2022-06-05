import 'package:flutter/material.dart';
import 'package:sikoopi_app/widgets/specific/login_screen_widgets/login_fragment.dart';
import 'package:sikoopi_app/widgets/specific/login_screen_widgets/login_screen_header.dart';
import 'package:sikoopi_app/widgets/specific/login_screen_widgets/sign_up_fragment.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  int selectedMenu = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 2.6,
              child: LoginScreenHeader(
                selectedMenu: selectedMenu,
                onChange: (result) {
                  setState(() {
                    selectedMenu = result;
                  });
                },
              ),
            ),
            selectedMenu == 0 ?
            const LoginFragment() :
            const SignUpFragment(),
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