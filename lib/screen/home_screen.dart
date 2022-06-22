import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sikoopi_app/miscellaneous/data_classes/order_classes.dart';
import 'package:sikoopi_app/miscellaneous/data_classes/authorization_classes.dart';
import 'package:sikoopi_app/miscellaneous/data_classes/cart_classes.dart';
import 'package:sikoopi_app/miscellaneous/data_classes/history_classes.dart';
import 'package:sikoopi_app/miscellaneous/functions/global_dialog.dart';
import 'package:sikoopi_app/miscellaneous/variables/global_string.dart';
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
  
  @override
  void initState() {
    super.initState();

    initLoad();
  }

  void initLoad() async {
    await SharedPref().readAuthorization().then((AuthorizationClasses? auth) {
      if(auth != null) {
        setState(() {
          role = auth.role;
        });
      }
    });
  }
  
  List<CartClasses> productDisplayList = [
    CartClasses(
      id: 1,
      name: 'Gula Rose Brand',
      uom: '1 Kg',
      price: 20000,
      imagePath: '${GlobalString.assetImagePath}/product_icon/gula_pasir.png',
      totalQty: 0,
    ),
    CartClasses(
      id: 2,
      name: 'Minyak Goreng SunCo',
      uom: '1 L',
      price: 25000,
      imagePath: '${GlobalString.assetImagePath}/product_icon/minyak_goreng.png',
      totalQty: 0,
    ),
    CartClasses(
      id: 3,
      name: 'Sabun Lifebuoy Refill',
      uom: '900 Ml',
      price: 50000,
      imagePath: '${GlobalString.assetImagePath}/product_icon/sabun_cair.png',
      totalQty: 0,
    ),
    CartClasses(
      id: 4,
      name: 'Molto Pewangi',
      uom: '750 Ml',
      price: 30000,
      imagePath: '${GlobalString.assetImagePath}/product_icon/pewangi_pakaian.png',
      totalQty: 0,
    ),
    CartClasses(
      id: 5,
      name: 'Beras Sania Premium',
      uom: '5 Kg',
      price: 60000,
      imagePath: '${GlobalString.assetImagePath}/product_icon/beras.png',
      totalQty: 0,
    ),
    CartClasses(
      id: 6,
      name: 'Telur',
      uom: '10 Btr',
      price: 25000,
      imagePath: '${GlobalString.assetImagePath}/product_icon/telur.png',
      totalQty: 0,
    ),
    CartClasses(
      id: 7,
      name: 'Tepung Segitiga Biru',
      uom: '1 Kg',
      price: 15000,
      imagePath: '${GlobalString.assetImagePath}/product_icon/terigu.png',
      totalQty: 0,
    ),
    CartClasses(
      id: 8,
      name: 'Sunlight',
      uom: '750 Ml',
      price: 25000,
      imagePath: '${GlobalString.assetImagePath}/product_icon/sabun_cuci_piring.png',
      totalQty: 0,
    ),
  ];
  List<CartClasses> cartItemList = [];
  List<HistoryClasses> historyItemList = [];
  List<ActiveOrderClass> activeOrderList = [
    ActiveOrderClass(
      orderCode: 'EX/001/14/06/22',
      date: DateTime(2022, 06, 14),
      detailOrder: [
        DetailActiveOrderClass(
          productName: 'Beras Sania Premium',
          productUOM: '5 Kg',
          productPrice: 60000,
          qty: 2,
          subtotal: 120000,
          imgPath: '${GlobalString.assetImagePath}/product_icon/beras.png',
        ),
        DetailActiveOrderClass(
          productName: 'Telur',
          productUOM: '10 Btr',
          productPrice: 25000,
          qty: 2,
          subtotal: 50000,
          imgPath: '${GlobalString.assetImagePath}/product_icon/telur.png',
        ),
      ],
      total: 170000,
      paymentMethod: 'cash',
      status: false,
    ),
    ActiveOrderClass(
      orderCode: 'EX/002/14/06/22',
      date: DateTime(2022, 06, 14),
      detailOrder: [
        DetailActiveOrderClass(
          productName: 'Gula Rose Brand',
          productUOM: '1 Kg',
          productPrice: 20000,
          qty: 3,
          subtotal: 60000,
          imgPath: '${GlobalString.assetImagePath}/product_icon/gula_pasir.png',
        ),
      ],
      total: 60000,
      paymentMethod: 'cash',
      status: false,
    ),
    ActiveOrderClass(
      orderCode: 'EX/003/14/06/22',
      date: DateTime(2022, 06, 14),
      detailOrder: [
        DetailActiveOrderClass(
          productName: 'Sabun Lifebuoy Refill',
          productUOM: '900 Ml',
          productPrice: 50000,
          qty: 1,
          subtotal: 50000,
          imgPath: '${GlobalString.assetImagePath}/product_icon/sabun_cair.png',
        ),
        DetailActiveOrderClass(
          productName: 'Sunlight',
          productUOM: '750 Ml',
          productPrice: 25000,
          qty: 1,
          subtotal: 25000,
          imgPath: '${GlobalString.assetImagePath}/product_icon/sabun_cuci_piring.png',
        ),
        DetailActiveOrderClass(
          productName: 'Molto Pewangi',
          productUOM: '750 Ml',
          productPrice: 30000,
          qty: 1,
          subtotal: 30000,
          imgPath: '${GlobalString.assetImagePath}/product_icon/pewangi_pakaian.png',
        ),
      ],
      total: 105000,
      paymentMethod: 'transfer',
      receipent: 'Umar Abdul Aziz',
      address: 'Jl. Sana-sini no.5, RT 007/ RW 001, Ds. Bojongkenyot',
      status: false,
    ),
  ];

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

                },
              ) :
              UserHomeFragment(
                productDisplayList: productDisplayList,
                onPressed: (CartClasses selectedItem) {
                  if(cartItemList.isEmpty) {
                    setState(() {
                      cartItemList.add(selectedItem);
                      cartItemList[0].totalQty = 1;
                    });
                  } else {
                    bool add = true;

                    for(int i = 0; i < cartItemList.length; i++) {
                      if(cartItemList[i].id == selectedItem.id) {
                        add = false;

                        setState(() {
                          cartItemList[i].totalQty = cartItemList[i].totalQty + 1;
                        });
                      }
                    }

                    if(add) {
                      setState(() {
                        cartItemList.add(selectedItem);
                        cartItemList[cartItemList.length - 1].totalQty = 1;
                      });
                    }
                  }

                  GlobalDialog(context: context, message: 'Success add to Cart').okDialog(() {

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
      endDrawer: HomeDrawer(
        orderList: cartItemList,
        historyList: historyItemList,
        onChangeQty: (List<int> qtyChange) {
          setState(() {
            if(qtyChange[1] == 0) {
              cartItemList.removeAt(qtyChange[0]);
            } else {
              cartItemList[qtyChange[0]].totalQty = qtyChange[1];
            }
          });
        },
        callbackScreen: (List<CartClasses> afterSuccessItem, String receiverName, String address) {
          setState(() {
            cartItemList = [];
            historyItemList.add(
              HistoryClasses(
                id: orderCounter,
                orderDate: DateFormat('yyyy-MM-dd').format(DateTime.now()),
                receiverName: receiverName,
                address: address,
                historyList: afterSuccessItem,
              ),
            );

            orderCounter = orderCounter + 1;
          });
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}