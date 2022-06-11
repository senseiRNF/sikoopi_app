import 'package:flutter/material.dart';
import 'package:sikoopi_app/miscellaneous/variables/global_string.dart';
import 'package:sikoopi_app/widgets/global_padding.dart';

class CheckoutCompleteFragment extends StatelessWidget {
  const CheckoutCompleteFragment({Key? key}) : super(key: key);

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
          SizedBox(
            height: MediaQuery.of(context).size.height / 3,
            child: Image.asset(
              '${GlobalString.assetImagePath}/complete_order_icon.png',
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}