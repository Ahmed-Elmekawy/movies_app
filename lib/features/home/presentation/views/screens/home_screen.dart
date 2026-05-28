import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/di/injection_container.dart';
import '../../../../auth/presentation/bloc/auth_cubit.dart';
import '../../../../auth/presentation/bloc/auth_state.dart';
import '../../../../explore/presentation/views/screens/explore_screen.dart';
import '../../../../profile/presentation/views/screens/profile_screen.dart';
import '../../../../search/presentation/views/screens/search_screen.dart';
import '../../bloc/home_cubit.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import '../widgets/home_view_body.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeViewBody(),
    const SearchScreen(),
    const ExploreScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<HomeCubit>()..getHomeData(),
      child: Scaffold(
        body: Builder(
          builder: (context) {
            return Stack(
              alignment: AlignmentGeometry.bottomEnd,
              children: [
                IndexedStack(index: _currentIndex, children: _screens),
                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    if (state is LogoutLoading || state is DeleteAccountLoading) {
                      return const SizedBox.shrink();
                    }
                    return CustomBottomNavBar(
                      currentIndex: _currentIndex,
                      onTap: (index) {
                        if (index == 0) {
                          context.read<HomeCubit>().getHomeData();
                        } else if (index == 3) {
                          context.read<AuthCubit>().checkAuthStatus();
                        }
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
