import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:lottie/lottie.dart';
import 'pages/history_page.dart';
import 'pages/home_page.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  // 1) Zatrzymujemy pierwszą klatkę – zostaje natywny splash
  final binding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: binding);

  // ✅ Wymuszenie pionowej orientacji
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  // 🟡 Preloaduj cięższe grafiki, żeby uniknąć ich "doklejania" na HomePage
  await _warmUp(binding);

  // 2) Tu możesz dorzucić cięższe init‑y (prefs, Firebase, dźwięki…)
  await Future.delayed(const Duration(milliseconds: 300)); // symulacja

  // 3) Odblokowujemy klatkę i startujemy apkę
  FlutterNativeSplash.remove();
  runApp(const DnDiceApp());
}

class DnDiceApp extends StatelessWidget {
  const DnDiceApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'DnDice',
        theme: ThemeData(
          fontFamily: 'MedievalSharp',
          scaffoldBackgroundColor: Colors.black, // = kolor splasha
        ),
        home: const SplashPage(), // zob. poniżej
        routes: {
          '/home': (_) => const HomePage(),
          '/history': (_) => const HistoryPage(),
        },
      );
}

/// 🟡 Pre‑cache grafik (tło + ikony kostek)
Future<void> _warmUp(WidgetsBinding binding) async {
  final ctx = binding.rootElement; // zamiennik renderViewElement
  if (ctx == null) return; // bezpieczeństwo

  // 1️⃣ JEDNA lista ze wszystkimi ścieżkami plików, których będziemy używać
  const assets = [
    'assets/backgrounds/fullbackground.png',
    'assets/icons/dice_d4.png',
    'assets/icons/dice_d6.png',
    'assets/icons/dice_d8.png',
    'assets/icons/dice_d10.png',
    'assets/icons/dice_d12.png',
    'assets/icons/dice_d20.png',
  ];

  // 2️⃣ Jeden Future.wait, który precache‑uje KAŻDY z tych obrazków równolegle
  await Future.wait([
    for (final path in assets) precacheImage(AssetImage(path), ctx),
  ]);
}

/// ----------
/// SplashPage z obracającą się kostką (Lottie)
/// ----------
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _goHome(); // odliczanie do wejścia na Home
  }

  Future<void> _goHome() async {
    await Future.delayed(const Duration(seconds: 2));

    // 🟡 Fade zamiast nagłego przeskoku
    if (mounted) {
      await Navigator.of(context).pushReplacement(PageRouteBuilder(
        pageBuilder: (_, __, ___) => const HomePage(),
        transitionDuration: const Duration(milliseconds: 600),
        transitionsBuilder: (_, animation, __, child) =>
            FadeTransition(opacity: animation, child: child),
      ));
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Lottie.asset(
            'assets/animations/d20_roll.json',
            width: 180,
            repeat: true,
          ),
        ),
      );
}
