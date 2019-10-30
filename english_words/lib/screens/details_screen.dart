import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {

  final Set<WordPair> savedItems;

  DetailsScreen(this.savedItems);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
              "Saved items",
            )
        ),
        body: savedItems.isEmpty ? _addEmptyPlaceholder() : _addFavoritesList()
    );
  }

  Widget _addFavoritesList() {
    return ListView.builder(
      itemCount: savedItems.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            savedItems.toList()[index].asPascalCase,
            style: const TextStyle(
                fontSize: 16.0
            ),
          ),
          trailing: Icon(
              Icons.favorite,
              color: Colors.red
          ),
        );
      },
    );
  }

  Widget _addEmptyPlaceholder() {
    return Center(
      child: Text(
        "Empty list",
        style: const TextStyle(
            fontSize: 20.0
        ),
      ),
    );
  }

}
