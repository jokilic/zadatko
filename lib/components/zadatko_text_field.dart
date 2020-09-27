import 'package:flutter/material.dart';

import '../constants.dart';

// Standardized TextField used across the app
// TODO: Potentially make the TextField nicer looking
// TODO: Create FocusNodes
class ZadatkoTextField extends StatelessWidget {
  final String hintText;
  final bool isObscureText;
  final TextEditingController textEditingController;

  ZadatkoTextField({
    @required this.hintText,
    this.isObscureText = false,
    @required this.textEditingController,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width * 0.8,
      child: Column(
        children: [
          TextField(
            controller: textEditingController,
            obscureText: isObscureText,
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
