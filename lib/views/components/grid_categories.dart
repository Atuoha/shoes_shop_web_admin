import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../constants/color.dart';
import '../../helpers/screen_size.dart';
import '../../resources/assets_manager.dart';
import '../widgets/loading_widget.dart';

SizedBox categoryGrid({
  required BuildContext context,
  required Size size,
  required Stream<QuerySnapshot> stream,
  required Function deleteDialog,
}) {
  return SizedBox(
    height: isSmallScreen(context) ? size.height / 2.5 : size.height / 2,
    child: StreamBuilder<QuerySnapshot>(
      stream: stream,
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
              child: Column(
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          item['img_url'],
                          width: 100,
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
                  const SizedBox(height: 10),
                  Text(
                    item['category'],
                  )
                ],
              ),
            );
          },
        );
      },
    ),
  );
}
