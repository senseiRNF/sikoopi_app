import 'package:flutter/material.dart';
import 'package:sikoopi_app/miscellaneous/data_classes/cart_classes.dart';
import 'package:sikoopi_app/miscellaneous/data_classes/active_order_classes.dart';
import 'package:sikoopi_app/miscellaneous/variables/global_color.dart';
import 'package:sikoopi_app/widgets/global_text.dart';
import 'package:sikoopi_app/widgets/specific/home_screen_widgets/product_display_item.dart';

class UserHomeFragment extends StatelessWidget {
  final List<CartClasses> productDisplayList;
  final Function onPressed;

  const UserHomeFragment({
    Key? key,
    required this.productDisplayList,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: GlobalColor.defaultWhite,
      ),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: productDisplayList.length,
        itemBuilder: (BuildContext gridContext, int index) {
          return ProductDisplayItem(
            orderList: productDisplayList[index],
            onPressed: () => onPressed(productDisplayList[index]),
          );
        },
      ),
    );
  }
}

class AdminHomeFragment extends StatelessWidget {
  final List<ActiveOrderClasses> activeOrder;

  const AdminHomeFragment({
    Key? key,
    required this.activeOrder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: GlobalColor.defaultWhite,
      ),
      child: activeOrder.isNotEmpty ?
      ListView.builder(
        itemCount: activeOrder.length,
        itemBuilder: (BuildContext gridContext, int index) {
          return ListTile(
            title: GlobalText(
              content: activeOrder[index].orderCode,
            ),
          );
        },
      ) : Center(
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