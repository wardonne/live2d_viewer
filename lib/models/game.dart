class Game extends Object {
  final String name;
  final String icon;
  final String route;

  Game({
    required this.name,
    required this.icon,
    required this.route,
  });

  Game.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String,
        icon = json['icon'] as String,
        route = json['route'] as String;

  Map<String, String> toJson() => {
        'name': name,
        'icon': icon,
        'route': route,
      };

  @override
  String toString() => toJson().toString();
}
