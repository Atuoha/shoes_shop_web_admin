import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import '../../../constants/color.dart';
import '../../../helpers/screen_size.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/font_manager.dart';
import '../../../resources/styles_manager.dart';
import '../../../resources/values_manager.dart';
import 'package:file_picker/file_picker.dart';

class CarouselBanners extends StatefulWidget {
  const CarouselBanners({Key? key}) : super(key: key);

  @override
  State<CarouselBanners> createState() => _CarouselBannersState();
}

class _CarouselBannersState extends State<CarouselBanners> {
  File? selectedImage;
  bool isImgSelected = false;
  Uint8List? fileBytes;
  String? fileName;
  bool isProcessing = false;

  Future selectImage() async {
    FilePickerResult? pickedImage = await FilePicker.platform.pickFiles(allowMultiple: false, type: FileType.image);

    if (pickedImage == null) {
      return;
    } else {
      setState(() {
        isImgSelected = true;

        fileBytes = pickedImage.files.first.bytes;
        fileName = pickedImage.files.first.name;
        selectedImage = File(pickedImage.files.single.path!);
      });
    }
  }

  void resetIsImagePicked() {
    setState(() {
      isImgSelected = false;
    });
  }

  Future<void> uploadImg() async {
    await FirebaseStorage.instance.ref('banners/$fileName').putData(fileBytes!);
  }

  final list =
      List.generate(50, (index) => AssetManager.placeholderImg).toList();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
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
                      ? Image.file(
                          File(selectedImage!.path),
                          width: 150,
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
                        child: const Icon(
                          Icons.photo,
                          color: accentColor,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(backgroundColor: accentColor),
              onPressed: () => uploadImg(),
              icon: const Icon(Icons.save),
              label: const Text('Upload Image'),
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
                isSmallScreen(context) ? size.height / 2.5 : size.height / 2.23,
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
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(list[index]),
                      ),
                    ),
            ),
          )
        ],
      ),
    );
  }
}
