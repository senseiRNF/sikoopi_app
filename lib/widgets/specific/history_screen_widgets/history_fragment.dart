import 'package:flutter/material.dart';
import 'package:sikoopi_app/widgets/global_padding.dart';

class HistoryFragment extends StatelessWidget {
  const HistoryFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GlobalPadding(
      paddingClass: const GlobalPaddingClass(
        paddingLeft: 10.0,
        paddingTop: 10.0,
        paddingRight: 10.0,
        paddingBottom: 10.0,
      ),
      content: ListView.builder(
        itemCount: 3,
        itemBuilder: (BuildContext listContext, int index) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0,),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: const [
                SizedBox(
                  height: 100.0,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}