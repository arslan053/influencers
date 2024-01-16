import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:influencer/src/features/admin/category/controller/categories_controller.dart';
import 'package:influencer/src/features/admin/category/model/category_model.dart';

import '../../../Utils/utils.dart';
import '../../../constants/colors.dart';
import '../../../constants/sizes.dart';

Future<dynamic> ShowDialog(BuildContext context) {
  final controller = Get.put(CategoriesController());

  return showDialog(
    context: context,
    builder: (BuildContext context) {
      // Declare a GlobalKey to keep track of the form state.
      final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
      String categoryName;
      Uint8List imageFile;
      void selectImage() async {
        Uint8List img = await imagePick(ImageSource.gallery);
        controller.image.value = img;
      }

      return AlertDialog(
        title: Text('Add Photo and Category'),
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(vertical: smallSize),
                child: Stack(
                  children: [
                    Obx(() {
                      return controller.image.value != null
                          ? CircleAvatar(
                              radius: 64,
                              backgroundImage:
                                  MemoryImage(controller.image.value!),
                            )
                          : const CircleAvatar(
                              radius: largeSize,
                              backgroundColor: myPrimaryColor,
                              child: Icon(
                                Icons.person,
                                size: largeSize * 1.7,
                                color: Colors.white,
                              ),
                            );
                    }),
                    Positioned(
                      bottom: 0,
                      left: 80,
                      child: IconButton(
                        icon: const Icon(Icons.add_a_photo),
                        onPressed: () {
                          selectImage();
                        },
                      ),
                    ),
                  ],
                ),
              ),
              TextFormField(
                controller: controller.category,
                decoration: InputDecoration(labelText: 'Category Name'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a category name';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Submit'),
            onPressed: () {
              // Save the form and retrieve the data.

              final cateogory = CategoryModel(
                category: controller.category.text.trim(),
              );
              CategoriesController.instance
                  .createCategory(cateogory, controller.image.value!);

              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
