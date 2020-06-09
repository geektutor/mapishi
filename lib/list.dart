import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'recipe.dart';

class _BottomSheetContent extends StatelessWidget {
  _BottomSheetContent({this.title, this.description});
  String title;
  List description;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: Column(
        children: [
          Container(
            height: 70,
            child: Center(
              child: Text(
                "$title",
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const Divider(thickness: 1),
          Expanded(
            child: ListView.builder(
              itemCount: description == null ? 0 : description.length,
              itemBuilder: (context, indexDes) {
                return ListTile(
                  title: Text("" + description[indexDes]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class RecipeList extends StatelessWidget {
  final List<Recipe> recipe;
  RecipeList({Key key, this.recipe}) : super(key: key);
  void _showModalBottomSheet(BuildContext context, int index) {
    showModalBottomSheet<void>(
      context: context,
      builder: (context) {
        return _BottomSheetContent(
          title: "" + recipe[index].title,
          description: recipe[index].description,
        );
      },
    );
  }

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
            onTap: () {
              _showModalBottomSheet(context, index);
            },
          ),
        );
      },
    );
  }
}
