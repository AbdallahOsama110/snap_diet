import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../history/presentation/view-model/history-cubit/history_cubit.dart';
import 'widgets/app_bar_title.dart';
import 'widgets/tab_bar_item.dart';
import 'widgets/home_view_body.dart';
import '../../../../core/utils/light_theme.dart';
import '../../../history/presentation/view/history_view.dart';
import '../view_model/home_cubit/home_cubit.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late PageController _pageController;
  int currentPage = 0;

  final List<String> tabs = ['Home', 'History'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
    _pageController = PageController();

    // Sync tab controller with page view
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        _pageController.animateToPage(
          _tabController.index,
          duration: Duration(milliseconds: 300),
          curve: Curves.ease,
        );
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if (state is SaveFoodSuccess){
          HistoryCubit.get(context).getHistory();
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: AppBarTitle(),
            bottom: TabBar(
              controller: _tabController,
              tabs: [
                TabBarItem(title: "Home", icon: Icons.home_rounded),
                TabBarItem(title: "History", icon: Icons.history_rounded),
              ],
              indicatorColor: ColorName.primaryColor,
              labelColor: ColorName.secondaryColor,
              unselectedLabelColor: ColorName.secondaryColor,
              isScrollable: false,
            ),
          ),
          body: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => currentPage = index);
              _tabController.animateTo(index);
            },
            children: [
              HomeViewBody(),
              HistoryView(),
            ],
          ),
        );
      },
    );
  }
}