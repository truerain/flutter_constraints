import 'package:flutter/material.dart';
import 'dart:math' as math;

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
      home: const TestConstraints(),
    );
  }
}

class TestConstraints extends StatefulWidget {
  const TestConstraints({super.key});

  @override
  State<TestConstraints> createState() => _TestConstraintsState();
}

class _TestConstraintsState extends State<TestConstraints> {
  int which = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Test Constraints')),
        backgroundColor: Colors.grey[900],
        body: SafeArea(
          child: Column(
            children: [
              whereToShow,
              Expanded(child: listToShow),
            ],
          ),
        ));
  }

  Widget get listToShow {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 64),
      itemCount: 15,
      itemBuilder: (context, index) {
        return OutlinedButton(
          style: OutlinedButton.styleFrom(
            foregroundColor: which == index ? Colors.white : Colors.blue,
            backgroundColor: which == index ? Colors.blue : Colors.white,
          ),
          child: Text('$index'),
          onPressed: () {
            setState(() => which = index);
          },
        );
      },
    );
  }

  Widget get whereToShow {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(16),
        width: 300,
        height: 300,
        color: Colors.black,
        child: whichToShow,
      ),
    );
  }

  Widget get whichToShow {
    switch (which) {
      case 0:
        return const FlutterLogo(size: 100);
      case 1:
        return const Center(child: FlutterLogo(size: 100));
      case 2:
        return const Center(child: FlutterLogo(size: 600));
      case 3:
        return ListView(
          children: [
            LayoutBuilder(builder: ((context, constraints) {
              return Text('$constraints',
                  style: const TextStyle(color: Colors.white));
            })),
            const FlutterLogo(size: 100),
            listViewOfFlutterLogo,
          ],
        );
      case 4:
        return ListView(
          children: [
            LayoutBuilder(builder: (context, constraints) {
              return Text('$constraints',
                  style: const TextStyle(color: Colors.white));
            }),
            const FlutterLogo(size: 100),
            SizedBox(height: 200, child: listViewOfFlutterLogo)
          ],
        );
      case 5:
        return Column(
          children: [
            LayoutBuilder(builder: (context, constraints) {
              return Text('$constraints',
                  style: const TextStyle(color: Colors.white));
            }),
            const FlutterLogo(size: 100),
            listViewOfFlutterLogo,
          ],
        );
      case 6:
        return Column(
          children: [
            LayoutBuilder(builder: (context, constraints) {
              return Text('$constraints',
                  style: const TextStyle(color: Colors.white));
            }),
            const FlutterLogo(size: 100),
            Expanded(child: listViewOfFlutterLogo),
          ],
        );
      case 7:
        return const UnconstrainedBox(child: FlutterLogo(size: 600));
      case 8:
        return const OverflowBox(
          minWidth: 0,
          minHeight: 0,
          maxWidth: double.infinity,
          maxHeight: double.infinity,
          child: FlutterLogo(size: 600),
        );
      case 9:
        return UnconstrainedBox(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 200, maxHeight: 200),
            child: const FlutterLogo(size: 600),
          ),
        );
      case 10:
        return const UnconstrainedBox(
          child: LimitedBox(
            maxWidth: 100,
            maxHeight: 100,
            child: FlutterLogo(size: 600),
          ),
        );
      case 11:
        return const Center(
          child: LimitedBox(
            maxWidth: 100,
            maxHeight: 100,
            child: FlutterLogo(size: 600),
          ),
        );
      case 12:
        return Column(children: listToTest);
      case 13:
        return ListView(children: listToTest);
      case 14:
        return Center(
          child: Transform.rotate(
            angle: math.pi / 4,
            child: Opacity(
              opacity: 0.5,
              child: Container(
                width: 200,
                height: 200,
                alignment: Alignment.center,
                color: Colors.yellow,
                child: const Text("한글연습", style: TextStyle(fontSize: 64)),
              ),
            ),
          ),
        );
    }

    return Container();
  }

  Widget get listViewOfFlutterLogo => ListView(
        children: const [
          FlutterLogo(size: 100),
          FlutterLogo(size: 100),
          FlutterLogo(size: 100),
        ],
      );

  List<Widget> get listToTest => [
        const FlutterLogo(size: 25),
        Container(
          color: Colors.red,
        ),
        Container(
          width: 50,
          color: Colors.green,
          child: const FlutterLogo(size: 25),
        ),
        Container(
          height: 50,
          color: Colors.blue,
          child: const FlutterLogo(size: 25),
        ),
        Container(
          alignment: Alignment.bottomRight,
          height: 50,
          color: Colors.yellow,
          child: const FlutterLogo(size: 25),
        ),
        const Align(
          alignment: Alignment.bottomRight,
          child: FlutterLogo(size: 25),
        ),
        LayoutBuilder(builder: (context, constraints) {
          return Text('$constraints',
              style: const TextStyle(color: Colors.white));
          //BoxConstraints(0.0<=w<=300, 0<=h<=Infinity) in Column
          //BoxConstraints(w==300, 0<=h<=Infinity) in ListView
        }),
      ];
}
