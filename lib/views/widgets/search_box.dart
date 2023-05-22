import 'package:flutter/material.dart';

import '../../constants/color.dart';
import '../../resources/values_manager.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({
    Key? key,
    required this.searchText,
  }) : super(key: key);

  final TextEditingController searchText;

  void handleSearch() {
    print(searchText);
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: searchText,
      decoration: InputDecoration(
        hintText: 'Search here',
        prefixIcon: GestureDetector(
          onTap: () => handleSearch,
          child: const Icon(Icons.search, color: primaryColor),
        ),
        fillColor: searchBoxBg,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSize.s100),
          borderSide: const BorderSide(color: searchBorderBg),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSize.s100),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSize.s100),
          borderSide: const BorderSide(color: searchBorderBg),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSize.s100),
          borderSide: const BorderSide(color: searchBorderBg),
        ),
      ),
    );
  }
}
