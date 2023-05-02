import 'package:casino_test/src/presentation/pages/character_screen.dart';
import 'package:casino_test/src/presentation/widgets/index.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 2)).then((value) => Navigator.push(
          context,
          PageRouteBuilder(
            transitionDuration: Duration(milliseconds: 1000),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return ScaleTransition(
                scale: Tween<double>(
                  begin: 0.0,
                  end: 1.0,
                ).animate(CurvedAnimation(
                  parent: animation,
                  curve: Curves.fastOutSlowIn,
                )),
                child: child,
              );
            },
            pageBuilder: (context, animation, secondaryAnimation) =>
                CharactersScreen(),
          ),
        ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(39, 43, 52, 1),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/appbar.png'), fit: BoxFit.contain),
            ),
          ),
          Center(
            child: RotatingImage(
              imagePath: 'assets/bg.jpg',
              size: MediaQuery.of(context).size.height * 0.45,
              duration: 2,
            ),
          ),
          const SizedBox(
            height: 150,
          )
        ],
      ),
    );
  }
}
