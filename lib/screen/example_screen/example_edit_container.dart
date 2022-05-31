import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:programming_memo_for_mac_app/screen/example_screen/example_edit_screen.dart';
import 'package:programming_memo_for_mac_app/store/memo/memo_provider.dart';

class ExampleEditContainer extends ConsumerWidget {
  const ExampleEditContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loadingState = ref.watch(memoStateProvider).loadingState;
    void _onTitleChanged(String text) {
      final memo = ref.read(memoStateProvider).memo;
      if (memo == null) {
        return;
      }
      ref.read(memoStateProvider.notifier).updateTitle(memo, text);
    }

    void _onContentChanged(String text) {
      final memo = ref.read(memoStateProvider).memo;
      if (memo == null) {
        return;
      }
      ref.read(memoStateProvider.notifier).updateContent(memo, text);
    }

    return ExampleEditScreen(
      loadingState: loadingState,
      onTitleChanged: _onTitleChanged,
      onContentChanged: _onContentChanged,
    );
  }
}
