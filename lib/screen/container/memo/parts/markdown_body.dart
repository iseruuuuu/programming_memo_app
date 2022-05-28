import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:programming_memo_for_mac_app/screen/screen/memo/parts/markdown_builder/header.dart';
import 'package:programming_memo_for_mac_app/screen/screen/memo/parts/markdown_builder/pre.dart';
import 'package:url_launcher/url_launcher.dart';

class MarkdownBodyHeaderCopiableContainer extends StatelessWidget {
  final String content;
  final Function(String) onCopyRequested;
  int headerIndex = 0;

  MarkdownBodyHeaderCopiableContainer({
    Key? key,
    required this.content,
    required this.onCopyRequested,
  }) : super(key: key);

  int add(String tag, String textContent) {
    return headerIndex++;
  }

  @override
  Widget build(BuildContext context) {
    final _onCopyRequested = onCopyRequested;
    return MarkdownBody(
      data: content,
      selectable: true,
      imageBuilder: (uri, title, alt) {
        return Center(
          child: Image.network(
            uri.toString(),
          ),
        );
      },
      onTapLink: (_, url, __) {
        if (url != null) {
          final uri = Uri.parse(url);
          launchUrl(uri);
        }
      },
      blockSyntaxes: [
        B2BlockSyntax(),
        VeryWarningSyntax(),
        LittleWarningSyntax(),
        InformationSyntax(),
        BoldSyntax(),
        ColorSyntax(),
        Quote1Syntax(),
      ],
      builders: <String, MarkdownElementBuilder>{
        'h1': CustomHeader1Builder(
          content: content,
          onHeaderFound: add,
          onCopyRequested: _onCopyRequested,
        ),
        'h2': CustomHeader2Builder(
          content: content,
          onHeaderFound: add,
          onCopyRequested: _onCopyRequested,
        ),
        'h3': CustomHeader3Builder(
          content: content,
          onHeaderFound: add,
          onCopyRequested: _onCopyRequested,
        ),
        'h4': CustomHeader4Builder(
          content: content,
          onHeaderFound: add,
          onCopyRequested: _onCopyRequested,
        ),
        'h5': CustomHeader5Builder(
          content: content,
          onHeaderFound: add,
          onCopyRequested: _onCopyRequested,
        ),
        'h6': CustomHeader6Builder(
          content: content,
          onHeaderFound: add,
          onCopyRequested: _onCopyRequested,
        ),
        'pre': CustomPreBuilder(),
        'warning': WarningBuilder(),
        'verywaring': VeryWarningBuilder(),
        'littlewaring': LittleWarningBuilder(),
        'information': InformationBuilder(),
        'bold': BoldBuilder(),
        'color': ColorBuilder(),
        'Q1': Quote1Builder(),
      },
    );
  }
}
