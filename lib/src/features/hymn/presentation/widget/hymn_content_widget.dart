import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common_widgets/app_circular_progress_bar.dart';
import '../../../setting/application/font_size_service.dart';
import '../../application/hymn_service.dart';
import '../../domain/hymn_model.dart';

class HymnContentWidget extends ConsumerWidget {
  final int id;

  const HymnContentWidget({required this.id, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    HymnService hymnService = ref.watch(hymnServiceProvider);
    final Future<HymnModel> hymn = hymnService.getHymnById(id);
    final fontSize = ref.watch(fontSizeServiceProvider);

    return FutureBuilder(
      future: hymn,
      builder: (context, AsyncSnapshot<HymnModel> snapshot) {
        if (snapshot.hasData) {
          final HymnModel hymn = snapshot.data as HymnModel;
          return Container(
            padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
            child: Text(
              hymn.content,
              style: TextStyle(fontSize: fontSize.toDouble(), height: 1.5),
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
