
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonPage extends StatelessWidget {
  final void Function()? onTap;
   ButtonPage({super.key, required this.onTap,});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white24,
        ),
      padding: EdgeInsets.all(8),
        child:Center(
          child: Text('Skip',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
        ),
      ),
    );
  }
}
