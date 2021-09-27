import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:rwk20/firebaseAuth/phone_number_auth_function.dart';
import 'package:rwk20/screens/create_account_screen/ui/createAccountScreen.dart';
import 'package:rwk20/ui/base_widget.dart';

import '../../../app.dart';

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
  TextStyle typeTitleTextStyle =
        TextStyle(fontWeight: FontWeight.bold, fontSize: 20);
    TextStyle typeTextStyle =
        TextStyle(fontWeight: FontWeight.w400, fontSize: 18);

  String verificationId;
  //Instance of firebase authentication for mobile number
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  TextEditingController phoneNumberController = TextEditingController();
  PhoneNumber number = PhoneNumber(
    isoCode: 'NG',
  );
  SelectorConfig selectorConfig = SelectorConfig(
    selectorType: PhoneInputSelectorType.DIALOG,
    showFlags: true,
    leadingPadding: 8.0,
    trailingSpace: false,
    setSelectorButtonAsPrefixIcon: true,
  );

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      builder: (context, sizingInformation) {
        return Scaffold(
          appBar: AppBar(
            title: Text('RW \'20 Preorder'),
          ),
          resizeToAvoidBottomInset: true,
          backgroundColor: App.primaryColor,
          body: SafeArea(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      // TODO: Add nice title here
                      // what can be here
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
                      padding: const EdgeInsets.all(8.0),
                      child: InternationalPhoneNumberInput(
                        selectorConfig: selectorConfig,
                        textFieldController: phoneNumberController,
                        initialValue: number,
                        formatInput: true,
                        onInputChanged: (PhoneNumber number) {
                          print(number.phoneNumber);
                        },
                        // onSaved: (PhoneNumber number) {
                          
                        //   print('On Saved: ${number.dialCode}');
                        // },
                        onInputValidated: (bool value) {
                          setState(() {
                            phoneNumberController.text = value as String;
                          });
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
                      padding: const EdgeInsets.only(left:8.0,right: 8.0,top: 20.0,),
                      child: Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                                onPressed: () async {
                                  Navigator.push(context, MaterialPageRoute(builder:(context)=>CreateAccountPage()));
                                  print(
                                      'Checking phone number for iso code \n ${phoneNumberController.text.toString()}');
                                  authPhoneNumber(
                                    context: context,
                                    phoneNumber: phoneNumberController.text,
                                    firebaseAuth: firebaseAuth,
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Text(
                                    "Verify Number",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // This trailing comma makes auto-formatting nicer for build methods.
        );
      }
    );
  }
}




                        // Container(
                        //   height: MediaQuery.of(context).size.height * 1 / 14,
                        //   width: MediaQuery.of(context).size.width * 3 / 4,
                        //   child: materialButton(
                        //       text: '',
                        //       iconData: Icons.arrow_forward_ios,
                        //       onPressed: () async {
                        //         // validating phoneNumberController for user input
                        //         if (phoneNumberController.text == '') {
                        //           setState(() {
                        //             widget.thankYou = 'Empty phone number field';
                        //           });
                        //         } else {}
                        //       }),
                        // ),