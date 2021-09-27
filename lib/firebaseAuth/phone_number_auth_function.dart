import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rwk20/components/otp_pincode_textfield.dart';
import 'package:rwk20/screens/create_account_screen/ui/createAccountScreen.dart';

Future<void> authPhoneNumber(
    {BuildContext context,
    String phoneNumber,
    FirebaseAuth firebaseAuth}) async {
  TextEditingController otpController;
  final PhoneCodeAutoRetrievalTimeout autoRetrievalTimeout = (String verId) {
    // verificationId = verId;
  };
  PhoneCodeSent smsCodeSent = (String verId, [int forceCodeResend]) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
              title: Text('Enter your OTP code'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    phoneNumber,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.blue,
                    ),
                  ),
                  PincodeTextField(otpController.text),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () async {
                    final credential = PhoneAuthProvider.credential(
                        verificationId: verId, smsCode: otpController.text);
                    UserCredential authCredential =
                        await firebaseAuth.signInWithCredential(credential);
                    if (authCredential.user != null) {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CreateAccountPage(
                                  displayPhoneNumber:
                                      authCredential.user.phoneNumber,
                                )),
                      );
                    }
                  },
                  child: Text('Confirm'),
                ),
              ],
            ));
  };
  PhoneVerificationCompleted verificationCompleted =
      (AuthCredential authCredential) async {
    Navigator.pop(context);
    await firebaseAuth.signInWithCredential(authCredential).then((value) {
      if (value.user != null) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => CreateAccountPage(
                    displayPhoneNumber: value.user.phoneNumber)));
      }
    });
    print('verified');
  };
  PhoneVerificationFailed verificationFailed =
      (FirebaseAuthException authException) {
    print(authException.message.toString());
  };
  await firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: Duration(seconds: 5),
      verificationFailed: verificationFailed,
      verificationCompleted: verificationCompleted,
      codeSent: smsCodeSent,
      codeAutoRetrievalTimeout: autoRetrievalTimeout);
}
