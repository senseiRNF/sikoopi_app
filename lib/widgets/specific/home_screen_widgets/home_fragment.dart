import 'package:flutter/material.dart';
import 'package:sikoopi_app/miscellaneous/data_classes/cart_classes.dart';
import 'package:sikoopi_app/miscellaneous/variables/global_color.dart';
import 'package:sikoopi_app/widgets/global_padding.dart';
import 'package:sikoopi_app/widgets/global_text.dart';

class HomeFragment extends StatelessWidget {
  final List<CartClasses> cartClassesList;
  final Function onChangeQty;

  const HomeFragment({
    Key? key,
    required this.cartClassesList,
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
        itemCount: cartClassesList.length,
        itemBuilder: (BuildContext gridContext, int index) {
          return Column(
            children: [
              Expanded(
                child: Image.asset(
                  cartClassesList[index].imagePath,
                  fit: BoxFit.fitWidth,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Card(
                      shape: const CircleBorder(),
                      child: InkWell(
                        onTap: () {
                          if(cartClassesList[index].totalQty > 0) {
                            onChangeQty([index, cartClassesList[index].totalQty - 1]);
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
                      content: cartClassesList[index].totalQty.toString(),
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
                          onChangeQty([index, cartClassesList[index].totalQty + 1]);
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
          );
        },
      ),
    );
  }
}