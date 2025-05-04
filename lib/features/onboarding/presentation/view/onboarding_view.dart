import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/consts.dart';
import '../view_model/onboarding_cubit/onboarding_cubit.dart';
import 'widgets/blur_circle_widget.dart';
import 'widgets/custom_onboarding_item.dart';
import 'widgets/onboarding_navigator_widget.dart';
import 'widgets/skip_button.dart';

class OnboardingView extends StatelessWidget {
  final pageController = PageController();

  OnboardingView({super.key});
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => OnboardingCubit(),
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<OnboardingCubit, OnboardingState>(
            builder: (context, state) {
              var onboardingCubit = OnboardingCubit.get(context);
              return Stack(
                children: [
                  BlurCircleWidget(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        height: size.height * .8,
                        child: PageView.builder(
                          onPageChanged: (index) {
                            onboardingCubit.onChangePageView(
                              index,
                              onboardingList.length - 1,
                            );
                          },
                          controller: pageController,
                          allowImplicitScrolling: true,
                          itemCount: onboardingList.length,
                          itemBuilder: (context, index) => CustomOnboardingItem(
                            onboardingModel: onboardingList[index],
                          ),
                        ),
                      ),
                      OnboardingNavigatorWidget(
                        condition: state is OnboardingIsLast,
                        pageController: pageController,
                        onboardingList: onboardingList,
                        onboardingCubit: onboardingCubit,
                      ),
                    ],
                  ),
                  SkipButton(
                    isVisibile: state is! OnboardingIsLast,
                    pageController: pageController,
                    onboardingList: onboardingList,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
