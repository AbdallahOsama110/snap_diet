import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';
import 'widgets/food_item.dart';
import '../view-model/history-cubit/history_cubit.dart';
import 'widgets/sort_dialog.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: BlocBuilder<HistoryCubit, HistoryState>(
        builder: (context, state) {
          var cubit = HistoryCubit.get(context);
          return Column(
            children: [
              SizedBox(height: 2.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Food List",
                      style: Theme.of(context).textTheme.bodyLarge),
                  TextButton.icon(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return SortDialog(cubit: cubit);
                        },
                      );
                    },
                    label: Text("Sort"),
                    icon: Icon(FontAwesomeIcons.arrowUpWideShort, size: 15),
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: cubit.foodHistory.length,
                  itemBuilder: (context, index) {
                    return FoodItem(foodItem: cubit.foodHistory[index]);
                  },
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
