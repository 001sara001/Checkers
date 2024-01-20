import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/home.dart';
import 'package:untitled1/screens/welcome_screen.dart';
import 'package:untitled1/signup/components/signup_auth_provider.dart';
import 'package:untitled1/signup/components/signup_auth_provider_for_restaurant.dart';
import 'package:untitled1/signup/signup_page.dart';
import 'package:untitled1/splash.dart';
import "package:untitled1/firebase_options.dart";

import 'login/components/login_auth_provider-for_restaurant.dart';
import 'login/components/login_auth_provider.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

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
          title: 'Flutter Demo',
          theme: ThemeData(
            appBarTheme: AppBarTheme(
              iconTheme: IconThemeData(
                color: Colors.black,
              ),
            ),
            // This is the theme of your application.
            //
            // TRY THIS: Try running your application with "flutter run". You'll see
            // the application has a purple toolbar. Then, without quitting the app,
            // try changing the seedColor in the colorScheme below to Colors.green
            // and then invoke "hot reload" (save your changes or press the "hot
            // reload" button in a Flutter-supported IDE, or press "r" if you used
            // the command line to start the app).
            //
            // Notice that the counter didn't reset back to zero; the application
            // state is not lost during the reload. To reset the state, use hot
            // restart instead.
            //
            // This works for code too, not just values: Most code changes can be
            // tested with just a hot reload.
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
            useMaterial3: true,
          ),
          home: const Splash(),
        )

    );
  }
}
//





