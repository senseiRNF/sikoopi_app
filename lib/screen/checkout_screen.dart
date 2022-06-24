import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sikoopi_app/miscellaneous/data_classes/cart_classes.dart';
import 'package:sikoopi_app/miscellaneous/data_classes/transaction_classes.dart';
import 'package:sikoopi_app/miscellaneous/functions/global_dialog.dart';
import 'package:sikoopi_app/miscellaneous/functions/global_route.dart';
import 'package:sikoopi_app/miscellaneous/variables/global_color.dart';
import 'package:sikoopi_app/miscellaneous/variables/global_string.dart';
import 'package:sikoopi_app/services/local_db.dart';
import 'package:sikoopi_app/services/shared_preferences.dart';
import 'package:sikoopi_app/widgets/global_button.dart';
import 'package:sikoopi_app/widgets/global_padding.dart';
import 'package:sikoopi_app/widgets/global_text.dart';
import 'package:sikoopi_app/widgets/specific/checkout_screen_widgets/checkout_complete_fragment.dart';
import 'package:sikoopi_app/widgets/specific/checkout_screen_widgets/checkout_delivery_fragment.dart';
import 'package:sikoopi_app/widgets/specific/checkout_screen_widgets/checkout_fragment.dart';
import 'package:sikoopi_app/widgets/specific/checkout_screen_widgets/checkout_payment_fragment.dart';
import 'package:sikoopi_app/widgets/specific/checkout_screen_widgets/checkout_screen_header.dart';

class CheckoutScreen extends StatefulWidget {
  final List<CartClasses> orderList;

  const CheckoutScreen({
    Key? key,
    required this.orderList,
  }) : super(key: key);

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int stage = 0;
  int paymentMethod = 0;
  int? userId;

  TextEditingController receipentNameTEC = TextEditingController();
  TextEditingController addressTEC = TextEditingController();

  String? username;

  @override
  void initState() {
    super.initState();

    initLoad();
  }

  void initLoad() async {
    await SharedPref().readAuthorization().then((result) {
      if(result != null) {
        setState(() {
          userId = result.id;
          username = result.username;
          addressTEC.text = result.address ?? 'Unknown Address';
        });
      }
    });
  }

  int countTotal() {
    int result = 0;

    if(widget.orderList.isNotEmpty) {
      for(int i = 0; i < widget.orderList.length; i++) {
        if(widget.orderList[i].totalQty != null && widget.orderList[i].price != null) {
          result = result + (widget.orderList[i].totalQty! * widget.orderList[i].price!);
        }
      }
    }

    return result;
  }

  Future<bool> savingTransaction() async {
    bool result = false;

    GlobalDialog(context: context, message: 'Before continue, please take a picture of the evidence of transfer').okDialog(() async {
      var status = await Permission.storage.status;

      if(status.isGranted) {
        await ImagePicker().pickImage(
          source: ImageSource.camera,
          preferredCameraDevice: CameraDevice.rear,
        ).then((image) async {
          if(image != null) {
            var savingResult = await ImageGallerySaver.saveImage(await image.readAsBytes());

            if(savingResult['isSuccess']) {
              await LocalDB().writeTransactions(
                TransactionClasses(
                  userId: userId,
                  username: username ?? 'Unknown User',
                  date: DateTime.now(),
                  total: countTotal(),
                  payment: 'Transfer',
                  receipent: receipentNameTEC.text,
                  address: addressTEC.text,
                  transferReceiptImage: savingResult['filePath'],
                ),
                widget.orderList,
              ).then((writeResult) {
                if(writeResult) {
                  setState(() {
                    stage = stage + 1;
                  });
                }
              });
            }
          }
        });
      } else {
        await Permission.storage.request().then((permissionResult) async {
          if(permissionResult.isGranted) {
            await ImagePicker().pickImage(
              source: ImageSource.camera,
              preferredCameraDevice: CameraDevice.rear,
            ).then((image) async {
              if(image != null) {
                var savingResult = await ImageGallerySaver.saveImage(await image.readAsBytes());

                if(savingResult['isSuccess']) {
                  await LocalDB().writeTransactions(
                    TransactionClasses(
                      userId: userId,
                      username: username ?? 'Unknown User',
                      date: DateTime.now(),
                      total: countTotal(),
                      payment: 'Transfer',
                      receipent: receipentNameTEC.text,
                      address: addressTEC.text,
                      transferReceiptImage: savingResult['filePath'],
                    ),
                    widget.orderList,
                  ).then((writeResult) {
                    if(writeResult) {
                      setState(() {
                        stage = stage + 1;
                      });
                    }
                  });
                }
              }
            });
          } else {
            GlobalDialog(context: context, message: 'Cannot proceed, permission to store image is denied').okDialog(() {

            });
          }
        });
      }
    });

    return result;
  }

  Future<bool> onBackPressed() {
    if(stage == 3) {
      GlobalRoute(context: context).back([true, widget.orderList, receipentNameTEC.text, addressTEC.text]);
    } else if(stage == 2) {
      setState(() {
        stage = 1;
      });
    } else if(stage == 1) {
      setState(() {
        stage = 0;
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
                  CheckoutPaymentScreenHeader(
                    stage: stage,
                    onBackPressed: () {
                      if(stage == 3) {
                        GlobalRoute(context: context).back([true, widget.orderList, receipentNameTEC.text, addressTEC.text]);
                      } else if(stage == 2) {
                        setState(() {
                          stage = 1;
                        });
                      } else if(stage == 1) {
                        setState(() {
                          stage = 0;
                        });
                      } else {
                        GlobalRoute(context: context).back(null);
                      }
                    },
                  ),
                  Expanded(
                    child: stage == 0 ?
                    CheckoutFragment(
                      orderList: widget.orderList,
                    ) :
                    stage == 1 ?
                    CheckoutPaymentFragment(
                      paymentMethod: paymentMethod,
                      onChangeMethod: (int method) {
                        setState(() {
                          paymentMethod = method;
                        });
                      },
                    ) :
                    stage == 2 ?
                    CheckoutDeliveryFragment(
                      receipentNameTEC: receipentNameTEC,
                      addressDetailTEC: addressTEC,
                    ) :
                    const CheckoutCompleteFragment(),
                  ),
                  widget.orderList.isNotEmpty ?
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      stage < 3 ?
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GlobalText(
                            content: 'Total',
                            size: 20.0,
                            color: GlobalColor.defaultWhite,
                            padding: const GlobalPaddingClass(
                              paddingLeft: 30.0,
                              paddingBottom: 10.0,
                            ),
                          ),
                          Expanded(
                            child: GlobalText(
                              content: "Rp.${NumberFormat('#,###', 'en_ID').format(countTotal()).replaceAll(',', '.')},-",
                              size: 20.0,
                              color: GlobalColor.defaultWhite,
                              align: TextAlign.end,
                              padding: const GlobalPaddingClass(
                                paddingRight: 30.0,
                                paddingBottom: 10.0,
                              ),
                            ),
                          ),
                        ],
                      ) :
                      const Material(),
                      GlobalElevatedButton(
                        onPressed: () async {
                          switch(stage) {
                            case 0:
                              setState(() {
                                stage = stage + 1;
                              });
                              break;
                            case 1:
                              if(paymentMethod == 0) {
                                await LocalDB().writeTransactions(
                                  TransactionClasses(
                                    userId: userId,
                                    username: username ?? 'Unknown User',
                                    date: DateTime.now(),
                                    total: countTotal(),
                                    payment: 'Cash',
                                    receipent: '',
                                    address: '',
                                    transferReceiptImage: '',
                                  ),
                                  widget.orderList,
                                ).then((result) {
                                  if(result) {
                                    setState(() {
                                      stage = stage + 2;
                                    });
                                  }
                                });
                              } else {
                                setState(() {
                                  stage = stage + 1;
                                });
                              }
                              break;
                            case 2:
                              if(receipentNameTEC.text != '' && addressTEC.text != '') {
                                savingTransaction();
                              } else {
                                GlobalDialog(context: context, message: 'Cannot proceed, receipent and address must be filled').okDialog(() {

                                });
                              }
                              break;
                            case 3:
                              GlobalRoute(context: context).back(true);
                              break;
                            default:
                              GlobalRoute(context: context).back(false);
                          }
                        },
                        title: stage == 0 ? 'Proceed to Payment' : stage == 1 ? paymentMethod == 0 ? 'Complete Order' : 'Proceed to Delivery' : stage == 2 ? 'Complete Order' : 'Back To Main Menu',
                        btnColor: GlobalColor.accentColor,
                        padding: const GlobalPaddingClass(
                          paddingLeft: 50.0,
                          paddingTop: 10.0,
                          paddingRight: 50.0,
                          paddingBottom: 10.0,
                        ),
                      )
                    ],
                  ) :
                  const Material(),
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