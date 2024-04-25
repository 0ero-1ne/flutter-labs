class Bread {
  final int id;
  final String title;
  final double calories;

  Bread({
    required this.id,
    required this.title,
    required this.calories
  });

  factory Bread.fromSqfliteDatabase(Map<String, dynamic> map) => Bread (
    id: map['id']?.toInt() ?? 0,
    title: map['title'] ?? '',
    calories: map['calories']?.toDouble() ?? 0
  );
}