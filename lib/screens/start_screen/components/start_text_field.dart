import 'package:flutter/material.dart';

import '../../../constants.dart';

class StartTextField extends StatelessWidget {
  final Function onChanged;
  final String hintText;
  final bool isObscureText;

  StartTextField({
    @required this.onChanged,
    @required this.hintText,
    this.isObscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width * 0.8,
      child: Column(
        children: [
          TextField(
            onChanged: onChanged,
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
