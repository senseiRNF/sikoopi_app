import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:sikoopi_app/miscellaneous/data_classes/cart_classes.dart';
import 'package:sikoopi_app/miscellaneous/data_classes/product_classes.dart';
import 'package:sikoopi_app/miscellaneous/data_classes/transaction_classes.dart';
import 'package:sikoopi_app/miscellaneous/data_classes/user_classes.dart';
import 'package:sikoopi_app/miscellaneous/variables/global_string.dart';
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
        'CREATE TABLE transactions (id INTEGER PRIMARY KEY, userId INTEGER, username TEXT, date TEXT, total INTEGER, payment TEXT, receipent TEXT, address TEXT, status TEXT, isActive TEXT)',
      );

      await db.execute(
        'CREATE TABLE detail_transactions (id INTEGER PRIMARY KEY, transactionId INTEGER, productName TEXT, productUom TEXT, productPrice INTEGER, productImage TEXT, productQty INTEGER, isActive TEXT)',
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

      await db.execute(
        'INSERT INTO product (name, uom, price, imagePath, isActive) VALUES (?, ?, ?, ?, ?)',
        [
          'Gula Rose Brand',
          '1 Kg',
          20000,
          '${GlobalString.assetImagePath}/product_icon/gula_pasir.png',
          'active',
        ],
      );
      await db.execute(
        'INSERT INTO product (name, uom, price, imagePath, isActive) VALUES (?, ?, ?, ?, ?)',
        [
          'Minyak Goreng SunCo',
          '1 L',
          25000,
          '${GlobalString.assetImagePath}/product_icon/minyak_goreng.png',
          'active',
        ],
      );
      await db.execute(
        'INSERT INTO product (name, uom, price, imagePath, isActive) VALUES (?, ?, ?, ?, ?)',
        [
          'Sabun Lifebuoy Refill',
          '900 Ml',
          50000,
          '${GlobalString.assetImagePath}/product_icon/sabun_cair.png',
          'active',
        ],
      );
      await db.execute(
        'INSERT INTO product (name, uom, price, imagePath, isActive) VALUES (?, ?, ?, ?, ?)',
        [
          'Molto Pewangi',
          '750 Ml',
          30000,
          '${GlobalString.assetImagePath}/product_icon/pewangi_pakaian.png',
          'active',
        ],
      );
      await db.execute(
        'INSERT INTO product (name, uom, price, imagePath, isActive) VALUES (?, ?, ?, ?, ?)',
        [
          'Beras Sania Premium',
          '5 Kg',
          60000,
          '${GlobalString.assetImagePath}/product_icon/beras.png',
          'active',
        ],
      );
      await db.execute(
        'INSERT INTO product (name, uom, price, imagePath, isActive) VALUES (?, ?, ?, ?, ?)',
        [
          'Telur',
          '10 Btr',
          25000,
          '${GlobalString.assetImagePath}/product_icon/telur.png',
          'active',
        ],
      );
      await db.execute(
        'INSERT INTO product (name, uom, price, imagePath, isActive) VALUES (?, ?, ?, ?, ?)',
        [
          'Tepung Segitiga Biru',
          '1 Kg',
          15000,
          '${GlobalString.assetImagePath}/product_icon/terigu.png',
          'active',
        ],
      );
      await db.execute(
        'INSERT INTO product (name, uom, price, imagePath, isActive) VALUES (?, ?, ?, ?, ?)',
        [
          'Sunlight',
          '750 Ml',
          25000,
          '${GlobalString.assetImagePath}/product_icon/sabun_cuci_piring.png',
          'active',
        ],
      );
    });

    return database;
  }

  // WRITE
  Future<List> writeUser(UserClasses user) async {
    bool result = false;
    int? userId;

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
      ).then((id) {
        result = true;
        userId = id;
      });
    });

    return [result, userId];
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

  Future<bool> writeTransactions(TransactionClasses transactions, List<CartClasses> cart) async {
    bool result = false;

    await openDB().then((db) async {
      await db.rawInsert(
        'INSERT INTO transactions (userId, username, date, total, payment, receipent, address, status, isActive) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)',
        [
          transactions.userId,
          transactions.username,
          DateFormat('yyyy-MM-dd').format(transactions.date!),
          transactions.total,
          transactions.payment,
          transactions.receipent,
          transactions.address,
          'waiting',
          'active',
        ],
      ).then((int transactionId) async {
        bool success = true;

        for(int i = 0; i < cart.length; i++) {
          await db.rawInsert(
            'INSERT INTO detail_transactions (transactionId, productName, productUom, productPrice, productImage, productQty, isActive) VALUES (?, ?, ?, ?, ?, ?, ?)',
            [
              transactionId,
              cart[i].name,
              cart[i].uom,
              cart[i].price,
              cart[i].imagePath,
              cart[i].totalQty,
              'active',
            ],
          ).catchError((e) {
            success = false;
          });
        }

        if(success) {
          result = true;
        }
      });
    });

    return result;
  }

  // READ
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
                id: int.parse("${result[i]['id']}"),
                pass: "${result[i]['pass']}",
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

  Future<List<ProductClasses>> readAllProduct() async {
    List<ProductClasses> productList = [];

    await openDB().then((db) async {
      await db.rawQuery(
        'SELECT * FROM product',
      ).then((result) {
        if(result.isNotEmpty) {
          for(int i = 0; i < result.length; i++) {
            productList.add(
              ProductClasses(
                id: int.parse("${result[i]['id']}"),
                name: "${result[i]['name']}",
                uom: "${result[i]['uom']}",
                price: int.parse("${result[i]['price']}"),
                imagePath: "${result[i]['imagePath']}",
                isActive: result[i]['isActive'] == 'active' ? true : false,
              ),
            );
          }
        }
      });
    });

    return productList;
  }

  Future<List<TransactionClasses>> readAllTransaction() async {
    List<TransactionClasses> transactionList = [];

    await openDB().then((db) async {
      await db.rawQuery(
        'SELECT * FROM transactions',
      ).then((result) {
        if(result.isNotEmpty) {
          for(int i = 0; i < result.length; i++) {
            transactionList.add(
              TransactionClasses(
                id: int.parse("${result[i]['id']}"),
                userId: int.parse("${result[i]['userId']}"),
                username: "${result[i]['username']}",
                date: DateTime.parse("${result[i]['date']}"),
                total: int.parse("${result[i]['total']}"),
                payment: "${result[i]['payment']}",
                receipent: "${result[i]['receipent']}",
                address: "${result[i]['address']}",
                status: "${result[i]['status']}",
                isActive: result[i]['isActive'] == 'active' ? true : false,
              ),
            );
          }
        }
      });
    });

    return transactionList;
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
              id: int.parse("${result[i]['name']}"),
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

  Future<ProductClasses?> readProduct(int id) async {
    ProductClasses? product;

    await openDB().then((db) async {
      await db.rawQuery(
        'SELECT * FROM product WHERE id = ?',
        [
          id,
        ],
      ).then((result) {
        if(result.isNotEmpty) {
          for(int i = 0; i < result.length; i++) {
            product = ProductClasses(
              id: int.parse("${result[i]['id']}"),
              name: "${result[i]['name']}",
              uom: "${result[i]['uom']}",
              price: int.parse("${result[i]['price']}"),
              imagePath: "${result[i]['imagePath']}",
              isActive: result[i]['isActive'] == 'active' ? true : false,
            );
          }
        }
      });
    });

    return product;
  }

  Future<List<CartClasses>> readDetailTransaction(int transactionId) async {
    List<CartClasses> transactionList = [];

    await openDB().then((db) async {
      await db.rawQuery(
        'SELECT * FROM detail_transactions WHERE transactionId = ?',
        [
          transactionId,
        ],
      ).then((result) {
        if(result.isNotEmpty) {
          for(int i = 0; i < result.length; i++) {
            transactionList.add(
              CartClasses(
                name: "${result[i]['productName']}",
                uom: "${result[i]['productUom']}",
                price: int.parse("${result[i]['productPrice']}"),
                imagePath: "${result[i]['productImage']}",
                totalQty: int.parse("${result[i]['productQty']}"),
              ),
            );
          }
        }
      });
    });

    return transactionList;
  }

  Future<UserClasses?> readLoginUser(String email, String pass) async {
    UserClasses? user;

    await openDB().then((db) async {
      await db.rawQuery(
        'SELECT * FROM user WHERE email = ? AND pass = ?',
        [
          email,
          pass,
        ],
      ).then((result) {
        if(result.isNotEmpty) {
          for(int i = 0; i < result.length; i++) {
            user = UserClasses(
              id: int.parse("${result[i]['id']}"),
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

  Future<List<TransactionClasses>> readTransactionByUser(int userId) async {
    List<TransactionClasses> transactionList = [];

    await openDB().then((db) async {
      await db.rawQuery(
        'SELECT * FROM transactions WHERE userId = ?',
        [
          userId,
        ],
      ).then((result) {
        if(result.isNotEmpty) {
          for(int i = 0; i < result.length; i++) {
            transactionList.add(
              TransactionClasses(
                id: int.parse("${result[i]['id']}"),
                userId: int.parse("${result[i]['userId']}"),
                username: "${result[i]['username']}",
                date: DateTime.parse("${result[i]['date']}"),
                total: int.parse("${result[i]['total']}"),
                payment: "${result[i]['payment']}",
                receipent: "${result[i]['receipent']}",
                address: "${result[i]['address']}",
                status: "${result[i]['status']}",
                isActive: result[i]['isActive'] == 'active' ? true : false,
              ),
            );
          }
        }
      });
    });

    return transactionList;
  }

  // UPDATE
  Future<bool> updateUser(UserClasses user) async {
    bool result = false;

    await openDB().then((db) async {
      await db.rawUpdate(
        'UPDATE user SET name = ?, phone = ? WHERE id = ?',
        [
          user.username,
          user.phoneNo,
          user.id,
        ],
      ).then((_) {
        result = true;
      });
    });

    return result;
  }
}