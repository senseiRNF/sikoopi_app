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

  List<CartClasses> cartClassesList = [
    CartClasses(
      id: 1,
      imagePath: '${GlobalString.assetImagePath}/product_icon/gula_pasir.png',
      totalQty: 0,
    ),
    CartClasses(
      id: 2,
      imagePath: '${GlobalString.assetImagePath}/product_icon/minyak_goreng.png',
      totalQty: 0,
    ),
    CartClasses(
      id: 3,
      imagePath: '${GlobalString.assetImagePath}/product_icon/sabun_cair.png',
      totalQty: 0,
    ),
    CartClasses(
      id: 4,
      imagePath: '${GlobalString.assetImagePath}/product_icon/pewangi_pakaian.png',
      totalQty: 0,
    ),
    CartClasses(
      id: 5,
      imagePath: '${GlobalString.assetImagePath}/product_icon/beras.png',
      totalQty: 0,
    ),
    CartClasses(
      id: 6,
      imagePath: '${GlobalString.assetImagePath}/product_icon/telur.png',
      totalQty: 0,
    ),
    CartClasses(
      id: 7,
      imagePath: '${GlobalString.assetImagePath}/product_icon/terigu.png',
      totalQty: 0,
    ),
    CartClasses(
      id: 8,
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
                cartClassesList: cartClassesList,
                onChangeQty: (List<int> updateQty) {
                  setState(() {
                    cartClassesList[updateQty[0]].totalQty = updateQty[1];
                  });
                },
              ),
            ),
          ],
        ),
      ),
      endDrawer: HomeDrawer(cartClassesList: cartClassesList,),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}