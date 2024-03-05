import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  const NavBar(
      {super.key,
      required this.selectedIndex,
      required this.onDestinationSelected});

  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;
  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      onDestinationSelected: onDestinationSelected,
      selectedIndex: selectedIndex,
      indicatorColor: Colors.blueAccent,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
      height: 60,
      destinations: const <Widget>[
        NavigationDestination(
          selectedIcon: Icon(Icons.home, color: Colors.white),
          icon: Icon(Icons.home_outlined),
          label: 'Home',
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.notifications_sharp, color: Colors.white),
          icon: Badge(child: Icon(Icons.notifications_sharp)),
          label: 'Transaction',
        ),
      ],
    );
  }
}
