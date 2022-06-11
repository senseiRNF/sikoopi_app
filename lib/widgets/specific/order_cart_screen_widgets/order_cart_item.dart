import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sikoopi_app/miscellaneous/data_classes/cart_classes.dart';
import 'package:sikoopi_app/miscellaneous/functions/global_dialog.dart';
import 'package:sikoopi_app/widgets/global_padding.dart';
import 'package:sikoopi_app/widgets/global_text.dart';

class OrderCartItem extends StatelessWidget {
  final CartClasses orderList;
  final Function onChangeQty;

  const OrderCartItem({
    Key? key,
    required this.orderList,
    required this.onChangeQty,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0,),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 120.0,
            height: 120.0,
            child: GlobalPadding(
              paddingClass: const GlobalPaddingClass(
                paddingLeft: 10.0,
                paddingTop: 10.0,
                paddingRight: 10.0,
                paddingBottom: 10.0,
              ),
              content: Image.asset(
                orderList.imagePath,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GlobalText(
                  content: orderList.name,
                  size: 18.0,
                  isBold: true,
                  align: TextAlign.center,
                ),
                GlobalText(
                  content: orderList.uom,
                  size: 16.0,
                  align: TextAlign.center,
                ),
                GlobalText(
                  content: "Rp.${NumberFormat('#,###', 'en_ID').format(orderList.price).replaceAll(',', '.')},-",
                  size: 16.0,
                  align: TextAlign.center,
                  padding: const GlobalPaddingClass(
                    paddingBottom: 10.0,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Card(
                              shape: const CircleBorder(),
                              child: InkWell(
                                onTap: () {
                                  if(orderList.totalQty > 1) {
                                    onChangeQty(orderList.totalQty - 1);
                                  } else {
                                    GlobalDialog(context: context, message: 'Remove item from Cart, are you sure?').optionDialog(() {
                                      onChangeQty(0);
                                    }, () {

                                    });
                                  }
                                },
                                customBorder: const CircleBorder(),
                                child: const GlobalPadding(
                                  paddingClass: GlobalPaddingClass(
                                    paddingLeft: 5.0,
                                    paddingTop: 5.0,
                                    paddingRight: 5.0,
                                    paddingBottom: 5.0,
                                  ),
                                  content: Icon(
                                    Icons.remove,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GlobalText(
                              content: orderList.totalQty.toString(),
                              size: 16.0,
                              align: TextAlign.center,
                            ),
                          ),
                          Expanded(
                            child: Card(
                              shape: const CircleBorder(),
                              child: InkWell(
                                onTap: () {
                                  onChangeQty(orderList.totalQty + 1);
                                },
                                customBorder: const CircleBorder(),
                                child: const GlobalPadding(
                                  paddingClass: GlobalPaddingClass(
                                    paddingLeft: 5.0,
                                    paddingTop: 5.0,
                                    paddingRight: 5.0,
                                    paddingBottom: 5.0,
                                  ),
                                  content: Icon(
                                    Icons.add,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: GlobalText(
                        content: "Rp.${NumberFormat('#,###', 'en_ID').format(orderList.totalQty * orderList.price).replaceAll(',', '.')},-",
                        size: 16.0,
                        align: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}