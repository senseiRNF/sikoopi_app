import 'package:flutter/material.dart';
import 'package:sikoopi_app/widgets/global_padding.dart';
import 'package:sikoopi_app/widgets/global_text.dart';

class CheckoutPaymentFragment extends StatelessWidget {
  const CheckoutPaymentFragment({Key? key}) : super(key: key);

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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: const [
                GlobalText(
                  content: 'Cash',
                  size: 20.0,
                  padding: GlobalPaddingClass(
                    paddingLeft: 20.0,
                    paddingTop: 20.0,
                    paddingRight: 20.0,
                    paddingBottom: 5.0,
                  ),
                ),
                GlobalPadding(
                  paddingClass: GlobalPaddingClass(
                    paddingLeft: 20.0,
                    paddingRight: 20.0,
                  ),
                  content: Divider(
                    thickness: 2.0,
                  ),
                ),
                GlobalText(
                  content: 'Bank Transfer',
                  size: 20.0,
                  padding: GlobalPaddingClass(
                    paddingLeft: 20.0,
                    paddingTop: 5.0,
                    paddingRight: 20.0,
                    paddingBottom: 20.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}