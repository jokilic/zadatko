import 'package:flutter/material.dart';

import '../../../constants/colors.dart';

int chosenColor;

// Colors that are shown in the 'createTag' modal
class ColorPicker extends StatefulWidget {
  @override
  _ColorPickerState createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.0,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: tagColors.length,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            setState(() {
              // If already selected Color is pressed, deselect colors
              chosenColor == index ? chosenColor = null : chosenColor = index;
            });
          },
          child: Container(
            width: 45.0,
            height: 45.0,
            margin: EdgeInsets.symmetric(horizontal: 12.0),
            decoration: BoxDecoration(
              color: chosenColor == index
                  ? tagColors[index]
                  : tagColors[index].withOpacity(0.25),
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}
