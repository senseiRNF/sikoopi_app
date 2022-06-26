import 'package:flutter/material.dart';
import 'package:sikoopi_app/miscellaneous/data_classes/product_classes.dart';
import 'package:sikoopi_app/miscellaneous/functions/global_dialog.dart';
import 'package:sikoopi_app/miscellaneous/functions/global_route.dart';
import 'package:sikoopi_app/miscellaneous/variables/global_string.dart';
import 'package:sikoopi_app/services/local_db.dart';
import 'package:sikoopi_app/widgets/global_button.dart';
import 'package:sikoopi_app/widgets/global_input_field.dart';
import 'package:sikoopi_app/widgets/global_padding.dart';
import 'package:sikoopi_app/widgets/specific/product_screen_widgets/product_screen_header.dart';

class ProductFormScreen extends StatefulWidget {
  final ProductClasses product;

  const ProductFormScreen({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<ProductFormScreen> createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  TextEditingController nameTEC = TextEditingController();
  TextEditingController uomTEC = TextEditingController();
  TextEditingController priceTEC = TextEditingController();
  TextEditingController stockTEC = TextEditingController();

  @override
  void initState() {
    super.initState();

    setState(() {
      nameTEC.text = widget.product.name ?? 'Unknown Name';
      uomTEC.text = widget.product.uom ?? 'Unknown Name';
      priceTEC.text = widget.product.price != null ? widget.product.price!.toString() : '0';
      stockTEC.text = widget.product.stock != null ? widget.product.stock!.toString() : '0';
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
                  child: Card(
                    child: ListView(
                      children: [
                        SizedBox(
                          height: 150.0,
                          child: Image.asset(
                            widget.product.imagePath ?? '',
                            fit: BoxFit.contain,
                          ),
                        ),
                        GlobalTextfield(
                          controller: nameTEC,
                          title: 'Product Name',
                          padding: const GlobalPaddingClass(
                            paddingLeft: 20.0,
                            paddingRight: 20.0,
                          ),
                        ),
                        GlobalTextfield(
                          controller: uomTEC,
                          title: 'Product UOM',
                          padding: const GlobalPaddingClass(
                            paddingLeft: 20.0,
                            paddingRight: 20.0,
                          ),
                        ),
                        GlobalTextfield(
                          controller: priceTEC,
                          title: 'Product Price',
                          inputType: TextInputType.number,
                          padding: const GlobalPaddingClass(
                            paddingLeft: 20.0,
                            paddingRight: 20.0,
                          ),
                        ),
                        GlobalTextfield(
                          controller: stockTEC,
                          title: 'Product Stock',
                          inputType: TextInputType.number,
                          padding: const GlobalPaddingClass(
                            paddingLeft: 20.0,
                            paddingRight: 20.0,
                            paddingBottom: 10.0,
                          ),
                        ),
                        GlobalElevatedButton(
                          title: 'Save Product Data',
                          onPressed: () async {
                            await LocalDB().updateProduct(
                              ProductClasses(
                                name: nameTEC.text,
                                uom: uomTEC.text,
                                price: priceTEC.text != '' ? int.parse(priceTEC.text) : 0,
                                stock: stockTEC.text != '' ? int.parse(stockTEC.text) : 0,
                                id: widget.product.id,
                              ),
                            ).then((result) {
                              if(result) {
                                GlobalRoute(context: context).back(true);
                              } else {
                                GlobalDialog(context: context, message: 'Failed to update data, please try again').okDialog(() {

                                });
                              }
                            });
                          },
                          padding: const GlobalPaddingClass(
                            paddingLeft: 20.0,
                            paddingRight: 20.0,
                          ),
                        ),
                      ],
                    ),
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