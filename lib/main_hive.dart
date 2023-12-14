import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import '/utils/utils.dart';
import '/widgets/ingredient_list_tile.dart';
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

// TODO: add a START OVER button which resets ingredients to 0 if you mess up

class _MyHomePageState extends State<MyHomePage> {
  // logic variables, methods
  @override
  initState() {
    super.initState();
    // Add listeners to this class
    Hive.box<Ingredient>('ingredients').put(flour.id, flour);
    Hive.box<Ingredient>('ingredients').put(yeast.id, yeast);
    Hive.box<Ingredient>('ingredients').put(water.id, water);
    Hive.box<Ingredient>('ingredients').put(sugar.id, sugar);
    Hive.box<Ingredient>('ingredients').put(salt.id, salt);
    Hive.box<Ingredient>('ingredients').put(oil.id, oil);
  }
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
  String food = "";

  increaseIngredient(ingredient) {
    setState(() { // need this to be in the home page state
      ingredient.count += 1;
      Hive.box<Ingredient>('ingredients').put(
          ingredient.id,
          Ingredient(
            id: ingredient.id,
            name: ingredient.name,
            img: ingredient.img,
            count: ingredient.count,
            measurement: ingredient.measurement,
          )
      );
    });
    //print(Hive.box<Ingredient>('ingredients').values.length);
  }

  void checkIngredients(){
    // https://tastesbetterfromscratch.com/bread-recipe/
    setState(() {
      if (water.getCount() == 2 && yeast.getCount() == 1 && sugar.getCount() == 1 && salt.getCount() == 2 && oil.getCount() == 2 && flour.getCount() == 4) {
        success = true;
        food = "bread";
      }
      print(success);
    });
  }

  void cook(){
    setState(() {
      if(success == true){
        message = "Congratulations! You made " + food + "!";
        //kitchenFeedback(context);
      }
      else {
        message = "You made a mistake; better try again.";
      }
      kitchenFeedback(context);
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
      body: ValueListenableBuilder(
        //body: Center(
        //child: SingleChildScrollView(
        //child: Column(
        //child: ValueListenableBuilder(
          valueListenable: Hive.box<Ingredient>('ingredients').listenable(),
          builder: (context, box, child) {
            // add objects to Hive box
            //mainAxisAlignment: MainAxisAlignment.center, // center the UI
            final ingredients = box.values; // do define list of ingredients
            return ListView.builder(
              // thanks Stack Overflow
              scrollDirection: Axis.vertical, // only generate what we can see
              shrinkWrap: true, // only generate what we can see
              // false throws an error
              // "RenderBox was not laid out: RenderRepaintBoundary#dde42 relayoutBoundary=up2 NEEDS-PAINT"
              itemCount: ingredients.length,
              itemBuilder: (context, index) {
                final ingredient = ingredients.elementAt(index);
                return IngredientListTile(
                    ingredient: ingredient,
                    onAdd: () {
                      // Don't need Hive to read values
                      // let's try deleting and re-adding the ingredient to edit it
                      //print(ingredients.length);
                      print(ingredient.count);
                      Hive.box<Ingredient>('ingredients').delete(ingredient.id);
                      increaseIngredient(ingredient);
                      // putting this before or after doesn't prevent value reset
                      //print(ingredients.length);
                      Hive.box<Ingredient>('ingredients').put(ingredient.id, ingredient);
                      print(ingredient.count);
                      // the count is increasing but it's not saving that way
                      print(" ");
                    },
                    onCook: () {
                      checkIngredients();
                      cook();
                      kitchenFeedback(context);
                    }
                );
              },

              /*
          // TODO: create and loop through list of ingredients
          ingredientWidget(flour, context),
          ingredientWidget(yeast, context),
          ingredientWidget(water, context),
          ingredientWidget(sugar, context),
          ingredientWidget(salt, context),
          ingredientWidget(oil, context),
           */
              /*
          Text("$message", style: Theme
              .of(context)
              .textTheme
              .headlineMedium),
          ElevatedButton(
            onPressed: () {
              checkIngredients();
              cook();
            },
            child: Text('Cook'),
          ),
          SizedBox(height: 20), // line break
           */
            );
          }
      ),
      //),

      /*
      body: ValueListenableBuilder(
        valueListenable: Hive.box<Ingredient>('ingredients').listenable(),
        builder: (context, box, child) {
          final ingredients = box.values;
          return ListView.builder(
            itemCount: ingredients.length,
            itemBuilder: (context, index) {
              final ingredient = ingredients.elementAt(index);
              return IngredientListTile(
                ingredient: ingredient,
                onDelete: () {
                  Hive.box<Ingredient>('ingredients').delete(ingredient.id);
                },
                onEdit: () async {
                  final newIngredient = await openAddIngredientDialog(
                    context: context,
                    ingredient: ingredient,
                  );
                  if (newIngredient != null) {
                    Hive.box<Ingredient>('ingredients').put(ingredient.id, newIngredient);
                  }
                  setState(() {});
                },
              );
            },
          );
        }
      ),
       */

      /*
      floatingActionButton: FloatingActionButton(
        onPressed: addFlour,
        tooltip: 'Add Flour',
        child: const Icon(Icons.add),
      ),
       */
      //),
    );
  }

  Widget kitchenFeedback(BuildContext context){
    return AlertDialog(
      title: const Text('Success!'),
      content: SingleChildScrollView(
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                  "Wahoo!" //message
              ),
            ]
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(null),
          child: const Text('Ok'),
        ),
      ],
    );
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
        ],
      ),
    );
  }

  Widget ingredientWidget(Ingredient ingredient, context){
    return Column(
        children: <Widget>[
          Image(image: AssetImage('graphics/' + ingredient.getImg()), height: 100),
          // can't wait for eggs of egg
          Text(ingredient.getMeasurement() + 's of ' + ingredient.getName() + ': ' + ingredient.getCount().toString(), style: Theme.of(context).textTheme.headlineMedium), // header
          SizedBox(height: 20), // line break
          ElevatedButton(
            onPressed: () {
              increaseIngredient(ingredient); // need set state
            },

            child: Text('Add a ' + ingredient.getMeasurement() + ' of ' + ingredient.getName()),
          ),
          SizedBox(height: 20), // line break
        ]
    );
  }
}