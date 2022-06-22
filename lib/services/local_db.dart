import 'package:path/path.dart';
import 'package:sikoopi_app/miscellaneous/data_classes/product_classes.dart';
import 'package:sikoopi_app/miscellaneous/data_classes/user_classes.dart';
import 'package:sqflite/sqflite.dart';

class LocalDB {
  Future<String> initDB() async {
    String dbPath = await getDatabasesPath();

    String path = join(dbPath, 'sikoopi.db');

    return path;
  }

  Future<Database> openDB () async {
    String path = await initDB();

    Database database = await openDatabase(path, version: 1, onCreate: (Database db, int version) async {
      await db.execute(
        'CREATE TABLE user (id INTEGER PRIMARY KEY, name TEXT, phone TEXT, email TEXT, pass TEXT, role TEXT, isActive TEXT)',
      );

      await db.execute(
        'CREATE TABLE product (id INTEGER PRIMARY KEY, name TEXT, uom TEXT, price INTEGER, imagePath TEXT, isActive TEXT)',
      );

      await db.execute(
        'CREATE TABLE transaction (id INTEGER PRIMARY KEY, user_name TEXT, date TEXT, total INTEGER, payment TEXT, receipent TEXT, address TEXT, status TEXT, isActive TEXT)',
      );

      await db.execute(
        'CREATE TABLE detail_transaction (id INTEGER PRIMARY KEY, transaction_id INTEGER, product_name TEXT, product_uom TEXT, product_price INTEGER, product_iamge TEXT, isActive TEXT)',
      );

      // Insert initial data
      await db.execute(
        'INSERT INTO user (name, phone, email, pass, role, isActive) VALUES (?, ?, ?, ?, ?, ?)',
        [
          'Admin Nadia',
          '+62-823-2219-6306',
          'nadia.sikoopi@gmail.com',
          'p4ssw0rd',
          'admin',
          'active',
        ],
      );
    });

    return database;
  }

  Future<bool> deleteDB() async {
    bool result = false;

    String path = await initDB();

    await deleteDatabase(path).then((_) {
      result = true;
    });

    return result;
  }

  Future<bool> writeUser(UserClasses user) async {
    bool result = false;

    await openDB().then((db) async {
      await db.rawInsert(
        'INSERT INTO user (name, phone, email, pass, role, isActive) VALUES (?, ?, ?, ?, ?, ?)',
        [
          user.username,
          user.phoneNo,
          user.email,
          user.pass,
          user.role,
          user.isActive,
        ],
      ).then((_) {
        result = true;
      });
    });

    return result;
  }

  Future<bool> writeProduct(ProductClasses product) async {
    bool result = false;

    await openDB().then((db) async {
      await db.rawInsert(
        'INSERT INTO product (name, uom, price, imagePath, isActive) VALUES (?, ?, ?, ?, ?)',
        [
          product.name,
          product.uom,
          product.price,
          product.imagePath,
          product.isActive,
        ],
      ).then((_) {
        result = true;
      });
    });

    return result;
  }

  Future<List<UserClasses>> readAllUser() async {
    List<UserClasses> userList = [];

    await openDB().then((db) async {
      await db.rawQuery(
        'SELECT * FROM user',
      ).then((result) {
        if(result.isNotEmpty) {
          for(int i = 0; i < result.length; i++) {
            userList.add(
              UserClasses(
                username: "${result[i]['name']}",
                phoneNo: "${result[i]['phone']}",
                email: "${result[i]['email']}",
                role: "${result[i]['role']}",
                isActive: result[i]['isActive'] == 'active' ? true : false,
              ),
            );
          }
        }
      });
    });

    return userList;
  }

  Future<UserClasses?> readUser(int id) async {
    UserClasses? user;

    await openDB().then((db) async {
      await db.rawQuery(
        'SELECT * FROM user WHERE id = ?',
        [
          id,
        ],
      ).then((result) {
        if(result.isNotEmpty) {
          for(int i = 0; i < result.length; i++) {
            user = UserClasses(
              username: "${result[i]['name']}",
              phoneNo: "${result[i]['phone']}",
              email: "${result[i]['email']}",
              role: "${result[i]['role']}",
              isActive: result[i]['isActive'] == 'active' ? true : false,
            );
          }
        }
      });
    });

    return user;
  }
}