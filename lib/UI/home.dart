import 'dart:math';

import 'package:bullseye/utilities/constants.dart';
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

  void hitmeClick() {
    final sliderValueRounded = (sliderValue * 100).round();
    final difference = (sliderValueRounded - targetValue).abs();
    final scoredPoints = (100 - difference);

    setState(() {});
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
                "Slider value is $sliderValueRounded and the target is $targetValue. Point scored is $scoredPoints"),
            actions: [
              TextButton(
                  onPressed: () {
                    currentScore = currentScore + scoredPoints;
                    currentRound++;
                    generateRandomInt();
                    Navigator.of(context).pop();
                  },
                  child: const Text("OK"))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Image.asset(
          "assets/bullseye.jpeg",
          width: double.infinity,
          fit: BoxFit.fitWidth,
        ),
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 99, 44, 23).withOpacity(0.99),
          ),
        ),
        Column(
          children: [
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Put the bullseye as close as you can to: ",
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "$targetValue",
                  style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.yellow,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 25,
                ),
                const Text(
                  "1",
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
                Expanded(
                  child: Slider(
                    value: sliderValue,
                    activeColor: Colors.green,
                    thumbColor: Colors.white,
                    onChanged: (newValue) {
                      sliderValue = newValue;
                      setState(() {});
                    },
                  ),
                ),
                const Text(
                  "100",
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  width: 25,
                ),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            ElevatedButton(
              onPressed: hitmeClick,
              style: ElevatedButton.styleFrom(
                backgroundColor: Constants.buttonBackground,
                shape: const RoundedRectangleBorder(
                  side: BorderSide(
                    color: Colors.black,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(7),
                  ),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              ),
              child: Text(
                Constants.hitmeText,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
            ),
            const Spacer(),
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
                      generateRandomInt();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Constants.buttonBackground,
                      shape: const RoundedRectangleBorder(
                        side: BorderSide(
                          color: Colors.black,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(7),
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.refresh,
                          color: Colors.black,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          Constants.startOverText,
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      const Text(
                        "Score:",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "$currentScore",
                        style: const TextStyle(
                          color: Colors.yellow,
                          fontSize: 21,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Text(
                        "Round:",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "$currentRound",
                        style: const TextStyle(
                          color: Colors.yellow,
                          fontSize: 21,
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      final difference =
                          (sliderValue * 100).round() - targetValue;
                      print("DIfference is $difference");
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Constants.buttonBackground,
                      shape: const RoundedRectangleBorder(
                        side: BorderSide(
                          color: Colors.black,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(7),
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.info_outline,
                          color: Colors.black,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          Constants.infoText,
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ],
    ));
  }
}
