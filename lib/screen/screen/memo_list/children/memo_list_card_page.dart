import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:programming_memo_for_mac_app/config.dart';
import 'package:programming_memo_for_mac_app/domain/entities/memo/memo.dart';

class CardAction {
  final IconData icons;
  final String label;
  final Function(Memo memo) action;
  final Color color;

  const CardAction({
    required this.icons,
    required this.label,
    required this.action,
    required this.color,
  });
}

class MemoListCardPage extends StatelessWidget {
  final Memo memo;
  final List<CardAction> actions;
  final bool isMemo;

  const MemoListCardPage({
    required this.memo,
    required this.actions,
    required this.isMemo,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final contentSummary = (() {
      if (memo.content.length > Constants.memoContentSummaryCounts) {
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
      onDoubleTap: () {
        isMemo ? actions[0].action(memo) : null;
      },
      child: Card(
        elevation: 5,
        child: Padding(
          padding: externalPaddingInset,
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      memo.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        overflow: TextOverflow.ellipsis,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: actions
                          .map(
                            (action) => TextButton.icon(
                              icon: Icon(
                                action.icons,
                                size: 30,
                                color: action.color,
                              ),
                              label: Text(
                                action.label,
                                style: TextStyle(
                                  color: action.color,
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
              ),
              // const Spacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (willDeleteDays != null)
                    Text(
                      memoCardWillDeleteDays,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                        fontSize: 18,
                      ),
                    ),
                  if (willDeleteDays != null)
                    const Padding(padding: headingPaddingInset),
                  Text(memoCardCreatedAt),
                  const Padding(padding: contentPaddingInset),
                  Text(memoCardLastModifiedAt),
                  const Padding(padding: contentPaddingInset),
                  Text(memoCardLastOpenedAt),
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
