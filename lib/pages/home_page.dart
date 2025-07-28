import 'package:flutter/material.dart';
import 'dice_roll_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void navigateToDiceRoll(BuildContext context, String diceType) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DiceRollPage(diceType: diceType),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          // 🔳 Tło
          Image.asset(
            'assets/backgrounds/fullbackground.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),

          // 📜 Zwój – zawartość wewnętrzna
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 10), // 🔼 Podniesiony tytuł

              // 🧾 Tytuł aplikacji
              const Text(
                'DnDice RPG Roller',
                style: TextStyle(
                  fontSize: 32,
                  fontFamily: 'MedievalSharp',
                  color: Color.fromARGB(255, 22, 29, 60),
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 26), // 🔼 mniej odstępu

              // 🎲 Ikony kości
              SizedBox(
                width: 270,
                child: Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 30,
                  runSpacing: 30,
                  children: [
                    for (var dice in [
                      'd4',
                      'd6',
                      'd8',
                      'd10',
                      'd12',
                      'd20',
                      'd100'
                    ])
                      GestureDetector(
                        onTap: () => navigateToDiceRoll(context, dice),
                        child: Image.asset(
                          'assets/icons/dice_$dice.png',
                          width: 70,
                          height: 70,
                        ),
                      ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // ✏️ Podpis pod ikonami
              const Text(
                'Wybierz kość',
                style: TextStyle(
                  fontSize: 26,
                  fontFamily: 'MedievalSharp',
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 30),

              // 🕰️ Przycisk Historia – przeniesiony wyżej
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, '/history');
                },
                icon: Image.asset(
                  'assets/icons/history_icon_1.png',
                  width: 30, // dostosuj rozmiar wedle potrzeb
                  height: 30,
                ),
                label: const Text(
                  'Historia rzutów',
                  style: TextStyle(
                    fontSize: 16, // rozmiar czcionki
                    //fontWeight: FontWeight.bold, // opcjonalnie: pogrubienie
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(221, 255, 255, 255),
                  foregroundColor: const Color.fromARGB(255, 0, 0, 0),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
