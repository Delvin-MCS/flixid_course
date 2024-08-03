import 'package:flixid_course/presentation/extensions/build_context_extensions.dart';
import 'package:flixid_course/presentation/misc/methods.dart';
import 'package:flixid_course/presentation/providers/router/router_provider.dart';
import 'package:flixid_course/presentation/providers/user_data/user_data_provider.dart';
import 'package:flixid_course/presentation/widgets/bottom_nav_bar.dart';
import 'package:flixid_course/presentation/widgets/bottom_nav_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  PageController pageController = PageController();
  int seletectedPage = 0;

  @override
  Widget build(BuildContext context) {
    ref.listen(
      userDataProvider,
      (previous, next) {
        if (previous != null && next is AsyncData && next.value == null) {
          ref.read(routerProvider).goNamed('login');
        } else if (next is AsyncError) {
          context.showSnackBar(next.error.toString());
        }
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Main Page'),
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              children: [
                Text(ref.watch(userDataProvider).when(
                    data: (data) => data.toString(),
                    error: (error, stackTrace) => '',
                    loading: () => 'Loading')),
                ElevatedButton(
                    onPressed: ref.read(userDataProvider.notifier).logout,
                    child: const Text('logout')),
                verticalSpace(50),
              ],
            ),
          ),
          BottomNavBar(items: const [
            BottomNavBarItem(
                index: 0,
                isSelected: true,
                title: 'Home',
                image: 'assets/movie.png',
                selectedImage: 'assets/movie-selected.png')
          ], onTap: (index) {}, selectedIndex: 0)
        ],
      ),
    );
  }
}
