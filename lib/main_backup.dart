import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import '/models/ingredient.dart';
import 'recipePage.dart';

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

  // TODO: add list of ingredients to make UI dynamic

  // instantiate objects
  Ingredient flour = new Ingredient(
      id: 1, name: "flour", img: "flour_immo_wegmann.jpg", count: 0, measurement: "cup",);
  Ingredient yeast = new Ingredient(
    id: 2, name: "yeast", img: "yeast_karyna_panchenko.jpg", count: 0, measurement: "tbsp",);
  Ingredient water = new Ingredient(
    id: 3, name: "water", img: "water_tanushree_rao.jpg", count: 0, measurement: "cup",);
  Ingredient sugar = new Ingredient(
    id: 4, name: "sugar", img: "sugar_faran-raufi.jpg", count: 0, measurement: "cup",);
  Ingredient salt = new Ingredient(
    id: 5, name: "salt", img: "salt_gidlark.jpg", count: 0, measurement: "tsp",);
  Ingredient oil = new Ingredient(
    id: 6, name: "oil", img: "oil_roberta-sorge.jpg", count: 0, measurement: "tbsp",);
  // for later recipes
  // TODO: find and update images
  Ingredient egg = new Ingredient(
    id: 7, name: "egg", img: "flour_immo_wegmann.jpg", count: 0, measurement: "egg",); // having the measurement of "egg" might mess up grammar later
  Ingredient milk = new Ingredient(
    id: 8, name: "milk", img: "flour_immo_wegmann.jpg", count: 0, measurement: "cup",);

  // logic variables
  bool success = false;
  String message = "";

  increaseIngredient(ingredient) {
    setState(() { // need this to be in the home page state
      //ingredient.count.increase(1);
        // this triggers a No Such Method error
      ingredient.count += 1;
    });
  }

  void checkIngredients(){
    // https://tastesbetterfromscratch.com/bread-recipe/
    setState(() {
      if (water.getCount() == 2 && yeast.getCount() == 1 && sugar.getCount() == 1 && salt.getCount() == 2 && oil.getCount() == 2 && flour.getCount() == 4) {
        success = true;
      }
      print(success);
    });
  }

  // TODO: add a START OVER button which resets ingredients to 0 if you mess up

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
      drawer: buildDrawer(context),
      body: Center(
        child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // center the UI
          children: <Widget>[
            // flour
            Image(image: AssetImage('graphics/flour_immo_wegmann.jpg'), height: 100),
            Text("Cups of Flour: " + flour.getCount().toString(), style: Theme.of(context).textTheme.headlineMedium), // header
            SizedBox(height: 20), // line break
            ElevatedButton(
              onPressed: () {
                increaseIngredient(flour);
              },
              child: Text('Add a Cup of Flour'),
            ),
            SizedBox(height: 20), // line break
            // yeast
            Image(image: AssetImage('graphics/yeast_karyna_panchenko.jpg'), height: 100),
            Text("Tablespoons of Yeast: " + yeast.getCount().toString(), style: Theme.of(context).textTheme.headlineMedium), // header
            SizedBox(height: 20), // line break
            ElevatedButton(
              onPressed: () {
                increaseIngredient(yeast);
              },
              child: Text('Add a Tablespoon of Yeast'),
            ),
            SizedBox(height: 20), // line break

            Image(image: AssetImage('graphics/water_tanushree_rao.jpg'), height: 100),
            Text("Cups of Warm Water: " + water.getCount().toString(), style: Theme.of(context).textTheme.headlineMedium),
            ElevatedButton(
              onPressed: () {
                increaseIngredient(water);
              },
              child: Text('Add a Cup of Warm Water'),
            ),
            SizedBox(height: 20), // line break

            Image(image: AssetImage('graphics/sugar_faran-raufi.jpg'), height: 100),
            Text("Quarter-Cups of Sugar: " + sugar.getCount().toString(), style: Theme.of(context).textTheme.headlineMedium),
            ElevatedButton(
              onPressed: () {
                increaseIngredient(sugar);
              },
              child: Text('Add a Quarter-Cup of Sugar'),
            ),
            SizedBox(height: 20), // line break

            Image(image: AssetImage('graphics/salt_gidlark.jpg'), height: 100),
            Text("Teaspoons of Salt: " + salt.getCount().toString(), style: Theme.of(context).textTheme.headlineMedium),
            ElevatedButton(
              onPressed: () {
                increaseIngredient(salt);
              },
              child: Text('Add a Teaspoon of Salt'),
            ),
            SizedBox(height: 20), // line break

            Image(image: AssetImage('graphics/oil_roberta-sorge.jpg'), height: 100),
            Text("Tablespoons of Oil: " + oil.getCount().toString(), style: Theme.of(context).textTheme.headlineMedium),
            ElevatedButton(
              onPressed: () {
                increaseIngredient(oil);
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

// navigation menu; thanks Michael
Widget buildDrawer(BuildContext context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        const DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child: Text(
            'Navigation',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ),
        ListTile(
          title: Text('Kitchen'),
          onTap: () {
            print('Navigating to Kitchen page');
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyHomePage(title: 'Kitchen',)),
            );
          },
        ),
        ListTile(
            title: Text('Recipes'),
            onTap: () {
              print('Navigating to recipe page');
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyRecipePage(title: 'Recipes',)),
              );
            }
        ),
        // Add more ListTiles for additional menu items
      ],
    ),
  );
}

Widget ingredientWidget(Ingredient ingredient, context){
  return Row(
    children: <Widget>[
    Image(image: AssetImage('graphics/' + ingredient.getImg()), height: 100),
    // can't wait for eggs of egg
    Text(ingredient.getMeasurement() + 's of ' + ingredient.getName() + ': ' + ingredient.getCount().toString(), style: Theme.of(context).textTheme.headlineMedium), // header
    SizedBox(height: 20), // line break
    ElevatedButton(
      onPressed: () {
        ingredient.increase(1);
      },
      child: Text('Add a ' + ingredient.getMeasurement() + ' of ' + ingredient.getName()),
    ),
    SizedBox(height: 20), // line break
    ]
    );
}