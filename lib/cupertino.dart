import 'package:flutter/cupertino.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  bool _menuOpen = false;

  void _toggleMenu() {
    setState(() => _menuOpen = !_menuOpen);
  }

  void _closeMenu() {
    setState(() => _menuOpen = false);
  }

  void _showAlert() {
    showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: const Text('Notification'),
        content: const Text('SnackBar triggered'),
        actions: [
          CupertinoDialogAction(
            child: const Text('OK'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Cupertino App'),
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: _toggleMenu,
          child: const Icon(CupertinoIcons.line_horizontal_3),
        ),
      ),
      child: Stack(
        children: [
          // 🔵 MAIN CONTENT
          Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    const SizedBox.shrink(),

                    // 🔘 FLOATING BUTTON
                    Positioned(
                      bottom: 20,
                      right: 20,
                      child: CupertinoButton(
                        padding: const EdgeInsets.all(16),
                        color: CupertinoColors.activeBlue,
                        borderRadius: BorderRadius.circular(30),
                        onPressed: _showAlert,
                        child: const Icon(
                          CupertinoIcons.bell,
                          color: CupertinoColors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // 🟢 BOTTOM TAB BAR
              CupertinoTabBar(
                currentIndex: _currentIndex,
                onTap: (index) {
                  setState(() => _currentIndex = index);
                },
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.house),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.star),
                    label: 'Favorite',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.wifi),
                    label: 'Internet',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.settings),
                    label: 'Settings',
                  ),
                ],
              ),
            ],
          ),

          // 🌫 OVERLAY
          if (_menuOpen)
            GestureDetector(
              onTap: _closeMenu,
              child: Container(color: CupertinoColors.black.withOpacity(0.3)),
            ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOut,
            top: 0,
            bottom: 0,
            left: _menuOpen ? 0 : -screenWidth * 0.75,
            width: screenWidth * 0.75,
            child: SafeArea(
              child: Container(
                color: CupertinoColors.systemBackground,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        'Menu',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    _SideItem(
                      icon: CupertinoIcons.house,
                      label: 'Home',
                      onTap: _closeMenu,
                    ),
                    _SideItem(
                      icon: CupertinoIcons.settings,
                      label: 'Settings',
                      onTap: _closeMenu,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SideItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _SideItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      onPressed: onTap,
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(width: 16),
          Text(label, style: const TextStyle(fontSize: 18)),
        ],
      ),
    );
  }
}
