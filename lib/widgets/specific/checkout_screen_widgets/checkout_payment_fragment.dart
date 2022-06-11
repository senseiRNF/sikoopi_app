import 'package:flutter/material.dart';
import 'package:sikoopi_app/widgets/global_padding.dart';
import 'package:sikoopi_app/widgets/global_text.dart';

class CheckoutPaymentFragment extends StatelessWidget {
  final int paymentMethod;
  final Function onChangeMethod;

  const CheckoutPaymentFragment({
    Key? key,
    required this.paymentMethod,
    required this.onChangeMethod,
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
      content: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0,),
            ),
            child: GlobalPadding(
              paddingClass: const GlobalPaddingClass(
                paddingLeft: 10.0,
                paddingTop: 10.0,
                paddingRight: 10.0,
                paddingBottom: 10.0,
              ),
              content: Column(
                children: [
                  CheckboxListTile(
                    value: paymentMethod == 0 ? true : false,
                    onChanged: (_) {
                      onChangeMethod(0);
                    },
                    title: const GlobalText(
                      content: 'Cash',
                      size: 20.0,
                    ),
                  ),
                  const GlobalPadding(
                    paddingClass: GlobalPaddingClass(
                      paddingLeft: 20.0,
                      paddingRight: 20.0,
                    ),
                    content: Divider(
                      thickness: 2.0,
                    ),
                  ),
                  CheckboxListTile(
                    value: paymentMethod == 1 ? true : false,
                    onChanged: (_) {
                      onChangeMethod(1);
                    },
                    title: const GlobalText(
                      content: 'Bank Transfer',
                      size: 20.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
          paymentMethod == 1 ?
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0,),
            ),
            child: const GlobalPadding(
              paddingClass: GlobalPaddingClass(
                paddingLeft: 20.0,
                paddingTop: 20.0,
                paddingRight: 20.0,
                paddingBottom: 20.0,
              ),
              content: GlobalText(
                content: 'Bank:\nBCA 4060988400 - a.n Razy Novianrizki F',
                size: 16.0,
              ),
            ),
          ) :
          const Material(),
        ],
      ),
    );
  }
}