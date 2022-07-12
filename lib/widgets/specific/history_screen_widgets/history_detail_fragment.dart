import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sikoopi_app/miscellaneous/variables/global_color.dart';
import 'package:sikoopi_app/services/api/transaction_services.dart';
import 'package:sikoopi_app/widgets/global_padding.dart';
import 'package:sikoopi_app/widgets/global_text.dart';
import 'package:sikoopi_app/widgets/specific/history_screen_widgets/history_detail_item.dart';

class HistoryDetailFragment extends StatelessWidget {
  final TransactionResponseData transaction;
  final List<TransactionDetailResponseData> detailTransaction;
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
                content: transaction.date != null ? DateFormat('dd-MM-yyyy').format(DateTime.parse(transaction.date!)) : 'Unknown Date',
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
                content: transaction.status ?? 'Unknown Status',
                size: 16.0,
                color: transaction.status != null ? transaction.status! == 'Waiting' ? GlobalColor.defaultBlue : GlobalColor.defaultGreen : GlobalColor.defaultRed,
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
                ),
              ),
              GlobalText(
                content: 'Payment: ${transaction.payment ?? "Unknown Payment"}',
                size: 16.0,
                align: TextAlign.start,
                padding: const GlobalPaddingClass(
                  paddingLeft: 10.0,
                  paddingRight: 10.0,
                  paddingBottom: 10.0,
                ),
              ),
              transaction.payment != null && transaction.payment == 'Transfer' && transaction.receipent != null ?
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  GlobalText(
                    content: 'Receipent: ${transaction.receipent ?? "Unknown Receipent"}',
                    size: 16.0,
                    align: TextAlign.start,
                    padding: const GlobalPaddingClass(
                      paddingLeft: 10.0,
                      paddingRight: 10.0,
                    ),
                  ),
                  GlobalText(
                    content: 'Address: ${transaction.address ?? "Unknown Address"}',
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
                content: 'Rp.${NumberFormat('#,###', 'en_ID').format(int.parse(transaction.total!)).replaceAll(',', '.')}',
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
              transaction.payment != null && transaction.payment == 'Transfer' && transaction.transferReceiptImage != null ?
              Center(
                child: InkWell(
                  onTap: () {
                    showBottomSheet(
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0,),
                          topRight: Radius.circular(20.0,),
                        ),
                      ),
                      builder: (BuildContext imgContext) {
                        return GlobalPadding(
                          paddingClass: const GlobalPaddingClass(
                            paddingLeft: 30.0,
                            paddingTop: 30.0,
                            paddingRight: 30.0,
                            paddingBottom: 30.0,
                          ),
                          content: Image.file(
                            File(transaction.transferReceiptImage!.substring(8)),
                            fit: BoxFit.contain,
                          ),
                        );
                      },
                    );
                  },
                  customBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0,),
                  ),
                  child: GlobalPadding(
                    paddingClass: const GlobalPaddingClass(
                      paddingLeft: 10.0,
                      paddingTop: 10.0,
                      paddingRight: 10.0,
                      paddingBottom: 10.0,
                    ),
                    content: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.image,
                          color: GlobalColor.defaultBlue,
                        ),
                        GlobalText(
                          content: 'See Transfer Receipt',
                          color: GlobalColor.defaultBlue,
                          padding: const GlobalPaddingClass(
                            paddingLeft: 20.0,
                            paddingRight: 20.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ) :
              const Material(),
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