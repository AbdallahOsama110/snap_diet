import 'package:flutter/material.dart';
import '../../../../../core/models/food_model.dart';
import '../../../../food-details/presentation/view/food_details_view.dart';
import '../../../data/history_datetime_format.dart';

class FoodItem extends StatelessWidget {
  const FoodItem({super.key, required this.foodItem});
  final FoodModel foodItem;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FoodDetailsView(foodItem: foodItem))),
        title: Text(foodItem.name),
        subtitle:
            Text(historyDateTimeFormat(foodItem.timestamp ?? DateTime.now())),
        trailing: Row(
          spacing: 5,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("${foodItem.calories} kcal"),
            Icon(Icons.arrow_forward_ios_rounded, size: 20),
          ],
        ),
      ),
    );
  }
}
