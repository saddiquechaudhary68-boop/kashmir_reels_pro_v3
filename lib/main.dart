import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const KashmirReelsApp());
}

class KashmirReelsApp extends StatelessWidget {
  const KashmirReelsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kashmir Reels Pro',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.black,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
        ),
      ),
      home: const MainTabScreen(),
    );
  }
}

class MainTabScreen extends StatefulWidget {
  const MainTabScreen({super.key});

  @override
  State<MainTabScreen> createState() => _MainTabScreenState();
}

class _MainTabScreenState extends State<MainTabScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const SearchScreen(),
    const CameraScreen(),
    const Center(child: Text('Inbox', style: TextStyle(color: Colors.white))),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Discover'),
          BottomNavigationBarItem(icon: Icon(Icons.add_box, size: 36, color: Colors.redAccent), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Inbox'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageView(
      children: [
        // Left Swipe: Friends Feed
        Container(
          color: Colors.black,
          child: const Center(
            child: Text(
              '👥 Friends Feed\n(Left Swipe)',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        // For You Page (FYP)
        Container(
          color: Colors.black,
          child: Stack(
            children: [
              const Center(
                child: Text(
                  '🔥 FYP Reels\nAuto Views Boost Engine Active (400-500 Views)',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
              Positioned(
                top: 50,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text('Friends', style: TextStyle(color: Colors.grey, fontSize: 16)),
                    SizedBox(width: 20),
                    Text('|', style: TextStyle(color: Colors.white38)),
                    SizedBox(width: 20),
                    Text('For You', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: TextField(
          decoration: InputDecoration(
            hintText: 'Search videos, users, hashtags...',
            hintStyle: const TextStyle(color: Colors.grey),
            prefixIcon: const Icon(Icons.search, color: Colors.white),
            filled: true,
            fillColor: Colors.grey[900],
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(25), borderSide: BorderSide.none),
          ),
        ),
      ),
      body: const Center(child: Text('Trending Videos & Search Feed', style: TextStyle(color: Colors.white))),
    );
  }
}

class CameraScreen extends StatelessWidget {
  const CameraScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.camera_alt, size: 80, color: Colors.white),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
              onPressed: () {},
              icon: const Icon(Icons.videocam),
              label: const Text('Record with Filters & Sounds'),
            )
          ],
        ),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Widget _buildBlueTick(int followers, bool isOwner, bool isFirst25) {
    if (isOwner || isFirst25 || followers >= 10000) {
      return const Icon(Icons.verified, color: Colors.blue, size: 20);
    }
    return const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    int userFollowers = 50000;
    bool isOwner = true; // Admin Override
    bool isFirst25User = false;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Profile Settings & Account'),
        actions: [IconButton(icon: const Icon(Icons.settings), onPressed: () {})],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(radius: 50, backgroundColor: Colors.grey, child: Icon(Icons.person, size: 50, color: Colors.white)),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Talha Official ', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
                _buildBlueTick(userFollowers, isOwner, isFirst25User),
              ],
            ),
            const SizedBox(height: 5),
            Text('Followers: $userFollowers (6-Month Free Blue Tick Active)', style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[800]),
              onPressed: () {},
              child: const Text('Privacy Policies & Account Settings'),
            )
          ],
        ),
      ),
    );
  }
}
