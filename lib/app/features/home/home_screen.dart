import 'package:flutter/material.dart';
import '../../widgets/content_card.dart';
import '../../extensions/widget_extensions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Главная')),
      
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          spacing: 20,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Услуги',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            ListView.separated(
              primary: false,
              shrinkWrap: true,
              itemCount: 10,
              itemBuilder: (_, __) => ContentCard(),
              separatorBuilder: (_, __) => 16.ph,
            ),
          ],
        ),
      ),
    );
  }
}