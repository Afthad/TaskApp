
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_app_1/pages/dashboard_page.dart';
import 'package:task_app_1/pages/login_page.dart';
import 'package:task_app_1/services/auth_service.dart';
import 'package:task_app_1/services/database.dart';



class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context);
    return StreamBuilder<User?>(
        stream: auth.onAuthStateChanged,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            User? user = snapshot.data;
            if (user == null) {
              return const LoginPage();
            }
            return Provider<Database>(
              create: (_) => FirestoreDatabase(uid:user.uid),
              child: Dashboard(uid: user.uid,)
            );
       
          } else {
            return Container();
          }
     
        });
  }
}
