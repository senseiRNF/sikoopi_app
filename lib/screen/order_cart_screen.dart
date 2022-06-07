import 'package:flutter/material.dart';
import 'package:sikoopi_app/miscellaneous/data_classes/cart_classes.dart';
import 'package:sikoopi_app/miscellaneous/variables/global_color.dart';
import 'package:sikoopi_app/miscellaneous/variables/global_string.dart';
import 'package:sikoopi_app/widgets/global_button.dart';
import 'package:sikoopi_app/widgets/global_padding.dart';
import 'package:sikoopi_app/widgets/global_text.dart';
import 'package:sikoopi_app/widgets/specific/order_cart_screen_widgets/order_cart_screen_header.dart';

class OrderCartScreen extends StatefulWidget {
  final List<CartClasses> cartClassesList;

  const OrderCartScreen({
    Key? key,
    required this.cartClassesList,
  }) : super(key: key);

  @override
  _OrderCartScreen createState() => _OrderCartScreen();
}

class _OrderCartScreen extends State<OrderCartScreen> {
  List<CartClasses> orderList = [];

  @override
  void initState() {
    super.initState();

    for(int i = 0; i < widget.cartClassesList.length; i++) {
      if(widget.cartClassesList[i].totalQty > 0) {
        setState(() {
          orderList.add(widget.cartClassesList[i]);
        });
      }
    }
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
                const OrderCartScreenHeader(),
                Expanded(
                  child: orderList.isNotEmpty ?
                  ListView.builder(
                    itemCount: orderList.length,
                    itemBuilder: (BuildContext listContext, int index) {
                      return Card(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 6,
                              child: Image.asset(
                                orderList[index].imagePath,
                              ),
                            ),
                            Expanded(
                              child: GlobalText(
                                content: 'Qty: ${orderList[index].totalQty}',
                                size: 20.0,
                                align: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ) :
                  Center(
                    child: GlobalText(
                      content: "There's no order...",
                      size: 30.0,
                      color: GlobalColor.defaultWhite,
                      isBold: true,
                      align: TextAlign.center,
                    ),
                  ),
                ),
                orderList.isNotEmpty ?
                GlobalElevatedButton(
                  onPressed: () {

                  },
                  title: 'Complete Order',
                  btnColor: GlobalColor.accentColor,
                  padding: const GlobalPaddingClass(
                    paddingLeft: 50.0,
                    paddingRight: 50.0,
                  ),
                ) :
                const Material(),
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