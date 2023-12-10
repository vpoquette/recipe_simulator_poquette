import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import '/models/ingredient.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Hive.registerAdapter<Ingredient>(IngredientAdapter());
  await Hive.initFlutter(); // added for Hive
  await Hive.openBox<Ingredient>('ingredients');
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

// use Hive to store current progress in recipe

class _MyHomePageState extends State<MyHomePage> {
  // logic variables, methods
  // need to move these to their own file for Separation of Concerns

  // TODO: add ingredient list to this file

  // six ingredients for our first recipe (bread)
  int flour = 0; // unit: cups
  int yeast = 0; // unit: tbsp
  int water = 0; // unit: cups
  int sugar = 0; // unit: cups
  int salt = 0; // unit: tsp
  int oil = 0; // unit: tbsp
  // progress checks
  bool success = false;
  String message = "";

  // for later recipes
  int egg = 0; // unit: egg
  int milk = 0; // unit: cups

  void checkIngredients(){
    // https://tastesbetterfromscratch.com/bread-recipe/
    setState(() {
      if (water == 2 && yeast == 1 && sugar == 1 && salt == 2 && oil == 2 && flour == 4) {
        success = true;
      }
      print(success);
    });
  }

  // TODO: add a START OVER button which resets ingredients to 0 if you mess up

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

  void cook(){
    setState(() {
      if(success == true){
        message = "You did it! Congratulations";
      }
      else{
        message = "You made a mistake; better try again.";
      }
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
        child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // center the UI
          children: <Widget>[
            // flour
            Image(image: AssetImage('graphics/flour_immo_wegmann.jpg'), height: 100),
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
            Image(image: AssetImage('graphics/yeast_karyna_panchenko.jpg'), height: 100),
            Text("Tablespoons of Yeast: $yeast", style: Theme.of(context).textTheme.headlineMedium), // header
            SizedBox(height: 20), // line break
            ElevatedButton(
              onPressed: () {
                addYeast();
              },
              child: Text('Add a Tablespoon of Yeast'),
            ),
            SizedBox(height: 20), // line break

            Image(image: AssetImage('graphics/water_tanushree_rao.jpg'), height: 100),
            Text("Cups of Warm Water: $water", style: Theme.of(context).textTheme.headlineMedium),
            ElevatedButton(
              onPressed: () {
                addWater();
              },
              child: Text('Add a Cup of Warm Water'),
            ),
            SizedBox(height: 20), // line break

            Image(image: AssetImage('graphics/sugar_faran-raufi.jpg'), height: 100),
            Text("Quarter-Cups of Sugar: $sugar", style: Theme.of(context).textTheme.headlineMedium),
            ElevatedButton(
              onPressed: () {
                addSugar();
              },
              child: Text('Add a Quarter-Cup of Sugar'),
            ),
            SizedBox(height: 20), // line break

            Image(image: AssetImage('graphics/salt_gidlark.jpg'), height: 100),
            Text("Teaspoons of Salt: $salt", style: Theme.of(context).textTheme.headlineMedium),
            ElevatedButton(
              onPressed: () {
                addSalt();
              },
              child: Text('Add a Teaspoon of Salt'),
            ),
            SizedBox(height: 20), // line break

            Image(image: AssetImage('graphics/oil_roberta-sorge.jpg'), height: 100),
            Text("Tablespoons of Oil: $oil", style: Theme.of(context).textTheme.headlineMedium),
            ElevatedButton(
              onPressed: () {
                addOil();
              },
              child: Text('Add a Tablespoon of Oil'),
            ),
            SizedBox(height: 20), // line break

            Text("Recipe Success: $success", style: Theme.of(context).textTheme.headlineMedium),
            Text("$message", style: Theme.of(context).textTheme.headlineMedium),
            ElevatedButton(
              onPressed: () {
                checkIngredients();
                cook();
              },
              child: Text('Cook'),
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
    ),
    );
  }
}
