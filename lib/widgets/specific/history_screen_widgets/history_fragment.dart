import 'package:flutter/material.dart';
import 'package:sikoopi_app/miscellaneous/data_classes/transaction_classes.dart';
import 'package:sikoopi_app/widgets/global_padding.dart';
import 'package:sikoopi_app/widgets/specific/history_screen_widgets/history_item.dart';

class HistoryFragment extends StatelessWidget {
  final List<TransactionClasses> transactionList;
  final Function onPressed;

  const HistoryFragment({
    Key? key,
    required this.transactionList,
    required this.onPressed,
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
      content: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: transactionList.length,
        itemBuilder: (BuildContext listContext, int index) {
          return HistoryItem(
            transactionItem: transactionList[index],
            onPressed: (TransactionClasses? transactionItem) {
              onPressed(transactionItem);
            },
          );
        },
      ),
    );
  }
}