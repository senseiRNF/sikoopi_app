import 'package:flutter/material.dart';
import 'package:sikoopi_app/miscellaneous/data_classes/history_classes.dart';
import 'package:sikoopi_app/miscellaneous/functions/global_route.dart';
import 'package:sikoopi_app/miscellaneous/variables/global_string.dart';
import 'package:sikoopi_app/widgets/specific/history_screen_widgets/history_detail_fragment.dart';
import 'package:sikoopi_app/widgets/specific/history_screen_widgets/history_fragment.dart';
import 'package:sikoopi_app/widgets/specific/history_screen_widgets/history_screen_header.dart';

class HistoryScreen extends StatefulWidget {
  final List<HistoryClasses> historyList;

  const HistoryScreen({
    Key? key,
    required this.historyList,
  }) : super(key: key);

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  HistoryClasses? selectedItem;

  @override
  void initState() {
    super.initState();
  }

  Future<bool> onBackPressed() {
    if(selectedItem != null) {
      setState(() {
        selectedItem = null;
      });
    } else {
      GlobalRoute(context: context).back(null);
    }

    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onBackPressed,
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Image.asset(
                  '${GlobalString.assetImagePath}/background_1.png',
                  fit: BoxFit.fill,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  HistoryScreenHeader(
                    onBackPressed: () {
                      if(selectedItem != null) {
                        setState(() {
                          selectedItem = null;
                        });
                      } else {
                        GlobalRoute(context: context).back(null);
                      }
                    },
                  ),
                  Expanded(
                    child: selectedItem != null ?
                    HistoryDetailFragment(historyClassesList: selectedItem!) :
                    HistoryFragment(
                      historyList: widget.historyList,
                      onPressed: (HistoryClasses historyItem) {
                        setState(() {
                          selectedItem = historyItem;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}