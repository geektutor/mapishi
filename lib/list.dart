import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'recipe.dart';

class RecipeList extends StatelessWidget {
  final List<Recipe> recipe;
  RecipeList({Key key, this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: recipe == null ? 0 : recipe.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          child: ListTile(
            leading: CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage(
                "" + recipe[index].image,
              ),
            ),
            title: Text("" + recipe[index].title),
            subtitle: Text("" + recipe[index].about),
            enabled: true,
            dense: true,
            onTap: () {},
          ),
        );
      },
    );
  }
}
