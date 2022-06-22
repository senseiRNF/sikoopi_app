import 'package:flutter/material.dart';
import 'package:sikoopi_app/miscellaneous/data_classes/cart_classes.dart';
import 'package:sikoopi_app/miscellaneous/functions/global_route.dart';
import 'package:sikoopi_app/miscellaneous/variables/global_color.dart';
import 'package:sikoopi_app/miscellaneous/variables/global_string.dart';
import 'package:sikoopi_app/screen/checkout_screen.dart';
import 'package:sikoopi_app/widgets/global_button.dart';
import 'package:sikoopi_app/widgets/global_padding.dart';
import 'package:sikoopi_app/widgets/global_text.dart';
import 'package:sikoopi_app/widgets/specific/order_cart_screen_widgets/order_cart_item.dart';
import 'package:sikoopi_app/widgets/specific/order_cart_screen_widgets/order_cart_screen_header.dart';

class OrderCartScreen extends StatefulWidget {
  final List<CartClasses> orderList;
  final Function onChangeQty;

  const OrderCartScreen({
    Key? key,
    required this.orderList,
    required this.onChangeQty,
  }) : super(key: key);

  @override
  _OrderCartScreen createState() => _OrderCartScreen();
}

class _OrderCartScreen extends State<OrderCartScreen> {
  List<CartClasses> orderList = [];

  @override
  void initState() {
    super.initState();

    for(int i = 0; i < widget.orderList.length; i++) {
      if(widget.orderList[i].totalQty != null && widget.orderList[i].totalQty! > 0) {
        setState(() {
          orderList.add(widget.orderList[i]);
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
                      return OrderCartItem(
                        orderList: orderList[index],
                        onChangeQty: (int qty) {
                          setState(() {
                            orderList[index].totalQty = qty;
                          });

                          widget.onChangeQty([index, qty]);

                          if(qty == 0) {
                            setState(() {
                              orderList.removeAt(index);
                            });
                          }
                        },
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
                    GlobalRoute(context: context).moveTo(CheckoutScreen(
                      orderList: orderList,
                    ), (List? callback) {
                      if(callback != null && callback.isNotEmpty && callback[0]) {
                        GlobalRoute(context: context).back([true, callback[1], callback[2], callback[3]]);
                      }
                    });
                  },
                  title: 'Complete Order',
                  btnColor: GlobalColor.accentColor,
                  padding: const GlobalPaddingClass(
                    paddingLeft: 50.0,
                    paddingTop: 10.0,
                    paddingRight: 50.0,
                    paddingBottom: 10.0,
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