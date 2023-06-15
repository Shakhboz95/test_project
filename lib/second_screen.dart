import 'package:flutter/material.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  late Animation<double> _fadeAnimation;
  late Animation<Color?> _colorAnimation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.linear);
    _colorAnimation =
        ColorTween(begin: Colors.blue, end: Colors.white).animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[300],
      body: Align(
        alignment: Alignment.bottomCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Hero(
                tag: "menu_btn",
                child: AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return FloatingActionButton(
                          heroTag: null,
                          backgroundColor: _colorAnimation.value,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          shape: const CircleBorder(),
                          child: Icon(
                            Icons.close,
                            color: Colors.blue[300],
                          ));
                    })),
            const SizedBox(
              height: 24,
            ),
            FadeTransition(
              opacity: _fadeAnimation,
              child: Column(children: [
                _text("Menu 1"),
                _text("Menu 2"),
                _text("Menu 3"),
                _text("Menu 4"),
                _text("Menu 5"),
                // _text("Menu 6"),
              ]),
            ),
            const SizedBox(
              height: 60,
            )
          ],
        ),
      ),
    );
  }

  _text(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(
        text,
        style: const TextStyle(
            color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
      ),
    );
  }
}
