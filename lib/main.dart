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
}
