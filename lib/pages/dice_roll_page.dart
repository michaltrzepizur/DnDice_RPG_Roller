import 'dart:math';
import 'package:flutter/material.dart';

class DiceRollPage extends StatefulWidget {
  final String diceType;

  const DiceRollPage({super.key, required this.diceType});

  @override
  State<DiceRollPage> createState() => _DiceRollPageState();
}

class _DiceRollPageState extends State<DiceRollPage> {
  int? totalResult;
  final TextEditingController _rollCountController =
      TextEditingController(text: '1');
  List<int> rollResults = [];

  List<int> rollDice(int times) {
    final sides = int.parse(widget.diceType.substring(1));
    List<int> results = [];
    for (int i = 0; i < times; i++) {
      results.add(Random().nextInt(sides) + 1);
    }
    return results;
  }

  String getDiceIconPath() {
    return 'assets/icons/dice_${widget.diceType.toLowerCase()}.png';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        alignment: Alignment.center,
        children: [
          // Drewniane tło
          Image.asset(
            'assets/backgrounds/wood.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),

          // Zwój z zawartością
          SizedBox(
            width: 450,
            height: 750,
            child: Stack(
              children: [
                Image.asset(
                  'assets/backgrounds/scroll.png',
                  fit: BoxFit.fill,
                  width: 450,
                  height: 750,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 16),
                  child: Column(
                    children: [
                      // "STRZAŁKA" WSTECZ (obrazek dłoni)
                      Align(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: Image.asset(
                            'assets/icons/back_hand.png',
                            width: 60, // rozmiar ręki powrót
                            height: 60,
                          ),
                        ),
                      ),

                      const SizedBox(height: 50),
                      const SizedBox(
                        width: 280, // dopasuj do szerokości pergaminu
                        child: Text(
                          'Pamiętaj, że możesz wyrzucić maksymalnie 20 rzutów.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(255, 230, 3, 3),
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Etykieta "Ile rzutów?"
                      const Text(
                        'Ile rzutów?',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),

                      const SizedBox(height: 8),

                      // TextField + ikona dłoni w jednej linii
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 120,
                            child: TextField(
                              controller: _rollCountController,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: Colors.white70,
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Image.asset(
                            'assets/icons/feather_hand.png',
                            width: 90,
                            height: 90,
                          )
                        ],
                      ),

                      const SizedBox(height: 20),

                      // Przycisk z ikoną kostki
                      ElevatedButton(
                        onPressed: () {
                          int count =
                              int.tryParse(_rollCountController.text) ?? 1;
                          if (count > 20) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content:
                                    Text('Maksymalna liczba rzutów to 20.'),
                                backgroundColor: Colors.redAccent,
                              ),
                            );
                            count = 20;
                          }
                          setState(() {
                            rollResults = rollDice(count);
                            totalResult = rollResults.reduce((a, b) => a + b);
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          padding: EdgeInsets.zero,
                        ),
                        child: Image.asset(
                          getDiceIconPath(),
                          width: 70,
                          height: 70,
                        ),
                      ),
                      const SizedBox(height: 24),
                      if (rollResults.isNotEmpty) ...[
                        const SizedBox(height: 15),
                        SizedBox(
                          height: 100,
                          child: SingleChildScrollView(
                            child: SizedBox(
                              width: 250, // <- ogranicza szerokość
                              child: Text(
                                'Wyniki: ${rollResults.join(', ')}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'MedievalSharp',
                                  color: Colors.black87,
                                ),
                                softWrap: true,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          'Suma: $totalResult',
                          style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'MedievalSharp',
                            color: Colors.brown,
                          ),
                        ),
                      ]
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
