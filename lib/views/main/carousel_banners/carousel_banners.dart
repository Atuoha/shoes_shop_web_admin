import 'package:flutter/material.dart';

class CarouselBanners extends StatefulWidget {
  const CarouselBanners({Key? key}) : super(key: key);

  @override
  State<CarouselBanners> createState() => _CarouselBannersState();
}

class _CarouselBannersState extends State<CarouselBanners> {
  @override
  Widget build(BuildContext context) {
    return Center(child:Text('Carousel Banners'));
  }
}
