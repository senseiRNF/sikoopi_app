import 'package:flutter/material.dart';
import 'package:sikoopi_app/miscellaneous/data_classes/cart_classes.dart';
import 'package:sikoopi_app/miscellaneous/data_classes/product_classes.dart';
import 'package:sikoopi_app/miscellaneous/data_classes/transaction_classes.dart';
import 'package:sikoopi_app/miscellaneous/data_classes/user_classes.dart';
import 'package:sikoopi_app/miscellaneous/functions/global_dialog.dart';
import 'package:sikoopi_app/services/local_db.dart';
import 'package:sikoopi_app/services/shared_preferences.dart';
import 'package:sikoopi_app/widgets/specific/home_screen_widgets/home_drawer.dart';
import 'package:sikoopi_app/widgets/specific/home_screen_widgets/home_fragment.dart';
import 'package:sikoopi_app/widgets/specific/home_screen_widgets/home_screen_header.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  int orderCounter = 0;

  String? role;

  List<ProductClasses> productDisplayList = [];
  List<CartClasses> cartItemList = [];
  List<TransactionClasses> activeOrderList = [];
  
  @override
  void initState() {
    super.initState();

    initLoad();
  }

  void initLoad() async {
    await SharedPref().readAuthorization().then((UserClasses? user) async {
      if(user != null) {
        setState(() {
          role = user.role;
        });

        if(user.role == 'user') {
          await LocalDB().readAllProduct().then((product) {
            setState(() {
              productDisplayList = product;
            });
          });
        } else {
          await LocalDB().readAllTransaction().then((transaction) {
            setState(() {
              activeOrderList = transaction;
            });
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            HomeScreenHeader(
              role: role ?? '',
              onPressed: () {
                _key.currentState!.openEndDrawer();
              },
            ),
            Expanded(
              child: role == 'admin' ?
              AdminHomeFragment(
                activeOrder: activeOrderList,
                onRefresh: () {
                  initLoad();
                },
              ) :
              UserHomeFragment(
                productDisplayList: productDisplayList,
                onPressed: (ProductClasses selectedItem) {
                  if(selectedItem.stock != null && selectedItem.stock! > 0) {
                    if(cartItemList.isEmpty) {
                      setState(() {
                        cartItemList.add(
                          CartClasses(
                            id: selectedItem.id,
                            name: selectedItem.name,
                            uom: selectedItem.uom,
                            price: selectedItem.price,
                            imagePath: selectedItem.imagePath,
                            totalQty: 1,
                          ),
                        );
                      });
                    } else {
                      bool add = true;

                      for(int i = 0; i < cartItemList.length; i++) {
                        if(cartItemList[i].id == selectedItem.id) {
                          add = false;

                          if(selectedItem.stock != null && selectedItem.stock! > 0) {
                            setState(() {
                              cartItemList[i].totalQty = cartItemList[i].totalQty! + 1;
                            });
                          }
                        }
                      }

                      if(add) {
                        setState(() {
                          cartItemList.add(
                            CartClasses(
                              id: selectedItem.id,
                              name: selectedItem.name,
                              uom: selectedItem.uom,
                              price: selectedItem.price,
                              imagePath: selectedItem.imagePath,
                              totalQty: 1,
                            ),
                          );
                        });
                      }
                    }

                    GlobalDialog(context: context, message: 'Success add to Cart').okDialog(() {

                    });
                  } else {
                    GlobalDialog(context: context, message: 'Failed to add to Cart, Stock is empty').okDialog(() {

                    });
                  }
                },
              ),
            ),
          ],
        ),
      ),
      endDrawer: role != null && role == 'admin' ?
      const AdminHomeDrawer() :
      UserHomeDrawer(
        orderList: cartItemList,
        onChangeQty: (List<int> qtyChange) {
          setState(() {
            if(qtyChange[1] == 0) {
              cartItemList.removeAt(qtyChange[0]);
            } else {
              cartItemList[qtyChange[0]].totalQty = qtyChange[1];
            }
          });
        },
        isClear: () {
          cartItemList.clear();
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}