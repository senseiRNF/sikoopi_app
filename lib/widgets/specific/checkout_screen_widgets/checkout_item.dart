import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sikoopi_app/miscellaneous/data_classes/cart_classes.dart';
import 'package:sikoopi_app/widgets/global_padding.dart';
import 'package:sikoopi_app/widgets/global_text.dart';

class CheckoutItem extends StatelessWidget {
  final CartClasses orderItem;

  const CheckoutItem({
    Key? key,
    required this.orderItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0,),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 120.0,
            height: 120.0,
            child: GlobalPadding(
              paddingClass: const GlobalPaddingClass(
                paddingLeft: 10.0,
                paddingTop: 10.0,
                paddingRight: 10.0,
                paddingBottom: 10.0,
              ),
              content: Image.asset(
                orderItem.imagePath ?? '',
                fit: BoxFit.contain,
              ),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GlobalText(
                  content: orderItem.name ?? 'Unknown Name',
                  size: 18.0,
                  isBold: true,
                  align: TextAlign.center,
                ),
                GlobalText(
                  content: orderItem.uom ?? 'Unknown UOM',
                  size: 16.0,
                  align: TextAlign.center,
                ),
                GlobalText(
                  content: "Rp.${NumberFormat('#,###', 'en_ID').format(orderItem.price).replaceAll(',', '.')},-",
                  size: 16.0,
                  align: TextAlign.center,
                  padding: const GlobalPaddingClass(
                    paddingBottom: 10.0,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: GlobalText(
                        content: 'Qty: ${orderItem.totalQty}',
                        size: 16.0,
                        align: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      child: GlobalText(
                        content: orderItem.totalQty != null && orderItem.price != null ? "Rp.${NumberFormat('#,###', 'en_ID').format(orderItem.totalQty! * orderItem.price!).replaceAll(',', '.')},-" : 'Unknown Total',
                        size: 16.0,
                        align: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}