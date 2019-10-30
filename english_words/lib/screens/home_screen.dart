import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

import 'details_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomeScreen> {

  final randomWords = RandomWords();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.list),
            onPressed: _navigateToSavedItems,
          )
        ],
      ),
      body: Center(
        child: randomWords
      ),
    );
  }

  _navigateToSavedItems() {
    Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => DetailsScreen(randomWords.savedItems)
        )
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
  final Set<WordPair> _saved = Set<WordPair>();

  Set<WordPair> get savedItems {
    return this._saved;
  }


}

class _RandomWordsState extends State<RandomWords> {

  final List<WordPair> _suggestions = <WordPair>[];
  final TextStyle _biggerFont = const TextStyle(fontSize: 18);

  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildSuggestions();
  }

  Widget _buildSuggestions() {
    return ListView.builder(
      padding: const EdgeInsets.all(10),
      itemBuilder: (context, index){
        if (index.isOdd) {
          return Divider();
        }
        final int ind = index ~/ 2;
        if (ind >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggestions[ind]);
      },
    );
  }

  Widget _buildRow(WordPair pair) {
    final bool alreadySaved = widget._saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            widget._saved.remove(pair);
          } else {
            widget._saved.add(pair);
          }
        });
      },
    );
  }
}
