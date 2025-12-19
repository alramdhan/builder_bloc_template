import 'package:builder_bloc_template/core/di/service_locator.dart';
import 'package:builder_bloc_template/presentation/views/home/cubit/menutab_cubit.dart';
import 'package:builder_bloc_template/presentation/views/home/home_page.dart';
import 'package:builder_bloc_template/presentation/views/home/profile_page.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainMenuTab extends StatefulWidget {
  const MainMenuTab({super.key});

  @override
  State<MainMenuTab> createState() => _MainMenuTabState();
}

class _MainMenuTabState extends State<MainMenuTab> {
  final List<Widget> _screen = [
    const HomePage(),
    const ProfilePage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<MenutabCubit>(),
      child: TabScreen(listWidget: _screen),
    );
  }
}

class TabScreen extends StatelessWidget {
  const TabScreen({super.key, required this.listWidget});

  final List<Widget> listWidget;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MenutabCubit, int>(
      builder: (ctx, state) {
        return Scaffold(
          body: IndexedStack(
            index: state,
            children: listWidget,
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: state,
            elevation: 8,
            onTap: (index) {
              context.read<MenutabCubit>().onSelecTab(index);
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  state == 0
                    ? FluentIcons.home_16_filled
                    : FluentIcons.home_16_regular
                ),
                label: "Beranda"
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  state == 1
                    ? FluentIcons.heart_16_filled
                    : FluentIcons.heart_16_regular
                ),
                label: "Favorit"
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  state == 2
                    ? FluentIcons.person_16_filled
                    : FluentIcons.person_16_regular
                ),
                label: "Profil"
              )
            ],
          ),
        );
      }
    );
  }
}