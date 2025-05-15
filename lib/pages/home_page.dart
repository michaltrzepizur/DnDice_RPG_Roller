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
          // Tło
          Image.asset(
            'assets/backgrounds/wood.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),

          // Zwój
          SizedBox(
            width: 450,
            height: 750,
            child: Image.asset(
              'assets/backgrounds/scroll.png',
              fit: BoxFit.fill,
            ),
          ),

          // Zawartość zwoju
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12),

              // Tytuł aplikacji
              const Text(
                'DnDice RPG Roller',
                style: TextStyle(
                  fontSize: 32,
                  fontFamily: 'MedievalSharp',
                  color: Color.fromARGB(255, 22, 29, 60),
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 110),

              // Ikony kości
              SizedBox(
                width: 270, // lub 280–290 – tyle, ile ma Twój zwój
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

              const SizedBox(height: 80),

              // Podpis pod ikonami
              const Text(
                'Wybierz kość',
                style: TextStyle(
                  fontSize: 26,
                  fontFamily: 'MedievalSharp',
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
