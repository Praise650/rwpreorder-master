import 'package:flutter/material.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

PinCodeTextField buildPinCodeTextField(TextEditingController otpController) {
  return PinCodeTextField(
    defaultBorderColor: Colors.white,
    pinBoxRadius: 10,
    pinBoxColor: Colors.grey.withOpacity(.4),
    controller: otpController,
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
