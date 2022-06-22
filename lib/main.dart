import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sikoopi_app/miscellaneous/variables/global_color.dart';
import 'package:sikoopi_app/miscellaneous/variables/global_string.dart';
import 'package:sikoopi_app/screen/splash_screen.dart';
import 'package:sikoopi_app/services/local_db.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) {
    LocalDB().openDB().then((_) {
      runApp(const MainApp());
    });
  });
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: GlobalString.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: GlobalColor.primaryColor,
          titleTextStyle: TextStyle(
            color: GlobalColor.defaultWhite,
          ),
        ),
        fontFamily: 'Lato',
      ),
      routes: {
        '/': (context) => const SplashScreen(),
      },
    );
  }
}
