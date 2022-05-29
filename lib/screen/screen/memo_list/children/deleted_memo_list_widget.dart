import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:programming_memo_for_mac_app/domain/entities/memo/memo.dart';
import 'package:programming_memo_for_mac_app/screen/screen/keyboard_action.dart';
import 'package:programming_memo_for_mac_app/screen/screen/loading.dart';
import 'package:programming_memo_for_mac_app/screen/screen/memo_list/children/memo_list_card_page.dart';
import 'package:programming_memo_for_mac_app/store/loading_state.dart';

class DeletedMemoListWidgets extends StatelessWidget {
  final List<Memo> deletedMemoList;
  final LoadingState loadingState;
  final Function(Memo memo) restoreMemo;
  final Function(Memo memo) permanentDeleteMemo;
  final Widget errorWidget;

  const DeletedMemoListWidgets({
    required this.loadingState,
    required this.deletedMemoList,
    required this.restoreMemo,
    required this.permanentDeleteMemo,
    required this.errorWidget,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final memoDeletedListNoItem =
        AppLocalizations.of(context)?.memoDeletedListNoItem ?? "";
    final memoDeletedListActionRestore =
        AppLocalizations.of(context)?.memoDeletedListActionRestore ?? "";
    final memoDeletedListActionDeletePermanent =
        AppLocalizations.of(context)?.memoDeletedListActionDeletePermanent ??
            "";
    const externalPaddingInset = EdgeInsets.all(8);
    if (loadingState == LoadingState.initial ||
        loadingState == LoadingState.loading) {
      return const LoadingWidget();
    } else if (loadingState == LoadingState.failed) {
      return Center(child: errorWidget);
    }
    ScrollController _controller = ScrollController();
    var position = 0.0;
    if (deletedMemoList.isEmpty) {
      return Padding(
        padding: externalPaddingInset,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.delete_forever,
              size: 130,
            ),
            const SizedBox(height: 10),
            Text(
              memoDeletedListNoItem,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
    }
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
          child: ListView(
            controller: _controller,
            padding: externalPaddingInset,
            children: deletedMemoList
                .map(
                  (memo) => MemoListCardPage(
                    key: Key(memo.id),
                    memo: memo,
                    isMemo: false,
                    actions: [
                      CardAction(
                        icons: Icons.restore,
                        label: memoDeletedListActionRestore,
                        action: restoreMemo,
                      ),
                      CardAction(
                        icons: Icons.delete_forever,
                        label: memoDeletedListActionDeletePermanent,
                        action: permanentDeleteMemo,
                      )
                    ],
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
