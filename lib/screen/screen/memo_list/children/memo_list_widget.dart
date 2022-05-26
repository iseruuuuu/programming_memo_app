import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:programming_memo_for_mac_app/domain/entities/memo/memo.dart';
import 'package:programming_memo_for_mac_app/screen/screen/loading.dart';
import 'package:programming_memo_for_mac_app/screen/screen/memo_list/children/memo_list_card_page.dart';
import 'package:programming_memo_for_mac_app/store/loading_state.dart';

class MemoListWidgets extends StatelessWidget {
  final List<Memo> memoList;
  final LoadingState loadingState;
  final Function(Memo memo) selectMemo;
  final Function(Memo memo) makeDeleteMemo;
  final Widget errorWidget;

  const MemoListWidgets({
    required this.memoList,
    required this.loadingState,
    required this.selectMemo,
    required this.makeDeleteMemo,
    required this.errorWidget,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final memoListNoItem = AppLocalizations.of(context)?.memoListNoItem ?? "";
    final memoListActionDelete =
        AppLocalizations.of(context)?.memoListActionDelete ?? "";
    final memoListActionOpen =
        AppLocalizations.of(context)?.memoListActionOpen ?? "";

    const externalPaddingInset = EdgeInsets.all(8);

    if (loadingState == LoadingState.initial ||
        loadingState == LoadingState.loading) {
      return const LoadingWidget();
    } else if (loadingState == LoadingState.failed) {
      return Center(child: errorWidget);
    }
    if (memoList.isEmpty) {
      return Padding(
        padding: externalPaddingInset,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.browser_not_supported,
              size: 120,
            ),
            const SizedBox(height: 10),
            Text(
              memoListNoItem,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
    }
    return ListView(
      padding: externalPaddingInset,
      children: memoList
          .map(
            (memo) => MemoListCardPage(
              key: Key(memo.id),
              memo: memo,
              isMemo: true,
              actions: [
                CardAction(
                  icons: Icons.file_open,
                  label: memoListActionOpen,
                  action: selectMemo,
                ),
                CardAction(
                  icons: Icons.delete,
                  label: memoListActionDelete,
                  action: makeDeleteMemo,
                ),
              ],
            ),
          )
          .toList(),
    );
  }
}
