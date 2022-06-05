import 'package:flutter/material.dart';
import 'package:sikoopi_app/miscellaneous/variables/global_color.dart';
import 'package:sikoopi_app/widgets/global_text.dart';
import 'package:sikoopi_app/widgets/specific/home_screen_widgets/home_drawer.dart';
import 'package:sikoopi_app/widgets/specific/home_screen_widgets/home_fragment.dart';
import 'package:sikoopi_app/widgets/specific/home_screen_widgets/home_screen_header.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      body: SafeArea(
        child: Column(
          children: [
            HomeScreenHeader(
              onPressed: () {
                _key.currentState!.openEndDrawer();
              },
            ),
            const Expanded(
              child: HomeFragment(),
            ),
          ],
        ),
      ),
      endDrawer: const HomeDrawer(),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}