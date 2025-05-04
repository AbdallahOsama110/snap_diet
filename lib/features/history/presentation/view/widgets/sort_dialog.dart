import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../../core/utils/light_theme.dart';
import '../../view-model/history-cubit/history_cubit.dart';

class SortDialog extends StatelessWidget {
  const SortDialog({super.key, required this.cubit});
  final HistoryCubit cubit;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white.withValues(alpha: .8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: Colors.white, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              onTap: () {
                cubit.sortHistoryOnCalories();
                Navigator.pop(context);
              },
              title: Text(
                'Sort by Calories',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
              ),
            ),
            Divider(
              indent: 20.w,
              endIndent: 20.w,
              height: 1,
              color: ColorName.secondaryColor,
            ),
            ListTile(
              onTap: () {
                cubit.sortHistoryOnDate();
                Navigator.pop(context);
              },
              title: Text(
                'Sort by Date',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
