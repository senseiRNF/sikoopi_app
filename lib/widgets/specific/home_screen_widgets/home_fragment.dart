import 'package:flutter/material.dart';
import 'package:sikoopi_app/miscellaneous/data_classes/cart_classes.dart';
import 'package:sikoopi_app/miscellaneous/variables/global_color.dart';
import 'package:sikoopi_app/widgets/specific/home_screen_widgets/product_display_item.dart';

class HomeFragment extends StatelessWidget {
  final List<CartClasses> productDisplayList;
  final Function onPressed;

  const HomeFragment({
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