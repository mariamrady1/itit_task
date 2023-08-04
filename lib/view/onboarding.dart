import 'package:flutter/material.dart';
import 'package:mariamproject/view/auth/login.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(alignment: Alignment.bottomCenter, children: [
          Image.asset(
            'assets/images/mariam.jpg',
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.fill,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Container(
                width: 300,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(50))),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) {
                      return LogIn();
                    }));
                  },
                  child: Text(
                    'Get Started',
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
