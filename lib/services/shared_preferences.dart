import 'package:shared_preferences/shared_preferences.dart';
import 'package:sikoopi_app/miscellaneous/data_classes/user_classes.dart';
import 'package:sikoopi_app/miscellaneous/variables/global_string.dart';

class SharedPref {
  Future<SharedPreferences> init() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    return sharedPreferences;
  }

  Future<bool> writeAuthorization(UserClasses user) async {
    bool result = false;

    await init().then((sharedPrefs) async {
      await sharedPrefs.setStringList(
        GlobalString.keyAuthorization,
        [
          user.username,
          user.phoneNo,
          user.email,
          user.role,
        ],
      ).then((_) {
        result = true;
      });
    });

    return result;
  }

  Future<UserClasses?> readAuthorization() async {
    UserClasses? result;

    await init().then((sharedPrefs) async {
      List<String>? authList = sharedPrefs.getStringList(GlobalString.keyAuthorization);

      if(authList != null) {
        result = UserClasses(
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