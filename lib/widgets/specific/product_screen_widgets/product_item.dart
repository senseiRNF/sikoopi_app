import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sikoopi_app/services/api/product_services.dart';
import 'package:sikoopi_app/widgets/global_padding.dart';
import 'package:sikoopi_app/widgets/global_text.dart';

class ProductItem extends StatelessWidget {
  final ProductResponseData product;
  final Function onPressed;

  const ProductItem({
    Key? key,
    required this.product,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10.0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0,)
      ),
      child: InkWell(
        onTap: () => onPressed(),
        customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0,)
        ),
        child: GlobalPadding(
          paddingClass: const GlobalPaddingClass(
            paddingLeft: 10.0,
            paddingTop: 5.0,
            paddingRight: 10.0,
            paddingBottom: 5.0,
          ),
          content: Column(
            children: [
              Expanded(
                child: Image.asset(
                  product.imagePath ?? '',
                  fit: BoxFit.contain,
                ),
              ),
              GlobalText(
                content: product.name ?? 'Unkonwn Name',
                size: 16.0,
                isBold: true,
                align: TextAlign.center,
              ),
              GlobalText(
                content: product.uom ?? 'Unknown UOM',
                align: TextAlign.center,
              ),
              GlobalText(
                content: "Rp.${NumberFormat('#,###', 'en_ID').format(int.parse(product.price ?? '0')).replaceAll(',', '.')},-",
                align: TextAlign.center,
                padding: const GlobalPaddingClass(
                  paddingBottom: 10.0,
                ),
              ),
              GlobalText(
                content: "Stock: ${NumberFormat('#,###', 'en_ID').format(int.parse(product.stock ?? '0')).replaceAll(',', '.')}",
                align: TextAlign.center,
                padding: const GlobalPaddingClass(
                  paddingBottom: 10.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}