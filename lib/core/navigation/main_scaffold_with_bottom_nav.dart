import 'package:flutter/material.dart';
import 'package:dharma_gyan/features/home/presentation/screens/home_screen.dart';
import 'package:dharma_gyan/features/stories/presentation/screens/stories_screen.dart';
import 'package:dharma_gyan/features/social/presentation/screens/social_screen.dart';
import 'package:dharma_gyan/features/profile/presentation/screens/profile_screen.dart';
import 'package:dharma_gyan/features/store/presentation/screens/store_screen.dart';

class MainScaffoldWithBottomNav extends StatefulWidget {
  const MainScaffoldWithBottomNav({super.key});

  @override
  State<MainScaffoldWithBottomNav> createState() =>
      _MainScaffoldWithBottomNavState();
}

class _MainScaffoldWithBottomNavState extends State<MainScaffoldWithBottomNav> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    StoriesScreen(),
    SocialScreen(),
    ProfileScreen(),
    StoreScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // For now, the AppBar is part of each individual screen.
    // We can centralize it here if the top bar (Diya, Lotus, Heart)
    // should be persistent across all these main tabs.
    // Based on your description, the top bar is part of the "Home Screen (The Learning Path)".
    // If it needs to be on all screens, we'll adjust.

    return Scaffold(
      body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined), // Placeholder: Path icon
            activeIcon: Icon(Icons.home), // Placeholder: Path icon
            label: 'Learn',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book_outlined), // Placeholder: Open book icon
            activeIcon: Icon(Icons.book), // Placeholder: Open book icon
            label: 'Stories',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.people_alt_outlined,
            ), // Placeholder: Leaderboard icon
            activeIcon: Icon(Icons.people_alt), // Placeholder: Leaderboard icon
            label: 'Satsang',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline), // Placeholder: Person icon
            activeIcon: Icon(Icons.person), // Placeholder: Person icon
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.storefront_outlined), // Placeholder: Gem icon
            activeIcon: Icon(Icons.storefront), // Placeholder: Gem icon
            label: 'Store',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(
          context,
        ).colorScheme.primary, // Use primary color from theme
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed, // Ensures all labels are visible
        showUnselectedLabels: true,
      ),
    );
  }
}
