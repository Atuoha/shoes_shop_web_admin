import 'dart:io';
import 'package:flutter/material.dart';
import '../../../constants/color.dart';
import '../../../helpers/screen_size.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/font_manager.dart';
import '../../../resources/styles_manager.dart';
import '../../../resources/values_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class CarouselBanners extends StatefulWidget {
  const CarouselBanners({Key? key}) : super(key: key);

  @override
  State<CarouselBanners> createState() => _CarouselBannersState();
}

class _CarouselBannersState extends State<CarouselBanners> {
  final _picker = ImagePicker();
  XFile? image;
  File? selectedImage;
  bool isImgSelected = false;

  Future selectImage() async {
    XFile? pickedImage;
    pickedImage = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedImage == null) {
      return;
    } else {
      setState(() {
        isImgSelected = true;
      });
    }

    setState(() {
      image = pickedImage;
      selectedImage = File(pickedImage!.path);
    });
  }

  void resetIsImagePicked() {
    setState(() {
      isImgSelected = false;
    });
  }

  void uploadImg() {}

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
          Stack(
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
                child: GestureDetector(
                  onTap: () => selectImage(),
                  child: CircleAvatar(
                    backgroundColor: gridBg,
                    child: const Icon(
                      Icons.photo,
                      color: accentColor,
                    ),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 10),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(backgroundColor: accentColor),
            onPressed: () => uploadImg(),
            icon: const Icon(Icons.save),
            label: const Text('Upload Image'),
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
