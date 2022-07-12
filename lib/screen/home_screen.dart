import 'package:flutter/material.dart';
import 'package:sikoopi_app/miscellaneous/data_classes/cart_classes.dart';
import 'package:sikoopi_app/miscellaneous/data_classes/user_classes.dart';
import 'package:sikoopi_app/miscellaneous/functions/global_dialog.dart';
import 'package:sikoopi_app/miscellaneous/variables/global_color.dart';
import 'package:sikoopi_app/miscellaneous/variables/global_string.dart';
import 'package:sikoopi_app/services/api/product_services.dart';
import 'package:sikoopi_app/services/api/transaction_services.dart';
import 'package:sikoopi_app/services/shared_preferences.dart';
import 'package:sikoopi_app/widgets/specific/home_screen_widgets/home_drawer.dart';
import 'package:sikoopi_app/widgets/specific/home_screen_widgets/admin_home_fragment.dart';
import 'package:sikoopi_app/widgets/specific/home_screen_widgets/user_home_fragment.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  int orderCounter = 0;

  String? role;

  TextEditingController categoryController = TextEditingController(text: 'All');

  List<ProductResponseData> productDisplayList = [];

  List<CartClasses> cartItemList = [];
  List<TransactionResponseData> activeOrderList = [];
  
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
          await ProductServices().readAllProduct().then((dioResult) {
            List<ProductResponseData> listTemp = [];

            if(dioResult != null && dioResult.data != null) {
              switch(categoryController.text) {
                case 'All':
                  for(int i = 0; i < dioResult.data!.length; i++) {
                    listTemp.add(dioResult.data![i]);
                  }
                  break;
                case 'Bahan Pokok':
                  for(int i = 0; i < dioResult.data!.length; i++) {
                    if(dioResult.data![i].categoryName == 'Bahan Pokok') {
                      listTemp.add(dioResult.data![i]);
                    }
                  }
                  break;
                case 'Produk Kebersihan':
                  for(int i = 0; i < dioResult.data!.length; i++) {
                    if(dioResult.data![i].categoryName == 'Produk Kebersihan') {
                      listTemp.add(dioResult.data![i]);
                    }
                  }
                  break;
                default:
                  break;
              }

              setState(() {
                productDisplayList = listTemp;
              });
            }
          });
        } else {
          await TransactionServices().readAllTransaction().then((dioResult) {
            List<TransactionResponseData> listTemp = [];

            if(dioResult != null && dioResult.data != null) {
              for(int i = 0; i < dioResult.data!.length; i++) {
                if(dioResult.data![i].status != 'Completed') {
                  listTemp.add(dioResult.data![i]);
                }
              }
            }

            setState(() {
              activeOrderList = listTemp;
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
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    '${GlobalString.assetImagePath}/background_2.png',
                  ),
                  fit: BoxFit.cover
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Material(
                        color: Colors.transparent,
                        child: IconButton(
                          onPressed: () {
                            _key.currentState!.openEndDrawer();
                          },
                          icon: Icon(
                            Icons.menu,
                            color: GlobalColor.defaultWhite,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        '${GlobalString.assetImagePath}/bps_jateng_icon.png',
                        width: MediaQuery.of(context).size.width / 2,
                      ),
                      const SizedBox(
                        width: 20.0,
                      ),
                      Image.asset(
                        '${GlobalString.assetImagePath}/sikoopi_icon.png',
                        height: MediaQuery.of(context).size.height / 8,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    height: 40.0,
                    decoration: BoxDecoration(
                      color: GlobalColor.defaultWhite,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(40.0,),
                        topRight: Radius.circular(40.0,),
                      ),
                    ),
                  )
                ],
              ),
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
                onPressed: (ProductResponseData selectedItem) {
                  if(selectedItem.stock != null && int.parse(selectedItem.stock!) > 0) {
                    if(cartItemList.isEmpty) {
                      setState(() {
                        cartItemList.add(
                          CartClasses(
                            id: int.parse(selectedItem.id!),
                            name: selectedItem.name,
                            uom: selectedItem.uom,
                            price: int.parse(selectedItem.price!),
                            stock: int.parse(selectedItem.stock!),
                            imagePath: selectedItem.imagePath,
                            totalQty: 1,
                            sellCount: int.parse(selectedItem.sellCount!),
                          ),
                        );
                      });
                    } else {
                      bool add = true;

                      for(int i = 0; i < cartItemList.length; i++) {
                        if(cartItemList[i].id == int.parse(selectedItem.id!)) {
                          add = false;

                          if(selectedItem.stock != null && int.parse(selectedItem.stock!) > 0) {
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
                              id: int.parse(selectedItem.id!),
                              name: selectedItem.name,
                              uom: selectedItem.uom,
                              price: int.parse(selectedItem.price!),
                              stock: int.parse(selectedItem.stock!),
                              imagePath: selectedItem.imagePath,
                              totalQty: 1,
                              sellCount: int.parse(selectedItem.sellCount!),
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
                categoryController: categoryController,
                categoryPressed: () {
                  GlobalDialog(context: context, message: 'Category').listCategory([
                    'All',
                    'Bahan Pokok',
                    'Produk Kebersihan',
                  ], (selected) {
                    if(selected != null) {
                      setState(() {
                        categoryController.text = selected;
                      });

                      initLoad();
                    }
                  });
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
          initLoad();
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}