import 'package:dappstore/features/dapp_info/application/handler/i_dapp_info_handler.dart';
import 'package:dappstore/widgets/image_widgets/image.dart';
import 'package:flutter/material.dart';

class ImageCarousel extends StatelessWidget {
  final List<String> imageUrls;
  final IDappInfoHandler dappInfoHandler;
  ImageCarousel(
      {super.key, required this.imageUrls, required this.dappInfoHandler});
  final PageController pageController = PageController(
    viewportFraction: 0.41334,
    keepPage: false,
  );

  @override
  Widget build(BuildContext context) {
    final images = imageUrls
        .map((e) => SizedBox(
              width: 166.52,
              height: 314,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 11.5),
                child: ImageWidgetCached(
                  e,
                  fit: BoxFit.cover,
                ),
              ),
            ))
        .toList();
    return Center(
      child: SizedBox(
        height: 311,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6.0),
          child: PageView.builder(
            padEnds: false,
            pageSnapping: false,
            controller: pageController,
            itemCount: images.length,
            itemBuilder: (context, index) {
              return images[index];
            },
          ),
        ),
      ),
    );
  }
}
