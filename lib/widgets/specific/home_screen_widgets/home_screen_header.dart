import 'package:flutter/material.dart';
import 'package:sikoopi_app/miscellaneous/variables/global_color.dart';
import 'package:sikoopi_app/miscellaneous/variables/global_string.dart';
import 'package:sikoopi_app/widgets/global_input_field.dart';
import 'package:sikoopi_app/widgets/global_padding.dart';

class HomeScreenHeader extends StatelessWidget {
  final Function onPressed;

  const HomeScreenHeader({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController searchTEC = TextEditingController();

    return SizedBox(
      height: MediaQuery.of(context).size.height / 2.6,
      child: Stack(
        children: [
          Image.asset(
            '${GlobalString.assetImagePath}/background_2.png',
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 2.6,
            fit: BoxFit.fill,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Material(
                color: Colors.transparent,
                child: IconButton(
                  onPressed: () => onPressed(),
                  icon: Icon(
                    Icons.menu,
                    color: GlobalColor.defaultWhite,
                  ),
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const SizedBox(
                height: 50.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
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
              GlobalTextfield(
                controller: searchTEC,
                title: 'Search Product',
                isFilled: true,
                fieldColor: Colors.white54,
                padding: const GlobalPaddingClass(
                  paddingLeft: 30.0,
                  paddingRight: 30.0,
                  paddingBottom: 20.0,
                ),
              ),
              Container(
                height: 40.0,
                decoration: BoxDecoration(
                  color: GlobalColor.defaultWhite,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40.0,),
                    topRight: Radius.circular(40.0,),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}