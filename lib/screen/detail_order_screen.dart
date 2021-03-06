import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sikoopi_app/miscellaneous/functions/global_dialog.dart';
import 'package:sikoopi_app/miscellaneous/functions/global_route.dart';
import 'package:sikoopi_app/miscellaneous/variables/global_color.dart';
import 'package:sikoopi_app/miscellaneous/variables/global_string.dart';
import 'package:sikoopi_app/services/api/transaction_services.dart';
import 'package:sikoopi_app/widgets/global_button.dart';
import 'package:sikoopi_app/widgets/global_padding.dart';
import 'package:sikoopi_app/widgets/global_text.dart';
import 'package:sikoopi_app/widgets/specific/detail_order_screen_widgets/detail_order_item.dart';
import 'package:sikoopi_app/widgets/specific/order_cart_screen_widgets/order_cart_screen_header.dart';

class DetailOrderScreen extends StatefulWidget {
  final TransactionResponseData transaction;
  
  const DetailOrderScreen({
    Key? key,
    required this.transaction,
  }) : super(key: key);
  
  @override
  State<DetailOrderScreen> createState() => _DetailOrderScreenState();
}

class _DetailOrderScreenState extends State<DetailOrderScreen> {
  List<TransactionDetailResponseData> detailTransaction = [];
  
  @override
  void initState() {
    super.initState();
    
    initLoad();
  }
  
  void initLoad() async {
    if(widget.transaction.id != null) {
      await TransactionServices().readTransactionDetail(int.parse(widget.transaction.id!)).then((dioResult) {
        if(dioResult != null && dioResult.data != null) {
          List<TransactionDetailResponseData> listTemp = [];

          for(int i = 0; i < dioResult.data!.length; i++) {
            listTemp.add(dioResult.data![i]);
          }

          setState(() {
            detailTransaction = listTemp;
          });
        }
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
                            content: widget.transaction.date != null ? DateFormat('dd MMMM yyyy').format(DateTime.parse(widget.transaction.date!)) : 'Unknown Date',
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
                          widget.transaction.payment != null && widget.transaction.payment == 'Transfer' ?
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
                              ),
                              Builder(
                                builder: (BuildContext detailContext) {
                                  return InkWell(
                                    onTap: () {
                                      showBottomSheet(
                                        context: detailContext,
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
                                              File(widget.transaction.transferReceiptImage!.substring(8)),
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
                                  );
                                },
                              ),
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
                widget.transaction.status != 'Completed' && detailTransaction.isNotEmpty ?
                GlobalElevatedButton(
                  onPressed: () {
                    GlobalDialog(context: context, message: 'Complete this order, Are you sure?').optionDialog(() async {
                      if(widget.transaction.id != null) {
                        await TransactionServices().updateTransactionStatus(int.parse(widget.transaction.id!), 'Completed').then((dioResult) {
                          if(dioResult) {
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