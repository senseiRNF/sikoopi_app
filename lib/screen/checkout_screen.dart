import 'package:flutter/material.dart';
import 'package:sikoopi_app/miscellaneous/data_classes/cart_classes.dart';
import 'package:sikoopi_app/miscellaneous/functions/global_route.dart';
import 'package:sikoopi_app/miscellaneous/variables/global_color.dart';
import 'package:sikoopi_app/miscellaneous/variables/global_string.dart';
import 'package:sikoopi_app/widgets/global_button.dart';
import 'package:sikoopi_app/widgets/global_padding.dart';
import 'package:sikoopi_app/widgets/global_text.dart';
import 'package:sikoopi_app/widgets/specific/checkout_screen_widgets/checkout_delivery_fragment.dart';
import 'package:sikoopi_app/widgets/specific/checkout_screen_widgets/checkout_fragment.dart';
import 'package:sikoopi_app/widgets/specific/checkout_screen_widgets/checkout_payment_fragment.dart';
import 'package:sikoopi_app/widgets/specific/checkout_screen_widgets/checkout_screen_header.dart';

class CheckoutScreen extends StatefulWidget {
  final List<CartClasses> orderList;

  const CheckoutScreen({
    Key? key,
    required this.orderList,
  }) : super(key: key);

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int stage = 0;

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
                CheckoutPaymentScreenHeader(
                  stage: stage,
                ),
                Expanded(
                  child: stage == 0 ?
                  CheckoutFragment(
                    orderList: widget.orderList,
                  ) :
                  stage == 1 ? const CheckoutPaymentFragment() :
                  const CheckoutDeliveryFragment(),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GlobalText(
                      content: 'Total',
                      size: 20.0,
                      color: GlobalColor.defaultWhite,
                      padding: const GlobalPaddingClass(
                        paddingLeft: 30.0,
                        paddingBottom: 10.0,
                      ),
                    ),
                    Expanded(
                      child: GlobalText(
                        content: 'Rp.0,-',
                        size: 20.0,
                        color: GlobalColor.defaultWhite,
                        align: TextAlign.end,
                        padding: const GlobalPaddingClass(
                          paddingRight: 30.0,
                          paddingBottom: 10.0,
                        ),
                      ),
                    ),
                  ],
                ),
                GlobalElevatedButton(
                  onPressed: () {
                    if(stage >= 0 && stage < 2) {
                      setState(() {
                        stage = stage + 1;
                      });
                    } else {
                      GlobalRoute(context: context).back(null);
                    }
                  },
                  title: stage == 0 ? 'Proceed to Payment' : stage == 1 ? 'Proceed to Delivery' : 'Complete Payment',
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