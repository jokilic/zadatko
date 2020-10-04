import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import '../../../constants/tasks_screen.dart';
import '../tasks_screen.dart';
import '../../../components/zadatko_text_field.dart';
import '../../../components/zadatko_button.dart';

// Modal that is shown when the user long-taps on the name
void changeName(BuildContext context) {
  TextEditingController changeNameController = TextEditingController();
  FocusNode changeNameFocusNode = FocusNode();

  // Gets called when the user presses the 'Update' button
  void updateName() {
    if (changeNameController.text.isNotEmpty) {
      chosenName = changeNameController.text;
      firestore.updateNameFirebase(chosenName);
      Navigator.pop(context);
    }
  }

  Size size = MediaQuery.of(context).size;

  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (context) => SingleChildScrollView(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        decoration: BoxDecoration(
          color: darkColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12.0),
            topRight: Radius.circular(12.0),
          ),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 36.0,
          vertical: 28.0,
        ),
        height: size.height * 0.4,
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              changeNameString,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headline1
                  .copyWith(fontSize: 36.0),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 24.0,
                bottom: 42.0,
              ),
              child: ZadatkoTextField(
                hintText: titleFieldHintString,
                textEditingController: changeNameController,
                focusNode: changeNameFocusNode,
                onEditingComplete: () => updateName(),
              ),
            ),
            ZadatkoButton(
              text: changeNameButtonString,
              onTap: () => updateName(),
            ),
          ],
        ),
      ),
    ),
  );
}
