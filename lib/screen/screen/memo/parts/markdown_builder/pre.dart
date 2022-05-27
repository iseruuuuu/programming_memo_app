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

//TODO waringに対して使用可能！！
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

//TODO Verywaringに対して使用可能！！
class VeryWarningSyntax extends md.BlockSyntax {
  static const String _pattern = r'^\[\[verywaring\]\](.*)$';

  @override
  RegExp get pattern => RegExp(_pattern);

  VeryWarningSyntax();

  @override
  md.Node parse(md.BlockParser parser) {
    var childLines = parseChildLines(parser);
    var content = childLines.join('\n');
    final md.Element el = md.Element('p', [
      md.Element('verywaring', [md.Text(content)]),
    ]);
    return el;
  }
}

class VeryWarningBuilder extends MarkdownElementBuilder {
  @override
  Widget visitElementAfter(md.Element element, TextStyle? preferredStyle) {
    return Builder(
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 15),
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Color(0xFFFEE8EB),
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.cancel,
                  color: Colors.red,
                  size: 40,
                ),
                const SizedBox(width: 5),
                Text(
                  element.textContent,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

//TODO LittleWaringに対して使用可能！！
class LittleWarningSyntax extends md.BlockSyntax {
  static const String _pattern = r'^\[\[littlewaring\]\](.*)$';

  @override
  RegExp get pattern => RegExp(_pattern);

  LittleWarningSyntax();

  @override
  md.Node parse(md.BlockParser parser) {
    var childLines = parseChildLines(parser);
    var content = childLines.join('\n');
    final md.Element el = md.Element('p', [
      md.Element('littlewaring', [md.Text(content)]),
    ]);
    return el;
  }
}

class LittleWarningBuilder extends MarkdownElementBuilder {
  @override
  Widget visitElementAfter(md.Element element, TextStyle? preferredStyle) {
    return Builder(
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 15),
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Color(0xFFFDF8DE),
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.error,
                  color: Color(0xFFF69B2F),
                  size: 40,
                ),
                const SizedBox(width: 5),
                Text(
                  element.textContent,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

//TODO informationに対して使用可能！！
class InformationSyntax extends md.BlockSyntax {
  static const String _pattern = r'^\[\[information\]\](.*)$';

  @override
  RegExp get pattern => RegExp(_pattern);

  InformationSyntax();

  @override
  md.Node parse(md.BlockParser parser) {
    var childLines = parseChildLines(parser);
    var content = childLines.join('\n');
    final md.Element el = md.Element('p', [
      md.Element('information', [md.Text(content)]),
    ]);
    return el;
  }
}

class InformationBuilder extends MarkdownElementBuilder {
  @override
  Widget visitElementAfter(md.Element element, TextStyle? preferredStyle) {
    return Builder(
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 15),
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Color(0xFFDFF6DA),
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.check_circle,
                  color: Color(0xFF4BBD00),
                  size: 40,
                ),
                const SizedBox(width: 5),
                Text(
                  element.textContent,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
