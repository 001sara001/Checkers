import 'package:flutter/material.dart';
import 'package:untitled1/login/login_page.dart';
import 'package:untitled1/signup/components/signup_auth_provider.dart';
import 'package:provider/provider.dart';

import '../../widgets/my_button.dart';
class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController fullName=TextEditingController();
  TextEditingController emailAddress=TextEditingController();
  TextEditingController password=TextEditingController();

  bool visibility=false;
  @override
  Widget build(BuildContext context) {
    SignupAuthProvider signupAuthProvider=Provider.of<SignupAuthProvider>(context);
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(

            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text("Sign Up",
                style: TextStyle(
                  fontSize:30,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Column(
                children: [
                  TextFormField(
                    controller: fullName,
                    decoration: const InputDecoration(

                      hintText: "full name",
                    ),
                  ),
                  TextFormField(
                    controller: emailAddress,
                    decoration: const InputDecoration(
                      hintText: "Email address",
                    ),
                  ),
                  TextFormField(
                    obscureText: visibility,
                    controller: password,
                    decoration:  InputDecoration(
                      hintText: "Password",
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            visibility = !visibility;
                          });
                        },
                        icon: Icon(
                          visibility ? Icons.visibility_off : Icons.visibility,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  signupAuthProvider.loading == false?
                  MyButton(
                    onPressed:(){
                      signupAuthProvider.signupValidation(
                          context: context,
                          fullName: fullName,
                          emailAddress: emailAddress,
                          password: password);
                    },
                    text: "SIGN UP",
                  )
                      : Center(
                    child: CircularProgressIndicator(),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account?\t\t"),
                      GestureDetector(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LoginPage(),));
                          },
                          child: const Text("Sign in"),),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
