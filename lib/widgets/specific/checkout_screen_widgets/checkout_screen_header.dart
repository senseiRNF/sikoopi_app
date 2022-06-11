import 'package:flutter/material.dart';
import 'package:sikoopi_app/miscellaneous/variables/global_color.dart';
import 'package:sikoopi_app/miscellaneous/variables/global_string.dart';
import 'package:sikoopi_app/widgets/global_padding.dart';
import 'package:sikoopi_app/widgets/global_text.dart';

class CheckoutPaymentScreenHeader extends StatelessWidget {
  final int stage;
  final Function onBackPressed;

  const CheckoutPaymentScreenHeader({
    Key? key,
    required this.stage,
    required this.onBackPressed,
  }) : super(key: key);

  Widget initTitle() {
    switch(stage) {
      case 1:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GlobalText(
              content: 'Payment',
              size: 42.0,
              color: GlobalColor.defaultWhite,
              isBold: true,
              align: TextAlign.center,
            ),
            GlobalPadding(
              paddingClass: const GlobalPaddingClass(
                paddingLeft: 30.0,
                paddingTop: 20.0,
                paddingRight: 30.0,
              ),
              content: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GlobalText(
                    content: 'Payment Method',
                    size: 16.0,
                    color: GlobalColor.defaultWhite,
                    padding: const GlobalPaddingClass(
                      paddingRight: 10.0,
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: GlobalColor.defaultWhite,
                      thickness: 1.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      case 2:
        return Column(
          children: [
            GlobalText(
              content: 'Delivery',
              size: 42.0,
              color: GlobalColor.defaultWhite,
              isBold: true,
              align: TextAlign.center,
            ),
            GlobalPadding(
              paddingClass: const GlobalPaddingClass(
                paddingLeft: 30.0,
                paddingTop: 20.0,
                paddingRight: 30.0,
              ),
              content: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GlobalText(
                    content: 'Address Details',
                    size: 16.0,
                    color: GlobalColor.defaultWhite,
                    padding: const GlobalPaddingClass(
                      paddingRight: 10.0,
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: GlobalColor.defaultWhite,
                      thickness: 1.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      case 3:
        return const Material();
      default:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GlobalPadding(
              paddingClass: const GlobalPaddingClass(
                paddingLeft: 30.0,
                paddingTop: 20.0,
                paddingRight: 30.0,
              ),
              content: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GlobalText(
                    content: 'Order List',
                    size: 16.0,
                    color: GlobalColor.defaultWhite,
                    padding: const GlobalPaddingClass(
                      paddingRight: 10.0,
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: GlobalColor.defaultWhite,
                      thickness: 1.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GlobalPadding(
      paddingClass: const GlobalPaddingClass(
        paddingTop: 20.0,
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GlobalPadding(
                paddingClass: const GlobalPaddingClass(
                  paddingLeft: 10.0,
                ),
                content: Material(
                  color: Colors.transparent,
                  child: IconButton(
                    onPressed: () {
                      onBackPressed();
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: GlobalColor.defaultWhite,
                      size: 34.0,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      '${GlobalString.assetImagePath}/bps_jateng_icon.png',
                      width: MediaQuery.of(context).size.width / 2,
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    Image.asset(
                      '${GlobalString.assetImagePath}/sikoopi_icon.png',
                      height: MediaQuery.of(context).size.height / 8,
                    ),
                  ],
                ),
              ),
            ],
          ),
          stage != 3 ?
          GlobalText(
            content: 'Checkout',
            size: 24.0,
            color: GlobalColor.defaultWhite,
            isBold: true,
            align: TextAlign.center,
          ) :
          GlobalText(
            content: 'Order Successful',
            size: 28.0,
            color: GlobalColor.defaultWhite,
            isBold: true,
            align: TextAlign.center,
            padding: const GlobalPaddingClass(
              paddingBottom: 30.0,
            ),
          ),
          initTitle(),
        ],
      ),
    );
  }
}