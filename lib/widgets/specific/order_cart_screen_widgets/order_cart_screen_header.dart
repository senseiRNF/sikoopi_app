import 'package:flutter/material.dart';
import 'package:sikoopi_app/miscellaneous/functions/global_route.dart';
import 'package:sikoopi_app/miscellaneous/variables/global_color.dart';
import 'package:sikoopi_app/miscellaneous/variables/global_string.dart';
import 'package:sikoopi_app/widgets/global_padding.dart';
import 'package:sikoopi_app/widgets/global_text.dart';

class OrderCartScreenHeader extends StatelessWidget {
  const OrderCartScreenHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GlobalPadding(
      paddingClass: const GlobalPaddingClass(
        paddingTop: 20.0,
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GlobalPadding(
                paddingClass: const GlobalPaddingClass(
                  paddingLeft: 10.0,
                ),
                content: Material(
                  color: Colors.transparent,
                  child: IconButton(
                    onPressed: () => GlobalRoute(context: context).back(null),
                    icon: Icon(
                      Icons.arrow_back,
                      color: GlobalColor.defaultWhite,
                      size: 34.0,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      '${GlobalString.assetImagePath}/bps_jateng_icon.png',
                      width: MediaQuery.of(context).size.width / 2,
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    Image.asset(
                      '${GlobalString.assetImagePath}/sikoopi_icon.png',
                      height: MediaQuery.of(context).size.height / 8,
                    ),
                  ],
                ),
              ),
            ],
          ),
          GlobalText(
            content: GlobalString.orderCartText,
            size: 24.0,
            color: GlobalColor.defaultWhite,
            isBold: true,
            align: TextAlign.center,
            padding: const GlobalPaddingClass(
              paddingBottom: 10.0,
            ),
          ),
        ],
      ),
    );
  }
}