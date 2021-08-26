import 'package:flutter/material.dart';
import 'package:rwk20/components/logo.dart';
import 'package:rwk20/components/materialButton.dart';
import 'package:rwk20/components/otp_pincode_textfield.dart';
import 'package:rwk20/components/richtext_widget.dart';
import 'package:rwk20/screens/create_account_screen/ui/createAccountScreen.dart';

class PhoneAuth extends StatefulWidget {
  final phoneNumber;
  PhoneAuth(
    this.phoneNumber, {
    Key key,
  }) : super(key: key);

  @override
  _PhoneAuthState createState() => _PhoneAuthState();
}

class _PhoneAuthState extends State<PhoneAuth> {
  TextEditingController otpController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xff080050),
      body: SafeArea(
        child: ListView(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            /* RCCG logo as background image of login screen */
            ImageWidget(),
            /* RCCG logo as background image of login screen end here */
            /* Frosted glass to host login field screen starts here */
            Container(
              height: MediaQuery.of(context).size.height * 1.8 / 3,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(100),
                  bottomRight: Radius.circular(100),
                ),
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Verify Phone',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.blue,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Column(
                      children: [
                        Text(
                          'Please enter the 6-digit OTP code sent to',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          widget.phoneNumber,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ),
                  buildPinCodeTextField(otpController),
                  richText(),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10.0,
                      top: 10.0,
                      right: 10.0,
                    ),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 1 / 14,
                      width: MediaQuery.of(context).size.width * 3 / 4,
                      child: materialButton(
                        text: 'Proceed',
                        iconData: Icons.arrow_forward_ios,
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CreateAccountPage(
                                      displayPhoneNumber: widget.phoneNumber,
                                    ))),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      /* Frosted glass to host login field screen end here */
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
