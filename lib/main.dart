import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled1/login/Homepage/HomePage.dart';
import 'package:untitled1/login/Homepage/HomePageForRestaurant.dart';
import 'package:untitled1/model/UserModel.dart';
import 'package:untitled1/signup/components/signup_auth_provider.dart';
import 'package:untitled1/signup/components/signup_auth_provider_for_restaurant.dart';
import 'package:untitled1/splash.dart';
import "package:untitled1/firebase_options.dart";
import 'package:uuid/uuid.dart';

import 'home.dart';
import 'login/FirebaseHelper.dart';
import 'login/components/login_auth_provider-for_restaurant.dart';
import 'login/components/login_auth_provider.dart';
import 'model/RestaurantModel.dart';

var uuid=Uuid();
final navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SharedPreferences? sharedPreferences = await SharedPreferences.getInstance();
  User? currentUser = FirebaseAuth.instance.currentUser;
  //User? currentUser = FirebaseAuth.instance.currentUser;

  /*
  if(currentUser != null) {
    // Logged In
    UserModel? thisUserModel=await FirebaseHelper.getUserModelById(currentUser.uid);
    RestaurantModel? thisRestaurantModel=await FirebaseHelper.getRestaurantModelById(currentUser.uid);
    if(thisUserModel != null) {
      runApp(MyAppLoggedIn(userModel: thisUserModel, firebaseUser: currentUser));
     //runApp(MyAppLoggedIn());
    }
    else if(thisRestaurantModel != null) {
      runApp(MyAppLoggedInAsRestaurantOwner(restaurantModel: thisRestaurantModel, firebaseUser: currentUser));
      //runApp(MyAppLoggedIn());
    }

    else {
      runApp(MyApp());
    }
  }
  else {
    // Not logged in
    runApp(MyApp());
  }
*/
  runApp(const MyApp());
}



//not logged in
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  void initState(){

    FirebaseApi().initNotification();
  }
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
  //const MyAppLoggedIn({super.key});
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
       navigatorKey: navigatorKey ,
      routes: {
            '/notification_screen':(context)=>const notificationPage(),
      },
      //home:MyHomePage(),
    );
  }
}
//logged in as restaurant owner

class MyAppLoggedInAsRestaurantOwner extends StatelessWidget {
  // This widget is the root of your application.
  final RestaurantModel restaurantModel;
  final User firebaseUser;

  //const MyAppLoggedIn({super.key, required this.userModel, required this.firebaseUser});
  const MyAppLoggedInAsRestaurantOwner({super.key, required this.restaurantModel, required this.firebaseUser});
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
      home: HomePageForRestaurant(restaurantModel: restaurantModel,firebaseUser:firebaseUser),
      //home:MyHomePage(),
    );
  }
}
