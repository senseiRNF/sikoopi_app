import 'package:flutter/material.dart';
import 'package:sikoopi_app/miscellaneous/variables/global_color.dart';
import 'package:sikoopi_app/widgets/global_padding.dart';

// Stateless Widgets -----------------------------------------------------------

class GlobalTextfield extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final TextInputType? inputType;
  final TextCapitalization? capitalization;
  final TextInputAction? inputAction;
  final bool? isBordered;
  final bool? isFilled;
  final Color? fieldColor;
  final GlobalPaddingClass? padding;

  const GlobalTextfield({
    Key? key,
    required this.controller,
    required this.title,
    this.inputType,
    this.capitalization,
    this.inputAction,
    this.isBordered,
    this.isFilled,
    this.fieldColor,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GlobalPadding(
      paddingClass: padding,
      content: TextField(
        controller: controller,
        decoration: InputDecoration(
          label: Text(
            title,
          ),
          border: isBordered != null && isBordered! ?
          OutlineInputBorder(
            borderSide: BorderSide(
              color: GlobalColor.defaultBlack,
            ),
            borderRadius: BorderRadius.circular(50.0,),
          ) :
          UnderlineInputBorder(
            borderSide: BorderSide(
              color: GlobalColor.defaultBlack,
            ),
            borderRadius: BorderRadius.circular(50.0,),
          ),
          filled: isFilled != null && isFilled! ? true : false,
          fillColor: fieldColor ?? GlobalColor.defaultWhite,
        ),
        keyboardType: inputType ?? TextInputType.text,
        textCapitalization: capitalization ?? TextCapitalization.none,
        textInputAction: inputAction ?? TextInputAction.done,
      ),
    );
  }
}

class GlobalTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final TextInputType? inputType;
  final TextCapitalization? capitalization;
  final TextInputAction? inputAction;
  final int? maxLine;
  final bool? isBordered;
  final bool? isFilled;
  final Color? fieldColor;
  final GlobalPaddingClass? padding;

  const GlobalTextFormField({
    Key? key,
    required this.controller,
    required this.title,
    this.inputType,
    this.capitalization,
    this.inputAction,
    this.maxLine,
    this.isBordered,
    this.isFilled,
    this.fieldColor,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GlobalPadding(
      paddingClass: padding,
      content: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          label: Text(
            title,
          ),
          border: isBordered != null && isBordered! ?
          OutlineInputBorder(
            borderSide: BorderSide(
              color: GlobalColor.defaultBlack,
            ),
            borderRadius: BorderRadius.circular(50.0,),
          ) :
          UnderlineInputBorder(
            borderSide: BorderSide(
              color: GlobalColor.defaultBlack,
            ),
            borderRadius: BorderRadius.circular(50.0,),
          ),
          filled: isFilled != null && isFilled! ? true : false,
          fillColor: fieldColor ?? GlobalColor.defaultWhite,
        ),
        keyboardType: inputType ?? TextInputType.text,
        textCapitalization: capitalization ?? TextCapitalization.none,
        textInputAction: inputAction ?? TextInputAction.done,
        maxLines: maxLine ?? 3,
      ),
    );
  }
}

// Stateful Widgets ------------------------------------------------------------

class GlobalPasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String title;
  final TextInputType? inputType;
  final TextCapitalization? capitalization;
  final TextInputAction? inputAction;
  final bool? isBordered;
  final bool? isFilled;
  final Color? fieldColor;
  final GlobalPaddingClass? padding;

  const GlobalPasswordField({
    Key? key,
    required this.controller,
    required this.title,
    this.inputType,
    this.capitalization,
    this.inputAction,
    this.isBordered,
    this.isFilled,
    this.fieldColor,
    this.padding,
  }) : super(key: key);

  @override
  _GlobalPasswordField createState() => _GlobalPasswordField();
}

class _GlobalPasswordField extends State<GlobalPasswordField> {
  bool isObscured = true;

  @override
  void initState() {
    super.initState();
  }

  void changeObscure() {
    setState(() {
      isObscured = !isObscured;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GlobalPadding(
      paddingClass: widget.padding,
      content: TextField(
        controller: widget.controller,
        decoration: InputDecoration(
          label: Text(
              widget.title,
            ),
          border: widget.isBordered != null && widget.isBordered! ?
          OutlineInputBorder(
            borderSide: BorderSide(
              color: GlobalColor.defaultBlack,
            ),
            borderRadius: BorderRadius.circular(10.0,),
          ) :
          UnderlineInputBorder(
            borderSide: BorderSide(
              color: GlobalColor.defaultBlack,
            ),
          ),
          suffixIcon: IconButton(
            onPressed: () => changeObscure(),
            icon: Icon(
              isObscured ? Icons.visibility : Icons.visibility_off,
            ),
          ),
          filled: widget.isFilled != null && widget.isFilled! ? true : false,
          fillColor: widget.fieldColor ?? GlobalColor.defaultWhite,
        ),
        keyboardType: widget.inputType ?? TextInputType.text,
        textCapitalization: widget.capitalization ?? TextCapitalization.none,
        textInputAction: widget.inputAction ?? TextInputAction.done,
        obscureText: isObscured,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}