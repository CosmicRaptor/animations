import 'package:animations/painters/analog_clock_painter.dart';
import 'package:animations/painters/raw_seven_segment.dart';
import 'package:animations/painters/rectangle_painter.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;

  int selectedIndex = 0;
  CustomPainter _getCurrentPainter() {
    switch (selectedIndex) {
      case 0:
        return RectanglePainter(controller: controller);
      case 1:
        return AnalogClockPainter(
            controller: controller, datetime: DateTime.now());
      case 2:
        return RawSevenSegment(controller: controller);
      default:
        throw Exception("Invalid index");
    }
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );
    controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    // controller.forward();
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.spa_outlined),
              label: "Flower animation",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.timer),
              label: "Clock",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.numbers),
              label: "Seven segment display",
            ),
          ],
          onTap: (val) {
            setState(() {
              selectedIndex = val;
            });
            if (!controller.isAnimating) {
              controller.forward();
            }
          }),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: CustomPaint(
              painter: _getCurrentPainter(),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: () {
          controller.reset();
          controller.forward();
        },
      ),
    );
  }
}
