import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pixbay_gallery/constants/commonFunctions.dart';
import 'package:pixbay_gallery/controller/services/pixabayAPIs.dart';

class ImageGalleryScreen extends StatefulWidget {
  @override
  _ImageGalleryScreenState createState() => _ImageGalleryScreenState();
}

class _ImageGalleryScreenState extends State<ImageGalleryScreen> {
  final PixabayApi api = PixabayApi();
  final ScrollController _scrollController = ScrollController();
  List<dynamic> images = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchImages();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          !_isLoading) {
        _fetchImages();
      }
    });
  }

  Future<void> _fetchImages() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final newImages = await api.fetchImages();
      setState(() {
        images.addAll(newImages);
      });
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final crossAxisCount = MediaQuery.of(context).size.width ~/ 150;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pixabay Gallery',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
      ),
      body: GridView.builder(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.03,
        ),
        controller: _scrollController,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: 15,
          crossAxisSpacing: 10,
          childAspectRatio: 0.8,
        ),
        itemCount: images.length,
        itemBuilder: (context, index) {
          final image = images[index];
          return Column(
            children: [
              Expanded(
                child: CachedNetworkImage(
                  imageUrl: image['webformatURL'],
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.01,
                  ),
                  const Icon(
                    Icons.favorite_outlined,
                    color: Colors.red,
                  ),
                  Text(
                    CommonFunctions.getShortForm(
                      image['likes'],
                    ),
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.remove_red_eye,
                    color: Colors.black,
                  ),
                  Text(
                    CommonFunctions.getShortForm(
                      image['views'],
                    ),
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.01,
                  )
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
