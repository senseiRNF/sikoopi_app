import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sikoopi_app/miscellaneous/data_classes/cart_classes.dart';
import 'package:sikoopi_app/miscellaneous/data_classes/transaction_classes.dart';
import 'package:sikoopi_app/miscellaneous/functions/global_dialog.dart';
import 'package:sikoopi_app/miscellaneous/functions/global_route.dart';
import 'package:sikoopi_app/miscellaneous/variables/global_color.dart';
import 'package:sikoopi_app/miscellaneous/variables/global_string.dart';
import 'package:sikoopi_app/services/local_db.dart';
import 'package:sikoopi_app/widgets/global_button.dart';
import 'package:sikoopi_app/widgets/global_padding.dart';
import 'package:sikoopi_app/widgets/global_text.dart';
import 'package:sikoopi_app/widgets/specific/detail_order_screen_widgets/detail_order_item.dart';
import 'package:sikoopi_app/widgets/specific/order_cart_screen_widgets/order_cart_screen_header.dart';

class DetailOrderScreen extends StatefulWidget {
  final TransactionClasses transaction;
  
  const DetailOrderScreen({
    Key? key,
    required this.transaction,
  }) : super(key: key);
  
  @override
  State<DetailOrderScreen> createState() => _DetailOrderScreenState();
}

class _DetailOrderScreenState extends State<DetailOrderScreen> {
  List<CartClasses> detailTransaction = [];
  
  @override
  void initState() {
    super.initState();
    
    initLoad();
  }
  
  void initLoad() async {
    if(widget.transaction.id != null) {
      await LocalDB().readDetailTransaction(widget.transaction.id!).then((detail) {
        setState(() {
          detailTransaction = detail;
        });
      });
    }
  }
  
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
                            content: widget.transaction.username ?? 'Unknown User',
                            size: 18.0,
                            isBold: true,
                          ),
                          GlobalText(
                            content: widget.transaction.date != null ? DateFormat('dd MMMM yyyy').format(widget.transaction.date!) : 'Unknown Date',
                            size: 16.0,
                            align: TextAlign.start,
                            padding: const GlobalPaddingClass(
                              paddingTop: 10.0,
                            ),
                          ),
                          GlobalText(
                            content: 'Payment: ${widget.transaction.payment ?? 'Unknown Payment'}',
                            size: 16.0,
                            align: TextAlign.start,
                            padding: const GlobalPaddingClass(
                              paddingTop: 10.0,
                            ),
                          ),
                          widget.transaction.payment != null && widget.transaction.payment == 'transfer' ?
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              GlobalText(
                                content: 'Receipent: ${widget.transaction.receipent ?? 'Unknown Receipent'}',
                                size: 16.0,
                                align: TextAlign.start,
                                padding: const GlobalPaddingClass(
                                  paddingTop: 10.0,
                                ),
                              ),
                              GlobalText(
                                content: 'Address: ${widget.transaction.address ?? 'Unknown Address'}',
                                size: 16.0,
                                align: TextAlign.start,
                              )
                            ],
                          ) :
                          const Material(),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: detailTransaction.isNotEmpty ?
                  ListView.builder(
                    itemCount: detailTransaction.length,
                    itemBuilder: (BuildContext listContext, int index) {
                      return DetailOrderItem(
                        orderItem: detailTransaction[index],
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
                detailTransaction.isNotEmpty ?
                GlobalElevatedButton(
                  onPressed: () {
                    GlobalDialog(context: context, message: 'Complete this order, Are you sure?').optionDialog(() async {
                      if(widget.transaction.id != null) {
                        await LocalDB().completeOrder(widget.transaction.id!).then((result) {
                          if(result) {
                            GlobalRoute(context: context).back(true);
                          }
                        });
                      } else {
                        GlobalDialog(context: context, message: 'Failed to complete this transaction').okDialog(() {

                        });
                      }
                    }, () {

                    });
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

  @override
  void dispose() {
    super.dispose();
  }
}