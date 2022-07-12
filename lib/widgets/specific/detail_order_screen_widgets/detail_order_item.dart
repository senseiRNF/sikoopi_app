import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sikoopi_app/services/api/transaction_services.dart';
import 'package:sikoopi_app/widgets/global_padding.dart';
import 'package:sikoopi_app/widgets/global_text.dart';

class DetailOrderItem extends StatelessWidget {
  final TransactionDetailResponseData orderItem;

  const DetailOrderItem({
    Key? key,
    required this.orderItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
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
                orderItem.productImage ?? '',
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
                    content: orderItem.productName ?? 'Unknown Name',
                    size: 16.0,
                    isBold: true,
                    align: TextAlign.center,
                  ),
                  GlobalText(
                    content: orderItem.productUom ?? 'Unknown UOM',
                    align: TextAlign.center,
                  ),
                  GlobalText(
                    content: "Rp.${NumberFormat('#,###', 'en_ID').format(int.parse(orderItem.productPrice!)).replaceAll(',', '.')},-",
                    align: TextAlign.center,
                    padding: const GlobalPaddingClass(
                      paddingBottom: 10.0,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: GlobalText(
                          content: 'Qty: ${orderItem.productQty}',
                          size: 14.0,
                          align: TextAlign.center,
                        ),
                      ),
                      Expanded(
                        child: GlobalText(
                          content: orderItem.productQty != null && orderItem.productPrice != null ? "Rp.${NumberFormat('#,###', 'en_ID').format(int.parse(orderItem.productQty!) * int.parse(orderItem.productPrice!)).replaceAll(',', '.')},-" : 'Unknown Total',
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