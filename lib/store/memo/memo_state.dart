import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:programming_memo_for_mac_app/domain/entities/memo/memo.dart';
import 'package:programming_memo_for_mac_app/store/loading_state.dart';

part 'memo_state.freezed.dart';

@freezed
class MemoState with _$MemoState {
  const factory MemoState({
    required LoadingState loadingState,
    required Memo? memo,
    required List<Memo> memoList,
    required List<Memo> deletedMemoList,
  }) = _MemoState;

  factory MemoState.initial() {
    return const MemoState(
      loadingState: LoadingState.initial,
      memo: null,
      memoList: [],
      deletedMemoList: [],
    );
  }
}
