import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../application/hymn_service.dart';
import '../../domain/hymn_model.dart';

class HymnListItemWidget extends ConsumerWidget {
  final HymnModel hymn;

  const HymnListItemWidget({required this.hymn, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final HymnService hymnService = ref.watch(hymnServiceProvider);

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.white70,
        foregroundColor: Colors.black,
        child: Text("${hymn.id}", style: const TextStyle(fontSize: 15)),
      ),
      title: Text(hymn.title),
      trailing: IconButton(
        key: Key("favorite-${hymn.id}"),
        icon: hymn.isFavorite == true
            ? const Icon(
                Icons.favorite,
                color: Colors.red,
              )
            : const Icon(Icons.favorite_border),
        onPressed: () async {
          await hymnService.toggleFavorite(hymn);
        },
      ),
      onTap: () {
        GoRouter.of(context).push("/hymn/${hymn.id}");
      },
    );
  }
}
