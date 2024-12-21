import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:recipieapp/pages/home.dart';
import 'package:recipieapp/pages/onbording.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Onbording(),
    
    );
  }
}

