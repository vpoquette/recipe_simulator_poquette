import 'package:flutter/material.dart';
import 'main.dart';

void main() async {
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
      home: const MyRecipePage(title: 'Recipe Simulator Home Page'),
    );
  }
}

class MyRecipePage extends StatefulWidget {
  const MyRecipePage({super.key, required this.title});

  final String title;

  @override
  State<MyRecipePage> createState() => _MyRecipePageState();
}

class _MyRecipePageState extends State<MyRecipePage> {
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
            mainAxisAlignment: MainAxisAlignment.start, // left-align the UI
            children: <Widget>[
              // flour
              SizedBox(height: 10), // padding on top
              Image(image: AssetImage('graphics/bread_charles-chen.jpg'), height: 200),
              SizedBox(height: 20), // line break
              Text("Bread", style: Theme.of(context).textTheme.headlineMedium,), // header
              SizedBox(height: 10), // line break
              Text("Ingredients", style: Theme.of(context).textTheme.headlineSmall),
              Text("2 cups warm water "
                  "\n 1 Tablespoons active dry yeast "
                  "\n 1/4 cup honey or sugar "
                  "\n 2 teaspoons salt "
                  "\n 2 Tablespoons oil "
                  "\n 4 cups all-purpose or bread flour"),
              SizedBox(height: 10), // line break

              // TODO: add process to main.dart and uncomment text below

              /* ***
              TEXT TO ADD ONCE KITCHEN HAS PROCESS FUNCTIONALITY
              *** */
              /*
              Text("Process", style: Theme.of(context).textTheme.headlineSmall),
              Text("1. Prepare the dough", style: Theme.of(context).textTheme.bodyLarge),
              Text("In a large bowl or stand mixer add the yeast, water and a pinch of the sugar or honey. "
                  "\n Allow to rest for 5-10 minutes until foaming and bubbly. "
                  "\n (This is called “proofing” the yeast, to make sure it is active. "
                  "\n If it doesn’t foam, the yeast is no good, and you need to start over with fresh yeast)."),
              Text("\n 2. Add remaining sugar or honey, salt, oil, and 3 cups of flour. Mix to combine."),
              Text("\n 3. Add another cup of flour and mix to combine."
                  "\n With the mixer running add more flour, ½ cup at a time, "
                  "\n ${' ' * 5}until the dough begins to pull away from the sides of the bowl."
                  "\n The dough should be smooth and elastic, and slightly stick "
                  "\n ${' ' * 5} to a clean finger, but not be overly sticky. "
                  "\n Add a little more flour, if needed."),
              SizedBox(height: 10),
              Text("4. Knead the dough", style: Theme.of(context).textTheme.bodyLarge),
              Text("Mix the dough for 4-5 minutes on medium speed "
                  "\n ${' ' * 5}(or knead with your hands on a lightly floured surface, for 5-8 minutes)."),
              SizedBox(height: 10), // line break
              Text("5. First rise", style: Theme.of(context).textTheme.bodyLarge),
              Text("Grease a large bowl with oil or cooking spray and place the dough inside, turning to coat. "
                  "\n Cover with a dish towel or plastic wrap and allow to rise in a warm place* "
                  "\n ${' ' * 5}until doubled in size, about 1 ½ hours."),
              SizedBox(height: 10), // line break
              Text("6. Spray two 9x5'' bread pans generously with cooking spray on all sides. "
                  "\n (I also like to line the bottom of the pans with "
                  "\n ${' ' * 5}a small piece of parchment or wax paper, but this is optional.)"),
              SizedBox(height: 10), // line break
              Text("7. Punch the dough down well to remove air bubbles. Divide into two equal portions. "
                  "\n Shape each ball into long logs and place into greased loaf pans."),
              SizedBox(height: 10), // line break
              Text("8. Second rise", style: Theme.of(context).textTheme.bodyLarge),
              Text("Spray two pieces of plastic wrap with cooking spray and lay them gently over the pans."
                  "\n Allow dough to rise again for about 45 minutes to one hour, "
                  "\n ${' ' * 5}or until risen about 1 inch above the loaf pans."
                  "\n Gently remove covering."),
              Text("9. Bake", style: Theme.of(context).textTheme.bodyLarge),
              Text("Preheat oven to 350 F. "
                  "\n Bake bread for about 30-33 minutes, or until golden brown on top."
                  "\n Give the top of a loaf a gentle tap; it should sound hollow."),
              Text("\n 10. Invert the loaves onto a wire cooling rack."
                  "\n Brush the tops with butter and allow to cool for at least 10 minutes before slicing."),
              Text("\n 11. Once cool, store in an airtight container or bag for "
                  "\n ${' ' * 5}2-3 days at room temperature, or up to 5 days in the refrigerator."),
              SizedBox(height: 10), // line break
              Text("Notes", style: Theme.of(context).textTheme.headlineSmall),
              Text("Flour", style: Theme.of(context).textTheme.bodyLarge),
              Text("Bread flour or all-purpose can both be used with no changes to the recipe."
                  "\n Bread flour will produce a slightly chewier loaf."
                  "\n Whole wheat flour can’t be substituted cup-for-cup "
                  "\n ${' ' * 5}because its gluten levels are different."),
              SizedBox(height: 10),
              Text("Yeast", style: Theme.of(context).textTheme.bodyLarge),
              Text("To substitute Instant or Rapid Rise yeast, skip the “proofing” of the dough "
                  "\n ${' ' * 5}in the first step and add the yeast to the bowl with step 2."
                  "\n Allow the dough to complete its first rise, and then roll and shape into loaves "
                  "\n ${' ' * 5}and rise again (rise times will be much faster with instant yeast)."),
              SizedBox(height: 10),
              Text("Quick-rise Tip", style: Theme.of(context).textTheme.bodyLarge),
              Text("To speed up the rising time of the first rise, make dough up to first rising, "
                  "\n placing it in a well greased bowl, turning it once to grease the dough all over."
                  "\n Cover bowl with plastic wrap."
                  "\n Preheat oven to 180 degrees F, then /turn oven off/." // how do I italicize?
                  "\n Place bowl into the oven, leaving the oven door slightly cracked open."
                  "\n Allow to rise until doubled. "
                  "\n Then remove, punch down and shape into loaves."),
              SizedBox(height: 10),
              Text("To Make Ahead", style: Theme.of(context).textTheme.bodyLarge),
              Text("Make the bread dough through step 4, before the first rise.  "
                  "\n Place in a large airtight container, and refrigerate for up to one day."
                  "\n Remove from fridge and allow to come to room temperature."
                  "\n Proceed with punching down and forming loaves."),
              SizedBox(height: 10),
              Text("Freezing Instructions", style: Theme.of(context).textTheme.bodyLarge),
              Text("To freeze the dough:", style: Theme.of(context).textTheme.bodyMedium),
              Text("Prepare the recipe through step (6), before the second rise."
                  "\n Place the shaped loaves into a freezer-safe or disposable aluminum bread pan."
                  "\n Cover tightly with a double layer of aluminum foil and freeze for up to 3 months."
                  "\n When ready to bake, allow the loaves to thaw and complete the second rise, "
                  "\n ${' ' * 5}at room temperature (about 5 hours)."
                  "\n Bake as directed."),
              Text("To freeze baked bread:", style: Theme.of(context).textTheme.bodyMedium),
              Text("Allow baked bread to cool completely."
                  "\n  Place each loaf in a freezer-safe resealable bag and freeze for up to 3 months."
                  "\n Thaw at room temperature on the countertop, or overnight in the refrigerator."),
              SizedBox(height: 10),
              Text("Bread Machine", style: Theme.of(context).textTheme.bodyLarge),
              Text("If using a bread machine, you may want to cut this recipe in half to make 1 loaf "
                  "\n ${' ' * 5}(depending on the capacity of your machine)."),
               */
              /* ***
              TEXT TO ADD ONCE KITCHEN HAS PROCESS FUNCTIONALITY
              *** */
              SizedBox(height: 10), // line break
              Text("Recipe found at https://tastesbetterfromscratch.com/bread-recipe/"),

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
