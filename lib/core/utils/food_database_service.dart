import 'dart:developer';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/food_model.dart';

class FoodDatabaseService {
  static final FoodDatabaseService instance = FoodDatabaseService._init();
  static Database? _database;

  FoodDatabaseService._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('food_history.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE food_history (
        id INTEGER PRIMARY KEY,
        name TEXT NOT NULL,
        imagePath TEXT NOT NULL,
        calories INTEGER NOT NULL,
        recipe TEXT NOT NULL,
        timestamp INTEGER NOT NULL
      )
    ''');
  }

  Future<bool> doesFoodExist(int foodId) async {
    final db = await instance.database;
    try {
      final result = await db
          .rawQuery('SELECT * FROM food_history WHERE id = $foodId LIMIT 1');
      return result.isNotEmpty;
    } catch (e) {
      log('Error checking food existence: $e');
      return false;
    }
    
  }

  // Insert or replace a food item
  Future<int> insertFood(FoodModel food) async {
    final db = await instance.database;

    return await db.insert(
      'food_history',
      {
        'id': food.id,
        'name': food.name,
        'imagePath': food.imagePath,
        'calories': food.calories,
        'recipe': food.recipe,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteFoodItem(int id) async {
  final db = await instance.database;
  try {
    await db.delete(
      'food_history',
      where: 'id = $id',
    );
    log('Food item with id $id deleted successfully.');
  } catch (e) {
    log('Error deleting food item: $e');
  }
}

  // Get all food history sorted by timestamp (newest first)
  Future<List<FoodModel>> getFoodHistory() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'food_history',
      orderBy: 'timestamp DESC',
    );

    return List.generate(maps.length, (i) {
      return FoodModel(
        id: maps[i]['id'],
        name: maps[i]['name'],
        imagePath: maps[i]['imagePath'],
        calories: maps[i]['calories'],
        recipe: maps[i]['recipe'],
        timestamp: DateTime.fromMillisecondsSinceEpoch(maps[i]['timestamp']),
      );
    });
  }

  Future dbClose() async {
    final db = await instance.database;
    db.close();
  }
}
