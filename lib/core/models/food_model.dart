class FoodModel {
  final int id;
  final String name;
  String? imagePath;
  final int calories;
  final String recipe;
  final DateTime? timestamp;

  FoodModel({
    required this.id,
    required this.name,
    required this.calories,
    required this.recipe,
    this.timestamp,
    this.imagePath,
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