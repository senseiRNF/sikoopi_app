import 'package:flutter/material.dart';
import 'package:sikoopi_app/miscellaneous/variables/global_color.dart';
import 'package:sikoopi_app/miscellaneous/variables/global_string.dart';
import 'package:sikoopi_app/widgets/global_input_field.dart';
import 'package:sikoopi_app/widgets/global_padding.dart';

class HomeScreenHeader extends StatelessWidget {
  const HomeScreenHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController searchTEC = TextEditingController();

    return Stack(
      children: [
        Image.asset(
          '${GlobalString.assetImagePath}/background_2.png',
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 2.6,
          fit: BoxFit.fill,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
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
                padding: const GlobalPaddingClass(
                  paddingLeft: 30.0,
                  paddingRight: 30.0,
                  paddingBottom: 20.0,
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: GlobalColor.defaultWhite,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(40.0,),
                      topRight: Radius.circular(40.0,),
                    ),
                  ),
                  child: ListView(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}