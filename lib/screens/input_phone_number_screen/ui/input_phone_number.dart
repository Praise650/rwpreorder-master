import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:rwk20/components/logo.dart';
import 'package:rwk20/components/materialButton.dart';
import 'package:rwk20/screens/create_account_screen/ui/createAccountScreen.dart';

class InputPhoneNumber extends StatefulWidget {
  String thankYou;
  InputPhoneNumber({
    this.thankYou,
    Key key,
  }) : super(key: key);

  @override
  _InputPhoneNumberState createState() => _InputPhoneNumberState();
}

class _InputPhoneNumberState extends State<InputPhoneNumber> {
  PhoneNumber number = PhoneNumber(
    isoCode: 'NG',
  );
  TextEditingController phoneNumberController = TextEditingController();

  SelectorConfig selectorConfig = SelectorConfig(
    selectorType: PhoneInputSelectorType.DIALOG,
    showFlags: true,
    leadingPadding: 8.0,
    trailingSpace: false,
    setSelectorButtonAsPrefixIcon: true,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xff080050),
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: [
            /* RCCG logo as background image of login screen */
            ImageWidget(),
            /* RCCG logo as background image of login screen end here */
            /* Frosted glass to host login field screen starts here */
            Container(
              height: MediaQuery.of(context).size.height * 1.6 / 3,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(100),
                  bottomRight: Radius.circular(100),
                ),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'RCF Membership Registration',
                      style: Theme.of(context).textTheme.headline5,
                      // style: TextStyle(
                      //   fontSize: 18,
                      //   color: Colors.black,
                      // ),
                    ),
                    Text(
                      '${widget.thankYou = 'Fill in your number to get verified'}',
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: InternationalPhoneNumberInput(
                        selectorConfig: selectorConfig,
                        textFieldController: phoneNumberController,
                        initialValue: number,
                        formatInput: true,
                        onInputChanged: (PhoneNumber number) {
                          print(number.phoneNumber);
                        },
                        onSaved: (PhoneNumber number) {
                          setState(() {
                            phoneNumberController.text = number.dialCode;
                          });
                          print('On Saved: ${number.dialCode}');
                        },
                        onInputValidated: (bool value) {
                          print('onInputValidated: $value');
                        },
                        inputBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        keyboardType: TextInputType.numberWithOptions(
                            decimal: true, signed: true),
                        isEnabled: true,
                        hintText: 'Enter your phone number',
                      ),
                    ),

                    // submit button with padding and firebase auth feature and validation
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 10.0,
                        top: 20.0,
                        right: 10.0,
                      ),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 1 / 14,
                        width: MediaQuery.of(context).size.width * 3 / 4,
                        child: materialButton(
                            text: '',
                            iconData: Icons.arrow_forward_ios,
                            onPressed: () {
                              // validating phoneNumberController for user input
                              if (phoneNumberController.text == '') {
                                setState(() {
                                 widget.thankYou =
                                      'Empty phone number field';
                                });
                              } else {
                                // phoneNumberAuth(
                                //   context,
                                //   phoneNumberController.text,
                                // );
                                print(
                                    'Checking phone number for iso code \n ${phoneNumberController.text.toString()}');
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CreateAccountPage(
                                              displayPhoneNumber:
                                                  phoneNumberController.text
                                                      .toString(),
                                            )));
                              }
                            }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
