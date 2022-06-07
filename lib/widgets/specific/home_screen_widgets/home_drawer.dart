import 'package:flutter/material.dart';
import 'package:sikoopi_app/miscellaneous/data_classes/cart_classes.dart';
import 'package:sikoopi_app/miscellaneous/functions/global_route.dart';
import 'package:sikoopi_app/miscellaneous/variables/global_color.dart';
import 'package:sikoopi_app/miscellaneous/variables/global_string.dart';
import 'package:sikoopi_app/screen/order_cart_screen.dart';
import 'package:sikoopi_app/screen/profile_screen.dart';
import 'package:sikoopi_app/widgets/global_padding.dart';
import 'package:sikoopi_app/widgets/global_text.dart';
import 'package:sikoopi_app/widgets/specific/home_screen_widgets/drawer_item.dart';

class HomeDrawer extends StatelessWidget {
  final List<CartClasses> cartClassesList;

  const HomeDrawer({
    Key? key,
    required this.cartClassesList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                '${GlobalString.assetImagePath}/background_1.png',
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        DrawerItem(
                          iconPath: 'profile_icon.png',
                          title: GlobalString.profileText,
                          onPressed: () {
                            GlobalRoute(context: context).back(null);

                            GlobalRoute(context: context).moveTo(const ProfileScreen(), (callback) {

                            });
                          },
                        ),
                        DrawerItem(
                          iconPath: 'product_icon.png',
                          title: GlobalString.productText,
                          onPressed: () {

                          },
                        ),
                        DrawerItem(
                          iconPath: 'order_icon.png',
                          title: GlobalString.orderCartText,
                          onPressed: () {
                            GlobalRoute(context: context).back(null);

                            GlobalRoute(context: context).moveTo(OrderCartScreen(
                              cartClassesList: cartClassesList,
                            ), (callback) {

                            });
                          },
                        ),
                        DrawerItem(
                          iconPath: 'payment_icon.png',
                          title: GlobalString.paymentDeliveryText,
                          onPressed: () {

                          },
                        ),
                        DrawerItem(
                          iconPath: 'history_icon.png',
                          title: GlobalString.historyText,
                          onPressed: () {

                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {

                  },
                  child: GlobalPadding(
                    paddingClass: const GlobalPaddingClass(
                      paddingLeft: 20.0,
                      paddingTop: 20.0,
                      paddingRight: 20.0,
                      paddingBottom: 20.0,
                    ),
                    content: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        GlobalText(
                          content: 'Sign Out',
                          size: 20.0,
                          color: GlobalColor.defaultRed,
                          padding: const GlobalPaddingClass(
                            paddingLeft: 20.0,
                            paddingRight: 20.0,
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: GlobalColor.defaultRed,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}