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
          user.id.toString(),
          user.username ?? 'Unknown Name',
          user.phoneNo ?? 'Unknown Phone',
          user.email ?? 'Unknown Email',
          user.address ?? 'Unknown Address',
          user.role ?? 'Unknown Role',
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
          id: int.parse(authList[0]),
          username: authList[1],
          phoneNo: authList[2],
          email: authList[3],
          address: authList[4],
          role: authList[5],
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