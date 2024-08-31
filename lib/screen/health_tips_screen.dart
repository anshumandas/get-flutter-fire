import 'package:flutter/material.dart';
import '../widgets/article_list_widget.dart';

class HealthTipsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Health Tips'),
      ),
      body: ArticleListWidget(),
    );
  }
}
