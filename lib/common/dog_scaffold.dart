import 'package:flutter/material.dart';
import 'package:karo_dogs/config.dart';

class DogScaffold extends StatelessWidget {
  const DogScaffold({
    super.key,
    required this.body,
    this.title,
  });

  final Widget body;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RichText(
          text: TextSpan(
            children: [
              const WidgetSpan(
                child: Icon(Icons.pets, color: Colors.white),
              ),
              TextSpan(text: ' ${title ?? AppConfig.appTitle}'),
            ],
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
        backgroundColor: Colors.green,
      ),
      body: body,
    );
  }
}
