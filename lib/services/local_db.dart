import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:sikoopi_app/miscellaneous/data_classes/cart_classes.dart';
import 'package:sikoopi_app/miscellaneous/data_classes/product_classes.dart';
import 'package:sikoopi_app/miscellaneous/data_classes/transaction_classes.dart';
import 'package:sikoopi_app/miscellaneous/data_classes/user_classes.dart';
import 'package:sqflite/sqflite.dart';

class LocalDB {
  Future<String> initDB() async {
    String dbPath = await getDatabasesPath();

    String path = join(dbPath, 'sikoopi.db');

    return path;
  }

  Future<Database> openDB() async {
    String path = await initDB();

    Database database = await openDatabase(path, version: 1, onCreate: (Database db, int version) async {
      await db.execute(
        'CREATE TABLE user (id INTEGER PRIMARY KEY, name TEXT, phone TEXT, address TEXT, email TEXT, pass TEXT, role TEXT)',
      );

      await db.execute(
        'CREATE TABLE category (id INTEGER PRIMARY KEY, categoryName TEXT)',
      );

      await db.execute(
        'CREATE TABLE product (id INTEGER PRIMARY KEY, name TEXT, uom TEXT, price INTEGER, imagePath TEXT, stock INTEGER, categoryId INTEGER, sellCount INTEGER)',
      );

      await db.execute(
        'CREATE TABLE opname (id INTEGER, date TEXT, userId INTEGER, userName TEXT)',
      );

      await db.execute(
        'CREATE TABLE detail_opname (id INTEGER, opnameId INTEGER, productId INTEGER, productName TEXT, qty INTEGER)',
      );

      await db.execute(
        'CREATE TABLE transactions (id INTEGER PRIMARY KEY, userId INTEGER, username TEXT, date TEXT, total INTEGER, payment TEXT, receipent TEXT, address TEXT, status TEXT, transferReceiptImage String)',
      );

      await db.execute(
        'CREATE TABLE detail_transactions (id INTEGER PRIMARY KEY, transactionId INTEGER, productName TEXT, productUom TEXT, productPrice INTEGER, productImage TEXT, productQty INTEGER)',
      );

      // Insert initial data
      await db.execute(
        'INSERT INTO user (name, phone, email, pass, role) VALUES (?, ?, ?, ?, ?)',
        [
          'Admin Nadia',
          '082322196306',
          'nadia.sikoopi@gmail.com',
          'p4ssw0rd',
          'admin',
        ],
      );

      await db.execute(
        'INSERT INTO user (name, phone, address, email, pass, role) VALUES (?, ?, ?, ?, ?, ?)',
        [
          'User Test',
          '0123456789',
          'Test Address',
          'user.test@sikoopi.com',
          'p4ssw0rd',
          'user',
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
        'INSERT INTO user (name, phone, email, address, pass, role) VALUES (?, ?, ?, ?, ?, ?)',
        [
          user.username,
          user.phoneNo,
          user.email,
          user.address,
          user.pass,
          user.role,
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
        'INSERT INTO product (name, uom, price, imagePath, stock) VALUES (?, ?, ?, ?, ?)',
        [
          product.name,
          product.uom,
          product.price,
          product.imagePath,
          product.stock,
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
        'INSERT INTO transactions (userId, username, date, total, payment, receipent, address, status, transferReceiptImage) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)',
        [
          transactions.userId,
          transactions.username,
          DateFormat('yyyy-MM-dd').format(transactions.date!),
          transactions.total,
          transactions.payment,
          transactions.receipent,
          transactions.address,
          'Waiting',
          transactions.transferReceiptImage,
        ],
      ).then((int transactionId) async {
        bool success = true;

        for(int i = 0; i < cart.length; i++) {
          await db.rawInsert(
            'INSERT INTO detail_transactions (transactionId, productName, productUom, productPrice, productImage, productQty) VALUES (?, ?, ?, ?, ?, ?)',
            [
              transactionId,
              cart[i].name,
              cart[i].uom,
              cart[i].price,
              cart[i].imagePath,
              cart[i].totalQty,
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
                address: "${result[i]['address']}",
                role: "${result[i]['role']}",
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
                stock: int.parse("${result[i]['stock']}"),
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
                transferReceiptImage: "${result[i]['transferReceiptImage']}",
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
              id: int.parse("${result[i]['id']}"),
              username: "${result[i]['name']}",
              phoneNo: "${result[i]['phone']}",
              email: "${result[i]['email']}",
              address: "${result[i]['address']}",
              role: "${result[i]['role']}",
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
              stock: int.parse("${result[i]['stock']}"),
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
              address: "${result[i]['address']}",
              role: "${result[i]['role']}",
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
                transferReceiptImage: "${result[i]['transferReceiptImage']}",
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
        'UPDATE user SET name = ?, phone = ?, address = ? WHERE id = ?',
        [
          user.username,
          user.phoneNo,
          user.address,
          user.id,
        ],
      ).then((_) {
        result = true;
      });
    });

    return result;
  }

  Future<bool> updateProduct(ProductClasses product) async {
    bool result = false;

    await openDB().then((db) async {
      await db.rawUpdate(
        'UPDATE product SET name = ?, uom = ?, price = ?, stock = ? WHERE id = ?',
        [
          product.name,
          product.uom,
          product.price,
          product.stock,
          product.id,
        ],
      ).then((_) {
        result = true;
      });
    });

    return result;
  }

  Future<bool> completeOrder(int transactionId) async {
    bool result = false;

    await openDB().then((db) async {
      await db.rawUpdate(
        "UPDATE transactions SET status = 'Completed' WHERE id = ?",
        [
          transactionId,
        ],
      ).then((_) {
        result = true;
      });
    });

    return result;
  }
}