import 'package:flutter/material.dart';
import 'package:hiradvantista/src/features/hymn/presentation/widget/hymn_filter_widget.dart';

class HymnSearchDelegateWidget extends SearchDelegate<String> {
  @override
  String get searchFieldLabel => 'N° ou titre';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return HymnFilterWidget(searchQuery: query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return HymnFilterWidget(searchQuery: query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recherche'),
        actions: [
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              query = '';
            },
          ),
        ],
      ),
      body: HymnFilterWidget(searchQuery: query),
    );
  }
}
