import 'package:flutter/material.dart';
import 'package:rwk20/components/richtext_widget.dart';

showAlert({
  BuildContext context,
  @required TextEditingController phoneNumberController,
  Widget buildPinCodeTextFields,
  Function onPressed,
}) {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new SimpleDialog(
          backgroundColor: Colors.white,
          title: Text('Enter OTP code'),
          children: [
            Text(
              phoneNumberController.text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                color: Colors.blue,
              ),
            ),
            SimpleDialogOption(
              child: buildPinCodeTextFields,
            ),
            richText(),
            TextButton(onPressed: onPressed, child: Text('OK'))
          ],
        );
      });
}
