import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Greškica se dogodila 🥺',
        style: TextStyle(
          color: Colors.white,
          fontSize: 36.0,
        ),
      ),
    );
  }
}
