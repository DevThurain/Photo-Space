// ignore_for_file: must_be_immutable

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

abstract class BasedPage extends ConsumerWidget {
  BasedPage({super.key});
  final GlobalKey _loadingKey = GlobalKey();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    buildListeners(context, ref);
    return buildContent(context, ref);
  }

  void buildListeners(BuildContext context, WidgetRef ref) {}

  Widget buildContent(BuildContext context, WidgetRef ref) {
    return const SizedBox();
  }

  void showLoadingDailog(BuildContext context) {
    showCupertinoDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return Dialog(
            key: _loadingKey,
            child: const Padding(
              padding: EdgeInsets.all(32.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 45,
                    height: 45,
                    child: CircularProgressIndicator(),
                  ),
                  SizedBox(height: 16.0),
                  Text('Loading')
                ],
              ),
            ),
          );
        });
  }

  void hideLoadingDialog(BuildContext context) {
    if (_loadingKey.currentContext != null) {
      context.router.maybePop();
    }
  }
}
