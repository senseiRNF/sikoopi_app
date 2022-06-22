import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sikoopi_app/miscellaneous/data_classes/product_classes.dart';
import 'package:sikoopi_app/widgets/global_button.dart';
import 'package:sikoopi_app/widgets/global_padding.dart';
import 'package:sikoopi_app/widgets/global_text.dart';

class ProductDisplayItem extends StatelessWidget {
  final ProductClasses productList;
  final Function onPressed;
  
  const ProductDisplayItem({
    Key? key,
    required this.productList,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10.0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0,)
      ),
      child: GlobalPadding(
        paddingClass: const GlobalPaddingClass(
          paddingLeft: 10.0,
          paddingTop: 5.0,
          paddingRight: 10.0,
          paddingBottom: 5.0,
        ),
        content: Column(
          children: [
            Expanded(
              child: Image.asset(
                productList.imagePath ?? '',
                fit: BoxFit.contain,
              ),
            ),
            GlobalText(
              content: productList.name ?? 'Unknown',
              size: 16.0,
              isBold: true,
              align: TextAlign.center,
            ),
            GlobalText(
              content: productList.uom ?? 'Unknown',
              align: TextAlign.center,
            ),
            GlobalText(
              content: "Rp.${NumberFormat('#,###', 'en_ID').format(productList.price ?? 0).replaceAll(',', '.')},-",
              align: TextAlign.center,
              padding: const GlobalPaddingClass(
                paddingBottom: 10.0,
              ),
            ),
            GlobalTextButton(
              onPressed: () => onPressed(),
              title: 'Add to Cart',
            ),
          ],
        ),
      ),
    );
  }
}