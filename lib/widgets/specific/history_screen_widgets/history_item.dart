import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sikoopi_app/miscellaneous/data_classes/transaction_classes.dart';
import 'package:sikoopi_app/miscellaneous/variables/global_color.dart';
import 'package:sikoopi_app/widgets/global_padding.dart';
import 'package:sikoopi_app/widgets/global_text.dart';

class HistoryItem extends StatelessWidget {
  final TransactionClasses transactionItem;
  final Function? onPressed;
  
  const HistoryItem({
    Key? key, 
    required this.transactionItem,
    this.onPressed,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0,),
      ),
      child: InkWell(
        onTap: onPressed != null ? () => onPressed!(transactionItem) : () {},
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0,),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GlobalText(
              content: transactionItem.date != null ? DateFormat('dd-MM-yyyy').format(transactionItem.date!) : 'Unknown Date',
              size: 18.0,
              isBold: true,
              align: TextAlign.center,
              padding: const GlobalPaddingClass(
                paddingLeft: 10.0,
                paddingTop: 10.0,
                paddingRight: 10.0,
                paddingBottom: 10.0,
              ),
            ),
            GlobalText(
              content: transactionItem.status ?? 'Unknown Status',
              size: 16.0,
              color: transactionItem.status != null ? transactionItem.status! == 'Waiting' ? GlobalColor.defaultBlue : GlobalColor.defaultGreen : GlobalColor.defaultRed,
              align: TextAlign.start,
              padding: const GlobalPaddingClass(
                paddingLeft: 10.0,
                paddingRight: 10.0,
                paddingBottom: 10.0,
              ),
            ),
            GlobalText(
              content: 'Buyer: ${transactionItem.username ?? "Unknown Buyer"}',
              size: 16.0,
              align: TextAlign.start,
              padding: const GlobalPaddingClass(
                paddingLeft: 10.0,
                paddingRight: 10.0,
                paddingBottom: 10.0,
              ),
            ),
            transactionItem.payment != null && transactionItem.payment == 'transfer' && transactionItem.receipent != null ?
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                GlobalText(
                  content: 'Receipent: ${transactionItem.receipent ?? "Unknown Receipent"}',
                  size: 16.0,
                  align: TextAlign.start,
                  padding: const GlobalPaddingClass(
                    paddingLeft: 10.0,
                    paddingRight: 10.0,
                  ),
                ),
                GlobalText(
                  content: 'Address: ${transactionItem.address ?? "Unknown Address"}',
                  size: 16.0,
                  align: TextAlign.start,
                  padding: const GlobalPaddingClass(
                    paddingLeft: 10.0,
                    paddingRight: 10.0,
                    paddingBottom: 10.0,
                  ),
                ),
              ],
            ) :
            const Material(),
            GlobalText(
              content: 'Rp.${NumberFormat('#,###', 'en_ID').format(transactionItem.total).replaceAll(',', '.')}',
              size: 20.0,
              color: Colors.deepOrange,
              isBold: true,
              align: TextAlign.end,
              padding: const GlobalPaddingClass(
                paddingLeft: 10.0,
                paddingRight: 10.0,
                paddingBottom: 10.0,
              ),
            ),
            const Icon(
              Icons.expand_more,
              size: 20.0,
            ),
            const SizedBox(
              height: 10.0,
            ),
          ],
        ),
      ),
    );
  }
}