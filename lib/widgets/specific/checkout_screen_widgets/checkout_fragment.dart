import 'package:flutter/material.dart';
import 'package:sikoopi_app/miscellaneous/data_classes/cart_classes.dart';
import 'package:sikoopi_app/miscellaneous/variables/global_color.dart';
import 'package:sikoopi_app/widgets/global_padding.dart';
import 'package:sikoopi_app/widgets/global_text.dart';
import 'package:sikoopi_app/widgets/specific/checkout_screen_widgets/checkout_item.dart';

class CheckoutFragment extends StatelessWidget {
  final List<CartClasses> orderList;

  const CheckoutFragment({
    Key? key,
    required this.orderList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GlobalPadding(
      paddingClass: const GlobalPaddingClass(
        paddingLeft: 10.0,
        paddingTop: 10.0,
        paddingRight: 10.0,
        paddingBottom: 10.0,
      ),
      content: orderList.isNotEmpty ?
      ListView.builder(
        itemCount: orderList.length,
        itemBuilder: (BuildContext listContext, int index) {
          return CheckoutItem(
            orderItem: orderList[index],
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
    );
  }
}