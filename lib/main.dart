import 'package:flutter/material.dart';
import 'package:pixbay_gallery/view/home/home.dart';

void main() {
  runApp(const PixaBayGalleryApp());
}

class PixaBayGalleryApp extends StatelessWidget {
  const PixaBayGalleryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pixabay Gallery',
      debugShowCheckedModeBanner: false,
      home: ImageGalleryScreen(),
    );
  }
}
