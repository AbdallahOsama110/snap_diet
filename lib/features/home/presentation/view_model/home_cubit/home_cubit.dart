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
part 'home_states.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitial());
  static HomeCubit get(context) => BlocProvider.of(context);

  File? selectedImage;
  Interpreter? interpreter;
  List<int>? outputProbabilities;
  int confidence = 0;
  List<String> labels = [];
  String classificationResult = "";
  List<FoodModel> foodList = [];
  FoodModel? foodItem;

  Future<List<FoodModel>> _loadFoodItems() async {
    try {
      // Load JSON file from assets
      final String response = await rootBundle
          .loadString('assets/models/aiy_food_V1_calories_&_recipes.json');

      // Decode JSON
      final Map<String, dynamic> data = await json.decode(response);

      // Convert each item to FoodModel
      List<FoodModel> foodList = (data['food_items'] as List)
          .map((item) => FoodModel.fromJson(item))
          .toList();

      return foodList;
    } catch (e) {
      log("Error loading food items: $e");
      emit(FoodClassifierError("Error loading food items: $e"));
      return []; // Return empty list on error
    }
  }

  Future<void> loadModel() async {
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
}















/* import 'dart:developer';
import 'dart:io';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
part 'home_states.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitial());
  static HomeCubit get(context) => BlocProvider.of(context);

  File? selectedImage;
  Interpreter? interpreter;
  List<List<List<double>>>? segmentationResult;

    Future<void> loadModel() async {
    try {
      interpreter = await Interpreter.fromAsset('assets/models/mobile_food_segmenter_V1.tflite');
      emit(FoodSegmenterModelLoaded());
    } catch (e) {
      log(e.toString());
      emit(FoodSegmenterError("Failed to load model: $e"));
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

  Future<void> classifyImage() async {
    if (selectedImage == null) {
      emit(FoodSegmenterError("No image selected!"));
      return;
    }
    emit(FoodSegmenterLoading());
    try {
      segmentationResult = await _runInference(selectedImage!);
      log("${segmentationResult?[0][0][0]}");
      emit(FoodSegmenterSuccess());
    } catch (e) {
      log("Error processing image: $e");
      emit(FoodSegmenterError("Error processing image: $e"));
    }
  }


Future<List<List<List<double>>>> _runInference(File imageFile) async {
  // Load and decode the image
  img.Image? image = img.decodeImage(await imageFile.readAsBytes());
  if (image == null) throw Exception("Invalid image format");

  // Resize image to 513x513
  image = img.copyResize(image, width: 513, height: 513);

  // Convert image to uint8 tensor (shape: [1, 513, 513, 3])
  var input = List.generate(1, (_) => List.generate(513, (i) =>
      List.generate(513, (j) {
        final pixel = image!.getPixel(j, i); // Get pixel object

        int red = pixel.r as int;   // Extract red channel
        int green = pixel.g as int; // Extract green channel
        int blue = pixel.b as int;  // Extract blue channel

        return [red, green, blue]; // Keep as uint8 (0-255)
      })));

  // Output tensor (shape: [1, 513, 513, 26])
  var output = List.generate(1, (_) => List.generate(513, (i) =>
      List.generate(513, (j) =>
          List.generate(26, (_) => 0.0)))); // Initialize as double

  // Run inference
  interpreter?.run(input, output);

  return output[0];  // Remove batch dimension
}


}
 */