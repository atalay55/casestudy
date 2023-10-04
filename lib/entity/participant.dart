class Participant {
  final int id;
  final String name;
  final int year;
  final String color;
  final String pantoneValue;

  Participant({
    required this.id,
    required this.name,
    required this.year,
    required this.color,
    required this.pantoneValue,
  });
  factory Participant.fromJson(Map<String, dynamic> json) {
    return Participant(
      id: json['id'] as int,
      name: json['name'] as String,
      year: json['year'] as int,
      color: json['color'] as String,
      pantoneValue: json['pantone_value'] as String,
    );
  }

}