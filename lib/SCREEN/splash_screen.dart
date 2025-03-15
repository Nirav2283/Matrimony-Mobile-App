import 'dart:async';
import 'package:flutter/material.dart';
import 'package:matrimony/SCREEN/bottomnavbar.dart';
import 'package:matrimony/SCREEN/dashboard_screen.dart';
import 'package:matrimony/SCREEN/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  static const String KEYLOGIN = "Login";
  @override
  void initState() {
    super.initState();
    whereToGo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 4,
              child: Center(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Image.asset(
                      'assets/images/splash_image.png',
                      height: constraints.maxHeight * 0.7,
                      width: constraints.maxWidth * 0.7,
                      fit: BoxFit.contain,
                    );
                  },
                ),
              ),
            ),

            // Text Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Hi ! There....',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.black,
                  fontSize: 28,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Welcome to MatchAura!',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 24,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'The Best Place to Meet Your Future Partner.',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  color: Colors.orange,
                  fontSize: 36,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(height: 50),
            Center(
              child: Image(
                image: AssetImage('assets/images/loading.gif'),
                height: 100,
                width: 100,
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void whereToGo() async {

    var sharedPref = await SharedPreferences.getInstance();
    var isLoggedIn = sharedPref.getBool(KEYLOGIN);
    Timer(Duration(seconds: 2), () {
      if(isLoggedIn!=null){
        if(isLoggedIn){
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => Bottomnavbar()));
        }else{
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => LoginPage()));
        }
      }else{
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => LoginPage()));
      }

    });
  }
}
