import 'package:flutter/material.dart';
import 'package:untitled1/login/login_page.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/signup/components/signup_auth_provider_for_restaurant.dart';

import '../../widgets/my_button.dart';
class SignupPageForRestaurant extends StatefulWidget {
  const SignupPageForRestaurant({Key? key}) : super(key: key);

  @override
  State<SignupPageForRestaurant> createState() => _SignupPageForRestaurantState();
}

class _SignupPageForRestaurantState extends State<SignupPageForRestaurant> {
  TextEditingController fullRestaurantName=TextEditingController();
  TextEditingController restaurantEmailAddress=TextEditingController();
  TextEditingController password=TextEditingController();

  bool visibility=false;
  @override
  Widget build(BuildContext context) {
    SignupAuthProviderForRestaurant signupAuthProviderForRestaurant=Provider.of<SignupAuthProviderForRestaurant>(context);
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
              const Text("Register",
                style: TextStyle(
                  fontSize:30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Column(
                children: [
                  TextFormField(
                    controller: fullRestaurantName,
                    decoration: const InputDecoration(

                      hintText: "Restaurant name",
                    ),
                  ),
                  TextFormField(
                    controller: restaurantEmailAddress,
                    decoration: const InputDecoration(
                      hintText: "Restaurant Email address",
                    ),
                  ),
                  TextFormField(
                    obscureText: visibility,
                    controller: password,
                    decoration:  InputDecoration(
                      hintText: "Password for the restaurant",
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
                  signupAuthProviderForRestaurant.loading == false?
                  MyButton(
                    onPressed:(){
                      signupAuthProviderForRestaurant.signupValidation(
                          context: context,
                          fullRestaurantName : fullRestaurantName,
                          restaurantEmailAddress: restaurantEmailAddress,
                          restaurantPassword: password);
                    },
                    text: "Register",
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
                      Text("Already have an account for the restaurant?\t\t"),
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
