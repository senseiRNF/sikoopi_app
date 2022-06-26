import 'package:flutter/material.dart';
import 'package:sikoopi_app/miscellaneous/data_classes/product_classes.dart';
import 'package:sikoopi_app/miscellaneous/functions/global_route.dart';
import 'package:sikoopi_app/miscellaneous/variables/global_string.dart';
import 'package:sikoopi_app/screen/product_form_screen.dart';
import 'package:sikoopi_app/services/local_db.dart';
import 'package:sikoopi_app/widgets/specific/product_screen_widgets/product_item.dart';
import 'package:sikoopi_app/widgets/specific/product_screen_widgets/product_screen_header.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {

  List<ProductClasses> productList = [];

  @override
  void initState() {
    super.initState();

    initLoad();
  }

  void initLoad() async {
    await LocalDB().readAllProduct().then((product) {
      setState(() {
        productList = product;
      });
    });
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
                        product: productList[index],
                        onPressed: () {
                          GlobalRoute(context: context).moveTo(ProductFormScreen(product: productList[index]), (callback) {
                            if(callback != null && callback) {
                              initLoad();
                            }
                          });
                        },
                      );
                    },
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