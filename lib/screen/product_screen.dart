import 'package:flutter/material.dart';
import 'package:sikoopi_app/miscellaneous/data_classes/cart_classes.dart';
import 'package:sikoopi_app/miscellaneous/variables/global_color.dart';
import 'package:sikoopi_app/miscellaneous/variables/global_string.dart';
import 'package:sikoopi_app/widgets/global_button.dart';
import 'package:sikoopi_app/widgets/global_padding.dart';
import 'package:sikoopi_app/widgets/specific/product_screen_widgets/product_item.dart';
import 'package:sikoopi_app/widgets/specific/product_screen_widgets/product_screen_header.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {

  List<CartClasses> productList = [
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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Image.asset(
                '${GlobalString.assetImagePath}/background_1.png',
                fit: BoxFit.fill,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const ProductScreenHeader(),
                Expanded(
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemCount: productList.length,
                    itemBuilder: (BuildContext gridContext, int index) {
                      return ProductItem(
                        orderList: productList[index],
                        onPressed: () => () {

                        },
                      );
                    },
                  ),
                ),
                GlobalElevatedButton(
                  onPressed: () {

                  },
                  title: 'Add New Product',
                  btnColor: GlobalColor.accentColor,
                  padding: const GlobalPaddingClass(
                    paddingLeft: 50.0,
                    paddingTop: 10.0,
                    paddingRight: 50.0,
                    paddingBottom: 10.0,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}