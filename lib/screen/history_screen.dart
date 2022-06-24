import 'package:flutter/material.dart';
import 'package:sikoopi_app/miscellaneous/data_classes/cart_classes.dart';
import 'package:sikoopi_app/miscellaneous/data_classes/transaction_classes.dart';
import 'package:sikoopi_app/miscellaneous/functions/global_route.dart';
import 'package:sikoopi_app/miscellaneous/variables/global_color.dart';
import 'package:sikoopi_app/miscellaneous/variables/global_string.dart';
import 'package:sikoopi_app/services/local_db.dart';
import 'package:sikoopi_app/services/shared_preferences.dart';
import 'package:sikoopi_app/widgets/global_text.dart';
import 'package:sikoopi_app/widgets/specific/history_screen_widgets/history_detail_fragment.dart';
import 'package:sikoopi_app/widgets/specific/history_screen_widgets/history_fragment.dart';
import 'package:sikoopi_app/widgets/specific/history_screen_widgets/history_screen_header.dart';

class HistoryScreen extends StatefulWidget {
  final String role;

  const HistoryScreen({
    Key? key,
    required this.role,
  }) : super(key: key);

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<TransactionClasses> transactionList = [];
  List<CartClasses> detailTransactionList = [];

  TransactionClasses? selectedItem;

  @override
  void initState() {
    super.initState();

    initLoad();
  }

  void initLoad() async {
    await SharedPref().readAuthorization().then((auth) async {
      if(widget.role == 'user') {
        if(auth != null && auth.id != null) {
          await LocalDB().readTransactionByUser(auth.id!).then((result) async {
            setState(() {
              transactionList = result;
            });
          });
        }
      } else {
        if(auth != null && auth.id != null) {
          await LocalDB().readAllTransaction().then((result) async {
            setState(() {
              transactionList = result;
            });
          });
        }
      }
    });
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
                    detailTransactionList.isNotEmpty ?
                    ListView(
                      children: [
                        HistoryDetailFragment(
                          transaction: selectedItem!,
                          detailTransaction: detailTransactionList,
                          onPressed: () {
                            setState(() {
                              detailTransactionList = [];
                              selectedItem = null;
                            });
                          },
                        ),
                      ],
                    ) :
                    Center(
                      child: GlobalText(
                        content: "There's no product ordered...",
                        size: 30.0,
                        color: GlobalColor.defaultWhite,
                        isBold: true,
                        align: TextAlign.center,
                      ),
                    ) :
                    transactionList.isNotEmpty ?
                    ListView(
                      children: [
                        HistoryFragment(
                          transactionList: transactionList,
                          onPressed: (TransactionClasses? transactionItem) async {
                            if(transactionItem != null) {
                              if(transactionItem.id != null) {
                                await LocalDB().readDetailTransaction(transactionItem.id!).then((detailTransaction) {
                                  setState(() {
                                    detailTransactionList = detailTransaction;
                                    selectedItem = transactionItem;
                                  });
                                });
                              }
                            }
                          },
                        ),
                      ],
                    ) :
                    Center(
                      child: GlobalText(
                        content: "There's no order history...",
                        size: 30.0,
                        color: GlobalColor.defaultWhite,
                        isBold: true,
                        align: TextAlign.center,
                      ),
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