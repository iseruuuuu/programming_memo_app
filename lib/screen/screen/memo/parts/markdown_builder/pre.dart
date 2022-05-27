import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;

class Pre extends StatelessWidget {
  final String text;

  const Pre({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        Stack(
          alignment: Alignment.topRight,
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFF2F3C40),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(40, 40, 40, 20),
                child: SelectableText(
                  text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                final data = ClipboardData(text: text);
                Clipboard.setData(data);
              },
              tooltip: 'クリップボードにコピー',
              icon: const Icon(
                Icons.file_copy_outlined,
                size: 25,
                color: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

//TODO コードのプレビューに対して使用可能
class CustomPreBuilder extends MarkdownElementBuilder {
  @override
  Widget visitText(md.Text text, TextStyle? preferredStyle) {
    return Pre(text: text.text);
  }
}

class B2BlockSyntax extends md.BlockSyntax {
  static const String _pattern = r'^\[\[warning\]\](.*)$';

  @override
  RegExp get pattern => RegExp(_pattern);

  B2BlockSyntax();

  @override
  md.Node parse(md.BlockParser parser) {
    var childLines = parseChildLines(parser);
    var content = childLines.join('\n');
    final md.Element el = md.Element('p', [
      md.Element('warning', [md.Text(content)]),
    ]);
    return el;
  }
}

//TODO waringに対して使用可能！！
class WarningBuilder extends MarkdownElementBuilder {
  @override
  Widget visitElementAfter(md.Element element, TextStyle? preferredStyle) {
    return Builder(
      builder: (context) {
        return Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(vertical: 15),
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(left: BorderSide(color: Colors.red, width: 2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Text(
                  'Warning !',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                element.textContent,
                style: preferredStyle,
              ),
            ],
          ),
        );
      },
    );
  }
}
