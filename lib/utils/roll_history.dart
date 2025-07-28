class RollHistory {
  static final List<String> rolls = [];

  static void add(String diceType, List<int> results) {
    final entry = '${diceType.toUpperCase()} → [${results.join(', ')}]';
    rolls.insert(0, entry); // dodaj na początek

    if (rolls.length > 10) {
      rolls.removeLast(); // max 10 rzutów
    }
  }

  static void clear() {
    rolls.clear();
  }
}
