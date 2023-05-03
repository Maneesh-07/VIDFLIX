import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class TermsAndCondtions extends StatelessWidget {
  TermsAndCondtions({super.key, this.radius = 8, required this.mdFileName1})
      : assert(mdFileName1.contains('.md'),
            'The file must Contains md Extenstions');

  final double radius;
  final String mdFileName1;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
      child: Column(
        children: [
          Expanded(
              child: FutureBuilder(
            future: Future.delayed(Duration(milliseconds: 150))
                .then((value) => rootBundle.loadString('assets/$mdFileName1')),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Markdown(data: snapshot.data!);
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          )),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Ok"),
          ),
        ],
      ),
    );
  }
}
