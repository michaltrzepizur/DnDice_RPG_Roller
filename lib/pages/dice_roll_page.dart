import 'dart:math';
import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';
import 'package:dndice/utils/roll_history.dart';

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
    return List.generate(times, (_) => Random().nextInt(sides) + 1);
  }

  String getDiceIconPath() =>
      'assets/icons/dice_${widget.diceType.toLowerCase()}.png';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        alignment: Alignment.center,
        children: [
          // 🔄 Nowe jednolite tło
          Positioned.fill(
            child: Image.asset(
              'assets/backgrounds/fullbackground.png',
              fit: BoxFit.cover,
            ),
          ),

          // 📦 Treść ekranu
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 130),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // 🔙 Lewy przycisk – powrót
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Image.asset(
                        'assets/icons/back_hand.png',
                        width: 90,
                        height: 60,
                      ),
                    ),

                    // 📜 Prawy przycisk – historia
                    IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/history');
                      },
                      icon: Image.asset(
                        'assets/icons/history_icon_1.png', // twoja ikona historii
                        width: 90,
                        height: 50,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                const Text(
                  'Wybierz swoje przeznaczenie!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Color.fromARGB(255, 4, 4, 4),
                  ),
                ),

                const SizedBox(height: 30),
                const Text(
                  'Pamiętaj, że możesz wyrzucić maksymalnie 20 rzutów.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Color.fromARGB(255, 230, 3, 3),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Ile rzutów?',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),

                // 📥 TextField + piórko
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

                // 🎲 Ikona kostki
                ElevatedButton(
                  onPressed: () async {
                    int count = int.tryParse(_rollCountController.text) ?? 1;
                    if (count > 20) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Maksymalna liczba rzutów to 20.'),
                          backgroundColor: Colors.redAccent,
                        ),
                      );
                      count = 20;
                    }
                    setState(() {
                      rollResults = rollDice(count);
                      totalResult = rollResults.reduce((a, b) => a + b);
                      RollHistory.add(widget.diceType, rollResults);
                    });
                    // ✅ Wibracja po rzucie
                    if (await Vibration.hasVibrator() ?? false) {
                      Vibration.vibrate(duration: 100);
                    }
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
                    height: 60,
                    child: SingleChildScrollView(
                      child: SizedBox(
                        width: 250,
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
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
