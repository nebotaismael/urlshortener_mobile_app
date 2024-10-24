import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Widget buttonSection(BuildContext context){
  final size = MediaQuery.of(context).size;
  return  Container(
    width: size.width,
    color: const Color.fromARGB(255, 51, 31, 61),
    child: Stack(
      children: [
        Positioned(
            child:
            SvgPicture.asset('assets/bg-boost-mobile.svg')),
        Positioned(
          top: 110,
          right: 60,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Boost your links today",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                    fontWeight: FontWeight.w900,
                    height: 1.2,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  style: const ButtonStyle(
                      backgroundColor:
                      WidgetStatePropertyAll(Colors.cyan)),
                  onPressed: () {},
                  child: const Text(
                    'Get Started',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    ),
  );
}