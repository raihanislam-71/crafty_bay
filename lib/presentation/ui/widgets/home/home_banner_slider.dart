import 'package:carousel_slider/carousel_slider.dart';
import 'package:crafty_bay/data/models/slider_banner_model.dart';
import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';

class HomeBannerSlider extends StatefulWidget {
  const HomeBannerSlider({super.key, required this.sliderList});

  final List<SliderModel> sliderList;

  @override
  State<HomeBannerSlider> createState() => _HomeBannerSliderState();
}

class _HomeBannerSliderState extends State<HomeBannerSlider> {
  final ValueNotifier<int> _selectedIndex = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
              height: 180,
              viewportFraction: 1.0,
              autoPlay: true,
              onPageChanged: ((index, reason) {
            _selectedIndex.value = index;
          })),
          items: widget.sliderList.map((value) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: const BoxDecoration(color: AppColors.themeColor),
                  alignment: Alignment.center,
                  child: Text(
                    value.title ?? '',
                    style: const TextStyle(fontSize: 16.0),
                  ),
                );
              },
            );
          }).toList(),
        ),
        const SizedBox(height: 8),
        ValueListenableBuilder(
          valueListenable: _selectedIndex,
          builder: (context, currentIndex, _) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < widget.sliderList.length; i++)
                  Container(
                    height: 12,
                    width: 12,
                    margin: const EdgeInsets.only(right: 4),
                    decoration: BoxDecoration(
                      color: currentIndex == i ? AppColors.themeColor : null,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey),
                    ),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    _selectedIndex.dispose();
    super.dispose();
  }
}
