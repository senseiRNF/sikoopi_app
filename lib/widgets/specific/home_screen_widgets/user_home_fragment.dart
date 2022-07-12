import 'package:flutter/material.dart';
import 'package:sikoopi_app/miscellaneous/variables/global_color.dart';
import 'package:sikoopi_app/services/api/product_services.dart';
import 'package:sikoopi_app/widgets/specific/home_screen_widgets/product_display_item.dart';

class UserHomeFragment extends StatelessWidget {
  final List<ProductResponseData> productDisplayList;
  final Function onPressed;
  final TextEditingController categoryController;
  final Function categoryPressed;

  const UserHomeFragment({
    Key? key,
    required this.productDisplayList,
    required this.onPressed,
    required this.categoryController,
    required this.categoryPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: GlobalColor.defaultWhite,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0,),
            child: TextField(
              onTap: () => categoryPressed(),
              readOnly: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                label: const Text(
                  'Category',
                ),
                suffixIcon: const Icon(
                  Icons.expand_more,
                )
              ),
              controller: categoryController,
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: productDisplayList.length,
              itemBuilder: (BuildContext gridContext, int index) {
                if(index == 0) {
                  return TopSellerProductDisplayItem(
                    product: productDisplayList[index],
                    onPressed: () => onPressed(productDisplayList[index]),
                  );
                } else {
                  return ProductDisplayItem(
                    product: productDisplayList[index],
                    onPressed: () => onPressed(productDisplayList[index]),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}