import 'package:flutter/material.dart';
import 'package:sikoopi_app/widgets/specific/login_screen_widgets/login_fragment.dart';
import 'package:sikoopi_app/widgets/specific/login_screen_widgets/login_screen_header.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController loginEmailTEC = TextEditingController();
  TextEditingController loginPassTEC = TextEditingController();

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
              child: const LoginScreenHeader(),
            ),
            LoginFragment(
              emailTEC: loginEmailTEC,
              passTEC: loginPassTEC,
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