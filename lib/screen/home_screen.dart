import 'package:flutter/material.dart';
import 'package:sikoopi_app/miscellaneous/data_classes/cart_classes.dart';
import 'package:sikoopi_app/miscellaneous/variables/global_string.dart';
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

  @override
  void initState() {
    super.initState();
  }

  List<CartClasses> orderList = [
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      body: SafeArea(
        child: Column(
          children: [
            HomeScreenHeader(
              onPressed: () {
                _key.currentState!.openEndDrawer();
              },
            ),
            Expanded(
              child: HomeFragment(
                orderList: orderList,
                onChangeQty: (List<int> updateQty) {
                  setState(() {
                    orderList[updateQty[0]].totalQty = updateQty[1];
                  });
                },
              ),
            ),
          ],
        ),
      ),
      endDrawer: HomeDrawer(
        orderList: orderList,
        onChangeQty: (List<int> updateQty) {
          if(updateQty.isNotEmpty) {
            WidgetsBinding.instance!.addPostFrameCallback((_) {
              setState(() {
                orderList[updateQty[0]].totalQty = updateQty[1];
              });
            });
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}