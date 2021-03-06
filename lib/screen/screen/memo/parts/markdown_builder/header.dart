import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:programming_memo_for_mac_app/libs/id_generator/id_generator.dart';

class Header extends StatelessWidget {
  final String text;
  final String content;
  final int level;
  final int occurrence;
  final Function(String headerId) onCopyRequested;

  const Header({
    Key? key,
    required this.text,
    required this.level,
    required this.occurrence,
    required this.content,
    required this.onCopyRequested,
  }) : super(key: key);

  String? _extractCopyText() {
    final start = (() {
      Iterable<Match> matches = RegExp("\n{0,}#{1,6} ").allMatches(content);
      if (matches.isEmpty) {
        return -1;
      }
      return matches.toList()[occurrence].start;
    })();
    if (start < 0) {
      return null;
    }
    final end = content.indexOf(RegExp("(\n{1,})#{1,$level} "), start + level);
    final text = content.substring(start, end >= 0 ? end : null);
    return text.replaceAll(RegExp("^\n{0,}"), "");
  }

  @override
  Widget build(BuildContext context) {
    final headerId = idGenerator.generate();
    final fontSize = (() {
      switch (level) {
        //GithubのMarkdownのサイズ
        case 1:
          return 32.0;
        case 2:
          return 24.0;
        case 3:
          return 20.0;
        case 4:
          return 16.0;
        case 5:
          return 14.0;
        case 6:
          return 13.6;
        default:
          return 8.0;
      }
    })();
    const copyButtonPaddingInset = EdgeInsets.all(16);
    return Row(
      key: Key(headerId),
      children: [
        Flexible(
          child: AutoSizeText(
            text,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 100,
            softWrap: false,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const Padding(padding: copyButtonPaddingInset),
      ],
    );
  }
}

class CustomHeaderBuilder extends MarkdownElementBuilder {
  final int Function(String tag, String text) onHeaderFound;
  final Function(String) onCopyRequested;
  final String content;
  int occurrence = 0;
  int level = 1;

  CustomHeaderBuilder({
    required this.content,
    required this.onHeaderFound,
    required this.onCopyRequested,
  });

  @override
  void visitElementBefore(md.Element element) {
    super.visitElementBefore(element);
    occurrence = onHeaderFound(element.tag, element.textContent);
  }

  @override
  Widget visitText(md.Text text, TextStyle? preferredStyle) {
    return Header(
      text: text.text,
      content: content,
      occurrence: occurrence,
      level: level,
      onCopyRequested: onCopyRequested,
    );
  }
}

class CustomHeader1Builder extends CustomHeaderBuilder {
  CustomHeader1Builder({onCopyRequested, onHeaderFound, content})
      : super(
          content: content,
          onHeaderFound: onHeaderFound,
          onCopyRequested: onCopyRequested,
        ) {
    level = 1;
  }
}

class CustomHeader2Builder extends CustomHeaderBuilder {
  CustomHeader2Builder({onCopyRequested, onHeaderFound, content})
      : super(
          content: content,
          onHeaderFound: onHeaderFound,
          onCopyRequested: onCopyRequested,
        ) {
    level = 2;
  }
}

class CustomHeader3Builder extends CustomHeaderBuilder {
  CustomHeader3Builder({onCopyRequested, onHeaderFound, content})
      : super(
          content: content,
          onHeaderFound: onHeaderFound,
          onCopyRequested: onCopyRequested,
        ) {
    level = 3;
  }
}

class CustomHeader4Builder extends CustomHeaderBuilder {
  CustomHeader4Builder({onCopyRequested, onHeaderFound, content})
      : super(
          content: content,
          onHeaderFound: onHeaderFound,
          onCopyRequested: onCopyRequested,
        ) {
    level = 4;
  }
}

class CustomHeader5Builder extends CustomHeaderBuilder {
  CustomHeader5Builder({onCopyRequested, onHeaderFound, content})
      : super(
          content: content,
          onHeaderFound: onHeaderFound,
          onCopyRequested: onCopyRequested,
        ) {
    level = 5;
  }
}

class CustomHeader6Builder extends CustomHeaderBuilder {
  CustomHeader6Builder({onCopyRequested, onHeaderFound, content})
      : super(
          content: content,
          onHeaderFound: onHeaderFound,
          onCopyRequested: onCopyRequested,
        ) {
    level = 6;
  }
}
