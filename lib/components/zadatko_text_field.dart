import 'package:flutter/material.dart';

import '../constants/colors.dart';

// Standardized TextField used across the app
class ZadatkoTextField extends StatelessWidget {
  final String hintText;
  final bool isObscureText;
  final TextEditingController textEditingController;
  final FocusNode focusNode;
  final Function onEditingComplete;
  final int maxLines;
  final TextCapitalization textCapitalization;
  final TextInputType textInputType;

  ZadatkoTextField({
    @required this.hintText,
    this.isObscureText = false,
    @required this.textEditingController,
    @required this.focusNode,
    @required this.onEditingComplete,
    this.maxLines = 1,
    this.textCapitalization = TextCapitalization.sentences,
    this.textInputType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width * 0.8,
      child: Column(
        children: [
          TextField(
            textCapitalization: textCapitalization,
            keyboardType: textInputType,
            maxLines: maxLines,
            controller: textEditingController,
            obscureText: isObscureText,
            focusNode: focusNode,
            onEditingComplete: onEditingComplete,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: lightColor,
              fontSize: 22.0,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              focusedBorder: buildInputBorder(),
              enabledBorder: buildInputBorder(),
              hintText: hintText,
              hintStyle: TextStyle(
                color: lightColor.withOpacity(0.5),
              ),
            ),
            cursorColor: lightColor,
            cursorRadius: Radius.circular(16.0),
            cursorWidth: 4.0,
          ),
        ],
      ),
    );
  }

  UnderlineInputBorder buildInputBorder() {
    return UnderlineInputBorder(
      borderSide: BorderSide(
        color: lightColor,
        width: 3.0,
      ),
    );
  }
}
