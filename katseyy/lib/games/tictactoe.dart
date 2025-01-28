// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'dart:math';
import 'package:katseyy/app_pages/dashboard_page.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(const TicTacToeApp());
}

class TicTacToeApp extends StatelessWidget {
  const TicTacToeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TicTacToeScreen(),
    );
  }
}

class TicTacToeScreen extends StatefulWidget {
  const TicTacToeScreen({super.key});

  @override
  _TicTacToeScreenState createState() => _TicTacToeScreenState();
}

class _TicTacToeScreenState extends State<TicTacToeScreen> {
  AudioPlayer audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    isPlayer1Turn = true; // Set player to move first

    // Check if it's computer mode and the computer's turn
    if (isComputerMode) {
      makeComputerMove();
    }
  }

  List<List<String>> board = List.generate(3, (_) => List.filled(3, ''));

  bool isPlayer1Turn = true; // true for Player 1, false for Player 2
  bool isComputerMode = false;
  bool isSoundEnabled = true; // Added variable for sound

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/5.jpg'), // Replace with your image path
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Column(
              children: [
                const SizedBox(height: 30),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 18),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color:
                        const Color.fromARGB(242, 84, 8, 129), // Set to transparent
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    isPlayer1Turn
                        ? 'Player 1'
                        : (isComputerMode ? 'Computer' : 'Player 2'),
                    style: const TextStyle(
                      fontSize: 25,
                      color: Color.fromARGB(255, 246, 236, 241),
                      fontFamily: "BlackHanSans",
                    ),
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GridView.builder(
                        shrinkWrap: true,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                        ),
                        itemBuilder: (context, index) {
                          int row = index ~/ 3;
                          int col = index % 3;
                          return GestureDetector(
                            onTap: () {
                              audioPlayer.play(AssetSource(
                                'pop.mp3',
                              ));
                              if (board[row][col].isEmpty) {
                                setState(() {
                                  makeMove(row, col);
                                  if (isComputerMode &&
                                      !checkForWinner() &&
                                      !isBoardFull()) {
                                    makeComputerMove();
                                  }
                                });
                              }
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.bounceInOut,
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: const Color.fromARGB(255, 0, 0, 0),
                                    width: 2),
                                borderRadius: BorderRadius.circular(13),
                                color: board[row][col].isEmpty
                                    ? const Color.fromARGB(255, 62, 1, 63)
                                    : const Color.fromARGB(212, 113, 60, 122),
                              ),
                              child: Center(
                                child: AnimatedAlign(
                                  duration: const Duration(
                                      milliseconds:
                                          700), // Adjust duration as needed
                                  alignment: const Alignment(0.0, -0.5),
                                  child: Opacity(
                                    opacity: 1.0,
                                    child: Text(
                                      board[row][col],
                                      style: const TextStyle(
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold,
                                        color:
                                            Color.fromARGB(255, 231, 226, 232),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        itemCount: 9,
                      ),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              _showDialog();
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ), backgroundColor: const Color.fromARGB(235, 105, 10, 160),
                              padding: const EdgeInsets.all(10),
                            ),
                            child: const Text(
                              'Change Mode',
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: "BlackHanSans",
                                color: Color.fromARGB(255, 209, 208, 240),
                              ),
                            ),
                          ),
                          const SizedBox(width: 30),
                          ElevatedButton(
                            onPressed: () {
                              resetGame();
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ), backgroundColor: const Color.fromARGB(235, 105, 10, 160),
                              padding: const EdgeInsets.all(10),
                            ),
                            child: const Text(
                              'Play Again',
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: "BlackHanSans",
                                color: Color.fromARGB(255, 209, 208, 240),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Bottom buttons
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                    30), // Adjust the border radius as needed
                gradient: const LinearGradient(
                  colors: [Color(0xffde3dfe), Color(0xfffe3da8)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color(
                        0x3cae2468), // Adjust the shadow color and opacity
                    spreadRadius: 2, // Adjust the spread radius
                    blurRadius: 5, // Adjust the blur radius
                    offset: Offset(0, 3), // Adjust the offset
                  ),
                ],
              ),
              child: FloatingActionButton(
                onPressed: () {
                  audioPlayer.play(AssetSource(
                    'pop.mp3',
                  ));
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const DashboardPage()),
                  );
                },
                backgroundColor: Colors.transparent,
                elevation: 0,
                child: const Icon(Icons.home, size: 40), // Remove the default elevation
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: const LinearGradient(
                  colors: [Color(0xffb014b5), Color(0xfffd1dc5)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x3cae2468),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: FloatingActionButton(
                onPressed: () {
                  audioPlayer.play(AssetSource(
                    'pop.mp3',
                  ));
                  _showTutorialDialog(
                      context); // Call the function to show the tutorial dialog
                },
                backgroundColor: Colors.transparent,
                elevation: 0,
                child: const Icon(Icons.help, size: 40),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void makeMove(int row, int col) {
    if (board[row][col].isEmpty) {
      setState(() {
        if (isPlayer1Turn) {
          board[row][col] = 'X';
        } else {
          board[row][col] = 'O';
        }

        // Add the following AnimatedContainer to create a popping animation
        int animatedRow = row;
        int animatedCol = col;
        double animatedOpacity = 1.0;

        Future.delayed(const Duration(milliseconds: 100), () {
          setState(() {
            animatedOpacity = 1.0;
          });
        });

        if (checkForWinner()) {
          audioPlayer.play(AssetSource('success.mp3'));
          _showWinnerDialog();
        } else if (isBoardFull()) {
          _showDrawDialog();
        } else {
          isPlayer1Turn = !isPlayer1Turn; // Move turn switch inside setState
        }
      });
    }
  }

  void makeComputerMove() {
    List<int> emptyCells = [];
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (board[i][j].isEmpty) {
          emptyCells.add(i * 3 + j);
        }
      }
    }

    if (emptyCells.isNotEmpty) {
      int randomIndex = Random().nextInt(emptyCells.length);
      int selectedCell = emptyCells[randomIndex];
      int row = selectedCell ~/ 3;
      int col = selectedCell % 3;

      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          makeMove(row, col);

          if (checkForWinner()) {
            audioPlayer.play(AssetSource('success.mp3'));
            _showWinnerDialog();
          } else if (isBoardFull()) {
            _showDrawDialog();
          }
        });
      });
    }
  }

  bool checkForWinner() {
    for (int i = 0; i < 3; i++) {
      if (board[i][0].isNotEmpty &&
          board[i][0] == board[i][1] &&
          board[i][1] == board[i][2]) {
        return true;
      }
      if (board[0][i].isNotEmpty &&
          board[0][i] == board[1][i] &&
          board[1][i] == board[2][i]) {
        return true;
      }
    }

    if (board[0][0].isNotEmpty &&
        board[0][0] == board[1][1] &&
        board[1][1] == board[2][2]) {
      return true;
    }

    if (board[0][2].isNotEmpty &&
        board[0][2] == board[1][1] &&
        board[1][1] == board[2][0]) {
      return true;
    }

    return false;
  }

  bool isBoardFull() {
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (board[i][j].isEmpty) {
          return false;
        }
      }
    }
    return true;
  }

  void resetGame() {
    setState(() {
      board = List.generate(3, (_) => List.filled(3, ''));
      isPlayer1Turn = true;
    });
  }

  Future<void> _showDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Select Game Mode',
            style: TextStyle(
              color: Color(0xFF4E208B),
              fontFamily: 'BlackHanSans', // Choose the title color
            ),
          ),
          content: Container(
            padding: const EdgeInsets.all(30.0),
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage(
                    'images/pop.png'), // Replace with your image asset
                fit: BoxFit.cover,
              ),
              border: Border.all(
                color: const Color.fromARGB(
                    255, 191, 138, 188), // Choose the border color
                width: 5.0, // Choose the border width
              ),
              borderRadius:
                  BorderRadius.circular(15.0), // Choose the border radius
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      isComputerMode = false;
                    });
                    resetGame();
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.people),
                  label: const Text(
                    'Multiplayer Mode',
                    style: TextStyle(
                      color: Colors.white, // Choose the button text color
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4E208B), // Choose the button color
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      isComputerMode = true;
                    });
                    resetGame();
                    Navigator.of(context).pop();
                    if (isComputerMode) {
                      makeComputerMove();
                    }
                  },
                  icon: const Icon(Icons.computer),
                  label: const Text(
                    'Computer Mode',
                    style: TextStyle(
                      color: Colors.white, // Choose the button text color
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4E208B), // Choose the button color
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _showWinnerDialog() async {
    audioPlayer.play(AssetSource(
      'success.mp3',
    ));
    String winner =
        isPlayer1Turn ? (isComputerMode ? 'Computer' : 'Player 1') : 'Player 1';

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            '$winner Wins!',
            style: const TextStyle(
              color: Color.fromARGB(255, 198, 4, 124),
              fontFamily: 'BlackHanSans', // Choose the title color
            ),
          ),
          actions: [
            ElevatedButton.icon(
              onPressed: () {
                resetGame();
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.refresh),
              label: const Text(
                'Play Again',
                style: TextStyle(
                  color: Colors.white, // Choose the button text color
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 76, 4, 169), // Choose the button color
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showDrawDialog() async {
    audioPlayer.play(AssetSource(
      'decide.mp3',
    ));
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'It\'s a Draw!',
            style: TextStyle(
              color: Color.fromARGB(255, 19, 3, 201),
              fontFamily: 'BlackHanSans', // Choose the title color
            ),
          ),
          actions: [
            ElevatedButton.icon(
              onPressed: () {
                resetGame();
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.refresh),
              label: const Text(
                'Play Again',
                style: TextStyle(
                  color: Colors.white, // Choose the button text color
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4E208B), // Choose the button color
              ),
            ),
          ],
        );
      },
    );
  }

  void _showTutorialDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          content: Container(
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage(
                    'images/backgroundimage/dialog.jpg'), // Replace with your image asset
                fit: BoxFit.cover,
              ),
              border: Border.all(
                color: const Color.fromARGB(
                    255, 212, 193, 211), // Choose the border color
                width: 5.0, // Choose the border width
              ),
              borderRadius:
                  BorderRadius.circular(15.0), // Choose the border radius
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Welcome to Tic Tac Toe!',
                    style: TextStyle(
                      fontSize: 25,
                      fontFamily: 'Salsa',
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // Set text color to white
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    '1. Open the Tic Tac Toe app and choose a game mode',
                    style: TextStyle(
                      fontFamily: 'Genos',

                      fontSize: 18,
                      color: Colors.white, // Set text color to white
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    '2. Tap on an empty square to place your symbol ("X" or "O")',
                    style: TextStyle(
                      fontFamily: 'Genos',

                      fontSize: 18,
                      color: Colors.white, // Set text color to white
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    '3.Aim to get three of your symbols in a row to win.',
                    style: TextStyle(
                      fontFamily: 'Genos',

                      fontSize: 18,
                      color: Colors.white, // Set text color to white
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    '4. If the board is full or someone wins, Play Again, if you want',
                    style: TextStyle(
                      fontFamily: 'Genos',

                      fontSize: 18,
                      color: Colors.white, // Set text color to white
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 116, 16,
                    138), // Set the background color of the button
              ),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}