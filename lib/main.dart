import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:rwk20/screens/input_phone_number_screen/ui/input_phone_number.dart';

void main() async {
  // runApp(DevicePreview(builder: (context) => MyApp()));
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = new MyHttpOverrides();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // The future is part of the state of our widget. We should not call `initializeApp`
  /// directly inside [build].
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        // ignore: missing_return
        builder: (context, snapshot) {
          // Check for errors
          if (snapshot.hasError) {
            return MaterialApp(
                debugShowCheckedModeBanner: false,
                home: 
                Scaffold(
                  body: Container(
                    child: Center(
                      child: Text(
                          "Something Went Wrong!... Could not initialize connection."),
                    ),
                  ),
                ));
          }

          // Once complete, show your application
          if (snapshot.connectionState == ConnectionState.done) {
            return MaterialApp(
              // builder: DevicePreview.appBuilder,
              title: 'Redemption Week Preorder',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: Colors.orange,
              ),
              home: InputPhoneNumber(),
            );
          }

          // Otherwise, show something whilst waiting for initialization to complete
          return Container(
            child: Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            ),
          );
        });
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
// class MyApp2 extends StatelessWidget {
//   const MyApp2({ Key key }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//               // builder: DevicePreview.appBuilder,
//               title: 'Redemption Week Preorder',
//               debugShowCheckedModeBanner: false,
//               theme: ThemeData(
//                 primarySwatch: Colors.orange,
//               ),
//               home: InputPhoneNumber(),
//             );
//   }
// }