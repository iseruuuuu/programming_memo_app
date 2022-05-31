import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:programming_memo_for_mac_app/screen/screen/loading.dart';
import 'package:programming_memo_for_mac_app/store/loading_state.dart';
import 'example.dart';

class ExampleEditScreen extends StatelessWidget {
  final LoadingState loadingState;
  final void Function(String text) onTitleChanged;
  final void Function(String text) onContentChanged;

  const ExampleEditScreen({
    required this.loadingState,
    required this.onTitleChanged,
    required this.onContentChanged,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final memoTitleName = AppLocalizations.of(context)?.memoTitleName ?? "";
    final memoTitleHint = AppLocalizations.of(context)?.memoTitleHint ?? "";
    final memoContentName = AppLocalizations.of(context)?.memoContentName ?? "";
    final memoContentHint = AppLocalizations.of(context)?.memoContentHint ?? "";
    const externalPaddingInset = EdgeInsets.all(8);
    const internalPaddingInset = EdgeInsets.all(4);
    const titleTextStyle = TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.black,
      fontSize: 30,
    );
    const outlineInputBorder = OutlineInputBorder();

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
              style: titleTextStyle,
            ),
            TextFormField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: outlineInputBorder,
                hintText: memoTitleHint,
              ),
              initialValue: Example().title,
              onChanged: onTitleChanged,
            ),
            const Padding(padding: internalPaddingInset),
            Text(
              memoContentName,
              style: titleTextStyle,
            ),
            TextFormField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: outlineInputBorder,
                hintText: memoContentHint,
              ),
              // initialValue: content,
              initialValue: Example().example,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              onChanged: onContentChanged,
            ),
          ],
        ),
      ),
    );
  }
}
