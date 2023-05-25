import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:shoes_shop_admin/views/widgets/loading_widget.dart';
import '../../../constants/color.dart';
import '../../../constants/enums/status.dart';
import '../../../helpers/screen_size.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/font_manager.dart';
import '../../../resources/styles_manager.dart';
import '../../../resources/values_manager.dart';
import 'package:file_picker/file_picker.dart';

import '../../widgets/kcool_alert.dart';
import '../../widgets/msg_snackbar.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  bool isImgSelected = false;
  Uint8List? fileBytes;
  String? fileName;
  bool isProcessing = false;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final FirebaseFirestore _firebase = FirebaseFirestore.instance;
  TextEditingController categoryName = TextEditingController();

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
    //if category name is empty
    if (categoryName.text.isEmpty) {
      displaySnackBar(
          status: Status.error,
          message: 'Category name is empty',
          context: context);
      return;
    }

    setState(() {
      isProcessing = true;
    });
    String? downloadLink;
    try {
      final Reference ref = _firebaseStorage.ref('categories/$fileName');
      await ref.putData(fileBytes!).whenComplete(() async {
        downloadLink = await ref.getDownloadURL();
      });
      await _firebase.collection('categories').doc(fileName).set(
        {
          'img_url': downloadLink,
          'category': categoryName.text.trim(),
        },
      ).whenComplete(() {
        kCoolAlert(
          message: 'Category uploaded successfully',
          context: context,
          alert: CoolAlertType.success,
          action: uploadDone,
        );
      });
    } catch (e) {
      kCoolAlert(
        message: 'Category not uploaded successfully',
        context: context,
        alert: CoolAlertType.error,
        action: uploadDone,
      );
    }
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
          Row(
            children: [
              Stack(
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
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 5,
                    child: TextFormField(
                      autofocus: true,
                      controller: categoryName,
                      decoration: const InputDecoration(
                        hintText: 'Enter category name',
                        prefixIcon: Icon(
                          Icons.category_outlined,
                          color: accentColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  isImgSelected
                      ? ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: accentColor,
                          ),
                          onPressed: () => !isProcessing ? uploadImg() : null,
                          icon: const Icon(Icons.save),
                          label: Text(
                            !isProcessing ? 'Upload category' : 'Uploading...',
                          ),
                        )
                      : const SizedBox.shrink(),
                ],
              )
            ],
          ),
          const SizedBox(height: 10),
          const Divider(color: boxBg, thickness: 1.5),
          const SizedBox(height: 5),
          Text(
            'Product Categories',
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
                crossAxisSpacing: 10,
              ),
              itemBuilder: (context, index) => list.isEmpty
                  ? Center(
                      child: Image.asset(AssetManager.noImagePlaceholderImg),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              list[index],
                              width: 100,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text('Hello')
                        ],
                      ),
                    ),
            ),
          )
        ],
      ),
    );
  }
}
