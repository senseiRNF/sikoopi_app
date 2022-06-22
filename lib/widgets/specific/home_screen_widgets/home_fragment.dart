import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sikoopi_app/miscellaneous/data_classes/order_classes.dart';
import 'package:sikoopi_app/miscellaneous/data_classes/product_classes.dart';
import 'package:sikoopi_app/miscellaneous/functions/global_route.dart';
import 'package:sikoopi_app/miscellaneous/variables/global_color.dart';
import 'package:sikoopi_app/screen/detail_order_screen.dart';
import 'package:sikoopi_app/widgets/global_padding.dart';
import 'package:sikoopi_app/widgets/global_text.dart';
import 'package:sikoopi_app/widgets/specific/home_screen_widgets/product_display_item.dart';

class UserHomeFragment extends StatelessWidget {
  final List<ProductClasses> productDisplayList;
  final Function onPressed;

  const UserHomeFragment({
    Key? key,
    required this.productDisplayList,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: GlobalColor.defaultWhite,
      ),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: productDisplayList.length,
        itemBuilder: (BuildContext gridContext, int index) {
          return ProductDisplayItem(
            productList: productDisplayList[index],
            onPressed: () => onPressed(productDisplayList[index]),
          );
        },
      ),
    );
  }
}

class AdminHomeFragment extends StatelessWidget {
  final List<ActiveOrderClass> activeOrder;
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
              GlobalRoute(context: context).moveTo(DetailOrderScreen(
                detailActiveOrder: activeOrder[index],
              ), (callback) {

              });
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
                      content: activeOrder[index].orderCode ?? 'Unknown',
                      size: 18.0,
                      align: TextAlign.start,
                      padding: const GlobalPaddingClass(
                        paddingLeft: 20.0,
                        paddingTop: 20.0,
                        paddingRight: 20.0,
                      ),
                    ),
                    GlobalText(
                      content: activeOrder[index].status != null && activeOrder[index].status! ? 'Selesai' : 'Diproses',
                      size: 18.0,
                      color: activeOrder[index].status != null && activeOrder[index].status! ? GlobalColor.defaultBlue : GlobalColor.defaultRed,
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
                  content: activeOrder[index].date != null ? DateFormat('dd MMMM yyyy').format(activeOrder[index].date!) : '-',
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
                        content: "Rp. ${NumberFormat('#,###', 'en_ID').format(activeOrder[index].total).replaceAll(',', '.')}",
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
    Stack(
      children: [
        const Center(
          child: GlobalText(
            content: "There's no order...",
            size: 30.0,
            isBold: true,
            align: TextAlign.center,
          ),
        ),
        RefreshIndicator(
          onRefresh: () async {

          },
          child: ListView(

          ),
        )
      ],
    );
  }
}