import 'package:flutter/material.dart';
import 'package:sikoopi_app/widgets/global_input_field.dart';
import 'package:sikoopi_app/widgets/global_padding.dart';

class CheckoutDeliveryFragment extends StatelessWidget {
  final TextEditingController receipentNameTEC;
  final TextEditingController addressDetailTEC;

  const CheckoutDeliveryFragment({
    Key? key,
    required this.receipentNameTEC,
    required this.addressDetailTEC,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GlobalPadding(
      paddingClass: const GlobalPaddingClass(
        paddingLeft: 10.0,
        paddingTop: 10.0,
        paddingRight: 10.0,
        paddingBottom: 10.0,
      ),
      content: ListView(
        shrinkWrap: true,
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0,),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                GlobalTextfield(
                  controller: receipentNameTEC,
                  title: 'Receipent Name',
                  capitalization: TextCapitalization.words,
                  padding: const GlobalPaddingClass(
                    paddingLeft: 20.0,
                    paddingTop: 20.0,
                    paddingRight: 20.0,
                  ),
                ),
                const GlobalPadding(
                  paddingClass: GlobalPaddingClass(
                    paddingLeft: 20.0,
                    paddingRight: 20.0,
                  ),
                  content: Divider(
                    thickness: 2.0,
                  ),
                ),
                GlobalTextFormField(
                  controller: addressDetailTEC,
                  title: 'Address',
                  capitalization: TextCapitalization.sentences,
                  padding: const GlobalPaddingClass(
                    paddingLeft: 20.0,
                    paddingTop: 5.0,
                    paddingRight: 20.0,
                    paddingBottom: 20.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}