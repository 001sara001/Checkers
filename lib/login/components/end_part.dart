import 'package:flutter/material.dart';


import '../../signup/signup_page.dart';
import '../../widgets/my_button.dart';
class EndPart extends StatelessWidget {
  final void Function()? onPressed;
  final bool loading;
  const EndPart({
    required this.loading,
    required this.onPressed,
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        loading == true
            ? CircularProgressIndicator()
            : MyButton(
          onPressed: onPressed,
          text: "LOG IN",
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Don't have an account?\t\t"),
           GestureDetector(
           onTap: () {
             Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SignupPage(),),
             );
           },

             child:  Text("Sign up"),
           ),
          ],
        ),
      ],
    );
  }
}