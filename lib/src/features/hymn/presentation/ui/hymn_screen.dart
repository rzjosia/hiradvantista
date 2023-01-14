import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hiradvantista/src/common_widgets/app_circular_progress_bar.dart';

import '../../application/hymn_service.dart';
import '../../domain/hymn_model.dart';

class HymnScreen extends ConsumerStatefulWidget {
  final int id;

  const HymnScreen({required this.id, Key? key}) : super(key: key);

  @override
  ConsumerState<HymnScreen> createState() => _HymnScreenState();
}

class _HymnScreenState extends ConsumerState<HymnScreen> {
  @override
  Widget build(BuildContext context) {
    final hymnService = ref.watch(hymnServiceProvider);
    final Future<HymnModel> hymn = hymnService.getHymnById(widget.id);

    return FutureBuilder(
      future: hymn,
      builder: (context, AsyncSnapshot<HymnModel> snapshot) {
        if (snapshot.hasData) {
          final HymnModel hymn = snapshot.data as HymnModel;
          final title =
              "${hymn.id} - ${hymn.title} ${hymn.key != "" ? "(${hymn.key})" : ""} ";

          return Scaffold(
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: Colors.brown,
                  foregroundColor: Colors.white,
                  pinned: true,
                  snap: false,
                  floating: true,
                  expandedHeight: 160.0,
                  flexibleSpace: FlexibleSpaceBar(
                    titlePadding: const EdgeInsets.only(
                        left: 76, right: 45, bottom: 16, top: 52),
                    title: Text(title,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                    background: Image.asset(
                      "assets/images/sliver_background.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                  actions: <Widget>[
                    IconButton(
                      key: Key("favorite-${hymn.id}"),
                      icon: hymn.isFavorite == true
                          ? const Icon(Icons.favorite, color: Colors.red)
                          : const Icon(Icons.favorite_border),
                      onPressed: () async {
                        await ref
                            .watch(hymnServiceProvider)
                            .toggleFavorite(hymn);
                      },
                    ),
                  ],
                ),
                SliverToBoxAdapter(
                  child: Container(
                    padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                    child: SizedBox(
                      width: double.infinity,
                      child: Text(hymn.content,
                          style: const TextStyle(fontSize: 18, height: 1.5)),
                    ),
                  ),
                )
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }

        return const AppCircularProgressBar();
      },
    );
  }
}
