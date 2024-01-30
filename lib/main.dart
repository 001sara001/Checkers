import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled1/home.dart';
import 'package:untitled1/login/FirebaseHelper.dart';
import 'package:untitled1/login/Homepage/HomePage.dart';
import 'package:untitled1/model/UserModel.dart';
import 'package:untitled1/page/Profile.dart';
import 'package:untitled1/screens/welcome_screen.dart';
import 'package:untitled1/signup/components/signup_auth_provider.dart';
import 'package:untitled1/signup/components/signup_auth_provider_for_restaurant.dart';
import 'package:untitled1/splash.dart';
import "package:untitled1/firebase_options.dart";

import 'login/components/login_auth_provider-for_restaurant.dart';
import 'login/components/login_auth_provider.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SharedPreferences? sharedPreferences = await SharedPreferences.getInstance();
  User? currentUser=FirebaseAuth.instance.currentUser;
  if(currentUser != null) {
    // Logged In
    UserModel? thisUserModel=await FirebaseHelper.getUserModelById(currentUser.uid);
    if(thisUserModel != null) {
      runApp(MyAppLoggedIn(userModel: thisUserModel, firebaseUser: currentUser));
    }
    else {
      runApp(MyApp());
    }
  }
  else {
    // Not logged in
    runApp(MyApp());
  }

  //runApp(const MyApp());

}

//not logged in
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context)=>SignupAuthProvider(),
          ),
          ChangeNotifierProvider(
            create: (context)=>LoginAuthProvider(),
          ),
          ChangeNotifierProvider(
            create: (context)=>SignupAuthProviderForRestaurant(),
          ),
          ChangeNotifierProvider(
            create: (context)=>LoginAuthProviderForRestaurant(),
          )
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'CHECKERS',
          theme: ThemeData(
            appBarTheme: AppBarTheme(
              iconTheme: IconThemeData(
                color: Colors.black,
              ),
            ),
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
            useMaterial3: true,
          ),
          home: const Splash(),
        )

    );
  }
}
//logged in
class MyAppLoggedIn extends StatelessWidget {
  // This widget is the root of your application.
  final UserModel userModel;
  final User firebaseUser;

  const MyAppLoggedIn({super.key, required this.userModel, required this.firebaseUser});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            appBarTheme: AppBarTheme(
              iconTheme: IconThemeData(
                color: Colors.black,
              ),
            ),
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
            useMaterial3: true,
          ),
          home: HomePage(userModel: userModel,firebaseUser:firebaseUser),
        );
  }
}





