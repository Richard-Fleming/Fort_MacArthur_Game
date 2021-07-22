import 'dart:math';

// returns a random integer between min(inclusive) and max(exclusive)
int intInRange(int min, int max) {
  final rand = new Random();
  return min + rand.nextInt(max - min);
}

// returns a random double between min(inclusive) and max(exclusive)
double doubleInRange(double min, double max) {
  final rand = new Random();
  return rand.nextDouble() * (max - min) + min;
}
