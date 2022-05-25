import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:programming_memo_for_mac_app/screen/component/memo_list/children/memo_list.dart';

import '../../../../domain/entities/memo/memo.dart';
import '../../../../store/memo/memo_provider.dart';


class MemoListWidgetsContainer extends ConsumerWidget {
  final Widget errorWidget;
  const MemoListWidgetsContainer({
    Key? key,
    required this.errorWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final memoList = ref.watch(memoStateProvider).memoList;
    final loadingState = ref.watch(memoStateProvider).loadingState;

    _selectMemo(Memo memo) {
      final memoList = ref.read(memoStateProvider).memoList;
      ref.read(memoStateProvider.notifier).openMemo(memo, memoList);
      Navigator.pushNamed(context, '/');
    }

    makeDeleteMemo(Memo memo) {
      final memoList = ref.read(memoStateProvider).memoList;
      final deletedMemoList = ref.read(memoStateProvider).deletedMemoList;
      ref.read(memoStateProvider.notifier).makeDeleteMemo(memo, memoList, deletedMemoList);
    }

    return MemoListWidgets(
      memoList: memoList,
      loadingState: loadingState,
      selectMemo: _selectMemo,
      makeDeleteMemo: makeDeleteMemo,
      errorWidget: errorWidget,
    );
  }
}
