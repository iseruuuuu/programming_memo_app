import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:programming_memo_for_mac_app/screen/container/memo/parts/markdown_body.dart';
import 'package:programming_memo_for_mac_app/screen/screen/loading.dart';
import 'package:programming_memo_for_mac_app/store/loading_state.dart';

class PreviewWidget extends StatelessWidget {
  const PreviewWidget({
    required this.title,
    required this.content,
    required this.loadingState,
    required this.onCopyRequested,
    Key? key,
  }) : super(key: key);
  final String? title;
  final String? content;
  final LoadingState loadingState;
  final Function(String) onCopyRequested;

  @override
  Widget build(BuildContext context) {
    final memoTitleName = AppLocalizations.of(context)?.memoTitleName ?? "";
    final memoContentName = AppLocalizations.of(context)?.memoContentName ?? "";
    final notifyMemoContentCopied =
        AppLocalizations.of(context)?.notifyMemoContentCopied ?? "";
    final memoListLoading = AppLocalizations.of(context)?.memoListLoading ?? "";
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
    return SingleChildScrollView(
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
            Text(
              title ?? memoListLoading,
              style: titleTextStyle,
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
            MarkdownBodyHeaderCopiableContainer(
              content: content ?? memoListLoading,
              onCopyRequested: _onCopyRequested,
            ),
          ],
        ),
      ),
    );
  }
}
