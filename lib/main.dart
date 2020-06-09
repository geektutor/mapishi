import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'recipe.dart';
import 'list.dart';
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mapishi',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Mapishi'),
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
        ));
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
