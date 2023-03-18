import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_app_1/pages/landing_page.dart';

import 'package:task_app_1/services/auth_service.dart';

void main() async{
     WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {

    return Provider<AuthBase>(
         create: (context) => Auth(),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
        title: 'Tasks',
        theme: ThemeData(
         
          primarySwatch: Colors.blue,
        ),
        home: const LandingPage(),
      ),
    );}
}
