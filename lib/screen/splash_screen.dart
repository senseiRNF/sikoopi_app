import 'package:flutter/material.dart';
import 'package:sikoopi_app/miscellaneous/data_classes/user_classes.dart';
import 'package:sikoopi_app/miscellaneous/functions/global_route.dart';
import 'package:sikoopi_app/miscellaneous/variables/global_color.dart';
import 'package:sikoopi_app/miscellaneous/variables/global_string.dart';
import 'package:sikoopi_app/screen/home_screen.dart';
import 'package:sikoopi_app/screen/login_screen.dart';
import 'package:sikoopi_app/services/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreen createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    initLoad();
  }

  void initLoad() async {
    await SharedPref().readAuthorization().then((UserClasses? user) {
      if(user != null) {
        Future.delayed(const Duration(seconds: 2), () {
          GlobalRoute(context: context).replaceWith(const HomeScreen());
        });
      } else {
        Future.delayed(const Duration(seconds: 2), () {
          GlobalRoute(context: context).replaceWith(const LoginScreen());
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
            Image.asset(
              '${GlobalString.assetImagePath}/splash_image.png',
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.fill,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: LinearProgressIndicator(
                    minHeight: 20.0,
                    color: GlobalColor.accentColor,
                    backgroundColor: GlobalColor.primaryColor,
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