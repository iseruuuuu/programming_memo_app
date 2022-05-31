import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:programming_memo_for_mac_app/screen/example_screen/example_preview_screen.dart';
import 'package:programming_memo_for_mac_app/store/memo/memo_provider.dart';

class ExamplePreviewContainer extends StatelessWidget {
  const ExamplePreviewContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _onCopyRequested(String text) {
      final data = ClipboardData(text: text);
      Clipboard.setData(data);
    }

    return Consumer(
      builder: (context, ref, _) {
        final loadingState = ref.watch(memoStateProvider).loadingState;
        return ExamplePreviewScreen(
          loadingState: loadingState,
          onCopyRequested: _onCopyRequested,
        );
      },
    );
  }
}
