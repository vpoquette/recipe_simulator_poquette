import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe Simulator',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Recipe Simulator Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// Current Goal:
  // cook a pre-set recipe by following the directions

class _MyHomePageState extends State<MyHomePage> {
  // logic variables, methods
    // need to move these to their own file for Separation of Concerns

  // six ingredients for our first recipe (bread)
  int flour = 0; // unit: cups
  int yeast = 0; // unit: tbsp
  int water = 0; // unit: cups
  int sugar = 0; // unit: cups
  int salt = 0; // unit: tsp
  int oil = 0; // unit: tbsp

  // for later recipes
  int egg = 0; // unit: egg
  int milk = 0; // unit: cups

  void addFlour(){
    setState(() {
      flour ++;
    });
  }

  void addYeast(){
    setState(() {
      yeast ++;
    });
  }

  void addWater(){
    setState(() {
      water ++;
    });
  }

  void addSugar(){
    setState(() {
      sugar ++;
    });
  }

  void addSalt(){
    setState(() {
      salt ++;
    });
  }

  void addOil(){
    setState(() {
      oil ++;
    });
  }

  // let's build a user interface
    // difficult to use an app without one
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title), // draws from one of the first widgets on this page
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // center the UI
          children: <Widget>[
            // flour
            Image(image: AssetImage('graphics/flour_immo_wegmann.jpg'), height: 150),
            Text("Cups of Flour: $flour", style: Theme.of(context).textTheme.headlineMedium), // header
            SizedBox(height: 20), // line break
            ElevatedButton(
              onPressed: () {
                addFlour();
              },
              child: Text('Add a Cup of Flour'),
            ),
            SizedBox(height: 20), // line break
            // yeast
            Image(image: AssetImage('graphics/yeast_karyna_panchenko.jpg'), height: 150),
            Text("Tablespoons of Yeast: $yeast", style: Theme.of(context).textTheme.headlineMedium), // header
            SizedBox(height: 20), // line break
            ElevatedButton(
              onPressed: () {
                addYeast();
              },
              child: Text('Add a Tablespoon of Yeast'),
            ),


          ],
        ),
      ),
      /*
      floatingActionButton: FloatingActionButton(
        onPressed: addFlour,
        tooltip: 'Add Flour',
        child: const Icon(Icons.add),
      ),
       */
    );
  }
}
