import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/material.dart';

class BookMark extends StatefulWidget {
  final List bookMark;
  const BookMark({Key? key, required this.bookMark}) : super(key: key);

  @override
  State<BookMark> createState() => _BookMarkState();
}

class _BookMarkState extends State<BookMark> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Book Mark",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            letterSpacing: 2,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: widget.bookMark
                .map(
                  (e) => Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: AnyLinkPreview(
                      link: e,
                      displayDirection: UIDirection.uiDirectionHorizontal,
                      showMultimedia: false,
                      bodyMaxLines: 5,
                      bodyTextOverflow: TextOverflow.ellipsis,
                      titleStyle: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                      bodyStyle:
                          const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
