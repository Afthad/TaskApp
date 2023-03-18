import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_app_1/services/auth_service.dart';
import 'package:task_app_1/widgets/text_widget.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MaterialButton(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            color: Colors.blue,
            child:const TextWidget(text: 'Login with Google',color: Colors.white,fontSize: 16,fontWeight: FontWeight.w700,),
            onPressed: (){
              auth.signInWithGoogle();
            },
          ),
          Container(),
        ],
      ),
    );
  }
}