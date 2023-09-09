import 'package:expense_app/home_page.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.network(
                'https://lottie.host/d35563c5-e4ac-491f-a093-0ccd42e20695/Hbq8OTl6AR.json',
                controller: _controller, onLoaded: (compos) {
              _controller
                ..duration = compos.duration
                ..forward().then((value) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                });
            }, height: 200.0, fit: BoxFit.cover),
          ],
        ),
      ),
    );
  }
}
