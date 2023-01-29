import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hiradvantista/src/common_widgets/app_circular_progress_bar.dart';
import 'package:hiradvantista/src/features/hymn/presentation/widget/hymn_content_widget.dart';

import '../../../setting/application/font_size_service.dart';
import '../../application/hymn_service.dart';
import '../../domain/hymn_model.dart';

class HymnScreen extends ConsumerStatefulWidget {
  final int id;

  const HymnScreen({required this.id, Key? key}) : super(key: key);

  @override
  ConsumerState<HymnScreen> createState() => _HymnScreenState();
}

class _HymnScreenState extends ConsumerState<HymnScreen> {
  late ScrollController _scrollController;
  Color _textColor = Colors.white;
  static const kExpandedHeight = 170.0;
  late PageController controller;
  late int currentId;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          _textColor = _isSliverAppBarExpanded ? Colors.white : Colors.black;
        });
      });

    currentId = widget.id;
    controller = PageController(initialPage: currentId - 1);
  }

  bool get _isSliverAppBarExpanded {
    return _scrollController.hasClients &&
        _scrollController.offset > kExpandedHeight - kToolbarHeight - 45;
  }

  void _onPageChanged(int index) {
    setState(() {
      currentId = index + 1;
      _scrollController.animateTo(0.0,
          duration: const Duration(milliseconds: 500),
          curve: Curves.fastOutSlowIn);
    });
  }

  @override
  Widget build(BuildContext context) {
    final hymnService = ref.watch(hymnServiceProvider);
    final Future<HymnModel> hymn = hymnService.getHymnById(currentId);

    return FutureBuilder(
      future: hymn,
      builder: (context, AsyncSnapshot<HymnModel> snapshot) {
        if (snapshot.hasData) {
          final HymnModel hymn = snapshot.data as HymnModel;
          final title =
              "${hymn.id} - ${hymn.title} ${hymn.key != "" ? "(${hymn.key})" : ""} ";
          final appBarTitle = "Hira ${hymn.id.toString()}";

          return Scaffold(
            body: NestedScrollView(
              controller: _scrollController,
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Colors.white,
                    pinned: true,
                    snap: false,
                    floating: false,
                    expandedHeight: kExpandedHeight,
                    forceElevated: innerBoxIsScrolled,
                    title: _isSliverAppBarExpanded
                        ? Text(
                            appBarTitle,
                            style: TextStyle(color: _textColor),
                          )
                        : null,
                    flexibleSpace: _isSliverAppBarExpanded
                        ? null
                        : FlexibleSpaceBar(
                            title: Text(title,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                            titlePadding: const EdgeInsets.all(16),
                            background: SizedBox(
                              height: kExpandedHeight,
                              child: Image.asset(
                                "assets/images/hymn_sliver_background.jpg",
                                fit: BoxFit.cover,
                              ),
                            ),
                            centerTitle: true,
                          ),
                    actions: <Widget>[
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          ref.read(fontSizeServiceProvider.notifier).decrease();
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          ref.read(fontSizeServiceProvider.notifier).increase();
                        },
                      ),
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
                ];
              },
              body: PageView.builder(
                controller: controller,
                itemCount: hymnService.lastId,
                itemBuilder: (context, index) {
                  return HymnContentWidget(id: currentId);
                },
                onPageChanged: _onPageChanged,
              ),
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
