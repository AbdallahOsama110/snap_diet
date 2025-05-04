import 'dart:developer';
import 'dart:io';
import 'dart:convert';
import 'dart:math' hide log;
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'package:flutter/services.dart' show rootBundle;
import '../../../../../core/models/food_model.dart';
import '../../../../../core/utils/food_database_service.dart';
part 'home_states.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitial()) {
    _loadModel();
  }
  static HomeCubit get(context) => BlocProvider.of(context);

  File? selectedImage;
  Interpreter? interpreter;
  List<int>? outputProbabilities;
  int confidence = 0;
  List<String> labels = [];
  String classificationResult = "";
  List<FoodModel> foodList = [];
  FoodModel? foodItem;
  bool isFoodExist = false;

  Future<List<FoodModel>> _loadFoodItems() async {
    try {
      final String response = await rootBundle
          .loadString('assets/models/aiy_food_V1_calories_&_recipes.json');

      final Map<String, dynamic> data = await json.decode(response);

      List<FoodModel> foodList = (data['food_items'] as List)
          .map((item) => FoodModel.fromJson(item))
          .toList();

      return foodList;
    } catch (e) {
      log("Error loading food items: $e");
      emit(FoodClassifierError("Error loading food items: $e"));
      return [];
    }
  }

  Future<void> _loadModel() async {
    try {
      interpreter = await Interpreter.fromAsset('assets/models/aiy.tflite');
      labels = await _loadLabels();
      foodList = await _loadFoodItems();
      emit(FoodClassifierModelLoaded());
    } catch (e) {
      log(e.toString());
      emit(FoodClassifierError("Failed to load model: $e"));
    }
  }

  Future<void> pickImage(ImageSource source) async {
    emit(PickImageLoading());
    try {
      final ImagePicker picker = ImagePicker();
      XFile? imageFile = await picker.pickImage(source: source);

      if (imageFile == null) {
        emit(PickImageError("No image selected"));
        return;
      }
      selectedImage = File(imageFile.path);
      emit(PickImageSuccess());
    } catch (e) {
      log(e.toString());
      emit(PickImageError("Error: $e"));
    }
  }

  Future<List<String>> _loadLabels() async {
    String csvData =
        await rootBundle.loadString('assets/models/aiy_food_V1_labelmap.csv');
    return csvData.split('\n').map((line) => line.trim()).toList();
  }

  Future<void> classifyImage() async {
    if (selectedImage == null) {
      emit(FoodClassifierError("No image selected!"));
      return;
    }
    emit(FoodClassifierLoading());
    try {
      isFoodExist = false;
      outputProbabilities = await _runInference(selectedImage!);
      int maxIndex = _getMaxIndex(outputProbabilities!);
      classificationResult =
          labels.isNotEmpty ? labels[maxIndex] : "Class ID: $maxIndex";
      confidence = outputProbabilities![maxIndex - 1];
      log("Top Food Class: $classificationResult with confidence: $confidence");
      foodItem = foodList.firstWhere(
          (food) => food.id.toString() == classificationResult.split(',')[0],
          orElse: () =>
              FoodModel(id: 0, name: "Unknown", calories: 0, recipe: ""));

      //check if foodItem in the database or not
      if (foodItem != null) {
        final db = FoodDatabaseService.instance;
        try {
          isFoodExist = await db.doesFoodExist(foodItem!.id);
          log("Food existence: $isFoodExist");
          emit(CheckFoodExistenceSuccess());
        } catch (e) {
          log("Error checking food existence: $e");
          emit(CheckFoodExistenceError());
        }
      }
      emit(FoodClassifierSuccess());
    } catch (e) {
      log("Error processing image: $e");
      emit(FoodClassifierError("Error processing image: $e"));
    }
  }

  Future<List<int>> _runInference(File imageFile) async {
    img.Image? image = img.decodeImage(await imageFile.readAsBytes());
    if (image == null) throw Exception("Invalid image format");
    image = img.copyResize(image, width: 224, height: 224);

    // Convert image to uint8 tensor (shape: [1, 224, 224, 3])
    var input = List.generate(
        1,
        (_) => List.generate(
            224,
            (i) => List.generate(224, (j) {
                  final pixel = image!.getPixel(j, i);
                  return [pixel.r, pixel.g, pixel.b]; // Keep as uint8 (0-255)
                })));

    // Convert input to Uint8List (ensuring correct type)
    var inputUint8 = input
        .map((batch) => batch
            .map((row) => row
                .map((pixel) => pixel.map((e) => e.toInt()).toList())
                .toList())
            .toList())
        .toList();

    // Model output: [1, 2024] probability vector
    var output = List.generate(1, (_) => List.filled(2024, 0));

    // Run inference
    interpreter?.run(inputUint8, output);

    return output[0];
  }

  int _getMaxIndex(List<int> probabilities) {
    return probabilities.indexOf(probabilities.reduce(max)) + 1;
  }

  void saveFoodItem() async {
    if (foodItem != null && !isFoodExist) {
      final db = FoodDatabaseService.instance;
      try {
        emit(SaveFoodLoading());
        await db.insertFood(foodItem!);
        log("Food item saved successfully");
        isFoodExist = true;
        emit(SaveFoodSuccess());
      } catch (e) {
        log("Error saving food item: $e");
        emit(SaveFoodError("Error saving food item: $e"));
      }
    }
  }
}
