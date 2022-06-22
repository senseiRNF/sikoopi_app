import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sikoopi_app/miscellaneous/data_classes/cart_classes.dart';
import 'package:sikoopi_app/miscellaneous/data_classes/transaction_classes.dart';
import 'package:sikoopi_app/miscellaneous/variables/global_color.dart';
import 'package:sikoopi_app/widgets/global_padding.dart';
import 'package:sikoopi_app/widgets/global_text.dart';
import 'package:sikoopi_app/widgets/specific/history_screen_widgets/history_detail_item.dart';

class HistoryDetailFragment extends StatelessWidget {
  final TransactionClasses transaction;
  final List<CartClasses> detailTransaction;
  final Function? onPressed;

  const HistoryDetailFragment({
    Key? key,
    required this.transaction,
    required this.detailTransaction,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GlobalPadding(
      paddingClass: const GlobalPaddingClass(
        paddingLeft: 10.0,
        paddingTop: 10.0,
        paddingRight: 10.0,
        paddingBottom: 10.0,
      ),
      content: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0,),
        ),
        child: InkWell(
          onTap: onPressed != null ? () => onPressed!() : () {},
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0,),
          ),
          child: ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              GlobalText(
                content: transaction.date != null ? DateFormat('dd-MM-yyyy').format(transaction.date!) : 'Unknown Date',
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
                content: transaction.status != null ? transaction.status!.replaceFirst(transaction.status!.substring(0, 1), transaction.status!.substring(0, 1).toUpperCase()) : 'Unknown Status',
                size: 16.0,
                color: transaction.status != null ? transaction.status! == 'waiting' ? GlobalColor.defaultBlue : GlobalColor.defaultGreen : GlobalColor.defaultRed,
                align: TextAlign.start,
                padding: const GlobalPaddingClass(
                  paddingLeft: 10.0,
                  paddingRight: 10.0,
                  paddingBottom: 10.0,
                ),
              ),
              GlobalText(
                content: 'Buyer: ${transaction.username ?? "Unknown Buyer"}',
                size: 16.0,
                align: TextAlign.start,
                padding: const GlobalPaddingClass(
                  paddingLeft: 10.0,
                  paddingRight: 10.0,
                  paddingBottom: 10.0,
                ),
              ),
              GlobalText(
                content: 'Rp.${NumberFormat('#,###', 'en_ID').format(transaction.total).replaceAll(',', '.')}',
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
              detailTransaction.isNotEmpty ?
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: detailTransaction.length,
                itemBuilder: (BuildContext listContext, int index) {
                  return HistoryDetailItem(
                    transactionItem: detailTransaction[index],
                  );
                },
              ) :
              Center(
                child: GlobalText(
                  content: "There's no order history...",
                  size: 30.0,
                  color: GlobalColor.defaultWhite,
                  isBold: true,
                  align: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Icon(
                Icons.expand_less,
                size: 20.0,
              ),
              const SizedBox(
                height: 10.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}