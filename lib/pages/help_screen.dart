import 'dart:async';

import 'package:flutter/material.dart';
import 'package:weatherapp/components/button.dart';
import 'package:weatherapp/pages/homepage_screen.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePageScreen()));
    });
  }

  void NavigatePage(BuildContext context) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomePageScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('lib/images/frame.avif',fit: BoxFit.cover,),
          Column(
            children: [
              SizedBox(
                height: 320,
              ),
              Icon(Icons.cloudy_snowing,size: 120,),
              Text(
                'We Show Weather For You',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 230,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 130.0),
                child: ButtonPage(
                  onTap: () {
                    NavigatePage(context);
                  },
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
