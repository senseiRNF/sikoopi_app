import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sikoopi_app/miscellaneous/variables/global_color.dart';
import 'package:sikoopi_app/miscellaneous/variables/global_string.dart';
import 'package:sikoopi_app/services/api/opname_services.dart';
import 'package:sikoopi_app/widgets/global_padding.dart';
import 'package:sikoopi_app/widgets/global_text.dart';
import 'package:sikoopi_app/widgets/specific/opname_list_screen_widgets/opname_list_screen_header.dart';

class OpnameListScreen extends StatefulWidget {
  final int productId;

  const OpnameListScreen({
    Key? key,
    required this.productId,
  }) : super(key: key);

  @override
  State<OpnameListScreen> createState() => _OpnameListScreenState();
}

class _OpnameListScreenState extends State<OpnameListScreen> {
  List<OpnameResponseData> opnameList = [];

  @override
  void initState() {
    super.initState();

    initLoad();
  }

  void initLoad() async {
    await OpnameServices().readOpnameProduct(widget.productId).then((dioResult) {
      List<OpnameResponseData> listTemp = [];

      if(dioResult != null && dioResult.data != null) {
        for(int i = 0; i < dioResult.data!.length; i++) {
          listTemp.add(dioResult.data![i]);
        }

        setState(() {
          opnameList = listTemp;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                const OpnameListScreenHeader(),
                Expanded(
                  child: opnameList.isNotEmpty ?
                  ListView.builder(
                    itemCount: opnameList.length,
                    itemBuilder: (BuildContext listContext, int index) {
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0,),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              GlobalText(
                                content: opnameList[index].date != null ? DateFormat('dd-MM-yyyy').format(DateTime.parse(opnameList[index].date!)) : 'Unknown Date',
                                size: 20.0,
                                isBold: true,
                                padding: const GlobalPaddingClass(
                                  paddingBottom: 10.0,
                                ),
                              ),
                              GlobalText(
                                content: "User: ${opnameList[index].username ?? 'Unknown User'}",
                                size: 18.0,
                              ),
                              GlobalText(
                                content: "Qty: ${opnameList[index].qty ?? 'Unknown Qty'}",
                                size: 18.0,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ) :
                  Center(
                    child: GlobalText(
                      content: "There's no opname history...",
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
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}