import 'package:flutter/material.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

// PinCodeTextField buildPinCodeTextField(TextEditingController otpController) {
//   return PinCodeTextField(
//     defaultBorderColor: Colors.white,
//     pinBoxRadius: 10,
//     pinBoxColor: Colors.grey.withOpacity(.4),
//     controller: otpController,
//     maxLength: 6,
//     hideCharacter: false,
//     hasTextBorderColor: Colors.grey.withOpacity(.2),
//     highlightPinBoxColor: Colors.grey.withOpacity(.3),
//     pinBoxBorderWidth: 0.0,
//     keyboardType: TextInputType.number,
//     textDirection: TextDirection.ltr,
//     pinBoxHeight: 45,
//     pinBoxWidth: 35,
//   );
// }


class PincodeTextField extends StatefulWidget {
  String otpController;
  PincodeTextField(String otpController, { Key key,}) : super(key: key);

  @override
  _PincodeTextFieldState createState() => _PincodeTextFieldState();
}

class _PincodeTextFieldState extends State<PincodeTextField> {
  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
    onTextChanged: (value){
      widget.otpController = value;
    },
    defaultBorderColor: Colors.white,
    pinBoxRadius: 10,
    pinBoxColor: Colors.grey.withOpacity(.4),
    // controller: otpController,
    maxLength: 6,
    hideCharacter: false,
    hasTextBorderColor: Colors.grey.withOpacity(.2),
    highlightPinBoxColor: Colors.grey.withOpacity(.3),
    pinBoxBorderWidth: 0.0,
    keyboardType: TextInputType.number,
    textDirection: TextDirection.ltr,
    pinBoxHeight: 45,
    pinBoxWidth: 35,
  );
  }
}