import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:shoes_shop_admin/views/widgets/are_you_sure_dialog.dart';
import 'package:shoes_shop_admin/views/widgets/loading_widget.dart';
import '../../../constants/color.dart';
import '../../../helpers/screen_size.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/font_manager.dart';
import '../../../resources/styles_manager.dart';
import '../../../resources/values_manager.dart';
import 'package:file_picker/file_picker.dart';

import '../../widgets/kcool_alert.dart';

class CarouselBanners extends StatefulWidget {
  const CarouselBanners({Key? key}) : super(key: key);

  @override
  State<CarouselBanners> createState() => _CarouselBannersState();
}

class _CarouselBannersState extends State<CarouselBanners> {
  bool isImgSelected = false;
  Uint8List? fileBytes;
  String? fileName;
  bool isProcessing = false;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final FirebaseFirestore _firebase = FirebaseFirestore.instance;

  Future selectImage() async {
    FilePickerResult? pickedImage = await FilePicker.platform
        .pickFiles(allowMultiple: false, type: FileType.image);

    if (pickedImage == null) {
      return;
    } else {
      setState(() {
        isImgSelected = true;
      });
    }

    setState(() {
      fileBytes = pickedImage.files.first.bytes;
      fileName = pickedImage.files.first.name;
    });
  }

  void resetIsImagePicked() {
    setState(() {
      isImgSelected = false;
    });
  }

  uploadDone() {
    Navigator.of(context).pop();
    setState(() {
      isProcessing = false;
      isImgSelected = false;
    });
  }

  Future<void> uploadImg() async {
    setState(() {
      isProcessing = true;
    });
    String? downloadLink;
    try {
      final Reference ref = _firebaseStorage.ref('banners/$fileName');
      await ref.putData(fileBytes!).whenComplete(() async {
        downloadLink = await ref.getDownloadURL();
      });
      await _firebase.collection('banners').doc(fileName).set(
        {
          'img_url': downloadLink,
        },
      ).whenComplete(() {
        kCoolAlert(
          message: 'Image uploaded successfully',
          context: context,
          alert: CoolAlertType.success,
          action: uploadDone,
        );
      });
    } catch (e) {
      kCoolAlert(
        message: 'Image not uploaded successfully',
        context: context,
        alert: CoolAlertType.error,
        action: uploadDone,
      );
    }
  }

  // action after deleting
  void doneDeleting() {
    Navigator.of(context).pop();
  }

  // delete carousel banners
  Future<void> deleteCarousel(String id) async {
    kCoolAlert(
      message: 'Banner is trying to delete',
      context: context,
      alert: CoolAlertType.loading,
    );

    try {
      await _firebase.collection('banners').doc(id).delete().whenComplete(() {
        kCoolAlert(
          message: 'Banner deleted successfully',
          context: context,
          alert: CoolAlertType.success,
          action: doneDeleting,
        );
      });
    } catch (e) {
      kCoolAlert(
        message: 'Banner not deleted successfully',
        context: context,
        alert: CoolAlertType.error,
        action: doneDeleting,
      );
    }
  }

  // delete dialog
  void deleteDialog({required String id}) {
    areYouSureDialog(
      title: 'Delete Banner',
      content: 'Are you sure you want to delete this banner?',
      context: context,
      action: deleteCarousel,
      isIdInvolved: true,
      id: id,
    );
  }

  final list =
      List.generate(50, (index) => AssetManager.placeholderImg).toList();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: isImgSelected
          ? FloatingActionButton(
              backgroundColor: !isProcessing ? accentColor: Colors.grey,
              onPressed: () => !isProcessing ? uploadImg() : null,
              child: const Icon(Icons.save),
            )
          : const SizedBox.shrink(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: isImgSelected
                        ? Image.memory(
                            fileBytes!,
                            width: 150,
                            height: 150,
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            AssetManager.placeholderImg,
                            width: 150,
                          ),
                  ),
                  Positioned(
                    bottom: 5,
                    right: 10,
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: InkWell(
                        onTap: () => selectImage(),
                        child: CircleAvatar(
                          backgroundColor: gridBg,
                          child: !isProcessing
                              ? const Icon(
                                  Icons.photo,
                                  color: accentColor,
                                )
                              : const LoadingWidget(size: 30),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Divider(color: boxBg, thickness: 1.5),
            const SizedBox(height: 5),
            Text(
              'Carousel Banners',
              style: getMediumStyle(
                color: Colors.black,
                fontSize: FontSize.s16,
              ),
            ),
            SizedBox(
              height:
                  isSmallScreen(context) ? size.height / 2.5 : size.height / 2,
              child: GridView.builder(
                itemCount: list.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isSmallScreen(context) ? 2 : 6,
                ),
                itemBuilder: (context, index) => list.isEmpty
                    ? Center(
                        child: Image.asset(AssetManager.noImagePlaceholderImg),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset(
                                    list[index],
                                    width: 100,
                                  ),
                                ),
                                Positioned(
                                  top: 5,
                                  right: 5,
                                  child: MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: InkWell(
                                      onTap: () =>
                                          deleteDialog(id: index.toString()),
                                      child: CircleAvatar(
                                        radius: 13,
                                        backgroundColor:
                                            gridBg.withOpacity(0.3),
                                        child: const Icon(
                                          Icons.delete_forever,
                                          color: primaryColor,
                                          size: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
