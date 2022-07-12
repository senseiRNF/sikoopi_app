import 'package:flutter/material.dart';
import 'package:sikoopi_app/miscellaneous/functions/global_dialog.dart';
import 'package:sikoopi_app/miscellaneous/functions/global_route.dart';
import 'package:sikoopi_app/miscellaneous/variables/global_string.dart';
import 'package:sikoopi_app/screen/opname_list_screen.dart';
import 'package:sikoopi_app/screen/product_form_screen.dart';
import 'package:sikoopi_app/services/api/product_services.dart';
import 'package:sikoopi_app/widgets/specific/product_screen_widgets/product_item.dart';
import 'package:sikoopi_app/widgets/specific/product_screen_widgets/product_screen_header.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {

  List<ProductResponseData> productList = [];

  @override
  void initState() {
    super.initState();

    initLoad();
  }

  void initLoad() async {
    await ProductServices().readAllProduct().then((dioResult) {
      List<ProductResponseData> listTemp = [];

      if(dioResult != null && dioResult.data != null) {
        for(int i = 0; i < dioResult.data!.length; i++) {
          listTemp.add(dioResult.data![i]);
        }
      }

      setState(() {
        productList = listTemp;
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
                          GlobalDialog(context: context, message: 'Select Menu').listProductMenu([
                            'Edit Product',
                            'See Opname History',
                          ], (selection) {
                            if(selection != null) {
                              if(selection == 'Edit Product') {
                                GlobalRoute(context: context).moveTo(ProductFormScreen(product: productList[index]), (callback) {
                                  if(callback != null && callback) {
                                    initLoad();
                                  }
                                });
                              } else {
                                GlobalRoute(context: context).moveTo(OpnameListScreen(productId: int.parse(productList[index].id!)), (callback) {

                                });
                              }
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