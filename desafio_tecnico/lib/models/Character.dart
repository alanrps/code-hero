class Character {
  final int id;
  final String name;
  final String description;
  final String thumbnailUrl;
  final int comicsAmount;
  final int seriesAmount;
  final int storiesAmount;
  final int eventsAmount;

  Character({
    required this.id,
    required this.name,
    required this.description,
    required this.thumbnailUrl,
    required this.comicsAmount,
    required this.seriesAmount,
    required this.storiesAmount,
    required this.eventsAmount,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      thumbnailUrl: '${json['thumbnail']['path']}.${json['thumbnail']['extension']}',
      comicsAmount: json['comics']['available'],
      seriesAmount: json['series']['available'],
      storiesAmount: json['stories']['available'],
      eventsAmount: json['events']['available'],
    );
  }
}