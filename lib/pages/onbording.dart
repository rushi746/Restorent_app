// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:recipieapp/pages/home.dart';

class Onbording extends StatefulWidget {
  const Onbording({super.key});

  @override
  State<Onbording> createState() => _OnbordingState();
}

class _OnbordingState extends State<Onbording> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 50.0),
            Center(child: Image.asset("images/pan1.jpg", height: 300,width: 300,)),
            SizedBox(height: 15.0,),
            Text("Discover your food ",
            style: TextStyle(color: Colors.black,fontSize: 26.0,fontWeight:FontWeight.bold),  
            ),

                        SizedBox(height: 20.0),
            Padding(padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore ",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black54,
                fontSize: 18.0,
                fontWeight: FontWeight.w500
              ),
            ),
            ),
            SizedBox(height: 70.0),
            Material(
              elevation: 3.0,
              borderRadius: BorderRadius.circular(20),
              child: Container(
                height: 60,
                width: MediaQuery.of(context).size.width / 2,
                decoration: BoxDecoration(
                  color: Color(0xffff734c),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      // Navigate to the Home page
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Home()),
                      );
                    },
                    child: Text(
                      "Next",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
         

            
          ],
        ),
      ),
    );
  }
}