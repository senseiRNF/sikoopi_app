import 'package:flutter/material.dart';
import 'package:sikoopi_app/miscellaneous/data_classes/history_classes.dart';
import 'package:sikoopi_app/widgets/global_padding.dart';
import 'package:sikoopi_app/widgets/global_text.dart';

class HistoryItem extends StatelessWidget {
  final HistoryClasses historyItem;
  final Function? onPressed;
  
  const HistoryItem({
    Key? key, 
    required this.historyItem,
    this.onPressed,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0,),
      ),
      child: InkWell(
        onTap: onPressed != null ? () => onPressed!(historyItem) : () {},
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0,),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GlobalText(
              content: historyItem.orderDate,
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
              content: 'Receipent: ${historyItem.receiverName}',
              size: 16.0,
              align: TextAlign.start,
              padding: const GlobalPaddingClass(
                paddingLeft: 10.0,
                paddingRight: 10.0,
              ),
            ),
            GlobalText(
              content: 'Address: ${historyItem.address}',
              size: 16.0,
              align: TextAlign.start,
              padding: const GlobalPaddingClass(
                paddingLeft: 10.0,
                paddingTop: 10.0,
                paddingRight: 10.0,
                paddingBottom: 10.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}