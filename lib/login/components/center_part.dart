import 'package:flutter/material.dart';
import 'package:untitled1/login/route/routing_page.dart';

import '../../forgot_password/forgot_password.dart';

class CenterPart extends StatelessWidget {
  final TextEditingController? email;
  final bool obscureText;
  final TextEditingController? password;
  final Widget icon;
  final void Function()? onPressed;
  CenterPart({
    required this.obscureText,
    required this.icon,
    required this.email,
    required this.password,
    required this.onPressed,
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          TextFormField(
            controller: email,
            decoration: InputDecoration(
              hintText: "Email",
            ),
          ),
          TextFormField(
            obscureText: obscureText,
            controller: password,
            decoration: InputDecoration(
              counter: GestureDetector(
                onTap: () {
                  RoutingPage.goTonext(
                    context: context,
                    navigateTo: ForgotPassword(),
                  );
                },
                child: Text(
                  "Forgot Password?",
                  style: TextStyle(
                    color: Colors.green,
                  ),
                ),
              ),
              hintText: "Password",
              suffixIcon: IconButton(onPressed: onPressed, icon: icon),
            ),
          ),
        ],
      ),
    );
  }

}
