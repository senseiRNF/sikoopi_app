import 'package:shared_preferences/shared_preferences.dart';
import 'package:sikoopi_app/miscellaneous/data_classes/authorization_classes.dart';
import 'package:sikoopi_app/miscellaneous/variables/global_string.dart';

class SharedPref {
  Future<SharedPreferences> init() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    return sharedPreferences;
  }

  Future<bool> writeAuthorization(AuthorizationClasses auth) async {
    bool result = false;

    await init().then((sharedPrefs) async {
      await sharedPrefs.setStringList(
        GlobalString.keyAuthorization,
        [
          auth.username,
          auth.phoneNo,
          auth.email,
          auth.role,
        ],
      ).then((_) {
        result = true;
      });
    });

    return result;
  }

  Future<AuthorizationClasses?> readAuthorization() async {
    AuthorizationClasses? result;

    await init().then((sharedPrefs) async {
      List<String>? authList = sharedPrefs.getStringList(GlobalString.keyAuthorization);

      if(authList != null) {
        result = AuthorizationClasses(
          username: authList[0],
          phoneNo: authList[1],
          email: authList[2],
          role: authList[3],
        );
      }
    });

    return result;
  }

  Future<bool> deleteAuthorization() async {
    bool result = false;

    await init().then((sharedPrefs) async {
      await sharedPrefs.remove(GlobalString.keyAuthorization).then((_) {
        result = true;
      });
    });

    return result;
  }
}