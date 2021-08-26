 import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;
      final CollectionReference users =  FirebaseFirestore.instance.collection("users");
Future storeDetails(String name,int phone,String location, int size, var color, ) async {
    return users.add({
      'full_name':  name,
      'phone_number': phone,
      'location': location,
      'size': size,
      'color':color,
    }).then((value) => print('Details Added'))
    .catchError((onError)=>print('$onError'));
   }
