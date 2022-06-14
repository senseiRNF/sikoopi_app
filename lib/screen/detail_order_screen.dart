import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sikoopi_app/miscellaneous/data_classes/order_classes.dart';
import 'package:sikoopi_app/miscellaneous/variables/global_color.dart';
import 'package:sikoopi_app/miscellaneous/variables/global_string.dart';
import 'package:sikoopi_app/widgets/global_button.dart';
import 'package:sikoopi_app/widgets/global_padding.dart';
import 'package:sikoopi_app/widgets/global_text.dart';
import 'package:sikoopi_app/widgets/specific/detail_order_screen_widgets/detail_order_item.dart';
import 'package:sikoopi_app/widgets/specific/order_cart_screen_widgets/order_cart_screen_header.dart';

class DetailOrderScreen extends StatefulWidget {
  final ActiveOrderClass detailActiveOrder;
  
  const DetailOrderScreen({
    Key? key,
    required this.detailActiveOrder,
  }) : super(key: key);
  
  @override
  State<DetailOrderScreen> createState() => _DetailOrderScreenState();
}

class _DetailOrderScreenState extends State<DetailOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Image.asset(
                '${GlobalString.assetImagePath}/background_1.png',
                fit: BoxFit.fill,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const OrderCartScreenHeader(),
                GlobalPadding(
                  paddingClass: const GlobalPaddingClass(
                    paddingLeft: 10.0,
                    paddingRight: 10.0,
                    paddingTop: 10.0,
                    paddingBottom: 10.0,
                  ),
                  content: Card(
                    child: GlobalPadding(
                      paddingClass: const GlobalPaddingClass(
                        paddingLeft: 20.0,
                        paddingTop: 10.0,
                        paddingRight: 20.0,
                        paddingBottom: 10.0,
                      ),
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          GlobalText(
                            content: widget.detailActiveOrder.orderCode,
                            size: 18.0,
                            isBold: true,
                          ),
                          GlobalText(
                            content: DateFormat('dd MMMM yyyy').format(widget.detailActiveOrder.date),
                            size: 16.0,
                            align: TextAlign.start,
                            padding: const GlobalPaddingClass(
                              paddingTop: 10.0,
                            ),
                          ),
                          GlobalText(
                            content: 'Receipent: ${widget.detailActiveOrder.receipent ?? '-'}',
                            size: 16.0,
                            align: TextAlign.start,
                            padding: const GlobalPaddingClass(
                              paddingTop: 10.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: widget.detailActiveOrder.detailOrder.isNotEmpty ?
                  ListView.builder(
                    itemCount: widget.detailActiveOrder.detailOrder.length,
                    itemBuilder: (BuildContext listContext, int index) {
                      return DetailOrderItem(
                        orderItem: widget.detailActiveOrder.detailOrder[index],
                      );
                    },
                  ) :
                  Center(
                    child: GlobalText(
                      content: "There's no order...",
                      size: 30.0,
                      color: GlobalColor.defaultWhite,
                      isBold: true,
                      align: TextAlign.center,
                    ),
                  ),
                ),
                widget.detailActiveOrder.detailOrder.isNotEmpty ?
                GlobalElevatedButton(
                  onPressed: () {

                  },
                  title: 'Complete Order',
                  btnColor: GlobalColor.accentColor,
                  padding: const GlobalPaddingClass(
                    paddingLeft: 50.0,
                    paddingTop: 10.0,
                    paddingRight: 50.0,
                    paddingBottom: 10.0,
                  ),
                ) :
                const Material(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}