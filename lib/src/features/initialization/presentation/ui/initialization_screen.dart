import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hiradvantista/src/common_widgets/app_circular_progress_bar.dart';
import 'package:hiradvantista/src/route/route_name.dart';

import '../controller/initialization_controller.dart';

class InitializationScreen extends ConsumerStatefulWidget {
  const InitializationScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<InitializationScreen> createState() =>
      _InitializationScreenState();
}

class _InitializationScreenState extends ConsumerState<InitializationScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      initialData: ref.read(initControllerProvider.notifier).initData(),
      builder: (context, AsyncSnapshot<Future<bool>> data) {
        if (data.hasData && data.data != null) {
          data.data!.whenComplete(() {
            context.goNamed(RouteName.home);
          });
        }
        if (data.hasError) {
          return Scaffold(
            body: Center(
              child: Container(
                padding: const EdgeInsets.all(8),
                child: const Text('Ialana tsiny fa misy tsy mety kely.'),
              ),
            ),
          );
        }

        return const AppCircularProgressBar(
            message: "Eo am-panomanana ireo hira rehetra izahay...");
      },
    );
  }
}
