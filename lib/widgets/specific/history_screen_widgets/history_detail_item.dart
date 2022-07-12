import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sikoopi_app/services/api/transaction_services.dart';
import 'package:sikoopi_app/widgets/global_padding.dart';
import 'package:sikoopi_app/widgets/global_text.dart';

class HistoryDetailItem extends StatelessWidget {
  final TransactionDetailResponseData transactionItem;

  const HistoryDetailItem({
    Key? key,
    required this.transactionItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
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
              transactionItem.productImage ?? '',
              fit: BoxFit.contain,
            ),
          ),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GlobalText(
                content: transactionItem.productName ?? 'Unknown Name',
                size: 18.0,
                isBold: true,
                align: TextAlign.center,
              ),
              GlobalText(
                content: transactionItem.productUom ?? 'Unknown UOM',
                size: 16.0,
                align: TextAlign.center,
              ),
              GlobalText(
                content: "Rp.${NumberFormat('#,###', 'en_ID').format(int.parse(transactionItem.productPrice!)).replaceAll(',', '.')},-",
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
                      content: 'Qty: ${transactionItem.productQty!}',
                      size: 16.0,
                      align: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: GlobalText(
                      content: transactionItem.productQty != null && transactionItem.productPrice != null ? "Rp.${NumberFormat('#,###', 'en_ID').format(int.parse(transactionItem.productQty!) * int.parse(transactionItem.productPrice!)).replaceAll(',', '.')},-" : 'Unknown Total',
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
    );
  }
}