import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:test_project/clipper.dart';
import 'package:test_project/second_screen.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen>
    with TickerProviderStateMixin {
  double padding = 14;
  late AnimationController _controller;
  late Animation<double> tweenSeq;
  bool isRunning = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    tweenSeq = TweenSequence<double>([
      TweenSequenceItem(tween: Tween<double>(begin: 14, end: 250), weight: 80),
      TweenSequenceItem(tween: Tween<double>(begin: 200, end: 0), weight: 20),
    ]).animate(_controller);

    _controller.addListener(() {
      log("controller val ${_controller.value}");
      if (!isRunning) {
        padding = _controller.value * 200;

        setState(() {});
      }
    });
    _controller.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        await Navigator.push(
            context,
            PageRouteBuilder(
                opaque: false,
                pageBuilder: (context, _, __) {
                  return SecondScreen();
                }));
        padding = 14;
        _controller.reset();
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Scaffold(
            bottomNavigationBar: BottomAppBar(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                  IconButton(onPressed: () {}, icon: const Icon(Icons.home)),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.home)),
                  const SizedBox(),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.home)),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.home)),
                ])),
            body: const Center(
              child: Text(
                "EVENTS",
                style: TextStyle(fontSize: 36, color: Colors.blue),
              ),
            ),
          ),
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) => ClipPath(
              clipper: SideCutClipper(
                  yFactor: tweenSeq.value / 2,
                  xFactor: tweenSeq.value > 150 ? 30 : tweenSeq.value / 5),
              child: Opacity(
                opacity: _controller.value,
                child: Container(
                  color: Colors.blue[300],
                ),
              ),
            ),
          ),
          AnimatedPositioned(
            bottom: padding < 14 ? 14 : padding,
            left: 0,
            right: 0,
            curve: Curves.fastOutSlowIn,
            duration: const Duration(milliseconds: 0),
            child: GestureDetector(
              onVerticalDragEnd: (details) {
                isRunning = false;
                if (details.velocity.pixelsPerSecond.dy > 0) {
                  print("down");
                } else {
                  _controller.forward();
                }
              },
              onVerticalDragUpdate: (details) {
                log("udpate...${details.primaryDelta}");
                log("udpate...${details}");
                log("udpate...${details.delta}");
                isRunning = true;
                var res = padding - (details.primaryDelta ?? 0);
                if (res > 14 && res < 250) {
                  padding -= details.primaryDelta ?? 0;
                } else if (res < 14) {
                  padding = 14;
                } else if (res > 250) {
                  padding = 250;
                }
                _controller.value = padding / 250;

                log("padding...$padding");
                setState(() {});
              },
              child: Hero(
                tag: "menu_btn",
                transitionOnUserGestures: true,
                flightShuttleBuilder: (flightContext, animation,
                    flightDirection, fromHeroContext, toHeroContext) {
                  print("anim val ${animation.value}");
                  return RotationTransition(
                    turns: animation,
                    child: toHeroContext.widget,
                  );
                },
                child: RotationTransition(
                  turns: _controller,
                  child: FloatingActionButton(
                    elevation: 0,
                    heroTag: null,
                    backgroundColor: Colors.blue[300],
                    onPressed: null,
                    shape: const CircleBorder(),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
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
