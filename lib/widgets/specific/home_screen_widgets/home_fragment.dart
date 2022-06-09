import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sikoopi_app/miscellaneous/data_classes/cart_classes.dart';
import 'package:sikoopi_app/miscellaneous/variables/global_color.dart';
import 'package:sikoopi_app/widgets/global_padding.dart';
import 'package:sikoopi_app/widgets/global_text.dart';

class HomeFragment extends StatelessWidget {
  final List<CartClasses> orderList;
  final Function onChangeQty;

  const HomeFragment({
    Key? key,
    required this.orderList,
    required this.onChangeQty,
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
        itemCount: orderList.length,
        itemBuilder: (BuildContext gridContext, int index) {
          return Card(
            elevation: 10.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0,)
            ),
            child: GlobalPadding(
              paddingClass: const GlobalPaddingClass(
                paddingTop: 5.0,
                paddingBottom: 5.0,
              ),
              content: Column(
                children: [
                  Expanded(
                    child: Image.asset(
                      orderList[index].imagePath,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  GlobalText(
                    content: orderList[index].name,
                    size: 16.0,
                    isBold: true,
                    align: TextAlign.center,
                  ),
                  GlobalText(
                    content: orderList[index].uom,
                    align: TextAlign.center,
                  ),
                  GlobalText(
                    content: "Rp.${NumberFormat('#,###', 'en_ID').format(orderList[index].price).replaceAll(',', '.')},-",
                    align: TextAlign.center,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Card(
                          shape: const CircleBorder(),
                          child: InkWell(
                            onTap: () {
                              if(orderList[index].totalQty > 0) {
                                onChangeQty([index, orderList[index].totalQty - 1]);
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
                          content: orderList[index].totalQty.toString(),
                          size: 20.0,
                          isBold: true,
                          align: TextAlign.center,
                        ),
                      ),
                      Expanded(
                        child: Card(
                          shape: const CircleBorder(),
                          child: InkWell(
                            onTap: () {
                              onChangeQty([index, orderList[index].totalQty + 1]);
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
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}