import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rwk20/components/logo.dart';
import 'package:rwk20/components/materialButton.dart';
import 'package:rwk20/screens/input_phone_number_screen/ui/input_phone_number.dart';
import 'package:rwk20/ui/views/home_view.dart';

// ignore: must_be_immutable
class CreateAccountPage extends StatefulWidget {
  String displayPhoneNumber;
  CreateAccountPage({
    this.displayPhoneNumber,
    Key key,
  }) : super(key: key);

  @override
  _CreateAccountPageState createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  String groupValue;
  String thanks = 'Thank you for your filing out the form';

  // bool visible;
  // Required for form validations
  final formKey = GlobalKey<FormState>();

  // Handles text onchange
  TextEditingController nameController = new TextEditingController();
  TextEditingController lastNameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController setYearController = new TextEditingController();
  TextEditingController departmentController = new TextEditingController();
  TextEditingController homeAddressController = new TextEditingController();
  TextEditingController schoolAddressController = new TextEditingController();

  // Future<List> sendData() async {
  //   var url = "http://192.168.43.162/phpmodels/registration.php";
  //
  //   final response = await http.post(Uri.parse(url), body: {
  //     "name": nameController.text,
  //     "email": emailController.text,
  //     "mobile": widget.displayPhoneNumber,
  //   });
  //
  //   var datauser = json.decode(response.body);
  //   print('$datauser');
  // }
  // Boolean variable for CircularProgressIndicator.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xff080050),
      /* Frosted glass to host login field screen starts here */
      body: SafeArea(
        child: ListView(
          children: [
            /* RCCG logo as background image of login screen */
            ImageWidget(),
            /* RCCG logo as background image of login screen end here */

            Container(
              height: MediaQuery.of(context).size.height * 2 / 3,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(100),
                  bottomRight: Radius.circular(100),
                ),
                color: Colors.white,
                // .withOpacity(.6),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Create Account',
                            style: Theme.of(context).textTheme.headline4,
                          ),
                          InputField(
                            label: "First Name",
                            controller: nameController,
                          ),
                          InputField(
                            label: "Last Name",
                            controller: lastNameController,
                          ),
                          InputField(
                            label: "Email",
                            controller: emailController,
                          ),
                          InputField(
                            label: "Set",
                            controller: setYearController,
                          ),
                          TextFormField(
                            readOnly: true,
                            decoration: InputDecoration(
                              enabled: false,
                              hintText: '${widget.displayPhoneNumber}',
                              hintStyle: TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 20.0),
                                  child: Text('Gender:'),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Male'),
                                          Radio(
                                              activeColor: Colors.red,
                                              value: 'Male',
                                              groupValue: groupValue,
                                              onChanged: (String value) {
                                                if (value == 'Male') {
                                                  setState(() {
                                                    groupValue = value;
                                                  });
                                                }
                                              }),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Female'),
                                          Radio(
                                              activeColor: Colors.red,
                                              value: 'Female',
                                              groupValue: groupValue,
                                              onChanged: (String value) {
                                                if (value == 'Female') {
                                                  setState(() {
                                                    groupValue = value;
                                                  });
                                                }
                                              }),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          InputField(
                            label: "Department",
                            controller: departmentController,
                          ),
                          InputField(
                            label: "Home Address",
                            controller: homeAddressController,
                          ),
                          InputField(
                            label: "School Address",
                            controller: schoolAddressController,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 20,
                              left: 10.0,
                              right: 10.0,
                            ),
                            child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 1 / 14,
                                width:
                                    MediaQuery.of(context).size.width * 3 / 4,
                                child: materialButton(
                                  text: 'Create Account',
                                  onPressed: () async {
                                    List list = [];
                                    list.add(
                                      {
                                        nameController.text.toString(),
                                        lastNameController.text.toString(),
                                        emailController.text.toString(),
                                        widget.displayPhoneNumber
                                            .trim()
                                            .toString(),
                                        groupValue,
                                        departmentController.text.toString(),
                                        setYearController.text.toString(),
                                        schoolAddressController.text.toString(),
                                        homeAddressController.text.toString(),
                                      },
                                    );
                                    print(list);
                                    await pushData();
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                InputPhoneNumber(
                                                  thankYou: thanks,
                                                )));
                                  },
                                )),
                          ),
                          // Visibility(
                          //     visible: visible,
                          //     child: Container(
                          //         margin: EdgeInsets.only(bottom: 30),
                          //         child: CircularProgressIndicator())),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      /* Frosted glass to host login field screen end here */
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future<http.Response> pushData() async {
    // url to registration php script
    // var APIURL = "http://192.168.43.162/phpmodels/registration.php";
    // var apiUrl ="http://127.0.0.1:8000/api/register";
    // var apiUrl = "http://10.0.2.2/api/register";
    var apiUrl = "http://192.168.43.162/api/register";

    //json maping user entered details
    Map mapdata = {
      'name': nameController.text.toString(),
      'lastname': lastNameController.text.toString(),
      'email': emailController.text.toString(),
      'phoneNumber': widget.displayPhoneNumber.trim(),
      'gender': groupValue,
      'department': departmentController.text.toString(),
      'setyear': setYearController.text.toString(),
      'schoolAddress': schoolAddressController.text.toString(),
      'homeAddress': homeAddressController.text.toString(),
    };
    //send  data using http post to our php code
    http.Response response = await http.post(
      Uri.parse(apiUrl),
      // headers: {'Accept': 'application/json'},
      body: json.encode(mapdata),
    );
    //getting response from php code, here
    var data = await json.decode(response.body);
    print("DATA:$data");
  }
}

// Http post request to create new data
//   Future<Response> _createStudent() async {
//     Response response = await post(
//       Uri.parse(
//         "${Env.URL_PREFIX}",
//         // "http://192.168.2.28/flutter_api/create",
//       ),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode({
//         'name': nameController.text,
//         'gender': groupValue,
//         'lastname': lastNameController.text,
//       }),
//     );
//     print((response.body));
//     return response;
//   }
// }
