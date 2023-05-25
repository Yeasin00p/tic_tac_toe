import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tic_tac_toe/constant/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  bool oTrun = true;
  List<String> displayXO = [
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
  ];
  List<int> matchedIndex = [];
  int oScroe = 0;
  int xScroe = 0;
  int filledBoxes = 0;
  int attempts = 0;
  bool winerFound = false;
  String resultDeclartion = '';
  static const maxSeacond = 30;
  int sceond = maxSeacond;
  Timer? timer;
  var custiomFontWith = GoogleFonts.coiny(
      textStyle: const TextStyle(
    color: Colors.white,
    letterSpacing: 3,
    fontSize: 28,
  ));
  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        if (sceond > 0) {
          sceond--;
        } else {
          stopTimer();
        }
      });
    });
  }

  void stopTimer() {
    restTimer();
    timer?.cancel();
  }

  void restTimer() => sceond = maxSeacond;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MainColor.primaryColor,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Player 0',
                            style: custiomFontWith,
                          ),
                          Text(
                            oScroe.toString(),
                            style: custiomFontWith,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Player X',
                            style: custiomFontWith,
                          ),
                          Text(
                            xScroe.toString(),
                            style: custiomFontWith,
                          )
                        ],
                      ),
                    ],
                  )),
              const SizedBox(
                height: 14,
              ),
              Expanded(
                flex: 3,
                child: GridView.builder(
                    itemCount: 9,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3),
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          _trapped(index);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                  width: 5, color: MainColor.primaryColor),
                              color: matchedIndex.contains(index)
                                  ? MainColor.accentColor
                                  : MainColor.secondaryColor),
                          child: Center(
                            child: Text(
                              displayXO[index],
                              style: GoogleFonts.coiny(
                                fontSize: 65,
                                color: matchedIndex.contains(index)
                                    ? MainColor.secondaryColor
                                    : MainColor.primaryColor,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
              const SizedBox(
                height: 8,
              ),
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      resultDeclartion,
                      style: custiomFontWith,
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    _buildTimer()
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  void _trapped(int index) {
    final isRunning = timer == null ? false : timer!.isActive;

    if (isRunning) {
      setState(() {
        if (oTrun && displayXO[index] == '') {
          displayXO[index] = '0';
          filledBoxes++;
        } else if (!oTrun && displayXO[index] == '') {
          displayXO[index] = 'X';
          filledBoxes++;
        }
        oTrun = !oTrun;
        _cheekwiner();
      });
    }
  }

  void _cheekwiner() {
    //1st Row
    if (displayXO[0] == displayXO[1] &&
        displayXO[0] == displayXO[2] &&
        displayXO[0] != '') {
      setState(() {
        resultDeclartion = 'Player${displayXO[0]}Wins';
        matchedIndex.addAll([0, 1, 2]);
        stopTimer();
        _updateScroe(displayXO[0]);
      });
    }
    //2nd Row
    if (displayXO[3] == displayXO[4] &&
        displayXO[3] == displayXO[5] &&
        displayXO[3] != '') {
      setState(() {
        resultDeclartion = 'Player${displayXO[3]}Wins';
        matchedIndex.addAll([3, 4, 5]);
        stopTimer();
        _updateScroe(displayXO[3]);
      });
    }
    //3rd Row
    if (displayXO[6] == displayXO[7] &&
        displayXO[6] == displayXO[8] &&
        displayXO[6] != '') {
      setState(() {
        resultDeclartion = 'Player${displayXO[6]}Wins';
        matchedIndex.addAll([6, 7, 8]);
        stopTimer();
        _updateScroe(displayXO[6]);
      });
    }
    //1st column
    if (displayXO[0] == displayXO[3] &&
        displayXO[0] == displayXO[6] &&
        displayXO[0] != '') {
      setState(() {
        resultDeclartion = 'Player${displayXO[0]}Wins';
        matchedIndex.addAll([0, 3, 6]);
        stopTimer();
        _updateScroe(displayXO[0]);
      });
    }
    //2nd column
    if (displayXO[1] == displayXO[4] &&
        displayXO[1] == displayXO[7] &&
        displayXO[1] != '') {
      setState(() {
        resultDeclartion = 'Player${displayXO[1]}Wins';
        matchedIndex.addAll([1, 4, 7]);
        stopTimer();
        _updateScroe(displayXO[1]);
      });
    }
    //3rd column
    if (displayXO[2] == displayXO[5] &&
        displayXO[2] == displayXO[8] &&
        displayXO[2] != '') {
      setState(() {
        resultDeclartion = 'Player${displayXO[2]}Wins';
        matchedIndex.addAll([2, 5, 8]);
        stopTimer();
        _updateScroe(displayXO[2]);
      });
    }
    //cheek digonal
    if (displayXO[0] == displayXO[4] &&
        displayXO[0] == displayXO[8] &&
        displayXO[0] != '') {
      setState(() {
        resultDeclartion = 'Player${displayXO[0]}Wins';
        matchedIndex.addAll([0, 4, 8]);
        stopTimer();
        _updateScroe(displayXO[0]);
      });
    }
    //cheek digonal
    if (displayXO[6] == displayXO[4] &&
        displayXO[6] == displayXO[2] &&
        displayXO[6] != '') {
      setState(() {
        resultDeclartion = 'Player${displayXO[6]}Wins';
        matchedIndex.addAll([6, 4, 2]);
        stopTimer();
        _updateScroe(displayXO[6]);
      });
    }
    if (!winerFound && filledBoxes == 9) {
      setState(() {
        resultDeclartion = 'Nobody Wins!';
        stopTimer();
      });
    }
  }

  void _updateScroe(String winner) {
    if (winner == '0') {
      oScroe++;
    } else if (winner == 'X') {
      xScroe++;
    }else{
       winerFound = true;
    }
   
  }

  void _clerBorad() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        displayXO[i] = '';
      }
      resultDeclartion = '';
      matchedIndex = [];
    });
    filledBoxes = 0;
  }

  Widget _buildTimer() {
    final isRunning = timer == null ? false : timer!.isActive;
    return isRunning
        ? SizedBox(
            width: 100,
            height: 100,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CircularProgressIndicator(
                  value: 1 - sceond / maxSeacond,
                  valueColor: const AlwaysStoppedAnimation(Colors.white),
                  strokeWidth: 8,
                  backgroundColor: MainColor.accentColor,
                ),
                Center(
                  child: Text(
                    '$sceond',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 50,
                    ),
                  ),
                )
              ],
            ),
          )
        : ElevatedButton(
            onPressed: () {
              startTimer();
              _clerBorad();
              attempts++;
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16)),
            child: Text(
              attempts == 0 ? 'Start' : 'Play Again',
              style: const TextStyle(color: Colors.black, fontSize: 16),
            ),
          );
  }
}
