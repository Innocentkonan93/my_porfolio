import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../controllers/home_controller.dart';

class PortfolioCarousel extends GetView<HomeController> {
  const PortfolioCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    // Assuming controller has carouselImages
    if (controller.carouselImages.isEmpty) return const SizedBox.shrink();

    return SizedBox(
      width: double.infinity,
      child: CarouselSlider(
        options: CarouselOptions(
          height: 250,
          viewportFraction: context.width >= 680 ? 0.12 : 0.25,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: const Duration(milliseconds: 100),
          autoPlayAnimationDuration: const Duration(milliseconds: 1500),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: false,
          scrollDirection: Axis.horizontal,
        ),
        items: controller.carouselImages.map((imagePath) {
          final index = controller.carouselImages.indexOf(imagePath);
          return Builder(
            builder: (BuildContext context) {
              return Transform.rotate(
                angle: index.isOdd ? 0.1 : -0.1,
                child: Container(
                  width: 300,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 3.0,
                    vertical: 25,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withValues(alpha: 0.15),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset(
                      imagePath,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[300],
                          child: const Icon(Icons.error),
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          );
        }).toList(),
      ),
    ).animate().fadeIn(duration: 800.ms);
  }
}
