import 'package:flutter/material.dart';
import 'package:untitled1/screens/signin_screen.dart';
import 'package:untitled1/screens/signup_screen.dart';
import 'package:untitled1/theme/theme.dart';
import 'package:untitled1/widgets/custom_scaffold.dart';
import 'package:untitled1/widgets/welcome_button.dart';
import 'package:untitled1/screens/applogo.dart';

import '../login/components/login_page_for_restaurant.dart';
import '../signup/components/signup_page_for_restaurant.dart';
import '../signup/signup_page.dart';

class Restaurant extends StatefulWidget {
  const Restaurant({super.key});

  @override
  State<Restaurant> createState() => _RestaurantState();
}
class _RestaurantState extends State<Restaurant> {

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
                  textAlign: TextAlign.start,
                  text: const TextSpan (
                    children: [

                      //Image.asset("assets/images/Checkers.png",40);
                      TextSpan(
                        text: 'Log in as restaurant owner\n',
                        style: TextStyle(
                          fontSize: 25.0,
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
                  //const applogo(),
                  const Expanded(
                    child: WelcomeButton(
                      buttonText: 'Log in ',
                      onTap: LoginPageForRestaurant(),
                      color: Colors.transparent,
                      textColor: Colors.white ,
                    ),
                  ),
                  Expanded(
                    child: WelcomeButton(
                      buttonText: 'Sign up',
                      onTap: const SignupPageForRestaurant(),
                      color: Colors.white,
                      textColor: lightColorScheme.primary,
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