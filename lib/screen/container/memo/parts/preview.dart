import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:programming_memo_for_mac_app/screen/screen/memo/parts/preview_widget.dart';
import 'package:programming_memo_for_mac_app/store/memo/memo_provider.dart';

class PreviewWidgetContainer extends StatelessWidget {
  const PreviewWidgetContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _onCopyRequested(String text) {
      final data = ClipboardData(text: text);
      Clipboard.setData(data);
    }

    return Consumer(
      builder: (context, ref, _) {
        final memo = ref.watch(memoProvider);
        final loadingState = ref.watch(memoStateProvider).loadingState;
        return PreviewWidget(
          title: memo?.title,
          content: memo?.content,
          loadingState: loadingState,
          onCopyRequested: _onCopyRequested,
        );
      },
    );
  }
}
