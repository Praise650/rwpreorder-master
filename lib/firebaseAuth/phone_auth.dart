import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rwk20/components/otp_pincode_textfield.dart';
import 'package:rwk20/screens/create_account_screen/ui/createAccountScreen.dart';

Future<void> phoneNumberAuth(
  BuildContext context,
  String phoneNumberController,
) async {
  TextEditingController otpController;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  await firebaseAuth.verifyPhoneNumber(
      phoneNumber: "+234" + "phoneNumberController.trim()",
      timeout: Duration(seconds: 5),
      verificationCompleted: (AuthCredential authCredential) {
        firebaseAuth.signInWithCredential(authCredential).catchError((onError) {
          print(onError);
        });
      },
      verificationFailed: (FirebaseAuthException error) {
        if (error.code == 'invalid-phone-number') {
          return Text('The phone number provided is not valid');
        }
      },
      codeSent: (String verificationId, int forceResendingToken) async {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => AlertDialog(
                  title: Text('Enter your OTP code'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      buildPinCodeTextField(otpController),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () async {
                        PhoneAuthCredential _credential =
                            PhoneAuthProvider.credential(
                                verificationId: verificationId,
                                smsCode: otpController.text.trim());
                        await firebaseAuth
                            .signInWithCredential(_credential)
                            .then((value) => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CreateAccountPage(
                                          displayPhoneNumber:
                                              phoneNumberController,
                                        ))));
                      },
                      child: Text('Ok'),
                    ),
                  ],
                ));
      },
      codeAutoRetrievalTimeout: (
        String verificationId,
      ) {
        otpController.text = verificationId;
        print(verificationId);
        print("Time Out");
      });
}
