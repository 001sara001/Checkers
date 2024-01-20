import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/widgets/my_button.dart';

import '../screens/applogo.dart';
import 'package:untitled1/login/components/center_part.dart';
import 'package:untitled1/login/components/top_part.dart';
import 'package:untitled1/login/components/end_part.dart';

import '../widgets/custom_scaffold.dart';
import 'components/login_auth_provider.dart';

class LoginPage extends StatefulWidget {

  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool visible = true;
  @override
  Widget build(BuildContext context) {
    LoginAuthProvider loginAuthProvider =
    Provider.of<LoginAuthProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //top part
            TopPart(),
               //center part
              CenterPart(
                email: email,
                password: password,
                obscureText: visible,
                onPressed: () {
                  setState(() {
                    visible = !visible;
                  });
                },
                icon: Icon(
                  visible ? Icons.visibility_off : Icons.visibility,
                ),
              ),
            //end part
              EndPart(
                loading: loginAuthProvider.loading,
                onPressed: () {
                  loginAuthProvider.loginValidation(
                    emailAdress : email,
                    password: password,
                    context: context,
                  );
                },
              ),


  ],
      ),
      ),
    );

  }
}
//
