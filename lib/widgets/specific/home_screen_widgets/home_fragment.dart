import 'package:flutter/material.dart';
import 'package:sikoopi_app/miscellaneous/variables/global_color.dart';

class HomeFragment extends StatelessWidget {
  const HomeFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: GlobalColor.defaultWhite,
      ),
      child: ListView(
        children: const [
          
        ],
      ),
    );
  }
}