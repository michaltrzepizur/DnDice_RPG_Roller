import 'package:flutter/material.dart';
import 'package:dndice/utils/roll_history.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final rolls = RollHistory.rolls;

    return Scaffold(
      // Cały ekran to stos – tło + zawartość
      body: Stack(
        alignment: Alignment.center,
        children: [
          // 🔳 Pełne tło (drewno + zwój w jednym)
          Positioned.fill(
            child: Image.asset(
              'assets/backgrounds/fullbackground.png',
              fit: BoxFit.cover,
            ),
          ),

          // 📜 Zawartość wewnątrz "zwoju"
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 130),
            child: Column(
              children: [
                // 🖐️ Ikona powrotu
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Image.asset(
                      'assets/icons/back_hand.png',
                      width: 90,
                      height: 60,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // 🧾 Tytuł
                const Text(
                  'Historia rzutów',
                  style: TextStyle(
                    fontSize: 32,
                    fontFamily: 'MedievalSharp',
                    color: Color.fromARGB(255, 22, 29, 60),
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 60),

                // Lista rzutów
                SizedBox(
                  height: 350, // Dostosuj do wysokości Twojego zwoju
                  child: RollHistory.rolls.isEmpty
                      ? const Center(
                          child: Text(
                            'Brak zapisanych rzutów 🎲',
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'MedievalSharp',
                              color: Colors.black87,
                            ),
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.only(bottom: 20),
                          itemCount: rolls.length,
                          itemBuilder: (context, index) {
                            return Center(
                              child: Container(
                                width: 300,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 6),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Rzut ${index + 1}: ${RollHistory.rolls[index].split('→').first}',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontFamily: 'MedievalSharp',
                                        color: Colors.black87,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Wrap(
                                      alignment: WrapAlignment.center,
                                      spacing: 8,
                                      runSpacing: 4,
                                      children: RollHistory.rolls[index]
                                          .split('→')
                                          .last
                                          .replaceAll('[', '')
                                          .replaceAll(']', '')
                                          .split(',')
                                          .map((number) => Text(
                                                number.trim(),
                                                style: const TextStyle(
                                                  fontSize: 18,
                                                  fontFamily: 'MedievalSharp',
                                                  color: Colors.black87,
                                                ),
                                              ))
                                          .toList(),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
