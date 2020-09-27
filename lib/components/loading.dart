import 'package:flutter/material.dart';

// TODO: Make the LoadingScreen nicer looking
class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
