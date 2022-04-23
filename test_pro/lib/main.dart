import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:test_pro/register.dart';
import 'package:test_pro/landing.dart';
import 'package:test_pro/user_data.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Test Pro",
      home: MyApp(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text(snapshot.error.toString())),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
              title: 'Test Pro',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                  primarySwatch: Colors.red,
                  backgroundColor: Colors.white,
                  scaffoldBackgroundColor: Colors.white),
              home: const LandingPage(),
              );
        }
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
