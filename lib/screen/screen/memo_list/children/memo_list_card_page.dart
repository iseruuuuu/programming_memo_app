import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:programming_memo_for_mac_app/config.dart';
import 'package:programming_memo_for_mac_app/domain/entities/memo/memo.dart';

class CardAction {
  final IconData icons;
  final String label;
  final Function(Memo memo) action;

  const CardAction({
    required this.icons,
    required this.label,
    required this.action,
  });
}

class MemoListCardPage extends StatelessWidget {
  final Memo memo;
  final List<CardAction> actions;

  const MemoListCardPage({
    required this.memo,
    required this.actions,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final contentSummary = (() {
      if (memo.content.length > Constants.memoContentSummaryCounts) {
        //TODO 何文字入れるかどうかについては後で決める
        //TODO StackOverflowしないために、あらかじめ最低大きさを決める。
        return memo.content
                .substring(0, Constants.memoContentSummaryCounts + 40) +
            "…";
      } else {
        return memo.content;
      }
    })();
    final willDeleteDays = (() {
      final willDeleteAt = memo.willDeleteAt;
      if (willDeleteAt == null) {
        return null;
      }
      return willDeleteAt.difference(DateTime.now()).inDays;
    })();
    String toDifferenceDateString(DateTime dateTime) {
      final diff = DateTime.now().difference(dateTime);
      if (diff.inDays > 30) {
        return AppLocalizations.of(context)?.monthsBefore(diff.inDays ~/ 30) ??
            "";
      } else if (diff.inDays > 0) {
        return AppLocalizations.of(context)?.daysBefore(diff.inDays) ?? "";
      } else if (diff.inHours > 0) {
        return AppLocalizations.of(context)?.hoursBefore(diff.inHours) ?? "";
      }
      return AppLocalizations.of(context)?.minutesBefore(diff.inMinutes) ?? "";
    }

    final memoCardCreatedAt =
        AppLocalizations.of(context)?.memoCardCreatedAt(memo.createdAt) ?? "";
    final memoCardLastModifiedAt = AppLocalizations.of(context)
            ?.memoCardLastModifiedAt(
                toDifferenceDateString(memo.lastModifiedAt)) ??
        "";
    final memoCardLastOpenedAt = AppLocalizations.of(context)
            ?.memoCardLastOpenedAt(toDifferenceDateString(memo.lastOpenedAt)) ??
        "";
    final memoCardWillDeleteDays = AppLocalizations.of(context)
            ?.memoCardWillDeleteDays(willDeleteDays ?? -1) ??
        "";

    const externalPaddingInset = EdgeInsets.all(16);
    const headingPaddingInset = EdgeInsets.all(8);
    const contentPaddingInset = EdgeInsets.all(10);

    return GestureDetector(
      onDoubleTap: () => actions[0].action(memo),
      child: Card(
        elevation: 5,
        child: Padding(
          padding: externalPaddingInset,
          child: Row(
            children: [
              Column(
                // mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    memo.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  const Padding(padding: contentPaddingInset),
                  Text(
                    contentSummary,
                    style: const TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 15,
                    ),
                  ),
                  const Padding(padding: contentPaddingInset),
                  if (willDeleteDays != null) Text(memoCardWillDeleteDays),
                  if (willDeleteDays != null)
                    const Padding(padding: headingPaddingInset),
                  const Padding(padding: contentPaddingInset),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: actions
                        .map(
                          (action) => TextButton.icon(
                            icon: Icon(
                              action.icons,
                              size: 30,
                            ),
                            label: Text(
                              action.label,
                              style: const TextStyle(
                                color: Colors.blueAccent,
                                fontSize: 20,
                              ),
                            ),
                            onPressed: () => action.action(memo),
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
              const Spacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    memoCardCreatedAt,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Padding(padding: contentPaddingInset),
                  Text(
                    memoCardLastModifiedAt,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Padding(padding: contentPaddingInset),
                  Text(
                    memoCardLastOpenedAt,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const Padding(padding: contentPaddingInset),
            ],
          ),
        ),
      ),
    );
  }
}
