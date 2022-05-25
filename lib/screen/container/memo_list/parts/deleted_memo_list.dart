import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:programming_memo_for_mac_app/screen/component/memo_list/children/deleted_memo_list.dart';


import '../../../../domain/entities/memo/memo.dart';
import '../../../../store/memo/memo_provider.dart';


class DeletedMemoListWidgetsContainer extends ConsumerWidget {
  final Widget errorWidget;
  const DeletedMemoListWidgetsContainer({
    Key? key,
    required this.errorWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deletedMemoList = ref.watch(memoStateProvider).deletedMemoList;
    final loadingState = ref.watch(memoStateProvider).loadingState;

    _restoreMemo(Memo memo) {
      final memoList = ref.read(memoStateProvider).memoList;
      final deletedMemoList = ref.read(memoStateProvider).deletedMemoList;
      ref.read(memoStateProvider.notifier).restoreMemo(memo, memoList, deletedMemoList);
    }

    _permanentDeleteMemo(Memo memo) {
      final deletedMemoList = ref.read(memoStateProvider).deletedMemoList;
      ref.read(memoStateProvider.notifier).permanentDeleteMemo(memo, deletedMemoList);
    }

    return DeletedMemoListWidgets(
      deletedMemoList: deletedMemoList,
      loadingState: loadingState,
      restoreMemo: _restoreMemo,
      permanentDeleteMemo: _permanentDeleteMemo,
      errorWidget: errorWidget,
    );
  }
}
