import 'package:flutter/material.dart';

// Should be some fancy spinner
class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
