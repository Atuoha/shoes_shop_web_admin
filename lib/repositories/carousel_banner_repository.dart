import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shoes_shop_admin/models/carousel_banner.dart';

class CarouselBannerRepository {
  static Future<void> createBanner(
      {required String? fileName, required downloadLink}) async {
    try {
      await FirebaseFirestore.instance.collection('banners').doc(fileName).set(
        {
          'img_url': downloadLink,
        },
      );
    } on FirebaseException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
