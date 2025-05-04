class FoodModel {
  final int id;
  final String name;
  final int calories;
  final String recipe;
  final DateTime? timestamp;

  FoodModel({
    required this.id,
    required this.name,
    required this.calories,
    required this.recipe,
    this.timestamp,
  });

  factory FoodModel.fromJson(Map<String, dynamic> json) {
    return FoodModel(
      id: json['id'],
      name: json['name'],
      calories: json['calories'],
      recipe: json['recipe'],
    );
  }
}