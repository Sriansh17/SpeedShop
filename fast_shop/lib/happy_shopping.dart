import 'package:flutter/material.dart';
import 'shopping_list.dart';

class HappyShopping extends StatefulWidget {
  const HappyShopping({super.key});

  @override
  _HappyShoppingState createState() => _HappyShoppingState();
}

class _HappyShoppingState extends State<HappyShopping> with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<Offset>? _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..forward();

    _animation = Tween<Offset>(
      begin: const Offset(-1.5, 0.0), // Start from left outside the screen
      end: const Offset(1.9, 0.0),    // Move to right outside the screen
    ).animate(CurvedAnimation(
      parent: _controller!,
      curve: Curves.easeInOut,
    ));

    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => const ShoppingList(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          transitionDuration: const Duration(seconds: 3),
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            color: Colors.white, // Background color for the whole screen
          ),
          Image.asset(
            'assets/images/bg2.png',  // Background image
            fit: BoxFit.contain,        // Cover the entire background
          ),
          Positioned(
            top: 40.0,
            left: 16.0,
            child: Image.asset(
              'assets/images/logo.png', // Your logo image
              width: 80, // Logo width
              height: 80, // Logo height
            ),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 80), // Space for the logo
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8), // Semi-transparent background for text
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: const Column(
                    children: [
                      Text(
                        'Welcome to Fast Shop!',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 390),
                      Text(
                        'Your smart shopping companion',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 120.0, // Position the button above the cart image
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to the shopping list directly for demonstration
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const ShoppingList()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10), // Smaller button
                  elevation: 5,
                ),
                child: const Text(
                  'Start Shopping',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SlideTransition(
              position: _animation!,
              child: Container(
                width: 80, // Adjusted width to make the cart smaller
                height: 80, // Adjusted height to make the cart smaller
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.orangeAccent.withOpacity(0.8), // Background color for the cart
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Image.asset(
                    'assets/images/manpushing.png',  // Cart image
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
