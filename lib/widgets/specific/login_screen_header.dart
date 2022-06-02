import 'package:flutter/material.dart';
import 'package:sikoopi_app/miscellaneous/variables/global_color.dart';
import 'package:sikoopi_app/miscellaneous/variables/global_string.dart';
import 'package:sikoopi_app/widgets/global_padding.dart';
import 'package:sikoopi_app/widgets/global_text.dart';

class LoginScreenHeader extends StatelessWidget {
  final int selectedMenu;
  final Function onChange;

  const LoginScreenHeader({
    Key? key,
    required this.selectedMenu,
    required this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          '${GlobalString.assetImagePath}/background_2.png',
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 2.6,
          fit: BoxFit.fill,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
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
            GlobalText(
              content: GlobalString.welcomeText,
              size: 36.0,
              color: GlobalColor.defaultWhite,
              isBold: true,
            ),
            GlobalText(
              content: GlobalString.signInText,
              size: 16.0,
              color: GlobalColor.defaultWhite,
              padding: const GlobalPaddingClass(
                paddingBottom: 20.0,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => onChange(0),
                      child: GlobalText(
                        content: 'Login',
                        size: 20.0,
                        color: selectedMenu == 0 ? GlobalColor.accentColor : GlobalColor.defaultWhite,
                        align: TextAlign.center,
                        padding: const GlobalPaddingClass(
                          paddingTop: 10.0,
                          paddingBottom: 10.0,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => onChange(1),
                      child: GlobalText(
                        content: 'Sign Up',
                        size: 20.0,
                        color: selectedMenu != 0 ? GlobalColor.accentColor : GlobalColor.defaultWhite,
                        align: TextAlign.center,
                        padding: const GlobalPaddingClass(
                          paddingTop: 10.0,
                          paddingBottom: 10.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}