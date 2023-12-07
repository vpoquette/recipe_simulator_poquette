import 'package:flutter/material.dart';
import 'ingredient.dart';

void main() {
  runApp(const HorizonsApp());

}
class HorizonsApp extends StatelessWidget {
  const HorizonsApp({super.key});

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
            IngredientList(),
          ],
        ),
      ),
    );
  }
}

class IngredientList extends StatelessWidget {
  const IngredientList({super.key});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return SliverList(
      delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
          final Ingredient ingredient = availableIngredients[index]; // grab current ingredient
          print(availableIngredients.length);
          return Card(
            child: Row(
                children: <Widget>[
                  // number on left of image
                    // might not need
                  Text(
                    ingredient.getName(),
                    style: textTheme.headlineMedium,
                  ),
                  Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start, // left align
                            children: <Widget>[
                              Text(
                                ingredient.getCount().toString(),
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
                                      child: Image(image: AssetImage('graphics/' + ingredient.getImg()), fit: BoxFit.cover,),
                                    ),
                                    Center(
                                      child: Text(
                                        ingredient
                                            .getName(),
                                        style: textTheme.displayMedium,
                                      ),
                                    ),
                                  ],
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
        childCount: availableIngredients.length,
      ),
    );
  }
}

// --------------------------------------------
// Below this line are helper classes and data.

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
