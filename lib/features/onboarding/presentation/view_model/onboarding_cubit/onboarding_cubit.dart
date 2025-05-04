import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/cache_helper.dart';
import '../../../../home/presentation/view/home_view.dart';
part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(OnboardingInitial());

  static OnboardingCubit get(context) =>
      BlocProvider.of(context, listen: false);

  bool isLast = false;

  Future<void> onChangePageView(int index, int lastIndex) async {
    if (index == lastIndex) {
      emit(OnboardingIsLast());
      log('is Last');
    } else {
      emit(OnboardingIsNotLast());
      log('is Not Last');
    }
  }

  Future<void> getStarted(BuildContext context) async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const HomeView(),
      ),
    );
    CacheHelper.putData(key: 'isFirstTimeOpen', value: false);
  }
}
