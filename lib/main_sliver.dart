import 'package:flutter/material.dart';
import 'ingredient.dart';

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

class _MyHomePageState extends State<MyHomePage> {
  //const HorizonsApp({super.key});

  Ingredient flour = new Ingredient(
      "flour", "flour_immo_wegmann.jpg", 0, "cup");
  Ingredient yeast = new Ingredient(
      "yeast", "yeast_karyna_panchenko.jpg", 0, "tbsp");

  // need imgs
  Ingredient water = new Ingredient(
      "water", "flour_immo_wegmann.jpg", 0, "cup");
  Ingredient sugar = new Ingredient(
      "sugar", "flour_immo_wegmann.jpg", 0, "cup");
  Ingredient salt = new Ingredient("salt", "flour_immo_wegmann.jpg", 0, "tsp");
  Ingredient oil = new Ingredient("oil", "flour_immo_wegmann.jpg", 0, "tbsp");

  bool success = false;
  String message = "";

  increaseIngredient(ingredient) {
    setState(() { // need this to be in the home page state
      ingredient.increase(1);
    });
  }

  @override
  Widget build(BuildContext context) {
    // doesn't error out here (sweats nervously)
    availableIngredients.add(flour);
    availableIngredients.add(yeast);
    availableIngredients.add(water);
    availableIngredients.add(sugar);
    availableIngredients.add(salt);
    availableIngredients.add(oil);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      scrollBehavior: const ConstantScrollBehavior(),
      title: 'Recipe Simulator',
      home: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              //floating: true,
              pinned: true,
              stretch: true,
              //stretchTriggerOffset: 10, // this doesn't seem to help it trigger
              onStretchTrigger: () async { // this doesn't seem to be triggering
                print('Load new data!');
                // await Server.requestNewData();
              },
              backgroundColor: Colors.green[500],
              expandedHeight: 200.0,
              flexibleSpace: FlexibleSpaceBar(
                stretchModes: const [
                  //StretchMode.zoomBackground,
                  //StretchMode.fadeTitle,
                  StretchMode.blurBackground,
                ],
                title: Text('Recipe Simulator'),
                background: DecoratedBox(
                  position: DecorationPosition.foreground,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.center,
                      colors: <Color>[
                        Colors.red[700]!,
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
            ),
            //IngredientList(),
            IngredientListMethod(),
          ],
        ),
      ),
    );
  }
}

Widget IngredientListMethod() {
  print("in IngredientListMethod with length = "+availableIngredients.length.toString());
  return SliverList(
    delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
        final Ingredient ingredient = availableIngredients[index]; // grab current ingredient
        print(availableIngredients.length);
        return cardWidget(ingredient);
        //return Text("ingredient is "+ingredient.name);
      },
      childCount: availableIngredients.length,
    ),
  );
}
Widget cardWidget(Ingredient ingredient)  {

  // find a spot where these methods won't error out
  /*
  void checkIngredients(){
    // https://tastesbetterfromscratch.com/bread-recipe/
    if (water.getCount() == 2 && yeast.getCount() == 1 && sugar.getCount() == 1 && salt.getCount() == 2 && oil.getCount() == 2 && flour.getCount() == 4) {
      success = true;
    }
    print(success);
  }

  void cook(){
    if(success == true){
      message = "You did it! Congratulations";
    }
    else{
      message = "You made a mistake; better try again.";
    }
  }
  */

// TODO: add a START OVER button which resets ingredients to 0 if you mess up

  return Card(
    child: Row(
        children: <Widget>[
          Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // left align
                    children: <Widget>[
                      Text(
                        ingredient.getName() + ": " + ingredient.getCount().toString() + " " + ingredient.getMeasurement(),
                        //style: textTheme.headlineSmall,
                      ),
                      SizedBox( // size of card
                        height: 200.0,
                        width: 200.0,
                        child: Stack(
                          fit: StackFit.expand,
                          children: <Widget>[
                            Center(
                              child: Image(image: AssetImage(
                                  'graphics/' + ingredient.getImg()),
                                fit: BoxFit.fill,),
                            ),
                          ],
                        ),
                      ),

                      /*
                      ElevatedButton(
                        onPressed: () {
                          increaseIngredient(ingredient);
                        },
                        child: Text('Add a ' + ingredient.getMeasurement() + " of " + ingredient.getName()),
                      ),
                      */
                    ]
                ),
              )
          ),
        ]
    ),
  );
}

// --------------------------------------------
// Below this line are helper classes and data.

List<Ingredient> availableIngredients = [];

class ConstantScrollBehavior extends ScrollBehavior {
  const ConstantScrollBehavior();

  @override
  Widget buildScrollbar(
      BuildContext context, Widget child, ScrollableDetails details) =>
      child;

  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) =>
      child;

  @override
  TargetPlatform getPlatform(BuildContext context) => TargetPlatform.macOS;

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) =>
      const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics());
}
