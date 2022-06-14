import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sikoopi_app/miscellaneous/data_classes/order_classes.dart';
import 'package:sikoopi_app/widgets/global_padding.dart';
import 'package:sikoopi_app/widgets/global_text.dart';

class DetailOrderItem extends StatelessWidget {
  final DetailActiveOrderClass orderItem;

  const DetailOrderItem({
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
            width: 80.0,
            height: 80.0,
            child: GlobalPadding(
              paddingClass: const GlobalPaddingClass(
                paddingLeft: 10.0,
                paddingTop: 10.0,
                paddingRight: 10.0,
                paddingBottom: 10.0,
              ),
              content: Image.asset(
                orderItem.imgPath,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Expanded(
            child: GlobalPadding(
              paddingClass: const GlobalPaddingClass(
                paddingTop: 10.0,
                paddingBottom: 10.0,
              ),
              content: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GlobalText(
                    content: orderItem.productName,
                    size: 16.0,
                    isBold: true,
                    align: TextAlign.center,
                  ),
                  GlobalText(
                    content: orderItem.productUOM,
                    align: TextAlign.center,
                  ),
                  GlobalText(
                    content: "Rp.${NumberFormat('#,###', 'en_ID').format(orderItem.productPrice).replaceAll(',', '.')},-",
                    align: TextAlign.center,
                    padding: const GlobalPaddingClass(
                      paddingBottom: 10.0,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: GlobalText(
                          content: 'Qty: ${orderItem.qty}',
                          size: 14.0,
                          align: TextAlign.center,
                        ),
                      ),
                      Expanded(
                        child: GlobalText(
                          content: "Rp.${NumberFormat('#,###', 'en_ID').format(orderItem.qty * orderItem.productPrice).replaceAll(',', '.')},-",
                          size: 14.0,
                          align: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}