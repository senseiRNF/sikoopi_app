import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sikoopi_app/miscellaneous/data_classes/cart_classes.dart';
import 'package:sikoopi_app/miscellaneous/variables/global_color.dart';
import 'package:sikoopi_app/widgets/global_padding.dart';
import 'package:sikoopi_app/widgets/global_text.dart';

class ProductItem extends StatelessWidget {
  final CartClasses orderList;
  final Function onPressed;

  const ProductItem({
    Key? key,
    required this.orderList,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10.0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0,)
      ),
      child: InkWell(
        onTap: () {

        },
        customBorder: RoundedRectangleBorder(
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
                  orderList.imagePath ?? '',
                  fit: BoxFit.contain,
                ),
              ),
              GlobalText(
                content: orderList.name ?? 'Unkonwn Name',
                size: 16.0,
                isBold: true,
                align: TextAlign.center,
              ),
              GlobalText(
                content: orderList.uom ?? 'Unknown UOM',
                align: TextAlign.center,
              ),
              GlobalText(
                content: "Rp.${NumberFormat('#,###', 'en_ID').format(orderList.price).replaceAll(',', '.')},-",
                align: TextAlign.center,
                padding: const GlobalPaddingClass(
                  paddingBottom: 10.0,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Icon(
                      Icons.delete_forever,
                      color: GlobalColor.defaultRed,
                    ),
                  ),
                  const Expanded(
                    child: Icon(
                      Icons.edit,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}