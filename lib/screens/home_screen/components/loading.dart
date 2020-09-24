import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Učitavanje... 👷‍♂️',
        style: TextStyle(
          color: Colors.white,
          fontSize: 36.0,
        ),
      ),
    );
  }
}
