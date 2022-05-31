import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:programming_memo_for_mac_app/screen/container/memo/parts/markdown_body.dart';
import 'package:programming_memo_for_mac_app/screen/screen/keyboard_action.dart';
import 'package:programming_memo_for_mac_app/screen/screen/loading.dart';
import 'package:programming_memo_for_mac_app/store/loading_state.dart';
import 'example.dart';

class ExamplePreviewScreen extends StatelessWidget {
  const ExamplePreviewScreen({
    required this.loadingState,
    required this.onCopyRequested,
    Key? key,
  }) : super(key: key);
  final LoadingState loadingState;
  final Function(String) onCopyRequested;

  @override
  Widget build(BuildContext context) {
    final memoTitleName = AppLocalizations.of(context)?.memoTitleName ?? "";
    final memoContentName = AppLocalizations.of(context)?.memoContentName ?? "";
    final notifyMemoContentCopied =
        AppLocalizations.of(context)?.notifyMemoContentCopied ?? "";
    const externalPaddingInset = EdgeInsets.all(8);
    const internalPaddingInset = EdgeInsets.all(10);
    const titleTextStyle = TextStyle(
      fontStyle: FontStyle.italic,
      fontSize: 24,
    );
    const titleStyle = TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.black,
      fontSize: 30,
    );

    void _onCopyRequested(String text) {
      onCopyRequested(text);
      final textSummary =
          text.substring(0, min(16, text.length)).replaceAll("\n", "");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("$notifyMemoContentCopied ($textSummary...)"),
        duration: const Duration(seconds: 2),
      ));
    }

    if (loadingState == LoadingState.initial ||
        loadingState == LoadingState.loading) {
      return const LoadingWidget();
    }
    ScrollController _controller = ScrollController();
    var position = 0.0;
    return Shortcuts(
      shortcuts: <ShortcutActivator, Intent>{
        LogicalKeySet(LogicalKeyboardKey.arrowDown): const ArrowDown(),
        LogicalKeySet(LogicalKeyboardKey.arrowUp): const ArrowUp(),
      },
      child: Actions(
        actions: <Type, Action<Intent>>{
          ArrowDown: CallbackAction<ArrowDown>(onInvoke: (ArrowDown intent) {
            position += 100;
            _controller.jumpTo(position);
          }),
          ArrowUp: CallbackAction<ArrowUp>(onInvoke: (ArrowUp intent) {
            if (position <= 0) {
            } else {
              position -= 100;
              _controller.jumpTo(position);
            }
          }),
        },
        child: Focus(
          autofocus: true,
          child: SingleChildScrollView(
            controller: _controller,
            child: Padding(
              padding: externalPaddingInset,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    memoTitleName,
                    style: titleStyle,
                  ),
                  const Divider(
                    color: Colors.black,
                    thickness: 2,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    color: Colors.grey.shade50,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        Example().title,
                        style: titleTextStyle,
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                  const Padding(padding: internalPaddingInset),
                  Text(
                    memoContentName,
                    style: titleStyle,
                  ),
                  const Divider(
                    color: Colors.black,
                    thickness: 2,
                  ),
                  const Padding(padding: internalPaddingInset),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    color: Colors.grey.shade50,
                    child: MarkdownBodyHeaderCopiableContainer(
                      content: Example().example,
                      onCopyRequested: _onCopyRequested,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
