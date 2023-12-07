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

// Current Goal:
// cook a pre-set recipe by following the directions

// use Hive to store current progress in recipe

class _MyHomePageState extends State<MyHomePage> {
  // logic variables, methods
  // need to move these to their own file for Separation of Concerns

  List<Ingredient> availableIngredients = [];
  _MyHomePageState() {
    availableIngredients.add(new Ingredient(
        "flour", "flour_immo_wegmann.jpg", 0));
    availableIngredients.add(new Ingredient(
        "yeast", "yeast_karyna_panchenko.jpg", 0));
    // need imgs
    availableIngredients.add(new Ingredient(
        "water", "flour_immo_wegmann.jpg", 0));
    availableIngredients.add(new Ingredient(
        "sugar", "flour_immo_wegmann.jpg", 0));
    availableIngredients.add(new Ingredient(
        "salt", "flour_immo_wegmann.jpg", 0));
    availableIngredients.add(new Ingredient(
        "oil", "flour_immo_wegmann.jpg", 0));
  }

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

  // TODO: instead of list tile, use defining_widgets_poquette
    // still do use the ingredients list

  // let's build a user interface
  // difficult to use an app without one
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        scrollBehavior: const ConstantScrollBehavior(),
        title: 'Recipe Simulator',
        home: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            stretch: true,
            backgroundColor: Colors.blue[700],
            expandedHeight: 200.0,
            flexibleSpace: FlexibleSpaceBar(
            stretchModes: const [
              //StretchMode.zoomBackground,
              //StretchMode.fadeTitle,
              StretchMode.blurBackground,
            ],
            title: Text('Le Kitchen'),
            background: DecoratedBox(
                position: DecorationPosition.foreground,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.center,
                    colors: <Color>[
                      Colors.blue[700]!,
                      Colors.transparent,
                    ],
                  ),
                ),


        child: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return Card(
                      child: Row(
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

            // TODO: find and add images for buttons below

            Text("Cups of Warm Water: $water", style: Theme.of(context).textTheme.headlineMedium),
            ElevatedButton(
              onPressed: () {
                addWater();
              },
              child: Text('Add a Cup of Warm Water'),
            ),
            SizedBox(height: 20), // line break

            Text("Quarter-Cups of Sugar: $sugar", style: Theme.of(context).textTheme.headlineMedium),
            ElevatedButton(
              onPressed: () {
                addSugar();
              },
              child: Text('Add a Quarter-Cup of Sugar'),
            ),
            SizedBox(height: 20), // line break

            Text("Teaspoons of Salt: $salt", style: Theme.of(context).textTheme.headlineMedium),
            ElevatedButton(
              onPressed: () {
                addSalt();
              },
              child: Text('Add a Teaspoon of Salt'),
            ),
            SizedBox(height: 20), // line break

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
      );
                      },
      /*
      floatingActionButton: FloatingActionButton(
        onPressed: addFlour,
        tooltip: 'Add Flour',
        child: const Icon(Icons.add),
      ),
       */
                    childCount: availableIngredients.length,
    )
    )
      )
      )
          )
          ]
    )
    )
    );
  }
}


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


  class DailyForecast {
  const DailyForecast({
  required this.id,
  required this.imageId,
  required this.highTemp,
  required this.lowTemp,
  required this.description,
  });

  final int id;
  final String imageId;
  final int highTemp;
  final int lowTemp;
  final String description;

  static const List<String> _weekdays = <String>[
  'Monday',
  'Tuesday',
  'Wednesday',
  'Thursday',
  'Friday',
  'Saturday',
  'Sunday',
  ];

  String getWeekday(int today) {
  final int offset = today + id;
  final int day = offset >= 7 ? offset - 7 : offset;
  return _weekdays[day];
  }

  int getDate(int today) => today + id;
  }

/*
class WeeklyForecastList extends StatelessWidget {
  const WeeklyForecastList({super.key});

  @override
  Widget build(BuildContext context) {
    final DateTime currentDate = DateTime.now();
    final TextTheme textTheme = Theme.of(context).textTheme;

    return SliverList(
      delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              final DailyForecast dailyForecast =
              Server.getDailyForecastByID(index);
              //Server.getDailyForecastListByID(index);
              return Card(
                child: Row(
                  children: <Widget>[
                    // number on left of image
                    Text(
                      dailyForecast.getDate(currentDate.day).toString(),
                      style: textTheme.headlineMedium,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start, // left align
                          children: <Widget>[
                            Text(
                              dailyForecast.getWeekday(currentDate.weekday),
                              style: textTheme.headlineSmall,
                            ),
                            SizedBox(
                              height: 200.0,
                              width: 200.0,
                              child: Stack(
                                fit: StackFit.expand,
                                children: <Widget>[
                                  DecoratedBox(
                                    position: DecorationPosition.foreground,
                                    decoration: BoxDecoration(
                                      gradient: RadialGradient(
                                        colors: <Color>[
                                          Colors.amber[500]!, //Colors.grey[800]!,
                                          //Colors.blue,
                                          Colors.transparent,
                                        ],
                                        radius: 0.25,
                                      ),
                                    ),
                                    child: Image.network(
                                      dailyForecast.imageId,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      dailyForecast
                                          .getDate(currentDate.day)
                                          .toString(),
                                      style: textTheme.headline2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(dailyForecast.description),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                '${dailyForecast.highTemp} | ${dailyForecast.lowTemp} F',
                                style: textTheme.titleSmall,
                              ),
                            ),
                          ]
                        ),
                      )
                    ),
                  ]
              ),
            );
          },
        childCount: 7,
      ),
    );
  }
}
 */