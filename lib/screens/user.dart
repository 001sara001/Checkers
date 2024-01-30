import 'package:flutter/material.dart';
import '../login/login_page.dart';
import '../signup/signup_page.dart';
import '../theme/theme.dart';
import '../widgets/custom_scaffold.dart';
import '../widgets/welcome_button.dart';
import 'applogo.dart';

class user extends StatelessWidget {
  const user({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Column(
        children: [
          const applogo(),
          Flexible(
            flex: 2,
            child: Container(

              padding: const EdgeInsets.symmetric(
                vertical: 0,
                horizontal: 40.0,
              ),
              child: Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan (
                    children: [
                      // Image.asset("assets/images/Checkers.png",40);
                      TextSpan(
                        text: 'Log in as user\n',
                        style: TextStyle(
                          fontSize:35.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            flex: 3,
            child: Align(
              alignment: Alignment.bottomCenter,

              child: Row(
                children: [

                  const Expanded(
                    child: WelcomeButton(
                      buttonText: 'Log in ',
                      onTap: LoginPage(),
                      color: Colors.transparent,
                      textColor:  Colors.white ,
                    ),
                  ),
                  Expanded(
                    child: WelcomeButton(
                      buttonText: 'Sign up',
                      onTap: const SignupPage(),
                      color: Colors.white,
                      textColor:  lightColorScheme.primary,
                    ),

                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
