import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sikoopi_app/miscellaneous/functions/global_route.dart';
import 'package:sikoopi_app/miscellaneous/variables/global_color.dart';
import 'package:sikoopi_app/screen/detail_order_screen.dart';
import 'package:sikoopi_app/services/api/transaction_services.dart';
import 'package:sikoopi_app/widgets/global_padding.dart';
import 'package:sikoopi_app/widgets/global_text.dart';

class AdminHomeFragment extends StatelessWidget {
  final List<TransactionResponseData> activeOrder;
  final Function onRefresh;

  const AdminHomeFragment({
    Key? key,
    required this.activeOrder,
    required this.onRefresh,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return activeOrder.isNotEmpty ?
    ListView.builder(
      itemCount: activeOrder.length,
      itemBuilder: (BuildContext gridContext, int index) {
        return Card(
          elevation: 10.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0,),
          ),
          child: InkWell(
            onTap: () {
              if(activeOrder[index].id != null) {
                GlobalRoute(context: context).moveTo(DetailOrderScreen(transaction: activeOrder[index]), (callback) {
                  if(callback != null && callback) {
                    onRefresh();
                  }
                });
              }
            },
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0,),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GlobalText(
                      content: activeOrder[index].username ?? 'Unknown User',
                      size: 18.0,
                      align: TextAlign.start,
                      padding: const GlobalPaddingClass(
                        paddingLeft: 20.0,
                        paddingTop: 20.0,
                        paddingRight: 20.0,
                      ),
                    ),
                    GlobalText(
                      content: activeOrder[index].status ?? 'Unknown Status',
                      size: 18.0,
                      color: activeOrder[index].status != null ? activeOrder[index].status == 'Waiting' ? GlobalColor.defaultBlue : GlobalColor.defaultGreen : GlobalColor.defaultRed,
                      align: TextAlign.start,
                      padding: const GlobalPaddingClass(
                        paddingLeft: 20.0,
                        paddingTop: 20.0,
                        paddingRight: 20.0,
                      ),
                    ),
                  ],
                ),
                GlobalText(
                  content: activeOrder[index].date != null ? DateFormat('dd MMMM yyyy').format(DateTime.parse(activeOrder[index].date!)) : '-',
                  size: 16.0,
                  align: TextAlign.start,
                  padding: const GlobalPaddingClass(
                    paddingLeft: 20.0,
                    paddingTop: 10.0,
                    paddingRight: 20.0,
                  ),
                ),
                GlobalPadding(
                  paddingClass: const GlobalPaddingClass(
                    paddingLeft: 20.0,
                    paddingTop: 20.0,
                    paddingRight: 20.0,
                    paddingBottom: 20.0,
                  ),
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GlobalText(
                        content: "Rp. ${NumberFormat('#,###', 'en_ID').format(int.parse(activeOrder[index].total!)).replaceAll(',', '.')}",
                        size: 16.0,
                        color: GlobalColor.defaultBlue,
                        isBold: true,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ) :
    const Center(
      child: GlobalText(
        content: "There's no new order...",
        size: 30.0,
        isBold: true,
        align: TextAlign.center,
      ),
    );
  }
}