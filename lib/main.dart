import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'homeScreen.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(home: const HomePage(),
  theme: ThemeData(
    fontFamily: 'Circular'
  ),
  ));
}


class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: const [
          HomeScreen(),
        ],
      ),
    );
  }
}
