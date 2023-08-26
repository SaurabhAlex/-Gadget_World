import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:grocery_app/firebase_helper/firebase_auth_helper/auth_helper.dart';
import 'package:grocery_app/firebase_options.dart';
import 'package:grocery_app/provider/app_provider.dart';
import 'package:grocery_app/screens/bottom_navBar/bottom_nav_bar.dart';
import 'package:grocery_app/screens/welcome/welcome.dart';
import 'package:provider/provider.dart';
import 'constants/theme.dart';



Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey=
  "pk_test_51MWx8OAVMyklfe3CsjEzA1CiiYOXBTlHYbZ8jQlGtVFlwQi4aNeGv8J1HUw4rgSavMTLzTwgn0XRlwoTVRFXyu2h00mRUeWmAf";
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppProvider(),
      child: MaterialApp(
        title: 'Tech Junction',
        debugShowCheckedModeBanner: false,
        theme: themeData,
        home: StreamBuilder(
            stream: FirebaseAuthHelper.instance.getAuthChange,
            builder: (context, snapshot){
              if(snapshot.hasData){
                return const BottomNavBar();
              }
              return const WelcomeScreen();
            }
        )
      ),
    );
  }
}