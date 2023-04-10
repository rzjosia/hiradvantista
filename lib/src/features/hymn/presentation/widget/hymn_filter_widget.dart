import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hiradvantista/src/features/hymn/presentation/widget/hymn_list_item_widget.dart';

import '../../../../common_widgets/app_circular_progress_bar.dart';
import '../../../../common_widgets/sliver_center.dart';
import '../../application/hymn_service.dart';
import '../../domain/hymn_model.dart';

class HymnFilterWidget extends ConsumerWidget {
  final HymnFilterType filterType;
  final String searchQuery;
  final bool isSliver;
  final bool searchInContent;

  const HymnFilterWidget(
      {Key? key,
      this.filterType = HymnFilterType.all,
      this.searchQuery = "",
      this.isSliver = false,
      this.searchInContent = false})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    HymnService service = ref.watch(hymnServiceProvider);
    Future<List<HymnModel>> hymn = service.getFilteredHymns(filterType,
        searchQuery: searchQuery, searchInContent: searchInContent);

    if (isSliver) {
      return FutureBuilder(
        future: hymn,
        builder: (context, AsyncSnapshot<List<HymnModel>> snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data as List<HymnModel>;

            if (data.isEmpty) {
              return const SliverCenter(
                child: Text("Aucune donnée disponible"),
              );
            }

            return SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return HymnListItemWidget(
                      key: Key("fihirana-${data[index]['id']}"),
                      hymn: data[index]);
                },
                childCount: data.length,
              ),
            );
          } else if (snapshot.hasError) {
            return SliverCenter(child: Text("${snapshot.error}"));
          }

          return const SliverCenter(child: AppCircularProgressBar());
        },
      );
    }

    return FutureBuilder(
      future: hymn,
      builder: (context, AsyncSnapshot<List<HymnModel>> snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data as List<HymnModel>;

          if (data.isEmpty) {
            return const Center(
              child: Text("Aucun chant disponible"),
            );
          }

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return HymnListItemWidget(
                  key: Key("fihirana-${data[index]['id']}"), hymn: data[index]);
            },
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }

        return const AppCircularProgressBar();
      },
    );
  }
}
