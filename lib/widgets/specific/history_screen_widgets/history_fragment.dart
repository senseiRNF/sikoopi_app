import 'package:flutter/material.dart';
import 'package:sikoopi_app/miscellaneous/data_classes/history_classes.dart';
import 'package:sikoopi_app/miscellaneous/variables/global_color.dart';
import 'package:sikoopi_app/widgets/global_padding.dart';
import 'package:sikoopi_app/widgets/global_text.dart';
import 'package:sikoopi_app/widgets/specific/history_screen_widgets/history_item.dart';

class HistoryFragment extends StatelessWidget {
  final List<HistoryClasses> historyList;
  final Function onPressed;

  const HistoryFragment({
    Key? key,
    required this.historyList,
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
      content: historyList.isNotEmpty ?
      ListView.builder(
        itemCount: historyList.length,
        itemBuilder: (BuildContext listContext, int index) {
          return HistoryItem(
            historyItem: historyList[index],
            onPressed: (HistoryClasses historyItem) => onPressed(historyItem),
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
    );
  }
}