import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/login/components/top_part_for_restaurant.dart';
import 'package:untitled1/widgets/my_button.dart';


import 'package:untitled1/login/components/center_part.dart';
import 'package:untitled1/login/components/top_part.dart';
import 'package:untitled1/login/components/end_part.dart';



import 'center_part_for_restaurant.dart';
import 'end_part_for_restaurant.dart';
import 'login_auth_provider-for_restaurant.dart';
import 'login_auth_provider.dart';

class LoginPageForRestaurant extends StatefulWidget {

  const LoginPageForRestaurant({Key? key}) : super(key: key);

  @override
  State<LoginPageForRestaurant> createState() => _LoginPageForRestaurantState();
}

class _LoginPageForRestaurantState extends State<LoginPageForRestaurant> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool visible = true;
  @override
  Widget build(BuildContext context) {
    LoginAuthProviderForRestaurant loginAuthProviderForRestaurant =
    Provider.of<LoginAuthProviderForRestaurant>(context);
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
            TopPartForRestaurant(),
            //center part
            CenterPartForRestaurant(
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
            EndPartForRestaurant(
              loading: loginAuthProviderForRestaurant.loading,
              onPressed: () {
                loginAuthProviderForRestaurant.loginValidation(
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
