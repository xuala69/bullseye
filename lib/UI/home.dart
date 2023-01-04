import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int targetValue = 0;
  double sliderValue = 0.5;
  int currentScore = 0;
  int currentRound = 1;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    generateRandomInt();
  }

  void generateRandomInt() {
    final newRandom = Random().nextInt(100);
    targetValue = newRandom;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/bullseye.jpeg",
            width: 70,
            height: 70,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Drag the slider to get as close as you can to: ",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              Text(
                "$targetValue",
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 25,
          ),
          Slider(
              value: sliderValue,
              onChanged: (newValue) {
                sliderValue = newValue;
                setState(() {});
              }),
          const SizedBox(
            height: 25,
          ),
          ElevatedButton(
            onPressed: () {
              final difference =
                  ((sliderValue * 100).round() - targetValue).abs();
              currentScore = currentScore + (100 - difference);
              currentRound++;
              setState(() {});
              generateRandomInt();
            },
            child: const Text("Hit me!"),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    currentRound = 1;
                    currentScore = 0;
                    setState(() {});
                  },
                  child: const Text("Start over"),
                ),
                Text("Score: $currentScore"),
                Text("Round: $currentRound"),
                ElevatedButton(
                  onPressed: () {
                    final difference =
                        (sliderValue * 100).round() - targetValue;
                    print("DIfference is $difference");
                  },
                  child: const Text("Score board"),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
