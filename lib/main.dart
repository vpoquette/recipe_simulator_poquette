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

class _MyHomePageState extends State<MyHomePage> {
  // logic variables, methods
  @override
  initState() {
    super.initState();
  }
  // instantiate objects
  Ingredient flour = Ingredient(
    id: 1, name: "flour", img: "flour_immo_wegmann.jpg", count: 0, measurement: "cup",);
  Ingredient yeast = Ingredient(
    id: 2, name: "yeast", img: "yeast_karyna_panchenko.jpg", count: 0, measurement: "tbsp",);
  Ingredient water = Ingredient(
    id: 3, name: "water", img: "water_tanushree_rao.jpg", count: 0, measurement: "cup",);
  Ingredient sugar = Ingredient(
    id: 4, name: "sugar", img: "sugar_faran-raufi.jpg", count: 0, measurement: "cup",);
  Ingredient salt = Ingredient(
    id: 5, name: "salt", img: "salt_gidlark.jpg", count: 0, measurement: "tsp",);
  Ingredient oil = Ingredient(
    id: 6, name: "oil", img: "oil_roberta-sorge.jpg", count: 0, measurement: "tbsp",);
  // for later recipes
  // TODO: find and update images
  Ingredient egg = Ingredient(
    id: 7, name: "egg", img: "flour_immo_wegmann.jpg", count: 0, measurement: "egg",); // having the measurement of "egg" might mess up grammar later
  Ingredient milk = Ingredient(
    id: 8, name: "milk", img: "flour_immo_wegmann.jpg", count: 0, measurement: "cup",);

  // logic variables
  bool success = false;
  String message = "";
  String messageHeader = "";
  String food = "";

  increaseIngredient(ingredient) {
    print(ingredient.count);
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
    print(ingredient.count);
    print(ingredient.name);
  }

  void checkIngredients(){
    // https://tastesbetterfromscratch.com/bread-recipe/
    print(flour.count);
    print(yeast.count);
    print(water.count);
    print(sugar.count);
    print(salt.count);
    print(oil.count);
    setState(() {
      if (water.count == 2 && yeast.count == 1 && sugar.count == 1 && salt.count == 2 && oil.count == 2 && flour.count == 4) {
        success = true;
        food = "bread";
      }
    });
  }

  void cook(){
    setState(() {
      if(success == true){
        messageHeader = "Success!";
        message = "Congratulations! You made " + food + "!";
        kitchenFeedback(context);
      }
      else {
        messageHeader = "Oops!";
        message = "You made a mistake; better try again.";
        kitchenFeedback(context);
      }
    });
  }

  void resetCount(ingredient){
    setState(() {
      //ingredient.count = 0;
      Hive.box<Ingredient>('ingredients').put(
          ingredient.id,
          Ingredient(
            id: ingredient.id,
            name: ingredient.name,
            img: ingredient.img,
            count: 0,
            measurement: ingredient.measurement,
          )
      );
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
          valueListenable: Hive.box<Ingredient>('ingredients').listenable(),
          builder: (context, box, child) {
            // add objects to Hive box
            //mainAxisAlignment: MainAxisAlignment.center, // center the UI
            final ingredients = box.values; // do define list of ingredients
            return ListView.builder(
              // thanks Stack Overflow
              scrollDirection: Axis.vertical, // only generate what we can see
              shrinkWrap: true, // only generate what we can see
              itemCount: ingredients.length,
              itemBuilder: (context, index) {
                final ingredient = ingredients.elementAt(index);
                return IngredientListTile(
                    ingredient: ingredient,
                    onAdd: () {
                      Hive.box<Ingredient>('ingredients').delete(ingredient.id);
                      increaseIngredient(ingredient);
                      Hive.box<Ingredient>('ingredients').put(ingredient.id, ingredient);
                    },
                );
              },

            );
          }
      ),
      floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
        children:[
          FloatingActionButton(
            heroTag: "setupButton",
            onPressed: () async {
              if (Hive.box<Ingredient>('ingredients').length == 0) {
                Hive.box<Ingredient>('ingredients').put(flour.id, flour);
                Hive.box<Ingredient>('ingredients').put(yeast.id, yeast);
                Hive.box<Ingredient>('ingredients').put(water.id, water);
                Hive.box<Ingredient>('ingredients').put(sugar.id, sugar);
                Hive.box<Ingredient>('ingredients').put(salt.id, salt);
                Hive.box<Ingredient>('ingredients').put(oil.id, oil);
              }
              setState(() {});
            },
            child: const Icon(Icons.auto_fix_high),
            // auto_awesome
            // breakfast_dining
            // countertops

            // keep looking after eco
              //https://api.flutter.dev/flutter/material/Icons-class.html

          ),
          SizedBox(height: 10),
          FloatingActionButton(
            heroTag: "cookButton",
            onPressed: () async {
              // ingredient counts are 0 even before the method is called
              /*
              print(flour.count);
              print(yeast.count);
              print(water.count);
              print(sugar.count);
              print(salt.count);
              print(oil.count);
               */
              checkIngredients();
              cook();
            },
            child: const Icon(Icons.local_dining, color: Colors.green),
          ),
          SizedBox(height: 10),
          // TODO: figure out why reset button existing seems to reset counts to 0 without pressing it
          /*
          FloatingActionButton(
            heroTag: "resetButton",
            onPressed: () {
              // TODO: loop through list of ingredients, call resetCount(ingredient)
              resetCount(flour);
              resetCount(yeast);
              resetCount(water);
              resetCount(sugar);
              resetCount(salt);
              resetCount(oil);
            },
            child: const Icon(Icons.refresh, color: Colors.red),
          ),
          */
        ]
      )
    );
  }

  Future kitchenFeedback(BuildContext context){
    return showDialog(
        context: context,
        builder : (BuildContext context){
          return AlertDialog(
            title: Text(messageHeader),
            content: SingleChildScrollView(
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                        message
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
        });
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

  // unused
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