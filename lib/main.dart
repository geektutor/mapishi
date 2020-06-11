import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'recipe.dart';
import 'list.dart';
import 'dart:convert';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isPlatformDark =
        WidgetsBinding.instance.window.platformBrightness == Brightness.dark;
    final initTheme = isPlatformDark ? darkTheme : lightTheme;
    return ThemeProvider(
      initTheme: initTheme,
      child: Builder(builder: (context) {
        return MaterialApp(
          title: 'Mapishi',
          theme: ThemeProvider.of(context),
          home: MyHomePage(),
        );
      }),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List data;

  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text('Mapishi'),
            actions: <Widget>[
              ThemeSwitcher(
                builder: (context) {
                  return IconButton(
                    icon: Icon(Icons.brightness_3, size: 25),
                    onPressed: () {
                      ThemeSwitcher.of(context).changeTheme(
                        theme: ThemeProvider.of(context).brightness ==
                                Brightness.light
                            ? darkTheme
                            : lightTheme,
                      );
                    },
                  );
                },
              ),
            ],
          ),
          body: Container(
            child: new Center(
              // Use future builder and DefaultAssetBundle to load the local JSON file
              child: new FutureBuilder(
                  future: DefaultAssetBundle.of(context)
                      .loadString('assets/meal.json'),
                  builder: (context, snapshot) {
                    List<Recipe> recipes = parseJosn(snapshot.data.toString());
                    return !recipes.isEmpty
                        ? new RecipeList(recipe: recipes)
                        : new Center(child: new CircularProgressIndicator());
                  }),
            ),
          )),
    );
  }

  List<Recipe> parseJosn(String response) {
    if (response == null) {
      return [];
    }
    final parsed =
        json.decode(response.toString()).cast<Map<String, dynamic>>();
    return parsed.map<Recipe>((json) => new Recipe.fromJson(json)).toList();
  }
}
