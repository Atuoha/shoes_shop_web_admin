import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../constants/color.dart';
import '../../helpers/screen_size.dart';
import '../../resources/assets_manager.dart';
import '../widgets/loading_widget.dart';


class CarouselBannerGrid extends StatelessWidget {
  const CarouselBannerGrid({
    Key? key,
    required this.deleteDialog,
  }) : super(key: key);


  final Function deleteDialog;

  @override
  Widget build(BuildContext context) {

    Stream<QuerySnapshot> bannerStream =
    FirebaseFirestore.instance.collection('banners').snapshots();

    return StreamBuilder<QuerySnapshot>(
      stream: bannerStream,
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          const Center(
            child: Text('Error occurred!'),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          const Center(
            child: LoadingWidget(),
          );
        }

        if (snapshot.data!.docs.isEmpty) {
          Center(
            child: Image.asset(AssetManager.noImagePlaceholderImg),
          );
        }

        return GridView.builder(
          itemCount: snapshot.data!.docs.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: isSmallScreen(context) ? 2 : 6,
            crossAxisSpacing: 10,
          ),
          itemBuilder: (context, index) {
            var item = snapshot.data!.docs[index];

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: [
                   ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        item['ímg_url'],
                        fit:BoxFit.cover,
                      ),
                    ),
                  Positioned(
                    top: 5,
                    right: 5,
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: InkWell(
                        onTap: () => deleteDialog(id: item.id),
                        child: CircleAvatar(
                          radius: 13,
                          backgroundColor: gridBg.withOpacity(0.3),
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
            );
          },
        );
      },
    );
  }
}

